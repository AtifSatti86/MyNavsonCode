pageextension 50133 "Posted Sales Invoice Line Ext" extends "Posted Sales Invoice Subform"
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
                Caption = 'VAT Prod. Posting Group';
            }
        }
        addafter("Line Amount")
        {
            field("VAT Amount"; (rec."Amount Including VAT" - rec.Amount))
            {
                Visible = true;
                Caption = 'VAT Amount';
                ApplicationArea = All;

            }
        }
    }

}