page 50012 "Salesperson Role Center"
{
    Caption = 'Salesperson Role Center';
    PageType = RoleCenter;
    layout
    {
        area(rolecenter)
        {
            group(Control1)
            {
                part(Control139; "Headline RC Business Manager")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Sections)
        {
            group("Sales")
            {
                Caption = 'Customer';
                action("Customer")
                {
                    ApplicationArea = All;
                    Caption = 'Customer List';
                    RunObject = page "Customer List - Salesperson";
                }
                action("Sales Quote")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Quote';
                    RunObject = Page "Sales Quotes - Salesperson";
                    ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
                }
                action("Sales Order")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Sales Order';
                    RunObject = Page "Sales Orders - Salesperson";
                    ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
                }
            }
            group("Reports")
            {
                action("TopCustomer")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Top 10 Customers';
                    Image = "Report";
                    RunObject = Report "Navson Customer - Top 10 List";
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
        }
        area(embedding)
        {
            ToolTip = 'Manage your business. See favorite customers.';
            action(Customers)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customers';
                RunObject = Page "Customer List - Salesperson";
                ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
            }
            action("Sales Quotes")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Quote';
                RunObject = Page "Sales Quotes - Salesperson";
                ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
            }
            action("Sales Orders")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Order';
                RunObject = Page "Sales Orders - Salesperson";
                ToolTip = 'View or edit detailed information for the customers that you trade with. From each customer card, you can open related information, such as sales statistics and ongoing orders, and you can define special prices and line discounts that you grant if certain conditions are met.';
            }
            action("RTopCustomer")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Top 10 Customers';
                Image = "Report";
                RunObject = Report "Navson Customer - Top 10 List";
            }
            action("RCustomerLastOrder")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customer Last Order';
                Image = "Report";
                RunObject = Report "Customer Last Order";
            }
            action("RSalespersonCustomerItem")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Salesperson Customer Item';
                Image = "Report";
                RunObject = Report "SalesCustItem";
            }
        }
    }
}

