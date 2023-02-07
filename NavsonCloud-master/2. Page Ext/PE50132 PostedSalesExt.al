pageextension 50132 "Posted Sales Inv Ext" extends "Posted Sales Invoice"
{
    layout
    {
        modify("Shipment Method Code")
        {
            visible = true;
        }
        addlast(General)
        {
            field("Customer Finance Charges"; rec."Customer Finance Charges")
            {
                ApplicationArea = ALL;
            }
            field("Order Status"; rec."Order Status")
            {
                ApplicationArea = ALL;
            }

            field("Cust. PO No."; rec."Your Reference")
            {
                Caption = 'Cust. PO No.';
                ApplicationArea = ALL;

            }
            field("VAT Bus. Posting Group"; rec."VAT Bus. Posting Group")
            {
                ApplicationArea = ALL;
            }

            field("Order Date"; rec."Order Date")
            {
                ApplicationArea = ALL;

            }
        }
        addlast("Shipping and Billing")
        {
            field("Frieght Charges"; rec."Frieght Charges")
            {
                ApplicationArea = ALL;
            }
            field("W/H Booking"; rec."W/H Booking")
            {
                ApplicationArea = ALL;
            }
            field("Customer W/H Reference"; rec."Customer W/H Reference")
            {
                ApplicationArea = ALL;
            }
            field("Shipment Ref. No."; rec."Shipping Ref No.")
            {
                ApplicationArea = ALL;
            }
            field("Delivery Time"; rec."Delivery Time")
            {
                ApplicationArea = ALL;
            }
        }
        addlast(factboxes)
        {
            part("Posted Allocation FactBox"; "Posted Allocation FactBox")
            {
                ApplicationArea = ALL;
                Provider = SalesInvLines;
                SubPageLink = "Sales Order" = FIELD("Order No."),
                              "Doc. Line No." = FIELD("Order Line No.");
            }
            part("Sales List Ext"; "SO PO Link FactBox")
            {
                ApplicationArea = ALL;
                SubPageLink = "SO No." = FIELD("Order No.");
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
}