tableextension 50036 "Sales Header Ext" extends "Sales Header"
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
        //below field is only used in Sales Cr. Memo Header
        field(50009; "Ignore Doc"; boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(70001; "Record Filter"; Integer)
        {
            Caption = 'Record Filter';
            FieldClass = FlowFilter;
        }
    }
}