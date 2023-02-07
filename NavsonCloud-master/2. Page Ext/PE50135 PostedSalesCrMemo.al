pageextension 50135 "Posted Sales Cr Subform Ext" extends "Posted Sales Cr. Memo Subform"
{
    layout
    {
        // Add changes to page layout here
        modify("Variant Code")
        {
            Visible = true;
        }
        addafter("Quantity")
        {
            field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
            {
                ApplicationArea = All;
                Visible = true;
                Caption = 'VAT Prod. Posting Group';
            }
        }
        addafter("Line Amount")
        {
            field("VAT Amount"; (rec."Amount Including VAT" - rec.Amount))
            {
                ApplicationArea = All;
                Visible = true;
                Caption = 'VAT Amount';
            }
        }
    }
}