table 50002 "Logistic Worksheet Allocation"
{
    // version Ashish


    fields
    {
        field(1; "Container No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Editable = true;

            trigger OnLookup();
            begin
                ContainerOnLookup();
            end;

            trigger OnValidate();
            begin
                IF "Doc. Type" = 0 THEN BEGIN
                    recPL.RESET;
                    recPL.SETRANGE("Document Type", 1);
                    recPL.SETRANGE("Document No.", "Doc. No.");
                    recPL.SETRANGE("Line No.", "Doc. Line No.");
                    IF recPL.FINDFIRST THEN BEGIN
                        UOM := recPL."Unit of Measure";
                    END;
                END;
            end;
        }
        field(2; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Line No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
        }
        field(4; "Variant Code"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Doc. Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output;
        }
        field(11; "Doc. No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Doc. Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(30; UOM; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(40; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate();
            begin
                IF "Doc. Type" IN [1, 3, 4] THEN BEGIN
                    AvailStock := GetAvailStock;
                    AllocStock := GetAllocStock;
                    IF Quantity > (AvailStock + AllocStock) THEN
                        ERROR('There is not enough Stock to Allocate. \\Avaliable Stock %1 %2 = %3', AvailStock, AllocStock, (AvailStock + AllocStock));
                END;
            end;
        }
        field(50; "Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            DecimalPlaces = 0 : 5;
        }
        field(60; Location; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(70; "Allocated Line"; Integer)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(80; "Date Received"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate();
            var
                DateCheck: Codeunit 11;
                Text001: TextConst ENU = 'is not within your range of allowed posting dates', ENG = 'is not within your range of allowed posting dates';
            begin
                IF DateCheck.DateNotAllowed("Date Received") THEN
                    FIELDERROR("Date Received", Text001);
            end;
        }
        field(100; "Use By Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(120; "Date Shipped"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate();
            var
                DateCheck: Codeunit 11;
                Text001: TextConst DAN = 'er ikke inden for den tilladte bogføringsperiode', ENU = 'is not within your range of allowed posting dates', ENG = 'is not within your range of allowed posting dates';
            begin
                IF DateCheck.DateNotAllowed("Date Shipped") THEN
                    FIELDERROR("Date Shipped", Text001);
            end;
        }
        field(125; "In-Transit"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(150; "Prod. Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(155; "Batch No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(90000; "Item Description"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(90001; "Customer Name"; Text[100])
        {
            CalcFormula = Lookup("Sales Header"."Sell-to Customer Name" WHERE("No." = FIELD("Doc. No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(90002; "Ship To Name"; Text[100])
        {
            CalcFormula = Lookup("Sales Header"."Ship-to Name" WHERE("No." = FIELD("Doc. No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(90003; "Total Con. Item Qty"; decimal)
        {
            CalcFormula = sum("Logistic Worksheet Allocation"."Quantity" WHERE("Location" = FIELD("Location"),
                                                                                "Item No." = field("Item No."),
                                                                                "Doc. Type" = field("Doc. Type"),
                                                                                "Doc. No." = field("Doc. No."),
                                                                                "Doc. Line No." = field("Doc. Line No.")
                                ));

            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Container No.", "Item No.", "Line No.")
        {
            SumIndexFields = Quantity;
        }
        key(Key2; "Doc. Type", "Container No.", "Item No.", "Allocated Line", "Doc. No.", "Doc. Line No.", Location, "Date Shipped", "In-Transit", Quantity)
        {
            SumIndexFields = Quantity;
        }
    }

    fieldgroups
    {
    }

    var
        AvailStock: Decimal;
        AllocStock: Decimal;
        recLW: Record 50003;
        frmLW: Page 50003;
        recPL: Record 39;
        AllocationWorksheet: Codeunit "Logistic Allocation Mgt";

    procedure GetAvailStock(): Decimal;
    var
        AvailStock: Decimal;
        recPLW: Record 50003;
    begin
        IF NOT AllocationWorksheet.CheckStockAllocation THEN
            EXIT(0);

        recPLW.RESET;
        recPLW.SETCURRENTKEY("Container No.", "Item No.", "Line No.");
        recPLW.SETRANGE("Container No.", "Container No.");
        recPLW.SETRANGE("Item No.", "Item No.");
        recPLW.SETRANGE(Location, Location);
        IF recPLW.FIND('-') THEN
            REPEAT
                IF (recPLW."Line No." = "Allocated Line") OR
                   (recPLW."Allocated Line" = "Allocated Line") THEN BEGIN
                    /*IF recLW."Doc. Type" = 0 THEN
                      AvailStock += recLW.Quantity;
                    IF recLW."Doc. Type" = 1 THEN*/
                    AvailStock += recPLW.Quantity;
                END;
            UNTIL recPLW.NEXT = 0;

        EXIT(AvailStock);

    end;

    procedure GetAllocStock(): Decimal;
    var
        AllocStock: Decimal;
        recLW: Record 50002;
    begin
        IF NOT AllocationWorksheet.CheckStockAllocation THEN
            EXIT(0);

        recLW.RESET;
        recLW.SETRANGE("Container No.", "Container No.");
        recLW.SETRANGE("Item No.", "Item No.");
        recLW.SETRANGE(Location, Location);
        recLW.SETRANGE("Allocated Line", "Allocated Line");
        recLW.SETFILTER("Line No.", '<>%1', "Line No.");
        IF recLW.FIND('-') THEN
            REPEAT
                IF recLW."Doc. Type" IN [0, 2] THEN
                    AllocStock += recLW.Quantity;
                IF recLW."Doc. Type" IN [1, 3] THEN
                    AllocStock -= recLW.Quantity;
            UNTIL recLW.NEXT = 0;

        EXIT(AllocStock);
    end;

    procedure AllocStockQty(pDocNo: Code[20]; pLineNo: Integer; pLocation: Code[20]; pItem: Code[20]): Decimal;
    var
        AllocStock: Decimal;
        recLWA: Record 50002;
    begin
        IF NOT AllocationWorksheet.CheckStockAllocation THEN
            EXIT(0);

        recLWA.RESET;
        recLWA.SETCURRENTKEY("Doc. Type", "Container No.", "Item No.", "Allocated Line", "Doc. No.", "Doc. Line No.", Location);
        IF pDocNo <> '' THEN
            recLWA.SETRANGE("Doc. No.", pDocNo);
        IF pLineNo <> 0 THEN
            recLWA.SETRANGE("Doc. Line No.", pLineNo);
        IF pLocation <> '' THEN
            recLWA.SETRANGE(Location, pLocation);
        IF pItem <> '' THEN
            recLWA.SETRANGE("Item No.", pItem);

        recLWA.CALCSUMS(Quantity);
        EXIT(recLWA.Quantity);
    end;

    procedure ContainerOnLookup()
    begin
        IF NOT AllocationWorksheet.CheckStockAllocation THEN
            EXIT;

        IF "Doc. Type" = 0 THEN
            ERROR('The lookup is not availiable for Purchase Documents');

        CLEAR(frmLW);

        recLW.RESET;
        recLW.SETRANGE(Location, Location);
        recLW.SETRANGE("Item No.", "Item No.");
        recLW.SETFILTER("Doc. Type", '%1|%2|%3', 0, 2, 4);
        recLW.SETFILTER(Quantity, '>%1', 0);
        recLW.SETFILTER("Balance Stock", '>0');
        if recLW.findfirst then;
        /*
        IF recLW.FINDSET THEN
            REPEAT
                recLW.CALCFIELDS("Qty. Sold");
                recLW."Balance Stock" := recLW.Quantity - recLW."Qty. Sold";
                recLW.MODIFY;
            UNTIL recLW.NEXT = 0;
        IF recLW.FINDSET THEN
            recLW.SETFILTER("Balance Stock", '>0');
       COMMIT;
        */

        frmLW.SETTABLEVIEW(recLW);
        frmLW.LOOKUPMODE(TRUE);

        IF frmLW.RUNMODAL = ACTION::LookupOK THEN BEGIN
            frmLW.GETRECORD(recLW);
            "Container No." := recLW."Container No.";
            "Allocated Line" := recLW."Line No.";
            "Use By Date" := recLW."Use By Date";
            "Date Received" := recLW."Date Received";
            UOM := recLW.UOM;
        END;

    end;
}

