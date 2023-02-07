permissionset 50000 GeneratedPermission
{
    Assignable = true;
    Permissions = tabledata CRM=RIMD,
        tabledata "Logistic Worksheet Allocation"=RIMD,
        tabledata "Navson Setup"=RIMD,
        tabledata "Posted Logc WrkSheet Alloc"=RIMD,
        tabledata "SO PO Link"=RIMD,
        tabledata "Table Data Sync"=RIMD,
        tabledata "Valid Field Value"=RIMD,
        table CRM=X,
        table "Logistic Worksheet Allocation"=X,
        table "Navson Setup"=X,
        table "Posted Logc WrkSheet Alloc"=X,
        table "SO PO Link"=X,
        table "Table Data Sync"=X,
        table "Valid Field Value"=X,
        report "Custom Sales - Pro Forma Inv"=X,
        report "Customer Last Order"=X,
        report "Delivery Note"=X,
        report "Haulage Accrual Report"=X,
        report "ILE vs Allocation"=X,
        report "Item Stock Container"=X,
        report "Navson Customer - Top 10 List"=X,
        report "Navson Customer Statement"=X,
        report "Navson Vendor Statement"=X,
        report Overrider=X,
        report "RBS Payment Detail"=X,
        report "Sales - Credit Memo"=X,
        report "Sales Order vs Allocation"=X,
        report "Sales UnAllocated"=X,
        report SalesCustItem=X,
        codeunit "Events Subscriber Stk Alloc"=X,
        codeunit EventSubscriberCodeunit=X,
        codeunit EventSubscriberPage=X,
        codeunit EventSubscriberTable=X,
        codeunit "Logistic Allocation Mgt"=X,
        codeunit "Nav Util"=X,
        page "Allocation FactBox"=X,
        page "Available Stock FactBox"=X,
        page "CRM List"=X,
        page "Customer List - Salesperson"=X,
        page "Data Transfer"=X,
        page "Data Transfer Tables"=X,
        page "Logc Wrk Allocation List"=X,
        page "Logistic Worksheet Allocation"=X,
        page "Navson Setup"=X,
        page NoOfRecords=X,
        page "Posted Allocation FactBox"=X,
        page "Posted Logc WrkSheet Alloc"=X,
        page "Posted Logistic Wrks - Detail"=X,
        page "Sales Orders - Salesperson"=X,
        page "Sales Quote Creation"=X,
        page "Sales Quotes - Salesperson"=X,
        page "Salesperson Role Center"=X,
        page "SO PO Link"=X,
        page "SO PO Link FactBox"=X,
        page "Unallocated SalesLine"=X,
        page "Valid Field Value"=X,
        tabledata "Email Queue"=RIMD,
        table "Email Queue"=X,
        page "Email Queue"=X,
        tabledata "Navson BOM Component"=RIMD,
        table "Navson BOM Component"=X,
        page "Navson Assembly BOM"=X;
}