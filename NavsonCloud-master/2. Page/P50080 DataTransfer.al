page 50080 "Data Transfer"
{
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            field("From Company"; FromCompany)
            {
                TableRelation = Company;
                ApplicationArea = All;
            }
            field("To Company"; ToCompany)
            {
                TableRelation = Company;
                ApplicationArea = All;
            }
            field("User ID"; USERID)
            {
                Editable = false;
                ApplicationArea = All;
            }
            part("Table Data"; 50079)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Data Transfer")
            {

                ApplicationArea = All;

                trigger OnAction();
                var
                    TableDataSync: Record 50080;
                begin
                    TableDataSync.DataSync(FromCompany, ToCompany);
                end;
            }
        }
    }

    var
        FromCompany: Text;
        ToCompany: Text;
}

