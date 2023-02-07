table 59995 "Email Queue"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Id; Code[20])
        {
            DataClassification = ToBeClassified;

        }
        field(2; "Email Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Message No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "To CC"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Body"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Subject"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(8; Process; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Processed By"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Report Id"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Process DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; Id, "Email Code")
        {
            Clustered = true;
        }
    }
}