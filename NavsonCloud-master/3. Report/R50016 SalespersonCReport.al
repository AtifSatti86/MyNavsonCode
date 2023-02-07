report 50016 "SalesCustItem"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = RdlLayout;
    Caption = 'Salesperson Customer Item';

    dataset
    {
        dataitem("Salesperson/Purchaser"; "Salesperson/Purchaser")
        {
            DataItemTableView = sorting(Code);
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Code";
            column(SalesPno; "code") { }
            column(SalesPName; Name) { }
            dataitem(Customer; Customer)
            {
                DataItemTableView = sorting("No.");
                DataItemLink = "Salesperson Code" = FIELD("code");
                DataItemLinkReference = "Salesperson/Purchaser";
                PrintOnlyIfDetail = true;
                RequestFilterFields = "No.";
                column(CustNo; "No.") { }
                column(CustName; Name) { }

                dataitem("Item Ledger Entry"; "Item Ledger Entry")
                {
                    DataItemTableView = sorting("Source No.");
                    DataItemLink = "Source No." = FIELD("No.");
                    DataItemLinkReference = Customer;
                    RequestFilterFields = "Posting Date";
                    column(Item_No_; "Item No.") { }
                    column(Quantity; -Quantity) { }
                    column(ILE_SalesValue; "Sales Amount (Actual)") { }
                    column(Posting_Date; YearMonthTxt) { }
                    column(MonthName; MonthName) { }
                    trigger OnAfterGetRecord()
                    begin
                        CalcFields("Sales Amount (Actual)");
                        YearMonthTxt := NavUtil.GetYearMonthText("Posting Date");
                        MonthName := NavUtil.GetMonthText("Posting Date")
                    end;
                }
            }
            trigger OnPreDataItem()
            var
                NavUtil: codeunit "Nav Util";
                UserSetup: record "User Setup";
            begin
                if NavUtil.CheckRole('SALESPERSON') then begin
                    UserSetup.get(USERID);
                    UserSetup.TESTFIELD("Salespers./Purch. Code");

                    SETRANGE(Code, UserSetup."Salespers./Purch. Code");
                end;

            end;

        }
    }


    rendering
    {
        layout(Doclayout)
        {
            Type = Word;
            LayoutFile = './3. Report format/SalesCustItem.docx';
        }
        layout(RdlLayout)
        {
            Type = RDLC;
            LayoutFile = './3. Report format/SalesCustItem.rdl';
        }
    }
    trigger OnPreReport()
    begin

    end;

    var
        SalespersonFilter: Text;
        PeriodText: Text;
        ItemLedgEntryFilter: Text;
        NavUtil: codeunit "Nav Util";
        YearMonthTxt: text[50];
        MonthName: text[50];
}