pageextension 50022 "Customer List Ext" extends "Customer List"
{
    layout
    {
        // Add changes to page layout here
        addafter(Name)
        {
            field("Customer Finance Charges"; rec."Customer Finance Charges")
            {
                ApplicationArea = ALL;
            }
            field("Customer Status"; rec."Customer Status")
            {
                ApplicationArea = ALL;
            }
        }
        addafter("Payments (LCY)")
        {
            field("Last Posted Transaction"; Rec."Last Posted Transaction")
            {
                Caption = 'Last Posted Transaction';
                ToolTip = 'The Last Posted Transaction Date of this Customer.';
                ApplicationArea = All;
            }
            field("Last Transaction Amount"; Rec."Last Transaction Amount")
            {
                Caption = 'Last Transaction Amount';
                ToolTip = 'The Last Posted Transaction Amount of this Customer.';
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
    }

    actions
    {
        // Add changes to page actions here
        addlast(creation)
        {
            action("Create Sales Quote")
            {
                ApplicationArea = All;
                Caption = 'Salesperon Quote';
                Image = Quote;
                Promoted = true;
                PromotedCategory = Category5;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    clear(SalesQuote);
                    SalesQuote.pParameterSales(rec."No.");
                    SalesQuote.RunModal();
                end;

            }
        }
    }

    var
        SalesQuote: page "Sales Quote Creation";
}
