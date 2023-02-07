reportextension 51302 "Sales Proforma Invoice Ext" extends 1302
{
    dataset
    {
        // Add changes to dataitems and columns here
        add(Header)
        {
            // column(OrderDate; format("Purch. Inv. Header"."Order Date"))
            // {
            // }
            column(Orderdate; format(Header."Order Date"))
            {

            }
            column(CustomerNo; format(Header."Bill-to Customer No."))
            {

            }
            column(ReqDeliveryDate; Format(Header."Requested Delivery Date"))
            {

            }
            column(Payment_Terms_Code; Header."Payment Terms Code")
            {

            }
            column(DueDate; format(Header."Due Date"))
            {

            }

        }
        add(Line)
        {

            column(ItemNO; Line."No.")
            {

            }
            column(Unit_of_Measure; "Unit of Measure")
            {

            }

        }

        addfirst(Header)
        {
            dataitem(Integer; Integer)
            {
                MaxIteration = 1;
                DataItemLinkReference = Header;
                column(ShpTA1; ShipToAdd[1])
                {

                }
                column(ShpTA2; ShipToAdd[2])
                {

                }
                column(ShpTA3; ShipToAdd[3])
                {

                }
                column(ShpTA4; ShipToAdd[4])
                {

                }
                column(ShpTA5; ShipToAdd[5])
                {

                }
                column(ShpTA6; ShipToAdd[6])
                {

                }
                column(ShpTA7; ShipToAdd[7])
                {

                }
                column(ShpTA8; ShipToAdd[8])
                {

                }
                column(BankBranchcode; CompanyInfo1."Bank Branch No.")
                {

                }
                trigger OnAfterGetRecord()
                begin
                    AddressFormat.SalesHeaderShipTo(ShipToAdd, CustAdd, Header);
                end;
            }
            dataitem(BankInfo; "Company Information")
            {
                DataItemLinkReference = Header;
                column(Bank_Name; CompanyBankAccount."Name")
                {

                }
                column(Bank_Account_No_; CompanyBankAccount."Bank Account No.")
                {

                }
                column(Bank_Branch_No_; CompanyBankAccount."Bank Branch No.")
                {

                }
                column(VAT_Registration_No_; "VAT Registration No.")
                {

                }
                trigger OnAfterGetRecord()
                begin
                    if not CompanyBankAccount.Get(Header."Company Bank Account Code") then
                        CompanyBankAccount.CopyBankFieldsFromCompanyInfo(BankInfo);
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
        AddressFormat: codeunit "Format Address";
        ShipToAdd: array[8] of Text[80];
        CustAdd: array[8] of Text[80];
        CompanyBankAccount: record "Bank Account";
}
