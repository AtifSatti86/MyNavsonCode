reportextension 50405 "Purchase Order Ext" extends 405
{
    dataset
    {
        // Add changes to dataitems and columns here
        add("Purchase Header")
        {
            // column(OrderDate; format("Purch. Inv. Header"."Order Date"))
            // {
            // }
            column(ContactName; "Purchase Header"."Buy-from Contact")
            {

            }
            column(DueDate; format("Purchase Header"."Due Date"))
            {

            }
        }
        // add("Purch. Line")
        // {

        //     column(UnitPrice; "Purch. Inv. Line"."Unit Cost")
        //     {

        //     }
        //     column(VATAmount; "Purch. Inv. Line"."VAT %")
        //     {

        //     }

        // }

        addfirst("Purchase Header")
        {
            dataitem(VendorNavson; Vendor)
            {
                DataItemLink = "No." = field("Buy-From Vendor No.");
                DataItemLinkReference = "Purchase Header";
                column("VendorVATReg"; VendorNavson."VAT Registration No.")
                {
                }
                column(CompanyPicture; CompanyInfo1.Picture)
                {
                }
                column(BankBranchcode; format(CompanyInfo1."Bank Branch No."))
                {

                }
                trigger OnPreDataItem()
                begin
                    CompanyInfo1.get;
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
