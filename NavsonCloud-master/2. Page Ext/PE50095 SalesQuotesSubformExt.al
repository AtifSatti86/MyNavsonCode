pageextension 50095 "Sales Quotes Subform Ext" extends "Sales Quote Subform"
{
    layout
    {
        modify("Variant Code")
        {
            Visible = true;
        }
        modify("Item Reference No.")
        {
            Visible = false;
        }
        modify("Qty. to Assemble to Order")
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}
