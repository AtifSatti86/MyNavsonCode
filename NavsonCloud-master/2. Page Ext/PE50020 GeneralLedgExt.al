pageextension 50020 "General Ledg Ent Ext" extends "General Ledger Entries"
{
    layout
    {
        // Add changes to page layout here
        addafter(Control1)
        {
            field("No Of Records"; rec.Count)
            {
                ApplicationArea = ALL;
                Editable = false;
                ColumnSpan = 2;
            }

        }
        modify("Source No.")
        {
            Visible = true;
        }

        addafter("Source No.")
        {
            field("Source Name"; SourceName)
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnAfterGetRecord()
    begin
        SourceName := '';

        IF (rec."Source Type" = Rec."Source Type"::Customer) then begin
            if not Customer.get(Rec."Source No.") then
                Customer.Init();
            SourceName := Customer.Name;
        end;

        IF (rec."Source Type" = Rec."Source Type"::Vendor) then begin
            if not Vendor.get(Rec."Source No.") then
                Vendor.Init();
            SourceName := Vendor.Name;
        end;

        IF (rec."Source Type" = Rec."Source Type"::"Bank Account") then begin
            if not Bank.get(Rec."Source No.") then
                Bank.Init();
            SourceName := Customer.Name;
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        SourceName := '';

        IF (rec."Source Type" = Rec."Source Type"::Customer) then begin
            if not Customer.get(Rec."Source No.") then
                Customer.Init();
            SourceName := Customer.Name;
        end;

        IF (rec."Source Type" = Rec."Source Type"::Vendor) then begin
            if not Vendor.get(Rec."Source No.") then
                Vendor.Init();
            SourceName := Vendor.Name;
        end;

        IF (rec."Source Type" = Rec."Source Type"::"Bank Account") then begin
            if not Bank.get(Rec."Source No.") then
                Bank.Init();
            SourceName := Customer.Name;
        end;
    end;

    var
        SourceName: Text[100];
        Vendor: Record Vendor;
        Customer: Record Customer;
        Bank: Record "Bank Account";

}
