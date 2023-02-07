report 50011 "Sales UnAllocated"
{
    ApplicationArea = All;
    Caption = 'Sales Un-Allocated';
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
            dataitem(SalesLine; "Sales Line")
            {
                DataItemLink = "No." = field("No.");
                DataItemTableView = sorting("No.") where(Type = filter(Item), "No." = filter(<> ''), Quantity = filter(<> 0));
                DataItemLinkReference = Item;
                column(ByGroup; ByGroup) { }
                column(ItemDesc; Item.Description) { }
                column(SL_DocType; "Document Type") { }
                column(SL_DocNo; "Document No.") { }
                column(SL_SellToCust; "Sell-to Customer No.") { }
                column(SL_SellToCustName; SalesHdr."Sell-to Customer Name") { }
                column(SL_ShipToCustName; SalesHdr."Ship-to Address") { }
                column(SL_ItemNo; "No.") { }
                column(SL_Description; "Description") { }
                column(SL_Quantity; Quantity) { }
                column(SL_Allocated; "Allocated Qty") { }
                column(SL_Shipped; "Quantity Shipped") { }
                column(SL_Invoiced; "Quantity Invoiced") { }

                trigger OnPreDataItem()
                begin
                    SETRANGE("Document Type", "Document Type"::Order);
                end;

                trigger OnAfterGetRecord()
                begin
                    if Type <> Type::Item then
                        currreport.skip;

                    if (Quantity = 0) or (Quantity = "Quantity Shipped") then
                        currreport.skip;

                    calcfields("Allocated Qty");
                    if ByGroup = ByGroup::"Sales UnAllocated" then begin
                        if (Quantity - "Quantity Shipped") = "Allocated Qty" then
                            currreport.skip;
                    end;

                    SalesHdr.GET("Document Type", "Document No.");

                end;

                trigger OnPostDataItem()
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
            LayoutFile = './3. Report Format/SalesUnAllocated.rdl';

        }
        layout(ReportWORD)
        {
            Type = word;
            LayoutFile = './3. Report Format/SalesUnAllocated.docx';
        }
    }

    trigger OnInitReport()
    begin
        IgnoreZeroBalance := true;
    end;

    var
        ByGroup: option "Sales All","Sales UnAllocated";
        IgnoreZeroBalance: boolean;
        SalesHdr: record "Sales Header";
}