table 50005 "Valid Field Value"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Valid Field Value";
    DrillDownPageId = "Valid Field Value";

    fields
    {
        field(1; TableID; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; FieldID; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; Value; Code[10])
        {
            DataClassification = ToBeClassified;
            Caption = 'Code';
        }
        field(10; Detail; Text[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Detail';
        }
        field(11; DecimalValue; decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Decimal Value';
        }
    }

    keys
    {
        key(Key1; TableId, FieldID, Value)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Value, Detail, DecimalValue)
        {
        }
        fieldgroup(Brick; Value, Detail, DecimalValue)
        {
        }
    }


    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

    procedure GetDetails(pTableID: integer; pFieldID: integer; pCode: code[20]; var rDescription: text[50]; var rDecimal: Decimal)
    var
        VFV: record "Valid Field Value";
    begin
        if not VFV.get(pTableID, pFieldID, pCode) then
            VFV.init;

        rDescription := vfv.Detail;
        rDecimal := vfv.DecimalValue;

    end;

}