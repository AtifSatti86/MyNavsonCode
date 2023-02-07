pageextension 50042 "Sales Order Ext" extends "Sales Order"
{
    layout
    {

        modify("Due Date")
        {
            Visible = false;
        }
        modify("Promised Delivery Date")
        {
            visible = false;
        }
        modify("Your Reference")
        {
            Caption = 'Cust. PO No.';
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Opportunity No.")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }
        modify(Status)
        {
            Visible = false;
        }
        modify("Work Description")
        {
            Caption = 'Note';
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("Payment Discount %")
        {
            Visible = false;
        }
        modify("Pmt. Discount Date")
        {
            Visible = false;
        }
        modify("Direct Debit Mandate ID")
        {
            Visible = false;
        }
        modify("Foreign Trade")
        {
            Visible = false;
        }
        modify("Prepayment %")
        {
            Visible = false;
        }
        modify("Prepayment Due Date")
        {
            Visible = false;
        }
        modify("Compress Prepayment")
        {
            Visible = false;
        }
        modify("Prepmt. Payment Discount %")
        {
            Visible = false;
        }
        modify("Prepmt. Payment Terms Code")
        {
            Visible = false;
        }
        modify("Prepmt. Pmt. Discount Date")
        {
            Visible = false;
        }
        modify("Shipping Time")
        {
            Visible = false;
        }
        modify("Outbound Whse. Handling Time")
        {
            Visible = false;
        }
        modify("Late Order Shipping")
        {
            Visible = false;
        }
        modify("Combine Shipments")
        {
            Visible = false;
        }

        addafter(Status)
        {
            field("Order Status"; rec."Order Status")
            {
                ApplicationArea = ALL;
            }
            field("Customer Finance Charges"; rec."Customer Finance Charges")
            {
                ApplicationArea = ALL;
            }
        }
        addafter("Shipment Date")
        {
            field("Fright Charges"; rec."Frieght Charges")
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
        addlast(Control4)
        {
            field("Ship-to Phone"; ShipTo."Phone No.")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Ship-to Email"; ShipTo."E-Mail")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addlast(factboxes)
        {
            part("Sales Order Ext"; "SO PO Link FactBox")
            {
                ApplicationArea = ALL;
                SubPageLink = "SO No." = FIELD("No.");
            }
            part("Allocation FactBox"; "Allocation FactBox")
            {
                ApplicationArea = ALL;
                Provider = SalesLines;
                SubPageLink = "Doc. No." = FIELD("Document No."),
                              "Doc. Line No." = FIELD("Line No.");
            }
            part("Posted Allocation FactBox"; "Posted Allocation FactBox")
            {
                ApplicationArea = ALL;
                Provider = SalesLines;
                SubPageLink = "Sales Order" = FIELD("Document No."),
                              "Doc. Line No." = FIELD("Line No.");
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        addafter("&Order Confirmation")
        {
            action("SO PO Link")
            {
                ApplicationArea = All;
                Caption = 'SO PO Link';
                ToolTip = 'SO PO Link';

                trigger OnAction()
                begin
                    clear(pSOPO);

                    tSOPO.reset;
                    tSOPO.SetRange("SO No.", rec."No.");
                    if tSOPO.findfirst then;

                    pSOPO.Parameter(rec."No.", '');
                    pSOPO.SetTableView(tSOPO);
                    pSOPO.RunModal();

                end;
            }
            action("Print Delivery Note")
            {
                ApplicationArea = All;
                Caption = 'Print Delivery Note';
                ToolTip = 'Print Delivery Note';

                trigger OnAction()
                begin
                    SalesHeader.reset;
                    SalesHeader.SETRANGE("Document Type", rec."Document Type");
                    SalesHeader.Setrange("No.", rec."No.");
                    report.run(50004, True, True, SalesHeader);
                end;
            }
            action("SO Update")
            {
                ApplicationArea = All;
                trigger Onaction()
                begin
                    if uppercase(USERID) <> 'ASHISH' then
                        error('Not Authorised');
                    SalesHdr.reset;
                    if SalesHdr.findfirst then
                        repeat
                            if Customer.get(saleshdr."Sell-to Customer No.") then begin
                                Saleshdr."Customer Finance Charges" := customer."Customer Finance Charges";
                                Saleshdr."Salesperson Code" := customer."Salesperson Code";
                                SalesHdr.modify;
                            end;
                        until SalesHdr.next = 0;

                end;
            }
            action("Item Update")
            {
                ApplicationArea = All;
                trigger Onaction()
                begin
                    if uppercase(USERID) <> 'ASHISH' then
                        error('Not Authorised');

                    Item.reset;
                    if Item.findfirst then
                        repeat
                            if not ISUM.get(Item."No.", Item."Base Unit of Measure") then begin
                                ISUM.init;
                                ISUM."Item No." := Item."No.";
                                ISUM.Code := Item."Base Unit of Measure";
                                ISUM."Qty. per Unit of Measure" := 1;
                                ISUM.Insert;
                            end;

                        until Item.next = 0;

                end;
            }

            action("Posted Allocation Fix")
            {
                ApplicationArea = All;
                trigger Onaction()
                begin
                    if uppercase(USERID) <> 'ASHISH' then
                        error('Not Authorised');

                    PA.reset;
                    PA.SETFILTER("Doc. Type", '%1', PA."Doc. Type"::Transfer);
                    PA.SETFILTER(Quantity, '>%1', 0);
                    if PA.findfirst then
                        repeat
                            if PA.Quantity > 0 then begin
                                PA."Allocated Line" := PA."Line No.";
                                PA.modify;
                            end;
                        /*
                        PA1.reset;
                        PA1.SETRANGE("Container No.", PA."Container No.");
                        PA1.SETRANGE("Item No.", PA."Item No.");
                        PA1.SETFILTER("Doc. Type", '%1|%2', PA1."Doc. Type"::Purchase, PA1."Doc. Type"::"Positive Adjmt.");
                        if PA1.findfirst then begin
                            PA."Allocated Line" := PA1."Line No.";
                            PA.modify;
                        end;
                        */
                        until PA.next = 0;
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        if Not ShipTo.get(rec."Sell-to Customer No.", rec."Ship-to Code") then
            ShipTo.init;
    end;

    var
        pSOPO: page 50006;
        tSOPO: Record 50004;
        SalesHdr: record 36;
        Customer: record 18;
        Item: record 27;
        ISUM: record "Item Unit of Measure";

        SalesHeader: record "Sales Header";
        PA: Record 50003;
        PA1: record 50003;
        ShipTo: record "Ship-to Address";
}