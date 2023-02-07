tableextension 50023 "Vendor Ext" extends Vendor
{
    fields
    {
        // Add changes to table fields here
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

    }
}