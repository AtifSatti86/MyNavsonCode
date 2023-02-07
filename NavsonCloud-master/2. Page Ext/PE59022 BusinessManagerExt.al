/*************************************************************************************************
Name : Headstart Dynamic Ltd.
Date : 
Comment : 
*************************************************************************************************/

pageextension 59022 "Business Manager Ext" extends "Business Manager Role Center"
{
    layout
    {
        // Add changes to page layout here

        AddAfter(Control55)
        {
            part(SecondChart; "Generic Chart")
            {
                ApplicationArea = Basic, Suite;
                Caption = '2nd Chart';
            }
        }

    }
    actions
    {
        // Add changes to page actions here
        addlast(Action40)
        {
            action("Unallocated Sales Line")
            {
                AccessByPermission = TableData "Sales Header" = IMD;
                ApplicationArea = All;
                Caption = 'Unallocated Sales Line';
                Image = NewOrder;
                RunObject = Page "Unallocated SalesLine";
                RunPageMode = View;
            }
        }

        addAfter(Action41)
        {
            group("Report")
            {
                Caption = 'Reports';
                Image = Setup;
                ToolTip = 'Reports';
                group(Inventory)
                {
                    action("Item Stock Container")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Item Stock Container';
                        Image = "Report";
                        RunObject = Report "Item Stock Container";
                    }
                    action("Sales UnAllocated")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales UnAllocated';
                        Image = "Report";
                        RunObject = Report "Sales UnAllocated";
                    }
                }
                group(Sales)
                {
                    action("Sales Un-Allocated")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Sales UnAllocated';
                        Image = "Report";
                        RunObject = Report "Sales UnAllocated";
                    }
                    action("TopCustomer")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Top 10 Customers';
                        Image = "Report";
                        RunObject = Report "Navson Customer - Top 10 List";
                    }
                    action("CustomerItem")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Item Sales';
                        Image = "Report";
                        RunObject = Report "Customer/Item Sales";
                    }
                    action("Overrider")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Overrider';
                        Image = "Report";
                        RunObject = Report "Overrider";
                    }
                    action("Customer Last Order")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Customer Last Order';
                        Image = "Report";
                        RunObject = Report "Customer Last Order";
                    }
                    action("Salesperson Customer Item")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Salesperson Customer Item';
                        Image = "Report";
                        RunObject = Report "SalesCustItem";
                    }
                }

                group(Purchases)
                {
                    action("Purchase Haulage")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Purchase Haulage';
                        Image = "Report";
                        RunObject = Report "Haulage Accrual Report";
                    }

                }
            }
        }
    }
}
