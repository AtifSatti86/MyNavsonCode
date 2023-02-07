tableextension 50112 "Sales Invoice Header Ext" extends "Sales Invoice Header"
{
    fields
    {
        // Add changes to table fields here

        field(50001; "Order Status"; Enum "Sales Order Status")
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Customer Finance Charges"; Text[80])
        {
            TableRelation = "Valid Field Value".Value WHERE(TableID = FILTER(18), FieldID = FILTER(50013));
        }
        field(50003; "Frieght Charges"; decimal)
        {
        }
        field(50004; "W/H Booking"; text[80])
        {
        }
        field(50005; "Customer W/H Reference"; text[80])
        {
        }
        field(50006; "Shipping Ref No."; text[80])
        {
        }
        field(50007; "Delivery Time"; text[80])
        {
        }
        field(50008; "Overrider"; code[20])
        {
            Caption = 'Overrider';
        }
        field(58000; "POD"; Boolean)
        {
            Caption = 'POD';
            FieldClass = FlowField;
            CalcFormula = exist("Document Attachment" where("Attachment Type" = const(1), "No." = field("No.")));
        }
        field(58001; "Order"; Boolean)
        {
            Caption = 'Order';
            FieldClass = FlowField;
            CalcFormula = exist("Document Attachment" where("Attachment Type" = const(2), "No." = field("No.")));
        }
        modify("Your Reference")
        {
            CaptionML = ENG = 'Cust. PO No.';
        }
    }
}