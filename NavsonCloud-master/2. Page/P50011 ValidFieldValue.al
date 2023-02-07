page 50011 "Valid Field Value"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Valid Field Value";
    InsertAllowed = True;
    DeleteAllowed = True;
    ModifyAllowed = True;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(TableId; rec.TableID)
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field(FieldID; rec.FieldID)
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Value"; rec.Value)
                {
                    ApplicationArea = All;
                    Caption = 'Code';
                }
                field(Detail; rec.Detail)
                {
                    ApplicationArea = All;
                }
                field(DecimalValue; rec.DecimalValue)
                {
                    ApplicationArea = All;
                    Caption = 'Decimal';
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
}