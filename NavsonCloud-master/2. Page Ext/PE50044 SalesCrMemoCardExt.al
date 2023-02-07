pageextension 50044 "Sales Cr Memo Card Ext" extends "Sales Credit Memo"
{
    layout
    {
        // Add changes to page layout here
                AddLast(General)
        {
            field("Ignore Doc"; rec."Ignore Doc")
            {
                ApplicationArea = ALL;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        Addlast("&Credit Memo")
        {
            Action("Print")
            {
                ApplicationArea = All;
                Caption = 'Print';
                ToolTip = 'Sales Credit Memo Print';
                Promoted = true;
                PromotedCategory = Category8;

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