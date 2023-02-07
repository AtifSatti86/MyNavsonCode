page 50006 "SO PO Link"
{
    // version Ashish

    DeleteAllowed = false;
    Editable = true;
    InsertAllowed = True;
    ModifyAllowed = true;
    PageType = List;
    DelayedInsert = true;
    SourceTable = 50004;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("SO No."; rec."SO No.")
                {
                    ApplicationArea = All;
                    Editable = bSO;
                }
                field("PO No."; rec."PO No.")
                {
                    ApplicationArea = All;
                    Editable = bPO;
                }
                field("Comments"; rec."Comments")
                {
                    ApplicationArea = All;
                    Caption = 'Free Text';
                    StyleExpr = TRUE;
                    ToolTip = 'Free Text';
                    Editable = True;
                }
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        bPO := true;
        bSO := true;
        if PO <> '' then
            bPO := False;
        if SO <> '' then
            bSO := False;

    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        rec."SO No." := SO;
        rec."PO No." := PO;
    end;

    procedure Parameter(pSO: code[20]; pPO: code[20])
    var
    begin
        SO := pSO;
        PO := pPO;
    end;

    var
        SO: code[20];
        PO: code[20];
        bPO: Boolean;
        bSO: Boolean;
}
