pageextension 59307 "Purchase Order List Ext" extends "Purchase Order List"
{
    layout
    {
        // Add changes to page layout here

        addafter(Status)
        {
            field("Approver ID"; rec."Approver ID")
            {
                ApplicationArea = All;
                Caption = 'Approver ID';
                Editable = false;
            }
        }

        addafter("Buy-from Vendor No.")
        {
            field("Quote No."; Rec."Quote No.")
            {
                ApplicationArea = All;
            }
            field("Order Status"; rec."Order Status")
            {
                ApplicationArea = ALL;
            }
            field("Vendor Order No."; rec."Vendor Order No.")
            {
                ApplicationArea = ALL;
            }
            field("Vendor Shipment No."; rec."Vendor Shipment No.")
            {
                ApplicationArea = ALL;
            }
            field("Vendor Invoice No."; rec."Vendor Invoice No.")
            {
                ApplicationArea = ALL;
            }
        }

        addafter(Control1)
        {
            field("No Of Records"; rec.Count)
            {
                ApplicationArea = ALL;
                Editable = false;
                ColumnSpan = 2;
            }

        }
        addlast(factboxes)
        {
            part("Purchase List Ext"; "SO PO Link FactBox")
            {
                ApplicationArea = ALL;
                SubPageLink = "PO No." = FIELD("No.");
            }
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var

}
