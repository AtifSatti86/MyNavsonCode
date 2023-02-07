page 50016 "Available Stock FactBox"
{
    Caption = 'Available Stock FactBox';
    PageType = ListPart;
    SourceTable = "Posted Logc WrkSheet Alloc";
    DeleteAllowed = False;
    SourceTableView = where("Doc. Type" = filter("Positive Adjmt." | "Purchase" | Transfer),
                                              "Quantity" = filter(> 0),
                                              "Balance Stock" = filter(> 0));
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
                field("Location"; rec."Location")
                {
                    ApplicationArea = All;
                    Caption = 'Location';
                    StyleExpr = TRUE;
                    ToolTip = 'Location';

                }
                field("Free Stock"; (rec."Balance Stock" + rec."Qty. Allocated"))
                {
                    ApplicationArea = All;
                    Caption = 'Free Stock';
                    StyleExpr = TRUE;
                    ToolTip = 'Free Stock';
                }
                field("Balance Quantity"; (rec."Balance Stock"))
                {
                    ApplicationArea = All;
                    Caption = 'Balance Stock';
                    StyleExpr = TRUE;
                    ToolTip = 'Balance Stock';
                }
                field("Allocated"; (rec."Qty. Allocated"))
                {
                    ApplicationArea = All;
                    Caption = 'Allocated Stock';
                    StyleExpr = TRUE;
                    ToolTip = 'Allocated Stock';
                }
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        rec.calcfields("Balance Stock", "Qty. Allocated");
    end;

}
