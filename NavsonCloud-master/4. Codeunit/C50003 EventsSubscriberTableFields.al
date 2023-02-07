codeunit 50003 EventSubscriberTable
{
    [EventSubscriber(ObjectType::Table, 36, 'OnAfterSelltoCustomerNoOnAfterValidate', '', true, true)]
    local procedure CustomerFinanceCharges(var SalesHeader: Record "Sales Header")
    var
        Customer: record Customer;
        CustomerMgt: codeunit "Customer Mgt.";
        ShipTo: option "Default (Sell-to Address)","Alternate Shipping Address","Custom Address";
        BillTo: option "Default (Sell-to Address)","Alternate Shipping Address","Custom Address";
    begin
        if not Customer.GET(SalesHeader."Sell-to Customer No.") then
            Customer.Init;
        SalesHeader.validate("Currency Code", Customer."Currency Code");
        SalesHeader.validate("Customer Finance Charges", Customer."Customer Finance Charges");
        SalesHeader.validate("Company Bank Account Code", Customer."Company Bank Account Code");
        ShipTo := 2;
        BillTo := 0;
        SalesHeader.validate("Ship-to Name", SalesHeader."Sell-to Customer Name" + ',');
        CustomerMgt.CalculateShipToBillToOptions(ShipTo, BillTo, SalesHeader);
    end;

    [EventSubscriber(ObjectType::Table, DataBase::"Document Attachment", 'OnBeforeInsertAttachment', '', false, false)]
    local procedure OnBeforeInsertAttachment(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        Options: Text[50];
        Selected: Integer;
        Txt001Lbl: Label 'Mark attachment as follows!';
        Txt002Lbl: Label 'POD,Order,None';
    begin
        if DocumentAttachment."Table ID" in [Database::"Sales Invoice Header", Database::"Sales Header"] then begin
            Options := Txt002Lbl;
            Selected := Dialog.StrMenu(Options, 3, Txt001Lbl);
            case Selected of
                1:
                    DocumentAttachment."Attachment Type" := DocumentAttachment."Attachment Type"::POD;
                2:
                    DocumentAttachment."Attachment Type" := DocumentAttachment."Attachment Type"::Order;
                else
                    exit;
            end
        end;
    end;

    [EventSubscriber(ObjectType::Table, 1173, 'OnAfterInitFieldsFromRecRef', '', true, true)]
    local procedure ExtraTableDocAttachment(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];

    begin
        case RecRef.Number of
            DATABASE::"Bank Account":
                begin
                    DocumentAttachment.Validate("Table ID", RecRef.Number);
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;
        end;

    end;

    [EventSubscriber(ObjectType::Page, 1174, 'OnBeforeDrillDown', '', true, true)]
    local procedure OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        BankAcc: record "Bank Account";
    begin
        case DocumentAttachment."Table ID" of
            DATABASE::"Bank Account":
                begin
                    RecRef.Open(DATABASE::"Bank Account");
                    if BankAcc.Get(DocumentAttachment."No.") then
                        RecRef.GetTable(BankAcc);
                end;
        end;

    end;

    [EventSubscriber(ObjectType::Page, 1173, 'OnAfterOpenForRecRef', '', true, true)]
    local procedure OnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];

    begin
        case RecRef.Number of
            DATABASE::"Bank Account":
                begin
                    DocumentAttachment.Validate("Table ID", RecRef.Number);
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        end;

    end;

    [EventSubscriber(ObjectType::Codeunit, 1173, 'OnAfterSetDocumentAttachmentFiltersForRecRef', '', true, true)]
    local procedure ExtraTableSetDocumentAttachment(var DocumentAttachment: Record "Document Attachment"; RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of
            DATABASE::"Bank Account":
                begin
                    DocumentAttachment.Validate("Table ID", RecRef.Number);
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.SetRange("No.", RecNo);
                end;
        end;
    end;

}