report 50017 "Haulage Accrual Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = RdlcLayout;
    Caption = 'Haulage Accrual Report';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            RequestFilterFields = "Posting Date";
            column(Posting_Date; "Posting Date") { }
            column(PSIDocNo; "No.") { }
            column(OrderNo; "Order No.") { }
            column(CustName; "Bill-to Name") { }
            column(Amount; Amount) { }
            column(YearMonth; YearMonth) { }
            column(MonthName; MonthName) { }
            column(PONO; PONo) { }
            column(POPostingDate; PostingDate) { }
            column(POAmt; POAmt) { }
            column(Shipment_Method_Code; "Shipment Method Code") { }
            column(Ship_to_City; "Ship-to City") { }
            column(Amount_Including_VAT; "Amount Including VAT") { }

            trigger OnAfterGetRecord()
            begin

                SOPOLink.reset;
                SOPOLink.setrange("So No.", "Order No.");
                if not SOPOLink.findfirst then
                    Currreport.skip;

                ShipmentMth := '';
                PONo := '';
                POAmt := 0;

                PurchLn.reset;
                PurchLn.SETFILTER("Document Type", '%1|%2', PurchHdr."Document Type"::Order, PurchHdr."Document Type"::Invoice);
                PurchLn.SETRANGE("Document No.", SOPOLink."PO No.");
                PurchLn.SETRANGE("No.", GLAccNo);
                if PurchLn.isempty then
                    currreport.skip;

                if PurchLn.findfirst then begin
                    PurchHdr.get(PurchLn."Document Type", PurchLn."Document No.");
                    PostingDate := PurchHdr."Document Date";
                    PONo := PurchHdr."No.";
                    PurchHdr.calcfields("Amount Including VAT");
                    POAmt := PurchHdr."Amount Including VAT";
                end else begin
                    PPI.RESET;
                    PPI.SETRANGE("Order No.", SOPOLink."Po No.");
                    if not PPI.findfirst then
                        PPI.init;
                    PostingDate := PPI."Posting Date";
                    PONo := PPI."No.";
                    PPI.calcfields("Amount Including VAT");
                    POAmt := PPI."Amount Including VAT";
                end;
                YearMonth := NavUtil.GetYearMonthText("Posting Date");
                MonthName := NavUtil.GetMonthText("Posting Date");
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
                    field("G\L Account"; GLAccNo)
                    {
                        ApplicationArea = Basic, Suite;

                    }
                }
            }
        }
    }

    rendering
    {
        layout(RdlcLayout)
        {
            Type = RDLC;
            LayoutFile = './3. Report Format/HaulageAccrualReport.rdl';
        }
    }

    var
        SOPOLink: Record "SO PO Link";
        PurchHdr: Record "Purchase Header";
        PurchLn: record "Purchase Line";
        PSI: Record "Sales Invoice Header";
        PPI: Record "Purch. Inv. Header";
        PostingDate: date;
        ShipmentMth: code[20];
        PONo: code[20];
        POAmt: decimal;
        NavUtil: Codeunit "Nav Util";
        YearMonth: text[20];
        MonthName: text[30];
        GLAccNo: code[20];
}