tableextension 50018 "Customer Ext" extends Customer
{
    fields
    {
        // Add changes to table fields here
        field(50004; Overrider; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Valid Field Value".Value WHERE(TableID = FILTER(18), FieldID = FILTER(50004));
        }
        field(50012; "Creditsafe Credit Limit"; text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50013; "Customer Finance Charges"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Valid Field Value".Value WHERE(TableID = FILTER(18), FieldID = FILTER(50013));
        }
        field(50014; "Contact Person"; text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50015; "E-mail 2"; text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50016; "Mobile No."; text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50017; "Telephone No."; text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50018; "E-Documents"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50019; "E-Doc Email"; text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50020; "Company Registeration No."; text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(50030; "Company Bank Account Code"; Code[20])
        {
            TableRelation = "Bank Account";
            DataClassification = ToBeClassified;
        }
        field(50040; "Customer Status"; option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "Active","In-Active";
        }
        field(90001; "Last Posted Transaction"; Date)
        {
            CalcFormula = max("Cust. Ledger Entry"."Posting Date" where("Customer No." = Field("No."), "Document Type" = filter(Invoice)));
            FieldClass = FlowField;
            Editable = False;
        }

        field(90002; "Last Transaction Amount"; Decimal)
        {
            CalcFormula = max("Cust. Ledger Entry"."Sales (LCY)" where("Customer No." = Field("No."), "Document Type" = filter(Invoice), "Posting Date" = Field("Last Posted Transaction")));
            //CalcFormula = max("Detailed Cust. Ledg. Entry"."Amount (LCY)" where("Customer No." = Field("No."), "Document Type" = filter(= Invoice), "Posting Date" = Field("Last Posted Transaction")));
            FieldClass = FlowField;
            Editable = False;
        }

    }
}
