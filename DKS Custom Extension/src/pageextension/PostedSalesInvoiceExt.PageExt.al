pageextension 50006 "Posted Sales Invoice Ext" extends "Posted Sales Invoice"
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
