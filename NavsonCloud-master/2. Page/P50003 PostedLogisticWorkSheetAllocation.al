page 50003 "Posted Logc WrkSheet Alloc"
{
    // version Ashish

    Editable = False;
    InsertAllowed = false;
    ModifyAllowed = False;
    DeleteAllowed = false;
    PageType = List;
    SourceTable = "Posted Logc WrkSheet Alloc";
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Container No."; rec."Container No.")
                {
                    ApplicationArea = All;
                }
                field("Item No."; rec."Item No.")
                {
                    ApplicationArea = All;
                }
                field("Doc. Type"; rec."Doc. Type")
                {
                    ApplicationArea = All;
                }
                field("Doc. No."; rec."Doc. No.")
                {
                    ApplicationArea = All;
                }

                field(UOM; rec.UOM)
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field(Location; rec.Location)
                {
                    ApplicationArea = All;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Qty. Allocated"; rec."Qty. Allocated")
                {
                    ApplicationArea = All;
                }
                field("Qty. Sold"; rec."Qty. Sold")
                {
                    ApplicationArea = All;
                }
                field("Free Stock"; FreeStock)
                {
                    ApplicationArea = All;
                }

                field("Balance Stock"; rec."Balance Stock")
                {
                    ApplicationArea = All;
                }

                field("Date Received"; rec."Date Received")
                {
                    ApplicationArea = All;
                }
                field("Use By Date"; rec."Use By Date")
                {
                    ApplicationArea = All;
                }
                field("Date Shipped"; rec."Date Shipped")
                {
                    ApplicationArea = All;
                }
                field("BL/Shipment No."; rec."BL/Shipment No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Allocated Line"; rec."Allocated Line")
                {
                    ApplicationArea = All;
                }
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Doc. Line No."; rec."Doc. Line No.")
                {
                    ApplicationArea = All;
                }
                field("Prod. Date"; rec."Prod. Date")
                {
                    ApplicationArea = All;
                }
                field("Batch No."; rec."Batch No.")
                {
                    ApplicationArea = All;
                }
                field("Date Filter"; rec."Date Filter")
                {
                    ApplicationArea = All;
                }
                field("Item Description"; rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field("Sales Order"; rec."Sales Order")
                {
                    ApplicationArea = All;
                }
                field("Purchase Order"; rec."Purchase Order")
                {
                    ApplicationArea = All;
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

    trigger OnAfterGetRecord()
    begin
        FreeStock := 0;
        rec.calcfields("Balance Stock", "Qty. Allocated");
        if (rec."Balance Stock" > 0) and (rec.Quantity > 0) then
            freeStock := rec."Balance Stock" + rec."Qty. Allocated";
    end;

    trigger OnAfterGetCurrRecord()
    begin
        FreeStock := 0;
        rec.calcfields("Balance Stock", "Qty. Allocated");
        if (rec."Balance Stock" > 0) and (rec.Quantity > 0) then
            freeStock := rec."Balance Stock" + rec."Qty. Allocated";
    end;

    var
        gRemainingSTK: Decimal;
        decWhseCost: Decimal;
        codAllWks: Codeunit 50002;
        FreeStock: Decimal;
}

