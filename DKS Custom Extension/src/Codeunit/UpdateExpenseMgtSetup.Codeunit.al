codeunit 50004 "Update Expense Mgt. Setup"
{
    trigger OnRun()
    begin
        if CEMExpenseManagementSetup.FindFirst()then begin
            CEMExpenseManagementSetup."Data Version":=240000;
            CEMExpenseManagementSetup.Modify();
        end end;
    var CEMExpenseManagementSetup: Record "CEM Expense Management Setup";
}
