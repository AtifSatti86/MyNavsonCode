page 50001 "Navson Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Navson Setup";
    DeleteAllowed = false;
    InsertAllowed = false;

    layout
    {
        area(Content)
        {
            group("General")
            {
                field("Report Path"; rec."Report Path")
                {
                    ApplicationArea = All;

                }
                field("Accounts Email"; rec."Accounts Email")
                {
                    ApplicationArea = All;

                }
                field("Navson CC Email"; rec."Navson CC Email")
                {
                    ApplicationArea = All;

                }
                field("Stock Allocation"; rec."Stock Allocation")
                {
                    ApplicationArea = All;

                }
                field("Bank Payments"; rec."Bank Payments")
                {
                    ApplicationArea = All;

                }
                field("Sales Email"; rec."Sales Email")
                {
                    ApplicationArea = All;

                }
            }
            group("Customer PO & POD")
            {
                Caption = 'Customer PO & POD';
                field("Role-ID"; Rec."Role-ID")
                {
                    ApplicationArea = All;
                    Caption = 'Role-ID';
                    ToolTip = 'Specifies the value of Roll-ID to user';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
    trigger OnOpenPage()
    begin
        if not rec.get() then begin
            rec.Init;
            rec.insert;
        end;
    end;

}