pageextension 50011 "Fixed Asset List Ext" extends "Fixed Asset List"
{
    layout
    {
        addlast(Control1)
        {
            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                Visible = true;
                ApplicationArea = All;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }
}
