tableextension 50037 "Sales Line Ext" extends "Sales Line"
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
        field(50001; "Order Date"; Date)
        {
            CalcFormula = lookup("Sales Header"."Order Date" WHERE("No." = FIELD("Document No.")));
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