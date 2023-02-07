tableextension 51173 "Navson Document Attachement" extends "Document Attachment"
{
    fields
    {

        field(58000; "Customer POD"; Boolean)
        {
            Caption = 'Customer POD';
            DataClassification = ToBeClassified;
        }
        field(58001; "Customer SO"; Boolean)
        {
            Caption = 'Customer SO';
            DataClassification = ToBeClassified;
        }
        field(58002; "Attachment Type"; Option)
        {
            OptionMembers = " ","POD","Order";
            DataClassification = ToBeClassified;
        }
    }
}
