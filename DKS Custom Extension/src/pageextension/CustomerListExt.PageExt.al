pageextension 50001 "Customer List Ext" extends "Customer List"
{
    layout
    {
        addlast(Control1)
        {
            field("Social Security No."; Rec."Social Security No.")
            {
                Visible = true;
                ApplicationArea = All;
            }
            field("Trading Partner (Filter)"; Rec."Trading Partner (Filter)")
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }
}
