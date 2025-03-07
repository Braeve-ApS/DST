pageextension 50002 "Sales Order Ext" extends "Sales Order"
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
