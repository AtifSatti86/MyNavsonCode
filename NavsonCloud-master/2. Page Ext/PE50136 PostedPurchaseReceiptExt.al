pageextension 50136 "Posted Purchase Receipt Ext" extends "Posted Purchase Receipt"
{
    layout
    {
        // Add changes to page layout here
        addafter("Posting Date")
        {
            Field("Consignment No."; rec."Consignment No.")
            {
                ApplicationArea = ALL;
            }
        }
        addlast(factboxes)
        {
            part("Posted Allocation FactBox"; "Posted Allocation FactBox")
            {
                ApplicationArea = ALL;
                Provider = PurchReceiptLines;
                SubPageLink = "Doc. No." = FIELD("Document No."),
                              "Doc. Line No." = FIELD("Line No.");
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}