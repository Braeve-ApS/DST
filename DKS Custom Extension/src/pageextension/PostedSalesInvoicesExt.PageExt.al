pageextension 50008 "Posted Sales Invoices Ext" extends "Posted Sales Invoices"
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
