pageextension 50008 "Transfer Line Ext" extends "Transfer Order Subform"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter("Item &Tracking Lines")
        {
            action("Stock Allocation")
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    LAM: Codeunit 50002;
                begin
                    //message('Stock Alloca');
                    LAM.TransferOrder(Rec);
                    ;
                end;
            }
        }
    }

    var
        myInt: Integer;
}