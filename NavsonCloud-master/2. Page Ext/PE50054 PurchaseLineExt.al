pageextension 50054 "Purchase Line Ext" extends "Purchase Order Subform"
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
            Field("Gen. Prod. Posting Group"; rec."Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                visible = TRUE;
            }
        }
        addafter("Line Amount")
        {
            field("VAT Amount"; (rec."Amount Including VAT" - rec.Amount))
            {
                Visible = true;
                ApplicationArea = All;

            }
        }

        modify("VAT Bus. Posting Group")
        {
            ApplicationArea = All;
            visible = TRUE;
        }
    }
    actions
    {
        // Add changes to page actions here
        addafter(Dimensions)
        {
            action("Stock Allocation")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    LAM: Codeunit 50002;
                begin
                    LAM.PurchaseStockAllocation(rec);
                end;
            }
        }
    }
    trigger OnAfterGetRecord();
    begin
        gStyleExpr := 'Standard';
        CurrPage.Update(False);
        rec.CalcFields("Allocated Qty");
        if (rec.Type = rec.Type::Item) and (rec."Allocated Qty" <> (rec.Quantity - rec."Quantity Received")) then begin
            gStyleExpr := 'Unfavorable';
        end;
    end;

    trigger OnAfterGetCurrRecord();
    begin
        gStyleExpr := 'Emphasize';
        CurrPage.Update(False);
        rec.CalcFields("Allocated Qty");
        if (rec.Type = rec.Type::Item) and (rec."Allocated Qty" <> (rec.Quantity - rec."Quantity Received")) then begin
            gStyleExpr := 'Unfavorable';
        end;
    end;

    var
        gStyleExpr: text;
}