page 50002 "Logistic Worksheet Allocation"
{
    PageType = List;
    SourceTable = 50002;
    ApplicationArea = All;
    UsageCategory = Lists;
    DelayedInsert = true;

    layout
    {
        area(content)
        {
            field("Total Con. Item Qty"; rec."Total Con. Item Qty")
            {
                ApplicationArea = All;
            }


            repeater(Group)
            {
                field("Container No."; rec."Container No.")
                {
                    ApplicationArea = All;
                    Caption = 'Container No.';
                    editable = MEditable;

                    trigger OnAssistEdit()
                    begin
                        rec.ContainerOnLookup();
                    end;
                }
                field("Item No."; rec."Item No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Line No."; rec."Line No.")
                {
                    ApplicationArea = All;
                    Editable = False;
                }
                field("Doc. Type"; rec."Doc. Type")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Doc. No."; rec."Doc. No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Doc. Line No."; rec."Doc. Line No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(UOM; rec.UOM)
                {
                    ApplicationArea = All;
                }
                field(Quantity; rec.Quantity)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CurrPage.update(true);
                        rec.CalcFields("Total Con. Item Qty");
                        if rec."Total Con. Item Qty" > gQty then
                            error('Order Qty %1 is less than Allocated %2', gQty, rec."Total Con. Item Qty");
                    end;
                }
                field("Unit Cost"; rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field(Location; rec.Location)
                {
                    Editable = false;
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
    trigger OnAfterGetRecord();
    begin
        CurrPage.Update(False);
        rec.CalcFields("Total Con. Item Qty");
    end;

    trigger OnAfterGetCurrRecord();
    begin
        MEditable := True;
        if rec."Doc. Type" in [rec."Doc. Type"::"Negative Adjmt.", rec."Doc. Type"::Sale, rec."Doc. Type"::Transfer] then
            MEditable := False;

        CurrPage.Update(False);
        rec.CalcFields("Total Con. Item Qty");
        //CurrPage."Use By Date".EDITABLE(TRUE);
        //CurrPage."Date Received".EDITABLE(TRUE);
        //CurrPage."Date Shipped".VISIBLE(TRUE);

        if rec."Total Con. Item Qty" > gQty then
            message('Order Qty %1 is less than Allocated %2', gQty, rec."Total Con. Item Qty");

        IF rec."Doc. Type" = 0 THEN BEGIN
            //    CurrPage."Date Shipped".VISIBLE(FALSE);
            BLShipment := '';
            if recPH.GET(1, rec."Doc. No.") then
                BLShipment := recPH."Vendor Shipment No.";
        END;

        IF rec."Doc. Type" = 1 THEN BEGIN
            LogisticWorksheet.RESET;
            LogisticWorksheet.SETRANGE("Container No.", rec."Container No.");
            LogisticWorksheet.SETRANGE("Doc. Type", 0);
            IF NOT LogisticWorksheet.FINDFIRST THEN
                LogisticWorksheet.INIT;
            BLShipment := LogisticWorksheet."BL/Shipment No.";
            //CurrPage."Use By Date".EDITABLE(FALSE);
            //CurrPage."Date Received".EDITABLE(FALSE);
        END;

    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        rec."Doc. Type" := gDocType;
        rec."Doc. No." := gDocNo;
        rec."Doc. Line No." := gDocLineNo;
        rec.Location := gLocationCode;
        rec."Item No." := gItem;
        //rec."Allocated Line" := gDocLineNo;
    end;

    var
        gDocType: Option Purchase,Sale,Transfer;
        gDocNo: Code[20];
        gDocLineNo: Integer;
        gLocationCode: Code[20];
        gItem: Code[20];
        gQty: decimal;
        BLShipment: Text[80];
        recPH: Record 38;
        LogisticWorksheet: Record 50003;
        MEditable: boolean;

    procedure gParameter(pDocType: Option Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output; pDocNo: Code[20]; pDocLineNo: Integer; pLocationCode: Code[20]; pItem: Code[20]; pQty: Decimal);
    begin
        gDocType := pDocType;
        gDocNo := pDocNo;
        gDocLineNo := pDocLineNo;
        gLocationCode := pLocationCode;
        gItem := pItem;
        gQty := pQty;
    end;
}
