page 50010 "NoOfRecords"
{
    Caption = 'No of Records';
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "Integer";

    layout
    {
        area(content)
        {
            field("Number"; rec.Number)
            {
                ApplicationArea = All;
                Caption = 'Records No.';
            }
        }
    }


    var
        NumberOfRecords: Integer;

}
