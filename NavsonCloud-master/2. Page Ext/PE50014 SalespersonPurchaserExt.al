pageextension 50014 "SalespersonPurchaser Ext" extends "Salespersons/Purchasers"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }
    trigger OnOpenPage()
    begin
        rec.SetRange("Privacy Blocked", false);
    end;

    var

}