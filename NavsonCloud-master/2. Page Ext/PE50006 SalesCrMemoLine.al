pageextension 50006 "Sales Cr Memo Line" extends "Sales Cr. Memo Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter(Quantity)
        {
            field("Return Qty. to Receive"; rec."Return Qty. to Receive")
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
                    LAM.SalesStockAllocation(rec);
                end;
            }
        }
    }

    var
        myInt: Integer;
}