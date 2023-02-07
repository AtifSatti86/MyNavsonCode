tableextension 50122 "Posted Purch Inv Ext" extends "Purch. Inv. Header"
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