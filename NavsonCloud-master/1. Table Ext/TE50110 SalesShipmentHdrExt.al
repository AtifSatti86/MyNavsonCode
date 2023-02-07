tableextension 50110 "Sales Shipment Header Ext" extends "Sales Shipment Header"
{
    fields
    {
        // Add changes to table fields here
        field(50008; "Overrider"; code[20])
        {
            Caption = 'Overrider';
        }

    }
}