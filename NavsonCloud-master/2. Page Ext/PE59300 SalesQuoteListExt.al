pageextension 59300 "Sales Quote List Ext" extends "Sales Quotes"
{
    layout
    {
        // Add changes to page layout here
        Modify("Amount")
        {
            ApplicationArea = ALL;

        }
        addafter(Amount)
        {
            field("Amount Including VAT"; rec."Amount Including VAT")
            {
                ApplicationArea = ALL;
            }
        }

        addafter(Status)
        {
            field("Order Date"; rec."Order Date")
            {
                ApplicationArea = ALL;
            }
            field("Order Status"; rec."Order Status")
            {
                ApplicationArea = ALL;
            }
            field("Delivery Date"; rec."Promised Delivery Date")
            {
                ApplicationArea = ALL;
                Caption = 'Delivery Date';
            }
            field("Cust. PO No."; rec."Your Reference")
            {
                ApplicationArea = ALL;
                Caption = 'Cust. PO No.';

            }
            field("Customer Finance Charges"; rec."Customer Finance Charges")
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
    }

    actions
    {
        // Add changes to page actions here
    }

    var

}
