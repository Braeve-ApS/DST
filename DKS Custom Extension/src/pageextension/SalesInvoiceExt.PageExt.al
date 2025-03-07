pageextension 50003 "Sales Invoice Ext" extends "Sales Invoice"
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
