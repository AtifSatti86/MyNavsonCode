tableextension 50114 "Sales Cr.Hdr Ext" extends "Sales Cr.Memo Header"
{
    fields
    {
        // Add changes to table fields here

        field(50009; "Ignore Doc"; boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
}