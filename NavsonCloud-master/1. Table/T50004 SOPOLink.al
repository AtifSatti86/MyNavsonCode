table 50004 "SO PO Link"
{
    DataClassification = ToBeClassified;
    LookupPageID = "Sales List";

    fields
    {
        field(1; "SO No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Sales Header"."No." WHERE("Document Type" = FILTER(Order));
        }
        field(2; "PO No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Purchase Header"."No." WHERE("Document Type" = FILTER(Order));
        }
        field(10; "Comments"; text[250])
        {
            DataClassification = ToBeClassified;
        }
    }


    keys
    {
        key(PK; "SO No.", "PO No.")
        {
            Clustered = true;
        }
    }

    procedure LinkLookup()
    var
        myInt: Integer;
    begin

    end;
}