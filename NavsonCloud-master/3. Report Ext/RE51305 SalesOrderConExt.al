reportextension 51305 "Sales Order Con Ext" extends "Standard Sales - Order Conf."
{
    dataset
    {
        // Add changes to dataite ms and columns here
        add(Header)
        {
            column("DeliveryDate"; header."Promised Delivery Date")
            {

            }
            column("OrderDate"; format(header."Order Date"))
            {
            }
        }
        addfirst(Header)
        {
            dataitem(Customer; Customer)
            {
                DataItemLink = "No." = field("Sell-to Customer No.");
                DataItemLinkReference = Header;
                column("CustomerVATReg"; customer."VAT Registration No.")
                {
                }
                column("CompanyBankCode"; CompanyInformation."Bank Branch No.")
                {
                }
                trigger OnAfterGetRecord()
                begin
                    CompanyInformation.GET();
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
        CompanyInformation: Record "Company Information";
}
