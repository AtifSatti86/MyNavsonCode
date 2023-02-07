report 50013 "Navson Vendor Statement"
{
    ApplicationArea = All;
    Caption = 'Navson Vendor Statement';
    DefaultLayout = RDLC;
    RDLCLayout = './3. Report Format/NavsonVendorStatement.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Currency Filter";
            column(No_Vendor; "No.")
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                PrintOnlyIfDetail = true;
                column(CompanyInfo1Picture; CompanyInfo1.Picture)
                {
                }
                column(CompanyInfo2Picture; CompanyInfo2.Picture)
                {
                }
                column(CompanyInfo3Picture; CompanyInfo3.Picture)
                {
                }
                column(VendorAddr1; VendorAddr[1])
                {
                }
                column(CompanyAddr1; CompanyAddr[1])
                {
                }
                column(VendorAddr2; VendorAddr[2])
                {
                }
                column(CompanyAddr2; CompanyAddr[2])
                {
                }
                column(VendorAddr3; VendorAddr[3])
                {
                }
                column(CompanyAddr3; CompanyAddr[3])
                {
                }
                column(VendorAddr4; VendorAddr[4])
                {
                }
                column(CompanyAddr4; CompanyAddr[4])
                {
                }
                column(VendorAddr5; VendorAddr[5])
                {
                }
                column(PhoneNo_CompanyInfo; CompanyInfo."Phone No.")
                {
                }
                column(VendorAddr6; VendorAddr[6])
                {
                }
                column(CompanyInfoEmail; CompanyInfo."E-Mail")
                {
                }
                column(CompanyInfoHomePage; CompanyInfo."Home Page")
                {
                }
                column(VATRegNo_CompanyInfo; CompanyInfo."VAT Registration No.")
                {
                }
                column(GiroNo_CompanyInfo; CompanyInfo."Giro No.")
                {
                }
                column(BankName_CompanyInfo; CompanyInfo."Bank Name")
                {
                }
                column(BankAccNo_CompanyInfo; CompanyInfo."Bank Account No.")
                {
                }
                column(No1_Vendor; Vendor."No.")
                {
                }
                column(TodayFormatted; Format(Today))
                {
                }
                column(StartDate; Format(StartDate))
                {
                }
                column(EndDate; Format(EndDate))
                {
                }
                column(LastStatmntNo_Vendor; '')
                {
                }
                column(VendorAddr7; VendorAddr[7])
                {
                }
                column(VendorAddr8; VendorAddr[8])
                {
                }
                column(CompanyAddr7; CompanyAddr[7])
                {
                }
                column(CompanyAddr8; CompanyAddr[8])
                {
                }
                column(StatementCaption; StatementCaptionLbl)
                {
                }
                column(PhoneNo_CompanyInfoCaption; PhoneNo_CompanyInfoCaptionLbl)
                {
                }
                column(VATRegNo_CompanyInfoCaption; VATRegNo_CompanyInfoCaptionLbl)
                {
                }
                column(GiroNo_CompanyInfoCaption; GiroNo_CompanyInfoCaptionLbl)
                {
                }
                column(BankName_CompanyInfoCaption; BankName_CompanyInfoCaptionLbl)
                {
                }
                column(BankAccNo_CompanyInfoCaption; BankAccNo_CompanyInfoCaptionLbl)
                {
                }
                column(No1_VendorCaption; No1_VendorCaptionLbl)
                {
                }
                column(StartDateCaption; StartDateCaptionLbl)
                {
                }
                column(EndDateCaption; EndDateCaptionLbl)
                {
                }
                column(LastStatmntNo_VendorCaption; LastStatmntNo_VendorCaptionLbl)
                {
                }
                column(PostDate_DtldVendorLedgEntriesCaption; PostDate_DtldVendorLedgEntriesCaptionLbl)
                {
                }
                column(DocNo_DtldVendorLedgEntriesCaption; "Detailed Vendor Ledg. Entry".FieldCaption("Document No."))
                {
                }
                column(Desc_VendorLedgEntry2Caption; VendorLedgEntry2.FieldCaption(Description))
                {
                }
                column(DueDate_VendorLedgEntry2Caption; DueDate_VendorLedgEntry2CaptionLbl)
                {
                }
                column(RemainAmtVendorLedgEntry2Caption; VendorLedgEntry2.FieldCaption("Remaining Amount"))
                {
                }
                column(VendorBalanceCaption; VendorBalanceCaptionLbl)
                {
                }
                column(OriginalAmt_VendorLedgEntry2Caption; VendorLedgEntry2.FieldCaption("Original Amount"))
                {
                }
                column(CompanyInfoHomepageCaption; CompanyInfoHomepageCaptionLbl)
                {
                }
                column(CompanyInfoEmailCaption; CompanyInfoEmailCaptionLbl)
                {
                }
                column(DocDateCaption; DocDateCaptionLbl)
                {
                }
                column(Total_Caption2; Total_CaptionLbl)
                {
                }
                column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
                {
                }
                dataitem(CurrencyLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                    PrintOnlyIfDetail = true;
                    dataitem(VendorLedgEntryHdr; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(Currency2Code_VendorLedgEntryHdr; StrSubstNo(Text001Lbl, CurrencyCode3))
                        {
                        }
                        column(StartBalance; StartBalance)
                        {
                            AutoFormatExpression = TempCurrency2.Code;
                            AutoFormatType = 1;
                        }
                        column(CurrencyCode3; CurrencyCode3)
                        {
                        }
                        column(VendorBalance_VendorLedgEntryHdr; VendorBalance)
                        {
                        }
                        column(PrintLine; PrintLine)
                        {
                        }
                        column(DtldVendorLedgEntryType; Format("Detailed Vendor Ledg. Entry"."Entry Type", 0, 2))
                        {
                        }
                        column(EntriesExists; EntriesExists)
                        {
                        }
                        column(IsNewVendorCurrencyGroup; IsNewVendorCurrencyGroup)
                        {
                        }
                        dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
                        {
                            DataItemTableView = SORTING("Vendor No.", "Posting Date", "Entry Type", "Currency Code");
                            column(PostDate_DtldVendorLedgEntries; Format("Posting Date"))
                            {
                            }
                            column(DocNo_DtldVendorLedgEntries; "Document No.")
                            {
                            }
                            column(Description; Description)
                            {
                            }
                            column(DueDate_DtldVendorLedgEntries; Format(DueDate))
                            {
                            }
                            column(CurrCode_DtldVendorLedgEntries; "Currency Code")
                            {
                            }
                            column(Amt_DtldVendorLedgEntries; Amount)
                            {
                                AutoFormatExpression = "Currency Code";
                                AutoFormatType = 1;
                            }
                            column(RemainAmt_DtldVendorLedgEntries; RemainingAmount)
                            {
                                AutoFormatExpression = "Currency Code";
                                AutoFormatType = 1;
                            }
                            column(VendorBalance; VendorBalance)
                            {
                                AutoFormatExpression = "Currency Code";
                                AutoFormatType = 1;
                            }
                            column(Currency2Code; TempCurrency2.Code)
                            {
                            }
                            //HA Show Vendor invoice no.
                            column(VendorInvoiceNo_DtldVendorLedgEntries; PurchInvHeader."Vendor Invoice No.")
                            {
                            }
                            column(VendorInvoiceNo_DtldVendorLedgEntriesCaption; LbLVendorInvoiceNo)
                            {
                            }
                            //<< Show Vendor invoice no.

                            trigger OnAfterGetRecord()
                            var
                                VendorLedgerEntry: Record "Vendor Ledger Entry";
                            begin

                                //HA - Show only open entries>>
                                // if VendorLedgerEntryOpen.GET("Detailed Vendor Ledg. Entry"."Vendor Ledger Entry No.") and (VendorLedgerEntryOpen.Open = FALSE) then CurrReport.SKIP();
                                if VendorLedgerEntryOpen.GET("Detailed Vendor Ledg. Entry"."Vendor Ledger Entry No.") then
                                    IF VendorLedgerEntryOpen.Open = false THEN
                                        if not CheckAppliedEntries.Get(VendorLedgerEntryOpen."Closed by Entry No.") then
                                            CurrReport.Skip()
                                        else
                                            if EndDate >= CheckAppliedEntries."Posting Date" then
                                                CurrReport.SKIP();
                                // IF VendorLedgerEntryOpen.Open = false THEN begin
                                //     CheckAppliedEntries.SetRange("Entry No.", VendorLedgerEntryOpen."Closed by Entry No.");
                                //     if CheckAppliedEntries.FindFirst() then
                                //         if EndDate < CheckAppliedEntries."Posting Date" then
                                //             CurrReport.SKIP();
                                // end;
                                //<<
                                //HA>> Show Vendor invoice no.
                                Clear(PurchInvHeader);
                                if not PurchInvHeader.Get("Document No.") then;
                                //<<

                                if SkipReversedUnapplied("Detailed Vendor Ledg. Entry") or (Amount = 0) then
                                    CurrReport.Skip();
                                RemainingAmount := 0;
                                PrintLine := true;
                                case "Entry Type" of
                                    "Entry Type"::"Initial Entry":
                                        begin
                                            VendorLedgerEntry.Get("Vendor Ledger Entry No.");
                                            Description := VendorLedgerEntry.Description;
                                            DueDate := VendorLedgerEntry."Due Date";
                                            VendorLedgerEntry.SetRange("Date Filter", 0D, EndDate);
                                            VendorLedgerEntry.CalcFields("Remaining Amount");
                                            RemainingAmount := VendorLedgerEntry."Remaining Amount";
                                        end;
                                    "Entry Type"::Application:
                                        begin
                                            DetailedVendorLedgEntry.SetCurrentKey("Vendor No.", "Posting Date", "Entry Type");
                                            DetailedVendorLedgEntry.SetRange("Vendor No.", "Vendor No.");
                                            DetailedVendorLedgEntry.SetRange("Posting Date", "Posting Date");
                                            DetailedVendorLedgEntry.SetRange("Entry Type", "Entry Type"::Application);
                                            DetailedVendorLedgEntry.SetRange("Transaction No.", "Transaction No.");
                                            DetailedVendorLedgEntry.SetFilter("Currency Code", '<>%1', "Currency Code");
                                            if not DetailedVendorLedgEntry.IsEmpty() then begin
                                                Description := Text005Txt;
                                                DueDate := 0D;
                                            end else
                                                PrintLine := false;
                                        end;
                                    "Entry Type"::"Payment Discount",
                                    "Entry Type"::"Payment Discount (VAT Excl.)",
                                    "Entry Type"::"Payment Discount (VAT Adjustment)",
                                    "Entry Type"::"Payment Discount Tolerance",
                                    "Entry Type"::"Payment Discount Tolerance (VAT Excl.)",
                                    "Entry Type"::"Payment Discount Tolerance (VAT Adjustment)":
                                        begin
                                            Description := Text006Txt;
                                            DueDate := 0D;
                                        end;
                                    "Entry Type"::"Payment Tolerance",
                                    "Entry Type"::"Payment Tolerance (VAT Excl.)",
                                    "Entry Type"::"Payment Tolerance (VAT Adjustment)":
                                        begin
                                            Description := Text014Txt;
                                            DueDate := 0D;
                                        end;
                                    "Entry Type"::"Appln. Rounding",
                                    "Entry Type"::"Correction of Remaining Amount":
                                        begin
                                            Description := Text007Txt;
                                            DueDate := 0D;
                                        end;
                                end;

                                if PrintLine then begin

                                    //HA - Show only open entries>>

                                    //VendorBalance := VendorBalance + Amount;
                                    VendorBalance := VendorBalance + RemainingAmount;

                                    //<<

                                    IsNewVendorCurrencyGroup := IsFirstPrintLine;
                                    IsFirstPrintLine := false;
                                    ClearCompanyPicture();
                                end;
                            end;

                            trigger OnPreDataItem()
                            begin
                                SetRange("Vendor No.", Vendor."No.");
                                SetRange("Posting Date", StartDate, EndDate);
                                SetRange("Currency Code", TempCurrency2.Code);

                                if TempCurrency2.Code = '' then begin
                                    GLSetup.TestField("LCY Code");
                                    CurrencyCode3 := GLSetup."LCY Code"
                                end else
                                    CurrencyCode3 := TempCurrency2.Code;

                                IsFirstPrintLine := true;
                            end;
                        }
                    }
                    dataitem(VendorLedgEntryFooter; "Integer")
                    {
                        DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                        column(CurrencyCode3_VendorLedgEntryFooter; CurrencyCode3)
                        {
                        }
                        column(Total_Caption; Total_CaptionLbl)
                        {
                        }
                        column(VendorBalance_VendorLedgEntryHdrFooter; VendorBalance)
                        {
                            AutoFormatExpression = TempCurrency2.Code;
                            AutoFormatType = 1;
                        }
                        column(EntriesExistsl_VendorLedgEntryFooterCaption; EntriesExists)
                        {
                        }

                        trigger OnAfterGetRecord()
                        begin
                            ClearCompanyPicture();
                        end;
                    }
                    dataitem(VendorLedgEntry2; "Vendor Ledger Entry")
                    {
                        DataItemLink = "Vendor No." = FIELD("No.");
                        DataItemLinkReference = Vendor;
                        DataItemTableView = SORTING("Vendor No.", Open, Positive, "Due Date");
                        column(OverDueEntries; StrSubstNo(Text002Lbl, TempCurrency2.Code))
                        {
                        }
                        column(RemainAmt_VendorLedgEntry2; "Remaining Amount")
                        {
                            AutoFormatExpression = "Currency Code";
                            AutoFormatType = 1;
                        }
                        column(PostDate_VendorLedgEntry2; Format("Posting Date"))
                        {
                        }
                        column(DocNo_VendorLedgEntry2; "Document No.")
                        {
                        }
                        column(Desc_VendorLedgEntry2; Description)
                        {
                        }
                        column(DueDate_VendorLedgEntry2; Format("Due Date"))
                        {
                        }
                        column(OriginalAmt_VendorLedgEntry2; "Original Amount")
                        {
                            AutoFormatExpression = "Currency Code";
                        }
                        column(CurrCode_VendorLedgEntry2; "Currency Code")
                        {
                        }
                        column(PrintEntriesDue; PrintEntriesDue)
                        {
                        }
                        column(Currency2Code_VendorLedgEntry2; TempCurrency2.Code)
                        {
                        }
                        column(CurrencyCode3_VendorLedgEntry2; CurrencyCode3)
                        {
                        }
                        column(VendorNo_VendorLedgEntry2; "Vendor No.")
                        {
                        }
                        trigger OnAfterGetRecord()
                        var
                            VendorLedgEntry: Record "Vendor Ledger Entry";
                        begin
                            if IncludeAgingBand then begin
                                if ("Posting Date" > EndDate) and ("Due Date" >= EndDate) then
                                    CurrReport.Skip();
                                if DateChoice = DateChoice::"Due Date" then
                                    if "Due Date" >= EndDate then
                                        CurrReport.Skip();
                            end;
                            VendorLedgEntry := VendorLedgEntry2;
                            VendorLedgEntry.SetRange("Date Filter", 0D, EndDate);
                            VendorLedgEntry.CalcFields("Remaining Amount");
                            "Remaining Amount" := VendorLedgEntry."Remaining Amount";

                            //HA - Show only open entries>>
                            // IF VendorLedgEntry.Open = false THEN
                            //     CurrReport.SKIP();
                            IF VendorLedgEntry.Open = false THEN
                                if not CheckAppliedEntries.Get(VendorLedgEntry."Closed by Entry No.") then
                                    CurrReport.Skip()
                                else
                                    if EndDate >= CheckAppliedEntries."Posting Date" then
                                        CurrReport.SKIP();
                            //<<
                            if VendorLedgEntry."Remaining Amount" = 0 then
                                CurrReport.Skip();

                            if IncludeAgingBand and ("Posting Date" <= EndDate) then
                                UpdateBuffer(TempCurrency2.Code, GetDate("Posting Date", "Due Date"), "Remaining Amount");
                            if "Due Date" >= EndDate then
                                CurrReport.Skip();

                            ClearCompanyPicture();

                        end;

                        trigger OnPreDataItem()
                        begin
                            if not IncludeAgingBand then
                                SetRange("Due Date", 0D, EndDate - 1);
                            SetRange("Currency Code", TempCurrency2.Code);
                            if (not PrintEntriesDue) and (not IncludeAgingBand) then
                                CurrReport.Break();
                        end;
                    }

                    trigger OnAfterGetRecord()
                    var
                        VendorLedgerEntry: Record "Vendor Ledger Entry";
                    begin
                        if Number = 1 then
                            TempCurrency2.FindSet();

                        repeat
                            if not IsFirstLoop then
                                IsFirstLoop := true
                            else
                                if TempCurrency2.Next() = 0 then
                                    CurrReport.Break();
                            VendorLedgerEntry.SetRange("Vendor No.", Vendor."No.");
                            VendorLedgerEntry.SetRange("Posting Date", 0D, EndDate);
                            VendorLedgerEntry.SetRange("Currency Code", TempCurrency2.Code);
                            EntriesExists := not VendorLedgerEntry.IsEmpty();
                        until EntriesExists;
                        Vendor2 := Vendor;
                        Vendor2.SetRange("Date Filter", 0D, StartDate - 1);
                        Vendor2.SetRange("Currency Filter", TempCurrency2.Code);
                        Vendor2.CalcFields("Net Change");
                        StartBalance := Vendor2."Net Change";
                        VendorBalance := Vendor2."Net Change";

                        //HA - Show only open entries>>

                        StartBalance := 0;
                        CLEAR(DtldVendorLedgEntries3);
                        DtldVendorLedgEntries3.SETRANGE(DtldVendorLedgEntries3."Vendor No.", Vendor."No.");
                        DtldVendorLedgEntries3.SETRANGE(DtldVendorLedgEntries3."Posting Date", 0D, StartDate - 1);
                        DtldVendorLedgEntries3.SETRANGE(DtldVendorLedgEntries3."Currency Code", TempCurrency2.Code);
                        IF DtldVendorLedgEntries3.FINDSET() THEN
                            REPEAT
                                // IF VendorLedgerEntryOpen.GET(DtldVendorLedgEntries3."Vendor Ledger Entry No.") AND (VendorLedgerEntryOpen.Open = TRUE) THEN
                                //     StartBalance += DtldVendorLedgEntries3.Amount;
                                IF VendorLedgerEntryOpen.GET(DtldVendorLedgEntries3."Vendor Ledger Entry No.") then
                                    if VendorLedgerEntryOpen.Open = false then begin
                                        if CheckAppliedEntries.Get(VendorLedgerEntryOpen."Closed by Entry No.") then
                                            if EndDate >= CheckAppliedEntries."Posting Date" then
                                                StartBalance += DtldVendorLedgEntries3.Amount;
                                    end else
                                        StartBalance += DtldVendorLedgEntries3.Amount;

                            UNTIL DtldVendorLedgEntries3.NEXT() = 0;
                        VendorBalance := StartBalance;

                        //<<

                    end;

                    trigger OnPreDataItem()
                    begin
                        Vendor.CopyFilter("Currency Filter", TempCurrency2.Code);
                    end;
                }
                dataitem(AgingBandLoop; "Integer")
                {
                    DataItemTableView = SORTING(Number) WHERE(Number = FILTER(1 ..));
                    column(AgingDate1; Format(AgingDate[1] + 1))
                    {
                    }
                    column(AgingDate2; Format(AgingDate[2]))
                    {
                    }
                    column(AgingDate21; Format(AgingDate[2] + 1))
                    {
                    }
                    column(AgingDate3; Format(AgingDate[3]))
                    {
                    }
                    column(AgingDate31; Format(AgingDate[3] + 1))
                    {
                    }
                    column(AgingDate4; Format(AgingDate[4]))
                    {
                    }
                    column(AgingBandEndingDate; StrSubstNo(Text011Lbl, AgingBandEndingDate, PeriodLength, SelectStr(DateChoice + 1, Text013Txt)))
                    {
                    }
                    column(AgingDate41; Format(AgingDate[4] + 1))
                    {
                    }
                    column(AgingDate5; Format(AgingDate[5]))
                    {
                    }
                    column(AgingBandBufCol1Amt; TempAgingBandBuf."Column 1 Amt.")
                    {
                        AutoFormatExpression = TempAgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AgingBandBufCol2Amt; TempAgingBandBuf."Column 2 Amt.")
                    {
                        AutoFormatExpression = TempAgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AgingBandBufCol3Amt; TempAgingBandBuf."Column 3 Amt.")
                    {
                        AutoFormatExpression = TempAgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AgingBandBufCol4Amt; TempAgingBandBuf."Column 4 Amt.")
                    {
                        AutoFormatExpression = TempAgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AgingBandBufCol5Amt; TempAgingBandBuf."Column 5 Amt.")
                    {
                        AutoFormatExpression = TempAgingBandBuf."Currency Code";
                        AutoFormatType = 1;
                    }
                    column(AgingBandCurrencyCode; AgingBandCurrencyCode)
                    {
                    }
                    column(beforeCaption; beforeCaptionLbl)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        if Number = 1 then begin
                            ClearCompanyPicture();
                            if not TempAgingBandBuf.Find('-') then
                                CurrReport.Break();
                        end else
                            if TempAgingBandBuf.Next() = 0 then
                                CurrReport.Break();
                        AgingBandCurrencyCode := TempAgingBandBuf."Currency Code";
                        if AgingBandCurrencyCode = '' then
                            AgingBandCurrencyCode := GLSetup."LCY Code";
                    end;

                    trigger OnPreDataItem()
                    begin
                        if not IncludeAgingBand then
                            CurrReport.Break();
                    end;
                }
            }

            trigger OnAfterGetRecord()
            var
                VendorLedgerEntry: Record "Vendor Ledger Entry";
            begin
                TempAgingBandBuf.DeleteAll();
                CurrReport.Language := Language.GetLanguageIdOrDefault("Language Code");
                PrintLine := false;
                if PrintAllHavingBal then
                    PrintLine := true;

                if (not PrintLine) and PrintAllHavingEntry then begin
                    VendorLedgerEntry.SetRange("Vendor No.", "No.");
                    VendorLedgerEntry.SetRange("Posting Date", StartDate, EndDate);
                    CopyFilter("Currency Filter", VendorLedgerEntry."Currency Code");
                    PrintLine := not VendorLedgerEntry.IsEmpty();
                end;
                if not PrintLine then
                    CurrReport.Skip();

                FormatAddr.Vendor(VendorAddr, Vendor);
                PrintedVendorsList.Add("No.");

                IsFirstLoop := false;
            end;

            trigger OnPreDataItem()
            var
                VendorLedgerEntry: Record "Vendor Ledger Entry";
            begin
                VerifyDates();
                AgingBandEndingDate := EndDate;
                CalcAgingBandDates();

                CompanyInfo.Get();
                FormatAddr.Company(CompanyAddr, CompanyInfo);

                VendorLedgerEntry.Reset();
                VendorLedgerEntry.SetCurrentKey("Currency Code");
                TempCurrency2.Init();
                while VendorLedgerEntry.FindFirst() do begin
                    TempCurrency2.Code := VendorLedgerEntry."Currency Code";
                    TempCurrency2.Insert();
                    VendorLedgerEntry.SetFilter("Currency Code", '>%1', VendorLedgerEntry."Currency Code");
                end;

                if PrintAllHavingBal and not PrintAllHavingEntry then begin
                    SetAutoCalcFields("Balance (LCY)");
                    SetFilter("Balance (LCY)", '<>0');
                end;
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
                    field("Start Date"; StartDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Start Date';
                        ToolTip = 'Specifies the date from which the report or batch job processes information.';
                        Visible = false;
                    }
                    field("End Date"; EndDate)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'End Date';
                        ToolTip = 'Specifies the date to which the report or batch job processes information.';
                    }
                    field(ShowOverdueEntries; PrintEntriesDue)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Show Overdue Entries';
                        ToolTip = 'Specifies if you want overdue entries to be shown separately for each currency.';
                    }
                    group(Include)
                    {
                        Caption = 'Include';
                        field(IncludeAllVendorswithLE; PrintAllHavingEntry)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Include All Vendors with Ledger Entries';
                            MultiLine = true;
                            ToolTip = 'Specifies if you want entries displayed for Vendors that have ledger entries at the end of the selected period.';

                            trigger OnValidate()
                            begin
                                if not PrintAllHavingEntry then
                                    PrintAllHavingBal := true;
                            end;
                        }
                        field(IncludeAllVendorswithBalance; PrintAllHavingBal)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Include All Vendors with a Balance';
                            MultiLine = true;
                            ToolTip = 'Specifies if you want entries displayed for Vendors that have a balance.';

                            trigger OnValidate()
                            begin
                                if not PrintAllHavingBal then
                                    PrintAllHavingEntry := true;
                            end;
                        }
                        field(IncludeReversedEntries; PrintReversedEntries)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Include Reversed Entries';
                            ToolTip = 'Specifies if you want to include reversed entries in the report.';
                        }
                        field(IncludeUnappliedEntries; PrintUnappliedEntries)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Include Unapplied Entries';
                            ToolTip = 'Specifies if you want to include unapplied entries in the report.';
                        }
                    }
                    group("Aging Band")
                    {
                        Caption = 'Aging Band';
                        field(IncludeAgingBand; IncludeAgingBand)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Include Aging Band';
                            ToolTip = 'Specifies if you want an aging band to be included in the document. If you place a check mark here, you must also fill in the Aging Band Period Length and Aging Band by fields.';
                        }
                        field(AgingBandPeriodLengt; PeriodLength)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Aging Band Period Length';
                            ToolTip = 'Specifies the length of each of the four periods in the aging band, for example, enter "1M" for one month. The most recent period will end on the last day of the period in the Date Filter field.';
                        }
                        field(AgingBandby; DateChoice)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Aging Band by';
                            OptionCaption = 'Due Date,Posting Date';
                            ToolTip = 'Specifies if the aging band will be calculated from the due date or from the posting date.';
                        }
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                        ToolTip = 'Specifies that interactions with the contact are logged.';
                    }
                }
                group("Output Options")
                {
                    Caption = 'Output Options';
                    field(ReportOutput; SupportedOutputMethod)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Report Output';
                        OptionCaption = 'Print,Preview,PDF,Email,Excel,XML';
                        ToolTip = 'Specifies the output of the scheduled report, such as PDF or Word.';

                        trigger OnValidate()
                        var
                            CustomLayoutReporting: Codeunit "Custom Layout Reporting";
                        begin
                            ShowPrintIfEmailIsMissing := (SupportedOutputMethod = SupportedOutputMethod::Email);

                            case SupportedOutputMethod of
                                SupportedOutputMethod::Print:
                                    ChosenOutputMethod := CustomLayoutReporting.GetPrintOption();
                                SupportedOutputMethod::Preview:
                                    ChosenOutputMethod := CustomLayoutReporting.GetPreviewOption();
                                SupportedOutputMethod::PDF:
                                    ChosenOutputMethod := CustomLayoutReporting.GetPDFOption();
                                SupportedOutputMethod::Email:
                                    ChosenOutputMethod := CustomLayoutReporting.GetEmailOption();
                                SupportedOutputMethod::Excel:
                                    ChosenOutputMethod := CustomLayoutReporting.GetExcelOption();
                                SupportedOutputMethod::XML:
                                    ChosenOutputMethod := CustomLayoutReporting.GetXMLOption();
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
                            ToolTip = 'Specifies if you want to print also the statements for Vendors that have not been set up with a send-to email address.';
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
            InitRequestPageDataInternal();
        end;
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        GLSetup.Get();
        SalesSetup.Get();

        case SalesSetup."Logo Position on Documents" of
            SalesSetup."Logo Position on Documents"::"No Logo":
                ;
            SalesSetup."Logo Position on Documents"::Left:
                begin
                    CompanyInfo1.Get();
                    CompanyInfo1.CalcFields(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Center:
                begin
                    CompanyInfo2.Get();
                    CompanyInfo2.CalcFields(Picture);
                end;
            SalesSetup."Logo Position on Documents"::Right:
                begin
                    CompanyInfo3.Get();
                    CompanyInfo3.CalcFields(Picture);
                end;
        end;

        LogInteractionEnable := true;

        StartDate := 20220101D;
        EndDate := Today;
    end;

    // trigger OnPostReport()
    // var
    //     CusNo: Code[20];
    // begin
    //     if not IsReportInPreviewMode() then
    //         foreach CusNo in PrintedVendorsList do
    //             if Vendor.Get(CusNo) then begin
    //                 Vendor."Last Statement No." := Vendor."Last Statement No." + 1;
    //                 Vendor.Modify();
    //                 if LogInteraction then
    //                     SegManagement.LogDocument(
    //                       7, Format(Vendor."Last Statement No."), 0, 0, DATABASE::Vendor, Vendor."No.", Vendor."Salesperson Code", '',
    //                       Text003Txt + Format(Vendor."Last Statement No."), '');
    //             end;
    // end;

    trigger OnPreReport()
    begin
        InitRequestPageDataInternal();
    end;

    var
        TempAgingBandBuf: Record "Aging Band Buffer" temporary;
        CompanyInfo: Record "Company Information";
        CompanyInfo1: Record "Company Information";
        CompanyInfo2: Record "Company Information";
        CompanyInfo3: Record "Company Information";
        TempCurrency2: Record Currency temporary;
        DetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry";
        DtldVendorLedgEntries3: Record "Detailed Vendor Ledg. Entry";
        GLSetup: Record "General Ledger Setup";
        PurchInvHeader: Record "Purch. Inv. Header"; //HA>> Show Vendor invoice no.
        SalesSetup: Record "Sales & Receivables Setup";
        Vendor2: Record Vendor;
        CheckAppliedEntries: Record "Vendor Ledger Entry"; //HA>> Show open entries
        VendorLedgerEntryOpen: Record "Vendor Ledger Entry";
        FormatAddr: Codeunit "Format Address";
        Language: Codeunit Language;
        SegManagement: Codeunit SegManagement;
        PeriodLength: DateFormula;
        PeriodLength2: DateFormula;
        EntriesExists: Boolean;
        FirstVendorPrinted: Boolean;
        IncludeAgingBand: Boolean;
        IsFirstLoop: Boolean;
        IsFirstPrintLine: Boolean;
        isInitialized: Boolean;
        IsNewVendorCurrencyGroup: Boolean;
        LogInteraction: Boolean;
        [InDataSet]
        LogInteractionEnable: Boolean;
        PrintAllHavingBal: Boolean;
        PrintAllHavingEntry: Boolean;
        PrintEntriesDue: Boolean;
        PrintIfEmailIsMissing: Boolean;
        PrintLine: Boolean;
        PrintReversedEntries: Boolean;
        PrintUnappliedEntries: Boolean;
        [InDataSet]
        ShowPrintIfEmailIsMissing: Boolean;
        CurrencyCode3: Code[10];
        AgingBandCurrencyCode: Code[20];
        AgingBandEndingDate: Date;
        AgingDate: array[5] of Date;
        DueDate: Date;
        EndDate: Date;
        StartDate: Date;
        RemainingAmount: Decimal;
        StartBalance: Decimal;
        VendorBalance: Decimal;
        ChosenOutputMethod: Integer;
        BankAccNo_CompanyInfoCaptionLbl: Label 'Account No.';
        BankName_CompanyInfoCaptionLbl: Label 'Bank';
        beforeCaptionLbl: Label '..before';
        BlankEndDateErr: Label 'End Date must have a value.';
        BlankStartDateErr: Label 'Start Date must have a value.';
        CompanyInfoEmailCaptionLbl: Label 'Email';
        CompanyInfoHomepageCaptionLbl: Label 'Home Page';
        CurrReportPageNoCaptionLbl: Label 'Page';
        DocDateCaptionLbl: Label 'Document Date';
        DueDate_VendorLedgEntry2CaptionLbl: Label 'Due Date';
        EndDateCaptionLbl: Label 'Ending Date';
        GiroNo_CompanyInfoCaptionLbl: Label 'Giro No.';
        LastStatmntNo_VendorCaptionLbl: Label 'Statement No.';
        LbLVendorInvoiceNo: Label 'Vendor Invoice no.'; //HA>> Show Vendor invoice no.
        No1_VendorCaptionLbl: Label 'Vendor No.';
        PhoneNo_CompanyInfoCaptionLbl: Label 'Phone No.';
        PostDate_DtldVendorLedgEntriesCaptionLbl: Label 'Posting Date';
        StartDateCaptionLbl: Label 'Starting Date';
        StartDateLaterTheEndDateErr: Label 'Start date must be earlier than End date.';
        StatementCaptionLbl: Label 'Statement';

        Text001Lbl: Label 'Entries %1', Comment = '%1 is the currency code';
        Text002Lbl: Label 'Overdue Entries %1', Comment = '%1 is the currency code';
        Text005Txt: Label 'Multicurrency Application';
        Text006Txt: Label 'Payment Discount';
        Text007Txt: Label 'Rounding';
        Text008Err: Label 'You must specify the Aging Band Period Length.';
        Text010Err: Label 'You must specify Aging Band Ending Date.';
        Text011Lbl: Label 'Aged Summary by %1 (%2 by %3)', Comment = '%1 is ending date, %2 is period length, %3 is Due Date or Posting Date';
        Text012Err: Label 'Period Length is out of range.';
        Text013Txt: Label 'Due Date,Posting Date';
        Text014Txt: Label 'Application Writeoffs';
        Text036Txt: Label '-%1', Comment = 'Negating the period length: %1 is the period length';
        Total_CaptionLbl: Label 'Total';
        VATRegNo_CompanyInfoCaptionLbl: Label 'VAT Registration No.';
        VendorBalanceCaptionLbl: Label 'Running Total';
        PrintedVendorsList: List of [Code[20]];
        DateChoice: Option "Due Date","Posting Date";
        SupportedOutputMethod: Option Print,Preview,PDF,Email,Excel,XML;
        CompanyAddr: array[8] of Text[100];
        Description: Text[100];
        VendorAddr: array[8] of Text[100];

    local procedure GetDate(PostingDate: Date; DueDate: Date): Date
    begin
        if DateChoice = DateChoice::"Posting Date" then
            exit(PostingDate);

        exit(DueDate);
    end;

    local procedure CalcAgingBandDates()
    begin
        if not IncludeAgingBand then
            exit;
        if AgingBandEndingDate = 0D then
            Error(Text010Err);
        if Format(PeriodLength) = '' then
            Error(Text008Err);
        Evaluate(PeriodLength2, StrSubstNo(Text036Txt, PeriodLength));
        AgingDate[5] := AgingBandEndingDate;
        AgingDate[4] := CalcDate(PeriodLength2, AgingDate[5]);
        AgingDate[3] := CalcDate(PeriodLength2, AgingDate[4]);
        AgingDate[2] := CalcDate(PeriodLength2, AgingDate[3]);
        AgingDate[1] := CalcDate(PeriodLength2, AgingDate[2]);
        if AgingDate[2] <= AgingDate[1] then
            Error(Text012Err);
    end;

    local procedure UpdateBuffer(CurrencyCode: Code[10]; Date: Date; Amount: Decimal)
    var
        GoOn: Boolean;
        I: Integer;
    begin
        TempAgingBandBuf.Init();
        TempAgingBandBuf."Currency Code" := CurrencyCode;
        if not TempAgingBandBuf.Find() then
            TempAgingBandBuf.Insert();
        I := 1;
        GoOn := true;
        while (I <= 5) and GoOn do begin
            if Date <= AgingDate[I] then
                if I = 1 then begin
                    TempAgingBandBuf."Column 1 Amt." := TempAgingBandBuf."Column 1 Amt." + Amount;
                    GoOn := false;
                end;
            if Date <= AgingDate[I] then
                if I = 2 then begin
                    TempAgingBandBuf."Column 2 Amt." := TempAgingBandBuf."Column 2 Amt." + Amount;
                    GoOn := false;
                end;
            if Date <= AgingDate[I] then
                if I = 3 then begin
                    TempAgingBandBuf."Column 3 Amt." := TempAgingBandBuf."Column 3 Amt." + Amount;
                    GoOn := false;
                end;
            if Date <= AgingDate[I] then
                if I = 4 then begin
                    TempAgingBandBuf."Column 4 Amt." := TempAgingBandBuf."Column 4 Amt." + Amount;
                    GoOn := false;
                end;
            if Date <= AgingDate[I] then
                if I = 5 then begin
                    TempAgingBandBuf."Column 5 Amt." := TempAgingBandBuf."Column 5 Amt." + Amount;
                    GoOn := false;
                end;
            I := I + 1;
        end;
        TempAgingBandBuf.Modify();
    end;

    procedure SkipReversedUnapplied(var DetailedVendorLedgEntry: Record "Detailed Vendor Ledg. Entry"): Boolean
    var
        VendorLedgEntry: Record "Vendor Ledger Entry";
    begin
        if PrintReversedEntries and PrintUnappliedEntries then
            exit(false);
        if not PrintUnappliedEntries then
            if DetailedVendorLedgEntry.Unapplied then
                exit(true);
        if not PrintReversedEntries then begin
            VendorLedgEntry.Get(DetailedVendorLedgEntry."Vendor Ledger Entry No.");
            if VendorLedgEntry.Reversed then
                exit(true);
        end;
        exit(false);
    end;

    procedure InitializeRequest(NewPrintEntriesDue: Boolean; NewPrintAllHavingEntry: Boolean; NewPrintAllHavingBal: Boolean; NewPrintReversedEntries: Boolean; NewPrintUnappliedEntries: Boolean; NewIncludeAgingBand: Boolean; NewPeriodLength: Text[30]; NewDateChoice: Option; NewLogInteraction: Boolean; NewStartDate: Date; NewEndDate: Date)
    begin
        InitRequestPageDataInternal();

        PrintEntriesDue := NewPrintEntriesDue;
        PrintAllHavingEntry := NewPrintAllHavingEntry;
        PrintAllHavingBal := NewPrintAllHavingBal;
        PrintReversedEntries := NewPrintReversedEntries;
        PrintUnappliedEntries := NewPrintUnappliedEntries;
        IncludeAgingBand := NewIncludeAgingBand;
        Evaluate(PeriodLength, NewPeriodLength);
        DateChoice := NewDateChoice;
        LogInteraction := NewLogInteraction;
        StartDate := NewStartDate;
        EndDate := NewEndDate;
    end;

    /* local procedure IsReportInPreviewMode(): Boolean
    var
        MailManagement: Codeunit "Mail Management";
    begin
        exit(CurrReport.Preview or MailManagement.IsHandlingGetEmailBody());
    end; */

    procedure InitRequestPageDataInternal()
    begin
        if isInitialized then
            exit;

        isInitialized := true;

        if (not PrintAllHavingEntry) and (not PrintAllHavingBal) then
            PrintAllHavingBal := true;

        LogInteraction := SegManagement.FindInteractTmplCode(7) <> '';
        LogInteractionEnable := LogInteraction;

        if Format(PeriodLength) = '' then
            Evaluate(PeriodLength, '<1M+CM>');

        PrintIfEmailIsMissing := SupportedOutputMethod = SupportedOutputMethod::Email;
    end;

    local procedure VerifyDates()
    begin
        if StartDate = 0D then
            Error(BlankStartDateErr);
        if EndDate = 0D then
            Error(BlankEndDateErr);
        if StartDate > EndDate then
            Error(StartDateLaterTheEndDateErr);
    end;

    local procedure ClearCompanyPicture()
    begin
        if FirstVendorPrinted then begin
            Clear(CompanyInfo.Picture);
            Clear(CompanyInfo1.Picture);
            Clear(CompanyInfo2.Picture);
            Clear(CompanyInfo3.Picture);
        end;
        FirstVendorPrinted := true;
    end;
}