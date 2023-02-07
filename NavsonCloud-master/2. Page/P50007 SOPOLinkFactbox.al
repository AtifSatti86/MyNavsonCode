page 50007 "SO PO Link FactBox"
{
    Caption = 'SO PO Link Factbox';
    PageType = ListPart;
    SourceTable = "SO PO Link";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                ShowCaption = false;
                field("SO No."; rec."SO No.")
                {
                    ApplicationArea = All;
                    Caption = 'SO No.';
                    StyleExpr = TRUE;
                    ToolTip = 'SO No.';

                }
                field("PO No."; rec."PO No.")
                {
                    ApplicationArea = All;
                    Caption = 'PO No.';
                    StyleExpr = TRUE;
                    ToolTip = 'PO No.';
                }
                field("Comments"; rec."Comments")
                {
                    ApplicationArea = All;
                    Caption = 'Free Text';
                    StyleExpr = TRUE;
                    ToolTip = 'Free Text';
                }
            }
        }
    }

    var
        NumberOfRecords: Integer;
}

