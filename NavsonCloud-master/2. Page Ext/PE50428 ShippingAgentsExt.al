pageextension 50428 "Shipping Agents Ext" extends "Shipping Agents"
{
    layout
    {
        // Add changes to page layout here
        addafter(Name)
        {
            field("Contact No"; rec."Contact No")
            {
                ApplicationArea = ALL;
            }
            field("Address"; rec."Address")
            {
                ApplicationArea = ALL;
            }
            field("Address 2"; rec."Address 2")
            {
                ApplicationArea = ALL;
            }
            field("Email"; rec."Email")
            {
                ApplicationArea = ALL;
            }
            field("Website"; rec."Website")
            {
                ApplicationArea = ALL;
            }
            field("Shipping Location"; rec."Shipping Location")
            {
                ApplicationArea = ALL;
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