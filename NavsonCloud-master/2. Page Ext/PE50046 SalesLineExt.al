pageextension 50046 "Sales Line Extension" extends "Sales Order Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Quantity")
        {
            field("Allocated Qty"; Rec."Allocated Qty")
            {
                ApplicationArea = All;
                Caption = 'Allocated Qty';
                StyleExpr = gStyleExpr;
            }
        }
        modify("Variant Code")
        {
            Visible = true;
        }
        modify("Item Reference No.")
        {
            Visible = false;
        }
        modify("Qty. to Assemble to Order")
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("Related Information")
        {
            action("Stock Allocation")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    LAM: Codeunit 50002;
                begin
                    //message('Stock Alloca');
                    LAM.SalesStockAllocation(rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        gStyleExpr := 'Standard';
        CurrPage.Update(False);
        rec.CalcFields("Allocated Qty");
        if (rec.Type = rec.Type::Item) and (rec."Allocated Qty" <> (rec.Quantity - rec."Quantity Shipped")) then begin
            gStyleExpr := 'Unfavorable';
        end;
    end;

    trigger OnAfterGetCurrRecord();
    begin
        gStyleExpr := 'Emphasize';
        CurrPage.Update(False);
        rec.CalcFields("Allocated Qty");
        if (rec.Type = rec.Type::Item) and (rec."Allocated Qty" <> (rec.Quantity - rec."Quantity Shipped")) then begin
            gStyleExpr := 'Unfavorable';
        end;
    end;

    var

        gStyleExpr: text;
}