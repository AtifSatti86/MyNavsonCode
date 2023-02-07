pageextension 50900 "Assembly Order Ext" extends "Assembly Order"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addAfter(Order)
        {
            action("Navson Item Variant BOM Explode")
            {
                //AccessByPermission = TableData "Navson BOM Component" = R;
                ApplicationArea = All;
                Caption = 'Navson Assembly BOM Explode';
                Image = BOM;
                Promoted = True;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    NavsonBOM: Record "Navson BOM Component";
                    AssemblyLine: Record "Assembly Line";
                    NextLineNo: Integer;
                begin
                    rec.TestField("Item No.");
                    rec.TestField("Variant Code");
                    rec.TestField("Location Code");

                    NavsonBOM.reset;
                    NavsonBOM.SETRANGE("Parent Item No.", rec."Item No.");
                    NavsonBOM.SETRANGE("Parent Variant Code", rec."Variant Code");
                    NavsonBOM.findfirst;

                    repeat
                        AssemblyLine.Init();
                        AssemblyLine."Document Type" := rec."Document Type";
                        AssemblyLine."Document No." := rec."No.";
                        NextLineNo := NextLineNo + 10000;
                        AssemblyLine."Line No." := NextLineNo;
                        AssemblyLine.Insert(true);

                        AssemblyLine.Validate(Type, NavsonBOM.Type);
                        AssemblyLine.Validate("No.", NavsonBOM."No.");
                        AssemblyLine.Validate("Variant Code", NavsonBOM."Variant Code");
                        AssemblyLine.Validate("Location Code", rec."Location Code");
                        if AssemblyLine.Type = AssemblyLine.Type::Resource then
                            case NavsonBOM."Resource Usage Type" of
                                NavsonBOM."Resource Usage Type"::Direct:
                                    AssemblyLine.Validate("Resource Usage Type", AssemblyLine."Resource Usage Type"::Direct);
                                NavsonBOM."Resource Usage Type"::Fixed:
                                    AssemblyLine.Validate("Resource Usage Type", AssemblyLine."Resource Usage Type"::Fixed);
                            end;
                        AssemblyLine.Validate("Unit of Measure Code", NavsonBOM."Unit of Measure Code");
                        if AssemblyLine.Type <> AssemblyLine.Type::" " then
                            AssemblyLine.Validate(
                              "Quantity per",
                              AssemblyLine.CalcBOMQuantity(
                                NavsonBOM.Type, NavsonBOM."Quantity per", 1, rec."Qty. per Unit of Measure", AssemblyLine."Resource Usage Type"));

                        AssemblyLine.Validate(
                            Quantity,
                            AssemblyLine.CalcBOMQuantity(
                                NavsonBOM.Type, NavsonBOM."Quantity per", rec.Quantity, rec."Qty. per Unit of Measure", AssemblyLine."Resource Usage Type"));
                        AssemblyLine.Validate(
                            "Quantity to Consume",
                            AssemblyLine.CalcBOMQuantity(
                                NavsonBOM.Type, NavsonBOM."Quantity per", rec."Quantity to Assemble", rec."Qty. per Unit of Measure", AssemblyLine."Resource Usage Type"));

                        if AssemblyLine.Type = AssemblyLine.Type::Item then
                            AssemblyLine.Validate("Variant Code", NavsonBOM."Variant Code");
                        AssemblyLine.Description := NavsonBOM.Description;

                        AssemblyLine.Modify(true);

                    until NavsonBOM.next = 0;

                    currpage.update();
                    rec.UpdateUnitCost();
                end;
            }
        }
    }

    var

}