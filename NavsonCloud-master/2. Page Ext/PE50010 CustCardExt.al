pageextension 50010 CustomerCardExt extends "Customer Card"
{
    layout
    {
        addafter("Credit Limit (LCY)")
        {
            Field("Creditsafe Credit Limit"; rec."Creditsafe Credit Limit")
            {
                Visible = True;
                ApplicationArea = All;
            }
        }
        addafter("Balance (LCY)")
        {
            Field("Balance "; rec.Balance)
            {
                Visible = True;
                ApplicationArea = All;
            }
            field("Last Posted Transaction"; Rec."Last Posted Transaction")
            {
                Caption = 'Last Posted Transaction';
                ToolTip = 'The Last Posted Transaction Date of this Customer.';
                ApplicationArea = All;
                Editable = false;
            }
            field("Last Transaction Amount"; Rec."Last Transaction Amount")
            {
                Caption = 'Last Transaction Amount';
                ToolTip = 'The Last Posted Transaction Amount of this Customer.';
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter(Statistics)
        {
            /*
            group("Buyer Details")
            {
                Caption = 'Buyer Details';
                field("xx"; rec."Customer finance charges")
                {
                    ApplicationArea = all;
                }
            }
            */
            group(Finance)
            {
                Caption = 'Finance Details';
                field("Customer Finance Charges"; rec."Customer Finance Charges")
                {
                    ApplicationArea = all;
                }
                field("Contact Person"; rec."Contact Person")
                {
                    ApplicationArea = all;
                }
                field("E-Mail 2"; rec."E-mail 2")
                {
                    ApplicationArea = all;
                }
                field("Mobile No."; rec."Mobile No.")
                {
                    ApplicationArea = all;
                }
                field("Telephone No."; rec."Telephone No.")
                {
                    ApplicationArea = all;
                }
                field("E-Documents"; rec."E-Documents")
                {
                    ApplicationArea = all;
                }
                field("E-Doc Email"; rec."E-Doc Email")
                {
                    ApplicationArea = all;
                }
                field("Company Registeration No."; rec."Company Registeration No.")
                {
                    ApplicationArea = all;
                }
                field("Company Bank Account Code"; rec."Company Bank Account Code")
                {
                    ApplicationArea = all;
                    Caption = 'Company Bank Account Code';
                }
                field("Overrider"; rec."Overrider")
                {
                    ApplicationArea = all;
                    Caption = 'Overrider';
                }
            }

        }
    }
    actions
    {
    }
}
