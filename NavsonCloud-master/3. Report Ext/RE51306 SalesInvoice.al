reportextension 51306 "Sales Invoice Ext" extends 1306
{
    dataset
    {
        // Add changes to dataitems and columns here
        add(Header)
        {
            // column(OrderDate; format("Purch. Inv. Header"."Order Date"))
            // {
            // }
            column(SalesOrderNo; Header."Order No.")
            {

            }
            column(OrderDate; format(Header."Order Date"))
            {

            }
            column(DeliveryDate; format(Header."Shipment Date"))
            {

            }
        }


        addfirst(Header)
        {
            dataitem(CustomerNavson; Customer)
            {
                DataItemLink = "No." = field("Sell-to Customer No.");
                DataItemLinkReference = Header;
                column("CustVATReg"; "VAT Registration No.")
                {
                }
                // column(CompanyPicture; CompanyInfo1.Picture)
                // {
                // }
                // column(BankBranchcode; CompanyInfo1."Bank Branch No.")
                // {

                // }
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
