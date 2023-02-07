report 50012 Overrider
{
    Caption = 'Overrider';
    ApplicationArea = All;
    UsageCategory = ReportsAndAnalysis;
    DataAccessIntent = ReadOnly;
    DefaultRenderingLayout = ReportRDLC;

    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Overrider";
            column(CustomerNo; Customer."No.") { }
            column(CustomerName; Customer."Name") { }
            column(OverRiderCode; Customer.Overrider) { }
            column(OverRiderDesc; recOverrider.Detail) { }
            column(OverRiderPec; recOverrider.DecimalValue) { }
            dataitem(CustLedgerEntry; "Cust. Ledger Entry")
            {
                DataItemLinkReference = Customer;
                DataItemTableView = SORTING("Customer No.") WHERE("Document Type" = FILTER(Invoice | "Credit Memo"));
                DataItemLink = "Customer No." = field("No.");
                RequestFilterFields = "Posting Date";

                column(PostingDate; "Posting Date") { }
                column(DocNo; "Document No.") { }
                column(SalesLCY; "Sales (LCY)") { }
                column(ProfitLCY; "Profit (LCY)") { }
                column(OrverriderValue; SalesCommissionAmt) { }
                column(ProfitValue; ProfitCommissionAmt) { }

                trigger OnPreDataItem()
                begin

                end;

                trigger OnAfterGetRecord()
                var
                    IgnoreRecord: Boolean;
                    PostedSalesCrMemo: record "Sales Cr.Memo Header";
                begin
                    IgnoreRecord := False;
                    if PostedSalesCrMemo.get("Document No.") then
                        IgnoreRecord := PostedSalesCrMemo."Ignore Doc";
                    if IgnoreRecord then
                        currreport.skip;
                    SalesCommissionAmt := ROUND("Sales (LCY)" * recOverrider.DecimalValue / 100);
                    ProfitCommissionAmt := ROUND("Profit (LCY)" * recOverrider.DecimalValue / 100);
                end;
            }
            trigger OnPreDataItem()
            var
                NavUtil: codeunit "Nav Util";
                UserSetup: record "User Setup";
            begin
                if NavUtil.CheckRole('SALESPERSON') then begin
                    UserSetup.get(USERID);
                    UserSetup.TESTFIELD("Salespers./Purch. Code");

                    SETRANGE("Salesperson Code", UserSetup."Salespers./Purch. Code");
                end;

            end;

            trigger OnAfterGetRecord()
            begin
                if not recOverrider.get('18', '50004', Overrider) then
                    Currreport.skip;
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
                group("Output Options")
                {
                    Caption = 'Output Options';
                    field(ReportOutput; SupportedOutputMethod)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Report Output';
                        OptionCaption = 'Print,Preview,Word,PDF,Email,XML - RDLC layouts only', Comment = 'Each item is a verb/action - to print, to preview, to export to Word, export to PDF, send email, export to XML for RDLC layouts only';
                        ToolTip = 'Specifies the output of the scheduled report, such as PDF or Word.';

                        trigger OnValidate()
                        var
                            CustomLayoutReporting: Codeunit "Custom Layout Reporting";
                        begin
                            ShowPrintIfEmailIsMissing := (SupportedOutputMethod = SupportedOutputMethod::Email);

                            case SupportedOutputMethod of
                                SupportedOutputMethod::Print:
                                    ChosenOutputMethod := CustomLayoutReporting.GetPrintOption;
                                SupportedOutputMethod::Preview:
                                    ChosenOutputMethod := CustomLayoutReporting.GetPreviewOption;
                                SupportedOutputMethod::Word:
                                    ChosenOutputMethod := CustomLayoutReporting.GetWordOption;
                                SupportedOutputMethod::PDF:
                                    ChosenOutputMethod := CustomLayoutReporting.GetPDFOption;
                                SupportedOutputMethod::Email:
                                    ChosenOutputMethod := CustomLayoutReporting.GetEmailOption;
                                SupportedOutputMethod::XML:
                                    ChosenOutputMethod := CustomLayoutReporting.GetXMLOption;
                            end;
                        end;
                    }
                    field(ChosenOutput; ChosenOutputMethod)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Chosen Output';
                        ToolTip = 'Specifies how to output the report, such as Print or Excel.';
                        Visible = false;
                    }
                    group(EmailOptions)
                    {
                        Caption = 'Email Options';
                        Visible = ShowPrintIfEmailIsMissing;
                        field(PrintMissingAddresses; PrintIfEmailIsMissing)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Print Although Email is Missing';
                            ToolTip = 'Specifies if you want to print also the statements for customers that have not been set up with a send-to email address.';
                        }
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin

        end;
    }

    rendering
    {
        layout(ReportRDLC)
        {
            Type = RDLC;
            LayoutFile = './3. Report Format/CustomerOverrider.rdl';
        }
        layout(ReportWORD)
        {
            Type = word;
            LayoutFile = './3. Report Format/CustomerOverrider.docx';
        }
    }

    labels
    {
    }

    var
        SupportedOutputMethod: Option Print,Preview,Word,PDF,Email,XML;
        ChosenOutputMethod: Integer;
        PrintIfEmailIsMissing: Boolean;
        ShowPrintIfEmailIsMissing: Boolean;
        SalesCommissionAmt: decimal;
        ProfitCommissionAmt: decimal;
        recOverrider: record "Valid Field Value";

    trigger OnInitReport()
    begin
        SupportedOutputMethod := 1;
    end;

    trigger OnPostReport()
    begin
    end;

    trigger OnPreReport()
    begin
    end;

}

