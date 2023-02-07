page 50004 "Logc Wrk Allocation List"
{
    // version Ashish

    PageType = List;
    SourceTable = 50002;

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
                field("In-Transit"; rec."In-Transit")
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
                field("Item Description"; rec."Item Description")
                {
                    ApplicationArea = All;
                }
                field("Customer Name"; rec."Customer Name")
                {
                    ApplicationArea = All;
                }
                field("Ship To Name"; rec."Ship To Name")
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
