page 50008 "Posted Allocation FactBox"
{
    Caption = 'Posted Allocation FactBox';
    PageType = ListPart;
    SourceTable = "Posted Logc WrkSheet Alloc";

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
