reportextension 51307 "Sales Credit Memo Ext" extends 1307
{
    dataset
    {
        // Add changes to dataitems and columns here
        add(Header)
        {
            column(ReceiptDate; format(Header."Posting Date")) { }
            column(ClaimNo; format(Header."Pre-Assigned No.")) { }
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
