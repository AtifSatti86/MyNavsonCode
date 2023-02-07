pageextension 50371 "Bank Account List Ext" extends "Bank Account List"
{
    layout
    {
        // Add changes to page layout here

        addafter(Control1905767507)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(270),
                              "No." = FIELD("No.");
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

}