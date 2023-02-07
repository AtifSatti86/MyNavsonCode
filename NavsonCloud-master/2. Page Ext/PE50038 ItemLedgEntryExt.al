pageextension 50038 "Item Ledg Entry Ext" extends "Item Ledger Entries"
{
    layout
    {
        addlast(factboxes)
        {
            part("Posted Allocation FactBox"; "Posted Allocation FactBox")
            {
                ApplicationArea = ALL;
                //Provider = SalesInvLines;
                SubPageLink = "Doc. No." = FIELD("Document No."),
                              "Doc. Line No." = FIELD("Document Line No.");
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
}