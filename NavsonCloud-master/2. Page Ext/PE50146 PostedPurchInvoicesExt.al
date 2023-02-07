pageextension 50146 "Posted Purch Invoices Ext" extends "Posted Purchase Invoices"
{
    layout
    {
        // Add changes to page layout here
        addafter("No.")
        {
            field("Quote No."; rec."Quote No.")
            {
                ApplicationArea = all;
            }
            Field("Consignment No."; rec."Consignment No.")
            {
                ApplicationArea = ALL;
            }
            field("Order Status"; rec."Order Status")
            {
                ApplicationArea = ALL;
            }
            field("Vendor Order No."; rec."Vendor Order No.")
            {
                ApplicationArea = ALL;
            }
        }
        addlast(factboxes)
        {
            part("Sales List Ext"; "SO PO Link FactBox")
            {
                ApplicationArea = ALL;
                SubPageLink = "PO No." = FIELD("Order No.");
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
    }

    actions
    {
        // Add changes to page actions here
    }

    var

}
