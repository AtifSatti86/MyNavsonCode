report 50000 "RBS Payment Detail"
{
    DefaultRenderingLayout = ReportRDLC;
    ApplicationArea = all;
    Caption = 'RBSPaymentDetail';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    DataAccessIntent = ReadOnly;

    dataset
    {
        dataitem("Cust Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = SORTING("Document Type", "Customer No.", "Posting Date", "Currency Code")
                                ORDER(Ascending)
            WHERE("Document Type" = FILTER("Credit Memo" | Invoice | Refund | Payment));
            RequestFilterFields = "Customer No.", "Posting Date", "Document Type";
            column(CustNo; "Customer No.")
            {
            }
            column(CustName; gtxtCustName)
            {
            }
            column(PostDate; "Posting Date")
            {
            }
            column(DocType; "Document Type")
            {
            }
            column(DocNo; "Document No.")
            {
            }
            column(Amount; "Amount (LCY)")
            {
            }

            trigger OnPreDataItem();
            begin
            end;

            trigger OnAfterGetRecord()
            begin
                gtxtCustName := '';
                IF Customer.GET("Customer No.") THEN
                    gtxtCustName := Customer.Name;

                IF Customer."Customer Finance Charges" <> gcodCFC THEN
                    CurrReport.SKIP;
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
                    field("Customer Finance Code"; gcodCFC)
                    {
                        ApplicationArea = All;
                        TableRelation = "Valid Field Value".Value WHERE(TableID = FILTER(18), FieldID = FILTER(50013));
                    }
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
            LayoutFile = './3. Report Format/RBS Payment Detail.rdl';
        }
        layout(ReportWORD)
        {
            Type = word;
            LayoutFile = './3. Report Format/RBS Payment Detail.docx';
        }
    }

    labels
    {
    }

    var
        gtxtCustName: Text[250];
        Customer: Record 18;
        gtxtFilter: Text[250];
        gcodCFC: Code[20];
}
