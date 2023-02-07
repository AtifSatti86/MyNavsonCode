pageextension 58000 "Navson Document Attach Details" extends "Document Attachment Details"
{
    layout
    {
        addbefore("File Extension")
        {
            field("Attachment Type"; Rec."Attachment Type")
            {
                ApplicationArea = All;
                ToolTip = 'Specified the value of attachment type';
                Editable = ReadOnly;
                Visible = Visibility;
            }
        }
    }
    trigger OnOpenPage()
    var
        AccessControl: Record "Access Control";
        User: Record User;
        NavsonSetup: Record "Navson Setup";
    begin
        if not NavsonSetup.Get() then
            exit;
        User.Get(UserSecurityId());
        AccessControl.SetRange("User Security ID", UserSecurityId());
        AccessControl.SetRange("Role ID", NavsonSetup."Role-ID");
        if not AccessControl.IsEmpty() then
            ReadOnly := true
        else
            ReadOnly := false;
    end;

    trigger OnAfterGetRecord()
    begin
        if Rec."Table ID" in [Database::"Sales Invoice Header", Database::"Sales Header"] then
            Visibility := true
        else
            Visibility := false;
    end;

    trigger OnDeleteRecord(): Boolean
    var
        AccessControl: Record "Access Control";
        User: Record User;
        NavsonSetup: Record "Navson Setup";
    begin
        if not NavsonSetup.Get() then
            exit;
        if not User.Get(UserSecurityId()) then
            exit;
        if Rec."Attachment Type" > 0 then begin
            AccessControl.SetRange("User Security ID", UserSecurityId());
            AccessControl.SetRange("Role ID", NavsonSetup."Role-ID");
            if AccessControl.IsEmpty() then begin
                Message('Permission denied : Marked Attachement cannot be deleted!');
                exit(false)
            end
            else
                exit(true);
        end;
        exit(true);
    end;

    var
        ReadOnly: Boolean;
        Visibility: Boolean;
}
