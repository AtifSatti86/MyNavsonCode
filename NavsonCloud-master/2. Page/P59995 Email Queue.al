page 59995 "Email Queue"
{
    PageType = Card;
    Caption = 'Email Queue';
    SourceTable = "Email Queue";
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(Content)
        {
            group(Email)
            {
                field(Id; rec.Id)
                {
                    Caption = 'Id';
                    ApplicationArea = All;

                }
                field("Email Code"; rec."Email Code")
                {
                    Caption = 'Email Code';
                    ApplicationArea = All;

                }
                field("Order No."; rec."Order No.")
                {
                    Caption = 'Order No.';
                    ApplicationArea = All;

                }
                field("Message No."; rec."Message No.")
                {
                    Caption = 'Message No.';
                    ApplicationArea = All;

                }
                field("To CC"; rec."To CC")
                {
                    Caption = 'To CC';
                    ApplicationArea = All;

                }
                field("Subject"; rec.Subject)
                {
                    Caption = 'Subject';
                    ApplicationArea = All;

                }
                field("Body"; rec.Body)
                {
                    Caption = 'Body';
                    ApplicationArea = All;

                }
                field("Process"; rec.Process)
                {
                    Caption = 'Process';
                    ApplicationArea = All;

                }
                field("Processed By"; rec."Processed By")
                {
                    Caption = 'Processed By';
                    ApplicationArea = All;

                }
                field("Report Id"; rec."Report Id")
                {
                    Caption = 'Report Id';
                    ApplicationArea = All;

                }
                field("Process DateTime"; rec."Process DateTime")
                {
                    Caption = 'Process DateTime';
                    ApplicationArea = All;

                }


            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Sent Email")
            {
                Caption = 'Sent Email';
                Image = Email;
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}