pageextension 51354 "Posted Cr.Memo Upd Ext" extends "Pstd. Sales Cr. Memo - Update"
{
    layout
    {
        addLast(General)
        {
            field("Ignore Doc"; Rec."Ignore Doc")
            {
                ApplicationArea = All;
                Caption = 'Ignore Doc on Overrider';
                Editable = true;
            }
        }
    }
}
