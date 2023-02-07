table 50080 "Table Data Sync"
{
    // version Ashish

    fields
    {
        field(1; "Table No"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = Field;
        }
        field(10; "Table Name"; Text[100])
        {
            CalcFormula = Lookup(Field.TableName WHERE(TableNo = FIELD("Table No")));
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "Table No")
        {
        }
    }

    fieldgroups
    {
    }

    procedure DataSync(FromCompany: Text; ToCompany: Text);
    var
        Window: Dialog;
        i: Integer;
        TableDataSync: Record 50080;
        TableRef1: RecordRef;
        TableRef2: RecordRef;
        FieldRef1: FieldRef;
        FieldRef2: FieldRef;
    begin
        IF UPPERCASE(USERID) <> 'ASHISH' THEN
            ERROR('Not Authorised');

        IF ToCompany = FromCompany THEN
            ERROR('%1 cant be %2', FromCompany, ToCompany);

        Window.OPEN('Table #1###########################\\Field #2###########################');
        TableDataSync.RESET;
        IF TableDataSync.FINDFIRST THEN
            REPEAT
                TableDataSync.CalcFields("Table Name");
                Window.UPDATE(1, TableDataSync."Table Name");
                TableRef1.OPEN(TableDataSync."Table No", FALSE, FromCompany);
                TableRef2.OPEN(TableDataSync."Table No", FALSE, ToCompany);
                IF TableRef1.FINDFIRST THEN BEGIN
                    Window.UPDATE(2, TableRef1.FIELDINDEX(1));
                    REPEAT
                        TableRef2.INIT;
                        FOR i := 1 TO TableRef1.FIELDCOUNT DO BEGIN
                            FieldRef2 := TableRef2.FIELDINDEX(i);
                            FieldRef1 := TableRef1.FIELDINDEX(i);
                            IF NOT (FORMAT(FieldRef1.TYPE) IN ['BLOB']) THEN
                                FieldRef2.VALUE(FieldRef1.VALUE);
                        END;
                        IF NOT TableRef2.INSERT THEN
                            TableRef2.MODIFY;
                        COMMIT;
                    UNTIL TableRef1.NEXT = 0;
                END;
                Tableref1.close;
                TableRef2.close;
                SLEEP(100);
            UNTIL TableDataSync.NEXT = 0;
        Window.CLOSE;
    end;
}
