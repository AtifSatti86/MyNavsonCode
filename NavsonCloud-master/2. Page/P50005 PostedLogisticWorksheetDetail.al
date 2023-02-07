page 50005 "Posted Logistic Wrks - Detail"
// version Ashish
{
    caption = 'Posted Logistic Wrk - Detail';
    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = true;
    PageType = List;
    SourceTable = "Posted Logc WrkSheet Alloc";
    UsageCategory = Lists;
    ApplicationArea = All;
    Editable = true;

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
                field("Line No."; rec."Line No.")
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
                field("Doc. Line No."; rec."Doc. Line No.")
                {
                    ApplicationArea = All;
                }
                field("Date Received"; rec."Date Received")
                {
                    ApplicationArea = All;
                }
                field(UOM; rec.UOM)
                {
                    ApplicationArea = All;
                }
                field(Quantity; rec.Quantity)
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
                field("Allocated Line"; rec."Allocated Line")
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
                field("Use By Date"; rec."Use By Date")
                {
                    ApplicationArea = All;
                }
                field("Balance Stock"; rec."Balance Stock")
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
        if uppercase(USERID) <> 'ASHISH' then
            error('Not Authorised');
    end;

}
