pageextension 50007 "Purch Cr Memo Line" extends "Purch. Cr. Memo Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter(Quantity)
        {
            field("Qty. to Return"; rec."Return Qty. to Ship")
            {
                ApplicationArea = ALL;
            }
        }

    }

    actions
    {
        // Add changes to page actions here
        addafter("Co&mments")
        {
            action("Stock Allocation")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    LAM: Codeunit 50002;
                begin
                    //message('Stock Alloca');
                    LAM.PurchaseStockAllocation(rec);
                end;
            }
        }
    }

    var
        myInt: Integer;
}