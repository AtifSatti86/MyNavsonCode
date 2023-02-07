/**************************************************
Creator : Ashish Kapoor
Created On : 2023.01.17
**************************************************/
pageextension 55401 "Item Variants Ext" extends "Item Variants"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addAfter(Translations)
        {
            action("Item Variant BOM")
            {
                AccessByPermission = TableData "Navson BOM Component" = R;
                ApplicationArea = Assembly;
                Caption = 'Navson Assembly BOM';
                Image = BOM;
                Promoted = True;
                PromotedCategory = Process;
                PromotedIsBig = true;

                RunObject = Page "Navson Assembly BOM";
                RunPageLink = "Parent Item No." = FIELD("Item No."), "Parent Variant Code" = FIELD("Code");
                ToolTip = 'View or edit the bill of material that specifies which items and resources are required to assemble the assembly Item Variant.';

            }
        }
    }

    var

}
