pageextension 50005 "Purch. Cr. Memo Ext" extends "Purchase Credit Memos"
{
    layout
    {
        // Add changes to page layout here
        addafter(Amount)
        {
            field("Amount including VAT"; rec."Amount Including VAT")
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
        myInt: Integer;
}