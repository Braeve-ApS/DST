pageextension 50009 "Posted Sales Credit Memos Ext" extends "Posted Sales Credit Memos"
{
    layout
    {
        addlast(Control1)
        {
            field("E-fak Note"; Rec."E-fak Note")
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }
}
