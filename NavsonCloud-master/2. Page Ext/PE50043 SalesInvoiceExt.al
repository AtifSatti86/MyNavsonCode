pageextension 50043 "Sales Invoice Ext" extends "Sales Invoice"
{
    layout
    {

        addafter(Status)
        {
            field("Order Status"; rec."Order Status")
            {
                ApplicationArea = ALL;
            }
            field("Customer Finance Charges"; rec."Customer Finance Charges")
            {
                ApplicationArea = ALL;
            }
        }
        addlast("Shipping and Billing")
        {
            field("Fright Charges"; rec."Frieght Charges")
            {
                ApplicationArea = ALL;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
}