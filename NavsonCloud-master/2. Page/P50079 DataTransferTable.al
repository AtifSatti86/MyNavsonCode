page 50079 "Data Transfer Tables"
{
    PageType = ListPart;
    DelayedInsert = true;
    SourceTable = 50080;
    Caption = 'Lines';
    MultipleNewLines = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Table No"; rec."Table No")
                {
                    ApplicationArea = All;
                }
                field("Table Name"; rec."Table Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}
