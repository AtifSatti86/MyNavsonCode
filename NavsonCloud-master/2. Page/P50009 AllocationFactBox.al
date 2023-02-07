page 50009 "Allocation FactBox"
{
    Caption = 'Allocation FactBox';
    PageType = ListPart;
    SourceTable = "Logistic Worksheet Allocation";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                ShowCaption = false;
                field("Container No."; rec."Container No.")
                {
                    ApplicationArea = All;
                    Caption = 'Container No.';
                    StyleExpr = TRUE;
                    ToolTip = 'Container No.';

                }
                field("Quantity"; rec."Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Quantity';
                    StyleExpr = TRUE;
                    ToolTip = 'Quantity';
                }
            }
        }
    }

    var
        NumberOfRecords: Integer;
}
