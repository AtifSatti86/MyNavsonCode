codeunit 50005 EventSubscriberPage
{
    [EventSubscriber(ObjectType::Page, 1354, 'OnAfterRecordChanged', '', true, true)]
    local procedure OnAfterRecordChanged(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; xSalesCrMemoHeader: Record "Sales Cr.Memo Header"; var IsChanged: Boolean)
    begin
        IsChanged :=
          (SalesCrMemoHeader."Ignore Doc" <> xSalesCrMemoHeader."Ignore Doc");
    end;

}