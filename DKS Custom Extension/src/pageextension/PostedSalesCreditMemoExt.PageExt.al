pageextension 50007 "Posted Sales Credit Memo Ext" extends "Posted Sales Credit Memo"
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
