pageextension 50041 "Sales Quote Ext" extends "Sales Quote"
{
    layout
    {
        modify("Your Reference")
        {
            Caption = 'Cust. PO No.';
        }
        modify("Quote Valid Until Date")
        {
            Visible = false;
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Opportunity No.")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify("Work Description")
        {
            Caption = 'Note';
        }
        modify(Status)
        {
            Visible = false;
        }
        modify("Foreign Trade")
        {
            Visible = false;
        }
        modify("Due Date")
        {
            Visible = false;
        }
        modify("No. of Archived Versions")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("Payment Discount %")
        {
            Visible = false;
        }
        modify("Pmt. Discount Date")
        {
            Visible = false;
        }
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