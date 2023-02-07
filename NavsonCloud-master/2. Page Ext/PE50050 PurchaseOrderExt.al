pageextension 50050 "Purchase Order Ext" extends "Purchase Order"
{
    layout
    {
        // Add changes to page layout here
        addafter(Status)
        {
            Field("Consignment No."; rec."Consignment No.")
            {
                ApplicationArea = ALL;
            }
            field("Order Status"; rec."Order Status")
            {
                ApplicationArea = ALL;
            }

        }
        addlast(factboxes)
        {
            part("Purchase Order Ext"; "SO PO Link FactBox")
            {
                ApplicationArea = ALL;
                SubPageLink = "PO No." = FIELD("No.");
            }
            part("Allocation FactBox"; "Allocation FactBox")
            {
                ApplicationArea = ALL;
                Provider = PurchLines;
                SubPageLink = "Doc. No." = FIELD("Document No."),
                              "Doc. Line No." = FIELD("Line No.");
            }
            part("Posted Allocation FactBox"; "Posted Allocation FactBox")
            {
                ApplicationArea = ALL;
                Provider = PurchLines;
                SubPageLink = "Purchase Order" = FIELD("Document No."),
                              "Doc. Line No." = FIELD("Line No."),
                              "Item No." = field("No.");
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter(Print)
        {
            action("SO PO Link")
            {
                ApplicationArea = All;
                Caption = 'SO PO Link';
                ToolTip = 'SO PO Link';

                trigger OnAction()
                begin
                    clear(pSOPO);
                    pSOPO.Parameter('', rec."No.");
                    tSOPO.reset;
                    tSOPO.SetRange("PO No.", rec."No.");
                    if tSOPO.findfirst then;
                    pSOPO.SetTableView(tSOPO);
                    pSOPO.RunModal();

                end;
            }
        }
    }

    var
        pSOPO: page 50006;
        tSOPO: Record 50004;
}
