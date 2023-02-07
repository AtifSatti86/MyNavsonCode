codeunit 50001 "Nav Util"
{
    trigger OnRun()
    begin

    end;

    procedure CaseToPallet(var pItem: code[20]; var pBUOM: code[20]; var pQuantity: Decimal; var pPalletQty: Decimal; var pRemQty: Decimal)
    var
        lrecBUOM: record "Item Unit of Measure";
        lTotalQty: integer;
        lQUOM: Decimal;
    begin
        PPalletQty := 0;
        PRemQty := 0;

        IF lrecBUOM.GET(PItem, PBUOM) THEN BEGIN
            lrecBUOM.TESTFIELD("Qty. per Unit of Measure");
            lQUOM := lrecBUOM."Qty. per Unit of Measure";
            lTotalQty := PQuantity * lrecBUOM."Qty. per Unit of Measure";
            IF lrecBUOM.GET(PItem, 'Pallet') THEN BEGIN
                lrecBUOM.TESTFIELD("Qty. per Unit of Measure");
                PPalletQty := lTotalQty DIV lrecBUOM."Qty. per Unit of Measure";
                PRemQty := lTotalQty MOD lrecBUOM."Qty. per Unit of Measure";
                //lrecBUOM.GET(PItem, PBUOM);
                PRemQty := PRemQty / lQUOM;
            END ELSE
                PRemQty := PQuantity;
        END ELSE
            PRemQty := PQuantity;
    end;

    procedure GetYearMonthText(pdate: Date): Text;
    var
        yy: integer;
        MM: integer;
    begin
        if pDate = 0D then
            pDate := today;

        YY := Date2DMY(pDate, 3);
        MM := Date2DMY(pDate, 2);

        if MM < 10 then
            exit(format(YY) + '- 0' + format(MM))
        else
            exit(format(YY) + '- ' + format(MM));
    end;

    procedure GetMonthText(pdate: Date): Text;
    var
        MM: integer;
        MonthName: text[30];
    begin
        if pDate = 0D then
            pDate := today;

        MM := Date2DMY(pDate, 2);
        Case MM of
            1:
                MonthName := 'January';
            2:
                MonthName := 'February';
            3:
                MonthName := 'March';
            4:
                MonthName := 'April';
            5:
                MonthName := 'May';
            6:
                MonthName := 'June';
            7:
                MonthName := 'July';
            8:
                MonthName := 'August';
            9:
                MonthName := 'September';
            10:
                MonthName := 'October';
            11:
                MonthName := 'November';
            12:
                MonthName := 'December';
        End;
        exit(MonthName);
    end;

    procedure CheckRole(pRole: text[30]): boolean;
    var
        User: record user;
        AccessControl: Record "Access Control";
    begin

        User.Get(UserSecurityId());
        AccessControl.SetRange("User Security ID", UserSecurityId());
        AccessControl.SetRange("Role ID", pRole);
        if AccessControl.findset then
            exit(True)
        else
            exit(False);
    end;
}