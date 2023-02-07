codeunit 50002 "Logistic Allocation Mgt"
{
    trigger OnRun();
    begin
    end;

    var
        gItemNo: Code[20];
        recIUM: Record 5404;
        recLocation: Record 14;
        Doc: Code[20];
        Line: Integer;
        Item: Code[20];

    procedure Purchase(precPL: Record 39);
    begin
        IF precPL."Document Type" IN [precpl."Document Type"::Order] THEN
            AllocationForm(0, precPL."Document No.", precPL."Line No.", precPL."Location Code", precPL."No.", precPL.Quantity - precPL."Quantity Received");

        IF precPL."Document Type" IN [precpl."Document Type"::"Credit Memo"] THEN
            AllocationForm(3, precPL."Document No.", precPL."Line No.", precPL."Location Code", precPL."No.", precPL.Quantity - precPL."Quantity Received");
    end;

    procedure Sales(precSL: Record 37);
    begin
        IF precSL."Document Type" IN [precSL."Document Type"::Order] THEN
            AllocationForm(1, precSL."Document No.", precSL."Line No.", precSL."Location Code", precSL."No.", precSL.Quantity - precSL."Quantity Shipped");

        IF precSL."Document Type" IN [precSL."Document Type"::"Credit Memo"] THEN
            AllocationForm(2, precSL."Document No.", precSL."Line No.", precSL."Location Code", precSL."No.", precSL.Quantity - precSL."Quantity Shipped");
    end;

    procedure AllocationForm(pDocType: Option Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output; pDocNo: Code[20]; pLine: Integer; pLocCode: Code[20]; pItem: Code[20]; pQty: Decimal);
    //procedure AllocationForm(pDocType: enum "Item Ledger Entry Type"; pDocNo: Code[20]; pLine: Integer; pLocCode: Code[20]; pItem: Code[20]; pQty: Decimal);
    var
        reclStockAlloc: Record 50002;
        frmlLogWrk: Page 50002;
    begin
        if pLocCode = '' then
            error('Location must not be blank');

        reclStockAlloc.RESET;
        reclStockAlloc.FILTERGROUP(9);
        reclStockAlloc.SETRANGE("Doc. Type", pDocType);
        reclStockAlloc.SETRANGE("Doc. No.", pDocNo);
        reclStockAlloc.SETRANGE("Doc. Line No.", pLine);
        reclStockAlloc.SETRANGE(Location, pLocCode);
        reclStockAlloc.SETRANGE("Item No.", pItem);
        reclStockAlloc.FILTERGROUP(0);

        frmlLogWrk.gParameter(pDocType, pDocNo, pLine, pLocCode, pItem, pQty);
        frmlLogWrk.SETTABLEVIEW(reclStockAlloc);
        frmlLogWrk.RUNMODAL;
    end;

    procedure Transfer(precIJL: Record 83);
    begin
        IF NOT CheckStockAllocation THEN
            EXIT;

        AllocationForm(precIJL."Entry Type", precIJL."Document No.", precIJL."Line No.", precIJL."Location Code", precIJL."Item No.", precIJL.Quantity);
    end;

    procedure TransferOrder(precTL: Record 5741);
    begin
        AllocationForm(4, precTL."Document No.", precTL."Line No.", precTL."Transfer-from Code", precTL."Item No.", precTL.Quantity);
    end;

    procedure FreeStockStorageCost(pContainer: Code[20]; pItem: Code[20]): Decimal;
    var
        recItem: Record 27;
        recLW: Record 50003;
        decStorageCost: Decimal;
        lDays: Integer;
    begin
        recLW.RESET;
        recLW.SETRANGE("Container No.", pContainer);
        recLW.SETRANGE("Item No.", pItem);
        recLW.SETFILTER("Doc. Type", '%1|%2', 0, 2);
        recLW.SetAutoCalcFields("Qty. Sold");
        IF recLW.FINDSET THEN
            REPEAT
                //recItem.GET(pItem);

                IF recLW."Date Received" = 0D THEN
                    recLW."Date Received" := TODAY;

                lDays := TODAY - recLW."Date Received";
            //  decStorageCost += (recLW.Quantity - recLW."Qty. Sold") * lDays * (recItem."WHSE Cost"/7);
            UNTIL recLW.NEXT = 0;

        EXIT(decStorageCost);
    end;

    procedure ShipWhseCost(pContainer: Code[20]; pItem: Code[20]; pLineNo: Integer): Decimal;
    var
        recLW: Record 50003;
        recLW1: Record 50003;
        recItem: Record 27;
        lDays: Integer;
        decStorageCost: Decimal;
    begin
        /*
        recLW.RESET;
        recLW.SETRANGE("Container No.",pContainer);
        recLW.SETRANGE("Item No.",pItem);
        recLW.SETFILTER("Doc. Type",'%1|%2',0,2);
        IF recLW.FINDFIRST THEN
        BEGIN
          recLW1.RESET;
          recLW1.SETRANGE("Container No.",pContainer);
          recLW1.SETRANGE("Item No.",pItem);
          recLW1.SETRANGE("Line No.",pLineNo);
          IF recLW1.FINDFIRST THEN
          BEGIN
            recItem.GET(pItem);
            IF recLW."Date Received" = 0D THEN
              recLW."Date Received" := TODAY;
            IF recLW1."Date Received" = 0D THEN
              recLW1."Date Received" := TODAY;
            lDays := recLW1."Date Received" - recLW."Date Received";
            decStorageCost += recLW1.Quantity * lDays * (recItem."WHSE Cost"/7);
          END;
        END;
        
        EXIT(decStorageCost);
        */

    end;

    procedure SOStoreageCost(pSalesOrder: Code[20]): Decimal;
    var
        recItem: Record 27;
        recLWA: Record 50002;
        decStorageCost: Decimal;
        lDays: Integer;
        recLW: Record 50003;
    begin
        decStorageCost := 0;

        recLWA.RESET;
        recLWA.SETRANGE("Doc. No.", pSalesOrder);

        IF Line <> 0 THEN
            recLWA.SETRANGE("Doc. Line No.", Line);

        IF recLWA.FINDSET THEN
            REPEAT
                recLW.RESET;
                recLW.SETRANGE("Container No.", recLWA."Container No.");
                recLW.SETRANGE("Item No.", recLWA."Item No.");
                IF recLW.FINDFIRST THEN BEGIN
                    //recItem.GET(recLWA."Item No.");

                    IF recLW."Date Received" = 0D THEN
                        recLW."Date Received" := TODAY;

                    IF recLWA."Date Shipped" = 0D THEN
                        recLWA."Date Shipped" := TODAY;

                    IF NOT recLocation.GET(recLW.Location) THEN
                        recLocation.INIT;

                    IF NOT recIUM.GET(recLW."Item No.", 'PALLET') THEN
                        recIUM."Qty. per Unit of Measure" := 1;

                    lDays := recLWA."Date Shipped" - recLW."Date Received";
                    //decStorageCost += ((recLocation."Location Cost" / 7) * recLWA.Quantity * lDays) / recIUM."Qty. per Unit of Measure";
                END;
            UNTIL recLWA.NEXT = 0;

        EXIT(decStorageCost);
    end;

    procedure PostedSOStoreageCost(pSalesOrder: Code[20]): Decimal;
    var
        recItem: Record 27;
        recLWA: Record 50003;
        decStorageCost: Decimal;
        lDays: Integer;
        recLW: Record 50003;
    begin
        recLWA.RESET;
        recLWA.SETRANGE("Doc. No.", pSalesOrder);
        recLWA.SETFILTER("Item No.", gItemNo);
        IF recLWA.FINDSET THEN
            REPEAT
                recLW.RESET;
                recLW.SETRANGE("Container No.", recLWA."Container No.");
                recLW.SETRANGE("Item No.", recLWA."Item No.");
                IF recLW.FINDFIRST THEN BEGIN
                    //recItem.GET(recLWA."Item No.");

                    IF recLW."Date Received" = 0D THEN
                        recLW."Date Received" := TODAY;

                    IF recLWA."Date Shipped" = 0D THEN
                        recLWA."Date Shipped" := TODAY;

                    IF NOT recLocation.GET(recLW.Location) THEN
                        recLocation.INIT;

                    IF NOT recIUM.GET(recLW."Item No.", 'PALLET') THEN
                        recIUM."Qty. per Unit of Measure" := 1;

                    lDays := recLWA."Date Shipped" - recLW."Date Received";
                    //decStorageCost += ABS(recLWA.Quantity) * lDays * (recLocation."Location Cost" / (7 * recIUM."Qty. per Unit of Measure"));
                END;
            UNTIL recLWA.NEXT = 0;

        EXIT(decStorageCost);
    end;

    procedure ParameterItem(pItemNo: Code[20]);
    begin
        gItemNo := pItemNo;
    end;

    procedure CheckStockAllocation(): Boolean;
    var
        NavsonSetup: Record 50001;
    begin
        if not NavsonSetup.GET() then
            NavsonSetup.Init;
        EXIT(NavsonSetup."Stock Allocation");
    end;

    procedure SalesOrderLine1(pDoc: Code[20]; pLine: Integer; pItem: Code[20]);
    begin
        Doc := pDoc;
        Line := pLine;
        Item := pItem;
    end;

    procedure SalesStockAllocation(pSalesLine: record 37)
    begin
        IF NOT CheckStockAllocation THEN
            EXIT;

        pSalesLine.TESTFIELD(Type, 2);
        pSalesLine.TESTFIELD("Location Code");
        Sales(pSalesLine);
    end;

    procedure PurchaseStockAllocation(pPurchLine: record 39)
    begin
        IF NOT CheckStockAllocation THEN
            EXIT;

        pPurchLine.TESTFIELD(Type, 2);
        pPurchLine.TESTFIELD("Location Code");
        Purchase(pPurchLine);
    end;

}
