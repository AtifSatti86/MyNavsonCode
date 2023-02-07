page 50013 "Sales Quote Creation"
{
    // version Navson
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = Item;
    SourceTableView = SORTING("No.");

    layout
    {
        area(content)
        {
            Field("For Customer"; (CustomerNo + ' - ' + CustomerName))
            {
                ApplicationArea = All;
                Caption = 'For Customer';
                Editable = False;
            }
            Field("Ship-To"; ShipTo)
            {
                ApplicationArea = All;
                Caption = 'Ship-To Customer';
                ToolTip = 'Leave blank if same customer address';
            }
            repeater(Group)
            {
                field("No."; rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; rec.Description)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Sales Unit of Measure"; rec."Sales Unit of Measure")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Quote Qty"; ItemQty)
                {
                    ApplicationArea = All;
                    DecimalPlaces = 0;

                    trigger OnValidate();
                    begin
                        CreateQuoteQty(rec."No.", ItemQty);
                    end;
                }
            }
        }
    }

    actions
    {
        area(creation)
        {
            action("Create Quote")
            {
                ApplicationArea = all;
                Image = Quote;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction();
                begin
                    IF CustomerNo = '' THEN
                        ERROR('Customer No. must be selected !!');

                    TempItem.reset;
                    TempItem.Setfilter("Reorder Quantity", '>%1', 0);
                    if not TempItem.findfirst then
                        error('Quantity must be specified.');

                    IF NOT CONFIRM(STRSUBSTNO('This will create the sales Quote for the customer %1.\\Do you want to continue?', CustomerNo)
                      , FALSE) THEN
                        ERROR('Rejected by the user');
                    if CreateSalesQuote then
                        MESSAGE('Customer %1 %2 Quote Created %3', CustomerNo, CustomerName, SalesHeader."No.")
                    else
                        message('No Qoute created !!');

                    CurrPage.close;
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        ItemQty := GetQuoteQty(rec."No.");
    end;

    trigger OnOpenPage();
    begin
        TempItem.DELETEALL;
    end;

    var
        CustomerNo: Code[20];
        CustomerName: text[80];
        ShipTo: code[20];
        Customer: record Customer;
        TempItem: Record Item temporary;
        ItemQty: Decimal;
        SalesHeader: record "Sales Header";
        SalesLine: record "Sales Line";
        LineNo: Integer;

    procedure pParameterSales(pCustomerNo: Code[20]);
    begin
        CustomerNo := pCustomerNo;
        Customer.get(CustomerNo);
        CustomerName := Customer.Name;
    end;

    local procedure GetQuoteQty(pItemNo: Code[20]) QuoteQty: Decimal;
    begin
        QuoteQty := 0;

        IF TempItem.GET(pItemNo) THEN
            QuoteQty := TempItem."Reorder Quantity";
    end;

    local procedure CreateQuoteQty(pItemNo: Code[20]; pQuoteQty: Decimal);
    begin
        IF NOT TempItem.GET(pItemNo) THEN BEGIN
            TempItem.INIT;
            TempItem."No." := pItemNo;
            TempItem.INSERT;
        END;

        TempItem."Reorder Quantity" := pQuoteQty;
        TempItem.MODIFY;
        COMMIT;
    end;

    local procedure CreateSalesQuote(): boolean;
    begin
        SalesHeader.Init;
        SalesHeader."Document Type" := SalesHeader."Document Type"::Quote;
        SalesHeader."No." := '';
        SalesHeader.insert(True);
        SalesHeader.validate("Sell-to Customer No.", CustomerNo);
        SalesHeader.modify(True);

        LineNo := 0;
        TempItem.reset;
        TempItem.Setfilter("Reorder Quantity", '>%1', 0);
        if TempItem.findfirst then
            repeat
                LineNo += 10000;
                SalesLine."Document Type" := SalesHeader."Document Type";
                SalesLine."Document No." := SalesHeader."No.";
                SalesLine."Line No." := LineNo;
                SalesLine.insert(true);
                SalesLine.validate(Type, SalesLine.Type::Item);
                SalesLine.validate("No.", TempItem."No.");
                SalesLine.validate(Quantity, TempItem."Reorder Quantity");
                SalesLine.Modify(true);

            until TempItem.next = 0;
        commit;
        exit(true);
    end;
}
