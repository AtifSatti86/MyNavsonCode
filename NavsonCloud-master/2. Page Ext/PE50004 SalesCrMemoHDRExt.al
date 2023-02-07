pageextension 50004 "Sales Cr Memo Ext" extends "Sales Credit Memos"
{
    layout
    {
        // Add changes to page layout here
        addafter(Amount)
        {
            field("Amount including VAT"; rec."Amount Including VAT")
            {
                ApplicationArea = ALL;
            }
            field("Ignore Doc."; rec."Ignore Doc")
            {
                ApplicationArea = ALL;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        AddAfter(Approvals)
        {
            Action("Print")
            {
                ApplicationArea = All;
                Caption = 'Print';
                ToolTip = 'Sales Credit Memo Print';
                Promoted = true;
                PromotedCategory = Category6;

                trigger OnAction()
                begin
                    SalesHdr.reset;
                    SalesHdr.Setrange("Document Type", rec."Document Type");
                    SalesHdr.SETRANGE("No.", rec."No.");
                    SalesHdr.findfirst;
                    Report.runmodal(50007, true, true, SalesHdr);
                end;
            }
        }
    }

    var
        SalesHdr: record "Sales Header";
        SalesCrMemo: report "Sales - Credit Memo";
}