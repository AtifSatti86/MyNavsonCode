pageextension 50026 VendorCardExt extends "Vendor Card"
{
    layout
    {
        addafter("Balance (LCY)")
        {
            Field("Balance "; rec.Balance)
            {
                Visible = True;
                ApplicationArea = All;
            }
        }

        addafter(Receiving)
        {
            group(Finance)
            {
                Caption = 'Finance Details';
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

            }


        }
    }
    actions
    {
        addbefore("Vendor - Balance to Date")
        {
            action("Report Statement")
            {
                ApplicationArea = All;
                Caption = 'Statement';
                Image = Report;
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ToolTip = 'View a list of a vendor''s transactions for a selected period, for example, to send to the vendor at the close of an accounting period. You can choose to have all overdue balances displayed regardless of the period specified, or you can choose to include an aging band.';

                trigger OnAction()
                var
                    vendor: record Vendor;
                begin
                    vendor.reset;
                    vendor.SetRange("No.", Rec."No.");
                    Report.RunModal(Report::"Navson Vendor Statement", true, true, vendor);
                end;
            }
        }
    }
}