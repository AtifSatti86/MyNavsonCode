pageextension 50140 "Posted Purch Cr Hdr Ext" extends "Posted Purchase Credit Memo"
{
    layout
    {
        addafter("Posting Date")
        {
            Field("Consignment No."; rec."Consignment No.")
            {
                ApplicationArea = ALL;
            }
        }
        /*
            addlast(factboxes)
        {
            part("Posted Allocation FactBox"; "Posted Allocation FactBox")
            {
                ApplicationArea = ALL;
                Provider = PurchCrMemoLines;
                SubPageLink = "Purchase Order" = FIELD("Order No."),
                              "Doc. Line No." = FIELD("Order Line No.");
            }
        }
        */
    }
}
