tableextension 50039 "Purchase Line Ext" extends "Purchase Line"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Allocated Qty"; Decimal)
        {
            CalcFormula = sum("Logistic Worksheet Allocation".Quantity WHERE("Doc. No." = FIELD("Document No."), "Doc. Line No." = FIELD("Line No.")));
            fieldclass = FlowField;
            Editable = false;
        }
    }

    trigger OnModify()
    var
        LogWksAlloc: Record "Logistic Worksheet Allocation";
    begin
        if xrec."Location Code" <> rec."Location Code" then begin
            LogWksAlloc.reset;
            LogWksAlloc.SETRANGE("Doc. No.", "Document No.");
            LogWksAlloc.SETRANGE("Doc. Line No.", "Line No.");
            if not LogWksAlloc.IsEmpty then
                error('Can not change Location Code \\Allocated Line should be first removed');
        end;
    end;

    trigger OnDelete()
    var
        LogWksAlloc: Record "Logistic Worksheet Allocation";
    begin
        LogWksAlloc.reset;
        LogWksAlloc.SETRANGE("Doc. No.", "Document No.");
        LogWksAlloc.SETRANGE("Doc. Line No.", "Line No.");
        LogWksAlloc.deleteall;
    end;

}