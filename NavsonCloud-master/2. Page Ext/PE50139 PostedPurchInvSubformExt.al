pageextension 50139 "Posted Purch Inv Subform Ext" extends "Posted Purch. Invoice Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter("Quantity")
        {
            field("VAT Prod. Posting Group"; rec."VAT Prod. Posting Group")
            {
                Visible = true;
                ApplicationArea = All;

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
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}