pageextension 50027 "Vendor List Ext" extends "Vendor List"
{
    layout
    {
        // Add changes to page layout here
        addafter(Control1)
        {
            field("No Of Records"; rec.Count)
            {
                ApplicationArea = ALL;
                Editable = false;
                ColumnSpan = 2;
            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var

}
