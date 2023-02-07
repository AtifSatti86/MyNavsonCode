pageextension 51140 "Tax Digital Ext" extends "OAuth 2.0 Setup"
{
    layout
    {
        addafter("Request URL Paths")
        {
            group("Client Token")
            {
                Caption = 'Client Token';
                field("Client ID"; rec."Client ID")
                {
                    ApplicationArea = all;
                }
                field("Client Secret"; rec."Client Secret")
                {
                    ApplicationArea = all;
                }
            }

        }
    }
}
