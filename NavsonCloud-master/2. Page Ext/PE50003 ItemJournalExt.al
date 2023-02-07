pageextension 50003 "Item Journal Extension" extends "Item Journal"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter(Dimensions)
        {

            action("Stock Allocation")
            {

                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category6;

                trigger OnAction()
                var
                    LAM: Codeunit 50002;
                begin
                    LAM.Transfer(rec);
                end;
            }
        }
    }

    var
        myInt: Integer;
}