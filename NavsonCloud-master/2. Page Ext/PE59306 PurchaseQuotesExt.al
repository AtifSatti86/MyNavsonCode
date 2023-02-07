pageextension 59306 "Purchase Quote List Ext" extends "Purchase Quotes"
{
    layout
    {
        // Add changes to page layout here
        addafter(Status)
        {
            field("Vendor Order No."; rec."Vendor Order No.")
            {
                ApplicationArea = ALL;
                Caption = 'Cust. PO No.';
            }
            field("Amount"; rec."Amount")
            {
                ApplicationArea = ALL;
                Caption = 'Amount';
            }
            field("Amount Incl. VAT"; rec."Amount Including VAT")
            {
                ApplicationArea = ALL;
                Caption = 'Amount Including VAT';

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
