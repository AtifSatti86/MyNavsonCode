pageextension 50033 "Customer Lookup Ext" extends "Customer Lookup"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addlast(creation)
        {
        }
    }

    trigger OnOpenPage()
    begin
        if NavUtil.CheckRole('SALESPERSON') then begin
            UserSetup.get(USERID);
            UserSetup.TESTFIELD("Salespers./Purch. Code");
            rec.FilterGroup(9);
            rec.SETRANGE("Salesperson Code", UserSetup."Salespers./Purch. Code");
            rec.FilterGroup(0);
        end;
    end;

    var
        UserSetup: Record "User Setup";
        NavUtil: codeunit "Nav Util";
}
