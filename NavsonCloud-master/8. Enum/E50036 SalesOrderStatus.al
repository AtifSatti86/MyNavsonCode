enum 50036 "Sales Order Status"
{
    Extensible = true;
    AssignmentCompatibility = true;

    value(0; "New Order") { Caption = 'New Order'; }
    value(1; "Stock Issue") { Caption = 'Stock Issue'; }
    value(2; "Whse. Requested") { Caption = 'Whse. Requested'; }
    value(3; "Customer Notified") { Caption = 'Customer Notified'; }
    value(4; "Haulage Booked") { Caption = 'Haulage Booked'; }
    value(5; "Delivered") { Caption = 'Delivered'; }
    value(6; "Invoice") { Caption = 'Invoice'; }
}