tableextension 50124 "Purch Cr Memo Ext" extends "Purch. Cr. Memo Hdr."
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


    }
}