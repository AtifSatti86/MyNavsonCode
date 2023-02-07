pageextension 50138 "Posted Purchase Invoice Ext" extends "Posted Purchase Invoice"
{
    layout
    {
        // Add changes to page layout here  
        addlast(General)
        {
            field("Order Date"; rec."Order Date")
            {
                ApplicationArea = ALL;
            }
            field("Order Status"; rec."Order Status")
            {
                ApplicationArea = ALL;
            }
            field("Consignment No."; rec."Consignment No.")
            {
                ApplicationArea = ALL;
            }
        }

        addlast(factboxes)
        {
            part("Posted Allocation FactBox"; "Posted Allocation FactBox")
            {
                ApplicationArea = ALL;
                Provider = PurchInvLines;
                SubPageLink = "Purchase Order" = FIELD("Order No."),
                              "Doc. Line No." = FIELD("Line No.");
            }
            part("Sales List Ext"; "SO PO Link FactBox")
            {
                ApplicationArea = ALL;
                SubPageLink = "PO No." = FIELD("Order No.");
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}