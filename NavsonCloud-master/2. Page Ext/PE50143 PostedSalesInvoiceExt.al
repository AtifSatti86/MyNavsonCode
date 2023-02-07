pageextension 50143 "Posted Sales Invoice Ext" extends "Posted Sales Invoices"
{
    layout
    {
        // Add changes to page layout here
        Modify("Ship-To Name")
        {
            ApplicationArea = all;
            Visible = True;
        }
        AddAfter("Ship-To Name")
        {
            field("Ship-To City"; rec."Ship-To City")
            {
                ApplicationArea = all;
            }
        }
        addafter("No.")
        {
            field("Quote No."; rec."Quote No.")
            {
                ApplicationArea = all;
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
            field(POD; Rec.POD)
            {
                ToolTip = 'Specified value of field';
                ApplicationArea = All;
            }
            field("Order"; Rec."Order")
            {
                ToolTip = 'Specified value of field';
                ApplicationArea = All;
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
            part("Sales List Ext"; "SO PO Link FactBox")
            {
                ApplicationArea = ALL;
                SubPageLink = "SO No." = FIELD("Order No.");
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var

}
