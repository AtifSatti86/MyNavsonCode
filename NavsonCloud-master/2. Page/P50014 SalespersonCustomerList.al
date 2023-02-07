page 50014 "Customer List - Salesperson"
{
    ApplicationArea = All;
    Caption = 'Customers List - Salesperson';
    PageType = List;
    UsageCategory = Lists;
    RefreshOnActivate = false;
    SourceTable = Customer;
    Editable = False;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                ShowCaption = true;
                field(No; rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Address; rec.Address)
                {
                    ApplicationArea = All;
                }
                field(Address2; rec."Address 2")
                {
                    ApplicationArea = All;
                }
                field(City; rec."City")
                {
                    ApplicationArea = All;
                }
                field(Postcode; rec."Post Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            Group("&Document")
            {
                Caption = '&Documents';
                action("New Sales Quote")
                {
                    ApplicationArea = All;
                    Image = NewSalesQuote;
                    Promoted = True;
                    PromotedCategory = New;
                    trigger OnAction();
                    begin
                        clear(SalesQuote);
                        SalesQuote.pParameterSales(rec."No.");
                        SalesQuote.RunModal();
                    end;

                }
                action("View Customer")
                {
                    ApplicationArea = All;
                    Image = Customer;
                    Promoted = True;
                    PromotedCategory = Process;

                    //RunObject = Page "Customer Card";
                    //RunPageLink = "No." = field("No.");
                    //RunPageMode = View;

                    trigger OnAction();
                    begin
                        clear(CustomerCard);
                        Customer.reset;
                        Customer.FilterGroup(2);
                        Customer.SETRANGE("No.", rec."No.");
                        Customer.FilterGroup(0);
                        Customer.findfirst;
                        CustomerCard.Editable(False);
                        CustomerCard.SetRecord(Customer);
                        CustomerCard.RunModal();
                    end;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        UserSetup.GET(USERID);
        UserSetup.Testfield("Salespers./Purch. Code");
        rec.reset;
        rec.FilterGroup(9);
        rec.SETRANGE("Salesperson Code", UserSetup."Salespers./Purch. Code");
        rec.FilterGroup(0);
    end;

    var
        SalesQuote: page "Sales Quote Creation";
        UserSetup: record "User Setup";
        CustomerCard: page "Customer Card";
        Customer: record Customer;
}