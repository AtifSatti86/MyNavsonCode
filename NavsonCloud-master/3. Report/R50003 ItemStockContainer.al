report 50003 "Item Stock Container"
{
    ApplicationArea = All;
    Caption = 'Item Stock Container';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;
    DataAccessIntent = ReadOnly;
    DefaultRenderingLayout = ReportRDLC;

    dataset
    {
        dataitem(Item; Item)
        {
            RequestFilterFields = "No.", "Date Filter";
            PrintOnlyIfDetail = true;
            column(ByGroup; ByGroup) { }
            dataitem(PLWA; "Posted Logc WrkSheet Alloc")
            {
                DataItemLink = "Item No." = field("No.");
                DataItemTableView = sorting("Item No.", "Container No.");
                DataItemLinkReference = Item;

                column(Location; Location) { }
                column(Item_No_; "Item No.") { }
                column(Item_Description; "Item Description") { }
                column(Container_No_; "Container No.") { }
                column(Posting_Date; "Posting Date") { }
                column(Quantity; Quantity) { }
                column(Qty__Allocated; "Qty. Allocated") { }
                column(Qty__Sold; "Qty. Sold") { }
                column(Balance_Stock; "Balance Stock") { }
                column(ItemInventory; Item.Inventory) { }

                trigger OnPreDataItem()
                var
                begin
                    SETFILTER("Date Filter", Item.GetFilter("Date Filter"));
                    SETFILTER("Posting Date", Item.GETFILTER("Date Filter"));

                    SETFILTER("Doc. Type", '%1|%2|%3', "Doc. Type"::"Positive Adjmt.", "Doc. Type"::Purchase, "Doc. Type"::Transfer);
                    SETFILTER(Quantity, '>%1', 0);
                end;

                trigger OnAfterGetRecord()
                var
                begin
                    CalcFields("Balance Stock", "Qty. Sold", "Qty. Allocated");
                    if IgnoreZeroBalance and ("Balance Stock" = 0) then
                        currreport.skip;
                    if ByGroup in [ByGroup::"Item Container Location (Summary)"] then
                        Item.SETFILTER("Location Filter", Location);
                    Item.CalcFields(Inventory);
                end;

                trigger OnPostDataItem()
                var
                begin

                end;
            }
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(ByGroup; ByGroup)
                    {
                        ApplicationArea = All;
                        Caption = 'Report Selection';
                    }
                    field(IgnoreZeroBalance; IgnoreZeroBalance)
                    {
                        ApplicationArea = All;
                        Caption = 'Remove Zero Balance';
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    rendering
    {
        layout(ReportRDLC)
        {
            Type = RDLC;
            LayoutFile = './3. Report Format/StockByContainer.rdl';

        }
        layout(ReportWORD)
        {
            Type = word;
            LayoutFile = './3. Report Format/StockByContainer.docx';
        }
    }

    trigger OnInitReport()
    begin
        IgnoreZeroBalance := true;
    end;

    var
        ByGroup: option "Item Container","Item Container Location (Summary)";
        IgnoreZeroBalance: boolean;
        SalesHdr: record "Sales Header";
}