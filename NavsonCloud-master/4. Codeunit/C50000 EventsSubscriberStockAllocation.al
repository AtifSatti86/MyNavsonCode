codeunit 50000 "Events Subscriber Stk Alloc"
{
    [EventSubscriber(ObjectType::Table, 111, 'OnAfterInsertEvent', '', true, true)]
    local procedure SalesShipmentLineInsert(var Rec: Record "Sales Shipment Line")
    var
        SalesLn: record 37;
        recLWA: record 50002;
        recLWA1: record 50002;
        recLW: record 50003;
        LogAllMgt: Codeunit 50002;

    begin
        if rec."Type" <> rec."Type"::Item then
            exit;

        if rec.Quantity = 0 then
            exit;

        IF LogAllMgt.CheckStockAllocation THEN BEGIN
            recLWA.RESET;
            recLWA.SETRANGE("Doc. No.", rec."Order No.");
            recLWA.SETRANGE("Doc. Line No.", rec."Order Line No.");
            recLWA.SETRANGE("Item No.", rec."No.");
            //recLWA.SETFILTER(Quantity, '<>%1', 0);
            recLWA.FINDSET;
            REPEAT
                if recLWA.Quantity <> 0 then begin
                    CLEAR(recLW);
                    recLW.TRANSFERFIELDS(recLWA);
                    recLW."Doc. No." := rec."Document No.";
                    recLW."Date Received" := recLWA."Date Received";
                    recLW."Date Shipped" := TODAY;
                    recLW."Date Shipped" := recLWA."Date Shipped";
                    recLW."Unit Cost" := rec."Unit Cost (LCY)";
                    recLW.UOM := rec."Unit of Measure";
                    recLW."Posting Date" := rec."Posting Date";
                    recLW."Line No." := 0;
                    recLW.Quantity := -recLW.Quantity;
                    recLW.INSERT(TRUE);

                    recLWA1.GET(recLWA."Container No.", recLWA."Item No.", recLWA."Line No.");
                    //Place the code for setrange & Delete
                    recLWA1.DELETE;
                end;
            UNTIL recLWA.NEXT = 0;
        END;
    end;

    [EventSubscriber(ObjectType::table, 115, 'OnAfterInsertEvent', '', true, true)]
    local procedure SalesCreditLineStockAlloc(var Rec: Record "Sales Cr.Memo Line")
    var
        recLWA: record 50002;
        recLWA1: record 50002;
        recLW: record 50003;
        LogAllMgt: Codeunit 50002;
        SalesCrHdr: record 114;

    begin
        if rec."Type" <> rec."Type"::Item then
            exit;

        if rec.Quantity = 0 then
            exit;

        IF LogAllMgt.CheckStockAllocation THEN BEGIN
            SalesCrHdr.Get(rec."Document No.");

            recLWA.RESET;
            recLWA.SETRANGE("Doc. No.", SalesCrHdr."Pre-Assigned No.");
            recLWA.SETRANGE("Doc. Line No.", rec."Line No.");
            recLWA.SETRANGE("Item No.", rec."No.");
            //recLWA.SETFILTER(Quantity, '<>%1', 0);
            recLWA.FINDSET;
            REPEAT
                if recLWA.Quantity <> 0 then begin
                    CLEAR(recLW);
                    recLW.TRANSFERFIELDS(recLWA);
                    recLW."Doc. No." := rec."Document No.";
                    recLW."Date Received" := recLWA."Date Received";
                    recLW."Date Shipped" := TODAY;
                    recLW."Date Shipped" := recLWA."Date Shipped";
                    recLW."Unit Cost" := rec."Unit Cost (LCY)";
                    recLW.UOM := rec."Unit of Measure";
                    recLW."Posting Date" := rec."Posting Date";
                    recLW."Line No." := 0;
                    recLW.Quantity := recLW.Quantity;
                    recLW.INSERT(TRUE);

                    recLW."Allocated Line" := recLW."Line No.";
                    recLW.Modify(TRUE);

                    recLWA1.GET(recLWA."Container No.", recLWA."Item No.", recLWA."Line No.");
                    //Place the code for setrange & Delete
                    recLWA1.DELETE;
                end;
            UNTIL recLWA.NEXT = 0;
        END;
    end;

    [EventSubscriber(ObjectType::codeunit, 80, 'OnBeforePostSalesDoc', '', true, true)]
    local procedure SalesHeaderCheck(SalesHeader: Record "Sales Header")
    begin
        SalesHeader.TestField("Salesperson Code");
    end;

    [EventSubscriber(ObjectType::codeunit, 80, 'OnAfterTestSalesLine', '', true, true)]
    local procedure SalesLineCheck(SalesLine: Record "Sales Line")
    var
        LogAllMgt: Codeunit 50002;
        recLWA: record 50002;
        AllocQty: decimal;
        QtyCheck: decimal;
        AK001: Label 'Qty to Ship/Receive should be = Allocation Qty for Item %1';
    begin
        if not (SalesLine."Document Type" in [SalesLine."Document Type"::Order, SalesLine."Document Type"::"Credit Memo"]) then
            exit;

        if SalesLine."Type" <> SalesLine."Type"::Item then
            exit;

        IF LogAllMgt.CheckStockAllocation THEN BEGIN
            recLWA.RESET;
            //recLWA.SETCURRENTKEY()
            //recLWA.SETRANGE("Doc. Type", 1);
            recLWA.SETRANGE("Doc. No.", SalesLine."Document No.");
            recLWA.SETRANGE("Doc. Line No.", SalesLine."Line No.");
            recLWA.SETRANGE("Item No.", SalesLine."No.");
            recLWA.CalcSums(Quantity);
            AllocQty := recLWA.Quantity;
            QtyCheck := 0;
            if SalesLine."Document Type" = SalesLine."Document Type"::Order then
                QtyCheck := SalesLine."Qty. to Ship"
            else
                if SalesLine."Document Type" = SalesLine."Document Type"::"Credit Memo" then
                    QtyCheck := SalesLine."return Qty. to Receive";

            IF allocQty <> QtyCheck THEN
                ERROR(AK001, SalesLine."No.");
        END;

    end;

    [EventSubscriber(ObjectType::codeunit, 90, 'OnAfterTestPurchLine', '', true, true)]
    local procedure PurchaseLineCheck(PurchLine: Record "Purchase Line")
    var
        LogAllMgt: Codeunit 50002;
        recLWA: record 50002;
        AllocQty: decimal;
        QtyCheck: decimal;
        AK001: Label 'Qty to Receive/Return should be = Allocation Qty for Item %1';
    begin
        if not (PurchLine."Document Type" in [PurchLine."Document Type"::Order, PurchLine."Document Type"::"Credit Memo"]) then
            exit;

        if PurchLine.Type <> PurchLine.Type::Item then
            exit;

        IF LogAllMgt.CheckStockAllocation THEN BEGIN
            recLWA.RESET;
            //recLWA.SETCURRENTKEY()
            //recLWA.SETRANGE("Doc. Type", 0);
            recLWA.SETRANGE("Doc. No.", PurchLine."Document No.");
            recLWA.SETRANGE("Doc. Line No.", PurchLine."Line No.");
            recLWA.SETRANGE("Item No.", PurchLine."No.");
            recLWA.CalcSums(Quantity);
            AllocQty := recLWA.Quantity;
            QtyCheck := 0;
            if PurchLine."Document Type" = PurchLine."Document Type"::Order then
                QtyCheck := PurchLine."Qty. to Receive"
            else
                if PurchLine."Document Type" = PurchLine."Document Type"::"Credit Memo" then
                    QtyCheck := PurchLine."Return Qty. to Ship";

            IF allocQty <> QtyCheck THEN
                ERROR(AK001, PurchLine."No.");
        END;
    end;

    [EventSubscriber(ObjectType::table, 121, 'OnAfterInsertEvent', '', true, true)]
    local procedure PurchReceiptLineStockAlloc(var Rec: Record "Purch. Rcpt. Line")
    var
        recLWA: record 50002;
        recLWA1: record 50002;
        recLW: record 50003;
        LogAllMgt: Codeunit 50002;

    begin
        if rec.Type <> rec.Type::Item then
            exit;

        if rec.Quantity = 0 then
            exit;

        IF LogAllMgt.CheckStockAllocation THEN BEGIN
            recLWA.RESET;
            recLWA.SETRANGE("Doc. No.", rec."Order No.");
            recLWA.SETRANGE("Doc. Line No.", rec."Order Line No.");
            recLWA.SETRANGE("Item No.", rec."No.");
            //recLWA.SETFILTER(Quantity, '<>%1', 0);
            recLWA.FINDSET;
            REPEAT
                if recLWA.Quantity <> 0 then begin
                    CLEAR(recLW);
                    recLW.TRANSFERFIELDS(recLWA);
                    recLW."Doc. No." := rec."Document No.";
                    recLW."Date Received" := recLWA."Date Received";
                    recLW."Date Shipped" := TODAY;
                    recLW."Date Shipped" := recLWA."Date Shipped";
                    recLW."Unit Cost" := rec."Unit Cost (LCY)";
                    recLW.UOM := rec."Unit of Measure";
                    recLW."Posting Date" := rec."Posting Date";
                    recLW."Line No." := 0;
                    recLW.Quantity := recLW.Quantity;
                    recLW.INSERT(TRUE);

                    recLW."Allocated Line" := recLW."Line No.";
                    recLW.Modify(TRUE);

                    recLWA1.GET(recLWA."Container No.", recLWA."Item No.", recLWA."Line No.");
                    //Place the code for setrange & Delete
                    recLWA1.DELETE;
                end;
            UNTIL recLWA.NEXT = 0;
        END;
    end;

    [EventSubscriber(ObjectType::table, 125, 'OnAfterInsertEvent', '', true, true)]
    local procedure PurchCrLineStockAlloc(var Rec: Record "Purch. Cr. Memo Line")
    var
        recLWA: record 50002;
        recLWA1: record 50002;
        recLW: record 50003;
        PurchCrHdr: record 124;
        LogAllMgt: Codeunit 50002;

    begin
        if rec.Type <> rec.Type::Item then
            exit;

        if rec.Quantity = 0 then
            exit;

        IF LogAllMgt.CheckStockAllocation THEN BEGIN
            PurchCrHdr.Get(rec."Document No.");

            recLWA.RESET;
            recLWA.SETRANGE("Doc. No.", PurchCrHdr."Pre-Assigned No.");
            recLWA.SETRANGE("Doc. Line No.", rec."Line No.");
            recLWA.SETRANGE("Item No.", rec."No.");
            //recLWA.SETFILTER(Quantity, '<>%1', 0);
            recLWA.FINDSET;
            REPEAT
                if recLWA.Quantity <> 0 then begin
                    CLEAR(recLW);
                    recLW.TRANSFERFIELDS(recLWA);
                    recLW."Doc. No." := rec."Document No.";
                    recLW."Date Received" := recLWA."Date Received";
                    recLW."Date Shipped" := TODAY;
                    recLW."Date Shipped" := recLWA."Date Shipped";
                    recLW."Unit Cost" := rec."Unit Cost (LCY)";
                    recLW.UOM := rec."Unit of Measure";
                    recLW."Posting Date" := rec."Posting Date";
                    recLW."Line No." := 0;
                    recLW.Quantity := -recLW.Quantity;
                    recLW.INSERT(TRUE);

                    recLWA1.GET(recLWA."Container No.", recLWA."Item No.", recLWA."Line No.");
                    //Place the code for setrange & Delete
                    recLWA1.DELETE;
                end;
            UNTIL recLWA.NEXT = 0;
        END;
    end;

    [EventSubscriber(ObjectType::codeunit, 23, 'OnAfterCheckJnlLine', '', true, true)]
    local procedure ItemJnlLineCheck(var ItemJournalLine: Record "Item Journal Line")
    var
        LogAllMgt: Codeunit 50002;
        recLWA: record 50002;
        AllocQty: decimal;
        AK001: Label 'Quantity should be = Allocation Qty for Item %1';
    begin
        IF LogAllMgt.CheckStockAllocation THEN BEGIN

            allocQty := 0;

            recLWA.RESET;
            recLWA.SETRANGE("Doc. Type", ItemJournalLine."Entry Type");
            recLWA.SETRANGE("Doc. No.", ItemJournalLine."Document No.");
            recLWA.SETRANGE("Doc. Line No.", ItemJournalLine."Line No.");
            recLWA.SETRANGE("Item No.", ItemJournalLine."Item No.");
            recLWA.CalcSums(Quantity);
            AllocQty := recLWA.Quantity;

            IF allocQty <> ItemJournalLine.Quantity THEN
                ERROR(AK001, ItemJournalLine."Item No.");

        END;

    end;

    [EventSubscriber(ObjectType::codeunit, 23, 'OnPostLinesOnBeforePostLine', '', true, true)]
    local procedure ItemJnlLineStockAlloc(var ItemJournalLine: Record "Item Journal Line")
    var
        recLWA: record 50002;
        recLWA1: record 50002;
        recLW: record 50003;
        LogAllMgt: Codeunit 50002;

    begin
        if not (ItemJournalLine."Entry Type" in [ItemJournalLine."Entry Type"::"Positive Adjmt."
                                                , ItemJournalLine."Entry Type"::"Negative Adjmt."
                                                , ItemJournalLine."Entry Type"::Transfer]) then
            exit;

        if itemjournalline.quantity = 0 then
            exit;

        IF LogAllMgt.CheckStockAllocation THEN BEGIN
            recLWA.RESET;
            recLWA.SETRANGE("Doc. No.", ItemJournalLine."Document No.");
            recLWA.SETRANGE("Doc. Line No.", ItemJournalLine."Line No.");
            recLWA.SETRANGE("Item No.", ItemJournalLine."Item No.");
            //recLWA.SETFILTER(Quantity, '<>%1', 0);
            recLWA.FINDSET;
            REPEAT
                if recLWA.Quantity <> 0 then begin
                    CLEAR(recLW);
                    recLW.TRANSFERFIELDS(recLWA);
                    recLW."Doc. No." := ItemJournalLine."Document No.";
                    recLW."Date Received" := recLWA."Date Received";
                    recLW."Date Shipped" := TODAY;
                    recLW."Date Shipped" := recLWA."Date Shipped";
                    recLW."Unit Cost" := ItemJournalLine."Unit Cost";
                    recLW.UOM := ItemJournalLine."Unit of Measure Code";
                    recLW."Posting Date" := ItemJournalLine."Posting Date";
                    recLW."Line No." := 0;
                    recLW.Quantity := recLW.Quantity;

                    IF itemjournalline."Entry Type" IN [ItemJournalLine."Entry Type"::Sale, ItemJournalLine."Entry Type"::"Negative Adjmt."] THEN
                        recLW.Quantity := -recLW.Quantity;

                    recLW.INSERT(TRUE);

                    if (ItemJournalLine."Entry Type" in [ItemJournalLine."Entry Type"::"Positive Adjmt."
                                                            , ItemJournalLine."Entry Type"::Transfer]) then begin
                        recLW."Allocated Line" := recLW."Line No.";
                        recLW.Modify(TRUE);
                    end;
                    //recLW.INSERT(TRUE);

                    if ((ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Transfer) and (recLW.Quantity > 0))
                        or (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Positive Adjmt.")
                        or (ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::"Negative Adjmt.")
                    then begin
                        recLWA1.GET(recLWA."Container No.", recLWA."Item No.", recLWA."Line No.");
                        //Place the code for setrange & Delete
                        recLWA1.DELETE;
                    end;
                end;
            UNTIL recLWA.NEXT = 0;
        END;
    end;

    [EventSubscriber(ObjectType::codeunit, 5704, 'OnCheckTransLine', '', true, true)]
    local procedure TransShptLineCheck(TransferLine: Record "Transfer Line")
    var
        LogAllMgt: Codeunit 50002;
        recLWA: record 50002;
        AllocQty: decimal;
        AK001: Label 'Quantity should be = Allocation Qty for Item %1';
    begin
        IF LogAllMgt.CheckStockAllocation THEN BEGIN

            allocQty := 0;

            recLWA.RESET;
            recLWA.SETRANGE("Doc. No.", TransferLine."Document No.");
            recLWA.SETRANGE("Doc. Line No.", TransferLine."Line No.");
            recLWA.SETRANGE("Item No.", TransferLine."Item No.");
            recLWA.CalcSums(Quantity);
            AllocQty := recLWA.Quantity;

            IF allocQty <> TransferLine.Quantity THEN
                ERROR(AK001, TransferLine."Item No.");

        END;

    end;

    [EventSubscriber(ObjectType::Table, 5745, 'OnAfterInsertEvent', '', true, true)]
    local procedure TransferShipmentLineInsert(var Rec: Record "Transfer Shipment Line")
    var
        recLWA: record 50002;
        recLWA1: record 50002;
        recLW: record 50003;
        LogAllMgt: Codeunit 50002;

    begin
        if rec.Quantity = 0 then
            exit;

        IF LogAllMgt.CheckStockAllocation THEN BEGIN
            BEGIN

                recLWA.RESET;
                recLWA.SETRANGE("Doc. No.", rec."Transfer Order No.");
                recLWA.SETRANGE("Doc. Line No.", rec."Line No.");
                recLWA.SETRANGE("Item No.", rec."Item No.");
                //recLWA.SETFILTER(Quantity, '<>%1', 0);
                recLWA.FINDSET;
                REPEAT
                    if recLWA.quantity <> 0 then begin
                        CLEAR(recLW);
                        recLW.TRANSFERFIELDS(recLWA);
                        recLW."Doc. No." := rec."Document No.";
                        recLW."Date Received" := recLWA."Date Received";
                        recLW."Date Shipped" := TODAY;
                        recLW."Date Shipped" := recLWA."Date Shipped";
                        recLW."Unit Cost" := recLWA."Unit Cost";
                        recLW.UOM := rec."Unit of Measure";
                        recLW."Posting Date" := today;
                        recLW."Line No." := 0;
                        recLW.Quantity := -recLW.Quantity;
                        recLW.INSERT(TRUE);

                        if recLWA1.Get(recLWA."Container No.", recLWA."Item No.", recLWA."Line No.") then begin
                            recLWA1."In-Transit" := true;
                            recLWA1.modify;
                        end;
                    end;
                UNTIL recLWA.NEXT = 0;
            END;
        end;
    end;

    [EventSubscriber(ObjectType::codeunit, 5705, 'OnCheckTransLine', '', true, true)]
    local procedure TransRcptLineCheck(TransferLine: Record "Transfer Line")
    var
        LogAllMgt: Codeunit 50002;
        recLWA: record 50002;
        AllocQty: decimal;
        AK001: Label 'Quantity should be = Allocation Qty for Item %1';
    begin
        IF LogAllMgt.CheckStockAllocation THEN BEGIN

            allocQty := 0;

            recLWA.RESET;
            recLWA.SETRANGE("Doc. No.", TransferLine."Document No.");
            recLWA.SETRANGE("Doc. Line No.", TransferLine."Line No.");
            recLWA.SETRANGE("Item No.", TransferLine."Item No.");
            recLWA.CalcSums(Quantity);
            AllocQty := recLWA.Quantity;

            IF allocQty <> TransferLine.Quantity THEN
                ERROR(AK001, TransferLine."Item No.");

        END;

    end;

    [EventSubscriber(ObjectType::Table, 5747, 'OnAfterInsertEvent', '', true, true)]
    local procedure TransferReceiptLineInsert(var Rec: Record "Transfer Receipt Line")
    var
        recLWA: record 50002;
        recLWA1: record 50002;
        recLW: record 50003;
        LogAllMgt: Codeunit 50002;

    begin
        if rec.Quantity = 0 then
            exit;

        IF LogAllMgt.CheckStockAllocation THEN BEGIN
            recLWA.RESET;
            recLWA.SETRANGE("Doc. No.", rec."Transfer Order No.");
            recLWA.SETRANGE("Doc. Line No.", rec."Line No.");
            recLWA.SETRANGE("Item No.", rec."Item No.");
            //recLWA.SETFILTER(Quantity, '<>%1', 0);
            recLWA.FindSet();
            REPEAT
                if recLWA.Quantity <> 0 then begin
                    CLEAR(recLW);
                    recLW.TRANSFERFIELDS(recLWA);
                    recLW."Doc. No." := rec."Document No.";
                    recLW."Date Received" := recLWA."Date Received";
                    recLW."Date Shipped" := TODAY;
                    recLW."Date Shipped" := recLWA."Date Shipped";
                    recLW."Unit Cost" := recLWA."Unit Cost";
                    recLW.UOM := rec."Unit of Measure";
                    recLW."Posting Date" := today;
                    recLW."Line No." := 0;
                    recLW.Quantity := recLW.Quantity;
                    recLW.Location := rec."Transfer-to Code";
                    recLW.INSERT(TRUE);

                    recLW."Allocated Line" := recLW."Line No.";
                    recLW.Modify(TRUE);

                    //SETRANGE & Delete
                    recLWA1.GET(recLWA."Container No.", recLWA."Item No.", recLWA."Line No.");
                    recLWA1.DELETE;
                end;
            UNTIL recLWA.NEXT = 0;
        END;
    end;
}