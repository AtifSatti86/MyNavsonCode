pageextension 50130 "Posted Sales Shipment Ext" extends "Posted Sales Shipment"
{
    layout
    {
        addlast(factboxes)
        {
            part("Sales List Ext"; "Posted Allocation FactBox")
            {
                ApplicationArea = ALL;
                Provider = SalesShipmLines;
                SubPageLink = "Sales Order" = FIELD("Order No."),
                              "Doc. Line No." = FIELD("Order Line No.");
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
}