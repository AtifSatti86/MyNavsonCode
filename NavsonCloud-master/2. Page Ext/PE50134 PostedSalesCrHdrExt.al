pageextension 50134 "Posted Sales Cr Hdr Ext" extends "Posted Sales Credit Memo"
{
    layout
    {
        AddLast(General)
        {
            field("Ignore Doc"; rec."Ignore Doc")
            {
                ApplicationArea = ALL;
            }
        }
        addlast(factboxes)
        {
            part("Posted Allocation FactBox"; "Posted Allocation FactBox")
            {
                ApplicationArea = ALL;
                Provider = SalesCrMemoLines;
                SubPageLink = "Doc. No." = FIELD("Document No."),
                              "Doc. Line No." = FIELD("Line No.");
            }
        }
    }
}