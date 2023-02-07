pageextension 59035 "Sales Order List Ext" extends "Sales Order List"
{
    layout
    {
        MODIFY("Ship-to Post Code")
        {
            ApplicationArea = ALL;
            visible = true;
        }

        // Add changes to page layout here
        addafter(Control1)
        {
            field("No Of Records"; rec.Count)
            {
                ApplicationArea = ALL;
                Editable = false;
                ColumnSpan = 2;
            }

        }
        addbefore("Ship-to Post Code")
        {
            field("Ship-to City"; rec."Ship-to City")
            {
                ApplicationArea = ALL;
            }
        }
        addafter(Status)
        {
            field("Order Date"; rec."Order Date")
            {
                ApplicationArea = ALL;
                visible = true;
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
        addlast(factboxes)
        {
            part("Sales List Ext"; "SO PO Link FactBox")
            {
                ApplicationArea = ALL;
                SubPageLink = "SO No." = FIELD("No.");
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnAfterGetCurrRecord()
    begin
        rec.setfilter("Record Filter", format(rec.Count));
    end;

    var
}