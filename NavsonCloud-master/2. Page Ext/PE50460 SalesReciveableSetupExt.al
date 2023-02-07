pageextension 50460 "SalesReceivablesSetupExt" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Customer Nos.")
        {
            field("CRM No."; Rec."CRM No.")
            {
                ApplicationArea = All;
                Caption = 'CRM No.';
            }
        }
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }
}