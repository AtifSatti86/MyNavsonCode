table 50500 "CRM"
{
    Caption = 'CRM';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            // NotBlank = true;
            // TableRelation="No. Series";
            trigger Onvalidate()
            begin
                if "No." <> xRec."No." then begin
                    SalesSetup.Get();
                    NoSeriesMgt.TestManual(SalesSetup."CRM No.");
                    "No. Series" := '';
                end;

            end;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
        field(3; "City"; Text[100])
        {
            Caption = 'City';

        }
        field(4; "Address"; Text[100])
        {
            Caption = 'Address';

        }
        field(5; "Address 2"; Text[100])
        {
            Caption = 'Address 2';
        }
        field(6; "Phone No."; Text[100])
        {
            Caption = 'Phone No.';

        }
        field(7; "Email"; Text[100])
        {
            Caption = 'Email';
            ExtendedDatatype = EMail;

        }
        field(8; "Website"; Text[100])
        {
            Caption = 'Website';

        }
        field(9; "Contact Name"; Text[30])
        {
            Caption = 'Contact Name';

        }
        field(10; "Comapany Reg. No."; Text[20])
        {
            Caption = 'Comapany Reg. No.';
        }
        field(11; "Salesperson"; Text[30])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(12; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }



    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        // key(PK1; "No. Series")
        // {

        // }
    }

    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CRM: Record CRM;


    trigger OnInsert()
    begin
        if "No." = '' then begin
            SalesSetup.Get();
            SalesSetup.TestField("CRM No.");
            NoSeriesMgt.InitSeries(SalesSetup."CRM No.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
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



}