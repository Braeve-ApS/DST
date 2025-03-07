pageextension 50004 "Sales Credit Memo Ext" extends "Sales Credit Memo"
{
    layout
    {
        addlast(General)
        {
            field("E-fak Note"; Rec."E-fak Note")
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }
}
