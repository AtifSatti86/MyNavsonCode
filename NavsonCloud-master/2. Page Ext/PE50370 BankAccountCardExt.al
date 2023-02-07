pageextension 50370 "Bank Account Card Ext" extends "Bank Account Card"
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
