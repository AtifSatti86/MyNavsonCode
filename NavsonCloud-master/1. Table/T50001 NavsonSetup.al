table 50001 "Navson Setup"
{

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Report Path"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Accounts Email"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(21; "Navson CC Email"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(22; "Sales Email"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "Doc. Mgt. Scan"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(31; "Doc. Mgt. File"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Company T C"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(33; "Stock Allocation"; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate();
            begin
                //IF CheckStockAllocation AND ("Stock Allocation" = FALSE) THEN
                //ERROR('Stock Allocation Should be switched On');
            end;
        }
        field(34; "Use Pipeline"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(35; "Bank Payments"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(36; "Cash Payments"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(37; "Credit Card Payments"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "G/L Account";
        }
        field(38; "POS Item Card"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Min. Proft Required"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "PDF Reader"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Cust List With Trans"; Text[30])
        {
            DataClassification = ToBeClassified;
            Description = 'Show Customer List In this Period';
        }
        field(42; "Ignore VAT"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(58003; "Role-ID"; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = "Aggregate Permission Set"."Role ID";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert();
    begin
        //"Stock Allocation" := CheckStockAllocation;
    end;

    procedure CheckStockAllocation(): Boolean;
    var
        recLWA: Record 50002;
        recLA: Record 50003;
    begin
        recLWA.RESET;
        IF NOT recLWA.FINDFIRST THEN BEGIN
            recLA.RESET;
            IF NOT recLA.FINDFIRST THEN
                EXIT(FALSE);
        END;

        EXIT(TRUE);
    end;
}

