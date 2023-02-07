report 50001 "ILE vs Allocation"
{
    DefaultRenderingLayout = ReportRDLC;
    ApplicationArea = Basic, Suite;
    Caption = 'ILE vs Allocation';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    DataAccessIntent = ReadOnly;

    dataset
    {
        dataitem(Item; Item)
        {
            PrintOnlyIfDetail = true;
            DataItemTableView = SORTING("No.");
            column(ItemNo; "No.")
            {
            }
            column(Item_Description; Description)
            {
            }
            dataitem(Location; Location)
            {
                DataItemTableView = SORTING("Code");
                column(Loc_Code; Code)
                {
                }
                column(IleStock; IleStock)
                {
                }
                column(AllocStock; AllocStock)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    IleStock := 0;
                    AllocStock := 0;

                    ILE.reset;
                    Ile.Setrange("Item no.", Item."No.");
                    ile.setrange("Location Code", location.Code);
                    ile.CalcSums(Quantity);
                    IleStock := ile.Quantity;

                    Alloc.reset;
                    Alloc.SETRANGE("Item No.", Item."No.");
                    Alloc.SETRAnge("Location", location.Code);
                    alloc.calcsums(Quantity);
                    AllocStock := Alloc.Quantity;

                    if ShowDiff then
                        if IleStock = AllocStock then
                            currreport.skip;
                end;

                trigger OnPreDataItem()
                begin
                    if findfirst then;
                end;
            }
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
            LayoutFile = './3. Report Format/ILEvsAllocation.rdl';
        }
        layout(ReportWORD)
        {
            Type = word;
            LayoutFile = './3. Report Format/ILEvsAllocation.docx';
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
        IleStock: decimal;
        AllocStock: decimal;
        ILE: record "Item Ledger Entry";
        Alloc: record "Posted Logc WrkSheet Alloc";
        ShowDiff: Boolean;

}

