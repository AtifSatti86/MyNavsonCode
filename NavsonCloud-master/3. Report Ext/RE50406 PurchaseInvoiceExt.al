reportextension 50406 "Purchase Invoice Ext" extends "Purchase - Invoice"
{
    dataset
    {
        // Add changes to dataitems and columns here
        add("Purch. Inv. Header")
        {
            column(OrderDate; format("Purch. Inv. Header"."Order Date"))
            {
            }
            column(ShipToName; "Purch. Inv. Header"."Ship-to Name")
            {
            }
            column(VendorInvNo; "Purch. Inv. Header"."Vendor Invoice No.")
            {
            }
            column(CompanyPicture; CompanyInfo1.Picture)
            {
            }
            column(BankBranchCode; CompanyInfo1."Bank Branch No.")
            {
            }
        }

        addfirst("Purch. Inv. Header")
        {
            dataitem(VendorNavson; Vendor)
            {
                DataItemLink = "No." = field("Buy-From Vendor No.");
                DataItemLinkReference = "Purch. Inv. Header";
                column("VendorVATReg"; VendorNavson."VAT Registration No.")
                {
                }

            }
        }
        add("Purch. Inv. Line")
        {
            column(UnitCost; "Purch. Inv. Line"."Unit Cost")
            {
            }
            column(VATAmount; "Purch. Inv. Line"."VAT %")
            {
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
