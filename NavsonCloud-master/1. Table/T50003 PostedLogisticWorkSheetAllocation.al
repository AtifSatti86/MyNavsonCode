table 50003 "Posted Logc WrkSheet Alloc"
{
    // version Ashish

    fields
    {
        field(1; "Container No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item;
        }
        field(3; "Line No."; Integer)
        {
            AutoIncrement = true;
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
        field(20; "Date Received"; Date)
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
        }
        field(50; "Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(60; Location; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Location;
        }
        field(70; "Allocated Line"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(80; "Qty. Allocated"; Decimal)
        {
            CalcFormula = - Sum("Logistic Worksheet Allocation".Quantity WHERE("Container No." = FIELD("Container No."),
                                                                               "Item No." = FIELD("Item No."),
                                                                               "Allocated Line" = FIELD("Line No."),
                                                                               "Doc. Type" = FILTER(Sale | "Negative Adjmt." | Transfer),
                                                                               "In-Transit" = FILTER(0)
                                                                               ));
            Editable = false;
            FieldClass = FlowField;
        }
        field(90; "Qty. Sold"; Decimal)
        {
            CalcFormula = - Sum("Posted Logc WrkSheet Alloc".Quantity WHERE("Container No." = FIELD("Container No."),
                                                                    "Item No." = FIELD("Item No."),
                                                                    Location = field(Location),
                                                                    "Allocated Line" = FIELD("Line No."),
                                                                    "Posting Date" = field("Date Filter"),
                                                                    Quantity = FILTER(< 0)));
            Editable = false;
            FieldClass = FlowField;
        }
        field(100; "Use By Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(110; "Balance Stock"; Decimal)
        {
            CalcFormula = Sum("Posted Logc WrkSheet Alloc".Quantity WHERE("Container No." = FIELD("Container No."),
                                                                    "Item No." = FIELD("Item No."),
                                                                    "Location" = field("Location"),
                                                                    "Allocated Line" = field("Line No."),
                                                                    "Posting Date" = field("Date Filter")
                                                                    ));
            Editable = false;
            FieldClass = FlowField;
        }
        field(120; "Date Shipped"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(130; "BL/Shipment No."; Text[80])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(140; "Posting Date"; Date)
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
        field(80000; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
            Caption = 'Date Filter';
        }
        field(90000; "Item Description"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(90001; "Sales Order"; Code[20])
        {
            CalcFormula = Lookup("Sales Shipment Line"."Order No." WHERE("Document No." = FIELD("Doc. No."),
                                                                          "Line No." = FIELD("Doc. Line No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(90002; "Purchase Order"; Code[20])
        {
            CalcFormula = Lookup("Purch. Rcpt. Header"."Order No." WHERE("No." = FIELD("Doc. No.")));
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
        key(Key2; "Doc. Type", "Container No.", "Item No.", "Allocated Line", "Date Shipped", "Posting Date", Quantity)
        {
            SumIndexFields = Quantity;
        }
        key(Key3; "Date Received")
        {
        }
        key(Key4; "Use By Date")
        {
        }
        key(Key5; "Prod. Date")
        {
        }
        key(Key6; "Item No.", Location, Quantity)
        {
        }
    }

    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if Quantity > 0 then
            "Allocated Line" := "Line No.";
    end;

    trigger OnDelete()
    begin
        //Error('No Deleteion Allowed');
    end;

}

