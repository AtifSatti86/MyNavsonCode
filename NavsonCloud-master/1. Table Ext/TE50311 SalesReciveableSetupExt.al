tableextension 50311 "SalesReciveableSetupExt" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50500; "CRM No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = "No. Series";
        }
        // Add changes to table fields here
    }

    var

}