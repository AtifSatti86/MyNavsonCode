report 50002 "Sales Order vs Allocation"
{
    DefaultRenderingLayout = ReportRDLC;
    ApplicationArea = Basic;
    Caption = 'SO vs Allocation';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    DataAccessIntent = ReadOnly;

    dataset
    {
        dataitem("Logistic Worksheet Allocation"; "Logistic Worksheet Allocation")
        {
            DataItemTableView = SORTING("Doc. No.", "Doc. Line No.");
            column(DocumentNo; "Doc. No.")
            {
            }
            column(DocumentLineNo; "Doc. Line No.")
            {
            }
            column(SO_Outstanding; SOStock)
            {
            }
            column(AllocQty; AllocStock)
            {
            }

            trigger OnAfterGetRecord()
            begin
                if "Doc. Type" <> "Doc. Type"::Sale then
                    currreport.skip;

                SalesLine.reset;
                SalesLine.setrange("Document Type", 1);
                SalesLine.Setrange("Document No.", "Doc. No.");
                SalesLine.Setrange("Line No.", "Doc. Line No.");
                if not SalesLine.FindFirst() then
                    SalesLine.Init;

                AllocStock := Quantity;
                SOStock := SalesLine."Outstanding Quantity";

                if ShowDiff then
                    if SOStock = AllocStock then
                        currreport.skip;
            end;

            trigger OnPreDataItem()
            begin
                if findfirst then;
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
                    Caption = 'Options';
                    field("Show Difference"; ShowDiff)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Difference only';
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
            LayoutFile = './3. Report Format/SOAllocation.rdl';
        }
        layout(ReportWORD)
        {
            Type = word;
            LayoutFile = './3. Report Format/SOAllocation.docx';
        }
    }

    labels
    {
    }

    trigger OnPostReport()
    begin

    end;

    trigger OnPreReport()
    begin

    end;

    var
        SOStock: decimal;
        AllocStock: decimal;
        SalesLine: record 37;
        ShowDiff: Boolean;

}

