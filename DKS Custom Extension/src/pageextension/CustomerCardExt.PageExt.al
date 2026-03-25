pageextension 50000 "Customer Card Ext" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("Social Security No."; Rec."Social Security No.")
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
        addlast(Payments)
        {
            field("PBS Incl moms"; Rec."PBS Incl moms")
            {
                visible = true;
                ApplicationArea = all;
            }
        }
        addafter("CPM Bal. Account No.")
        {
            field("Anvender BetalingsService"; Rec."Anvender BetalingsService")
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }
}
