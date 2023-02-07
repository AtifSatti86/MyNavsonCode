tableextension 50038 "Purchase Header Ext" extends "Purchase Header"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "Order Status"; Enum "Purchase Order Status")
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Consignment No."; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(80001; "Approver ID"; Code[50])
        {
            CalcFormula = lookup("Approval Entry"."Approver ID" WHERE("Document No." = FIELD("No."), Status = filter(Open)));
            FieldClass = FlowField;
        }
    }
}