codeunit 50004 EventSubscriberCodeunit
{
    [EventSubscriber(ObjectType::Codeunit, 1408, 'OnBeforeSalesCrMemoHeaderModify', '', true, true)]
    local procedure OnBeforeSalesCrMemoHeaderModify(var SalesCrMemoHeader: Record "Sales Cr.Memo Header"; FromSalesCrMemoHeader: Record "Sales Cr.Memo Header")
    begin
        SalesCrMemoHeader."Ignore Doc" := FromSalesCrMemoHeader."Ignore Doc";
    end;

    [EventSubscriber(ObjectType::Codeunit, 81, 'OnBeforeOnRun', '', true, true)]
    local procedure OnBeforeOnRun(var SalesHeader: record "Sales Header")
    begin
        SalesHeader.testfield("External Document No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::ReportManagement, 'OnAfterSubstituteReport', '', true, true)]
    local procedure SubstituteReport(ReportId: Integer; var NewReportId: Integer)
    begin
        if ReportId = Report::"Customer - Top 10 List" then
            NewReportId := Report::"Navson Customer - Top 10 List";
        if ReportId = Report::"Customer Statement" then
            NewReportId := Report::"Navson Customer Statement";
    end;

}