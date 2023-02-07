report 50010 "Customer Last Order"
{
    DefaultRenderingLayout = ReportRDLC;
    ApplicationArea = all;
    Caption = 'Customer Last Order';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    DataAccessIntent = ReadOnly;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.") ORDER(Ascending);
            RequestFilterFields = "No.";
            column(CustNo; "No.") { }
            column(OrderNo; recSIH."No.") { }
            column(CustName; Name) { }
            column(OrderDate; recSIH."Order Date") { }
            column(PostingDate; recSIH."Posting Date") { }
            column(InvoiceAmount; recSIH.Amount) { }

            trigger OnPreDataItem();
            begin

            end;

            trigger OnAfterGetRecord()
            begin
                if NavUtil.CheckRole('SALESPERSON') then begin
                    UserSetup.get(USERID);
                    UserSetup.TESTFIELD("Salespers./Purch. Code");

                    if "Salesperson Code" <> UserSetup."Salespers./Purch. Code" then
                        currreport.skip;
                end;

                recSIH.RESET;
                recSIH.SETCURRENTKEY("Sell-to Customer No.", "No.");
                recSIH.SETRANGE("Sell-to Customer No.", "No.");
                IF NOT recSIH.FINDLAST THEN
                    CurrReport.SKIP;
                recSIH.CALCFIELDS(Amount);

            end;

            trigger OnPostDataItem();
            begin
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    /*
                                       field("Customer Finance Code"; gcodCFC)
                                        {
                                            ApplicationArea = All;
                                            TableRelation = "Valid Field Value".Value WHERE(TableID = FILTER(18), FieldID = FILTER(50013));
                                        }
                    */
                }

            }
        }

        actions
        {
        }
    }

    rendering
    {
        layout(ReportRDLC)
        {
            Type = RDLC;
            LayoutFile = './3. Report Format/CustomerLastOrder.rdl';
        }
        layout(ReportWORD)
        {
            Type = word;
            LayoutFile = './3. Report Format/CustomerLastOrder.docx';
        }
    }

    labels
    {
    }

    var
        recSIH: record "Sales Invoice Header";
        gcodCFC: Code[20];
        UserSetup: Record "User Setup";
        NavUtil: codeunit "Nav Util";
}
