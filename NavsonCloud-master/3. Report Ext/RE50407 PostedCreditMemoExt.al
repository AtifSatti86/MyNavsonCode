reportextension 51407 "Posted Credit Memo Ext" extends 407
{
    dataset
    {
        // Add changes to dataitems and columns here
        add("Purch. Cr. Memo Hdr.")
        {
            column(ContactPerson; "Purch. Cr. Memo Hdr."."Pay-to Contact") { }
        }
        addfirst("Purch. Cr. Memo Hdr.")
        {
            dataitem(IntegerCompInfo; Integer)
            {
                MaxIteration = 1;
                DataItemLinkReference = "Purch. Cr. Memo Hdr.";
                column(BankBranchNo; CompanyInfo1."Bank Branch No.") { }
                trigger OnAfterGetRecord()
                begin
                    CompanyInfo1.GET();
                end;
            }
        }
    }
    requestpage
    {
        // Add changes to the requestpage here
        layout
        {

        }
    }
    var
        CompanyInfo1: Record "Company Information";
}
