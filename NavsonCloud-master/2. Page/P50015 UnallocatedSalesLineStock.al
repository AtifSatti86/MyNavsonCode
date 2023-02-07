page 50015 "Unallocated SalesLine"
{
    ApplicationArea = All;
    Caption = 'Unallocated SalesLine';
    PageType = List;
    UsageCategory = Lists;
    SourceTable = "Sales line";
    SourceTableTemporary = true;
    Editable = False;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Document Type"; rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field(Customer; SalesHdr."Sell-to Customer Name")
                {
                    ApplicationArea = All;
                }
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Description"; rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Location Code"; rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field(AllocatedQuantity; rec."Allocated Qty")
                {
                    ApplicationArea = All;
                }
                field("Quantity Shipped"; rec."Quantity Shipped")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Shipment Date"; rec."Shipment Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; SalesHdr."Document Date")
                {
                    ApplicationArea = All;
                }
            }
        }

        area(factboxes)
        {
            part("Stock FactBox"; "Available Stock Factbox")
            {
                ApplicationArea = ALL;
                Caption = 'Avaliable Stock';
                SubPageLink = "Item No." = FIELD("No.");
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Open Sales Order")
            {
                ApplicationArea = All;
                Image = Quote;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction();
                begin
                    SalesHdr.GET(rec."Document Type", rec."Document No.");
                    SalesHdr.SETRECFILTER;
                    PAGE.RUNMODAL(42, SalesHdr);
                end;
            }
        }
    }
    trigger OnAfterGetRecord();
    begin
        SalesHdr.GET(rec."Document Type", rec."Document No.");
        rec.calcfields("Allocated Qty");
    end;

    trigger OnOpenPage();
    begin
        UpdateTempTable;
    end;

    var
        SalesLine: Record "Sales Line";
        SalesHdr: Record "Sales Header";

    local procedure UpdateTempTable();
    begin
        SalesLine.RESET;
        SalesLine.SETRANGE("Document Type", SalesLine."Document Type"::Order);
        SalesLine.SETRANGE(Type, SalesLine.Type::Item);
        SalesLine.SETFILTER("No.", '<>%1', '');
        SalesLine.SETFILTER("Quantity", '<>%1', 0);
        IF SalesLine.FINDFIRST THEN
            REPEAT
                SalesLine.calcfields("Allocated Qty");
                if (SalesLine.Quantity - SalesLine."Quantity Shipped") <> SalesLine."Allocated Qty" then BEGIN
                    Rec.TRANSFERFIELDS(SalesLine);
                    Rec.Insert;
                end;
            UNTIL SalesLine.NEXT = 0;
    end;
}
