pageextension 50010 "VAT Posting Setup Ext" extends "VAT Posting Setup"
{
    layout
    {
        addlast(Control1)
        {
            field("VAT Statement No."; Rec.Kommunemoms)
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
    }
}
