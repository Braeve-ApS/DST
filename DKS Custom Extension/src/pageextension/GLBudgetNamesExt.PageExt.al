pageextension 50005 "G/L Budget Names Ext" extends "G/L Budget Names"
{
    actions
    {
        addlast(processing)
        {
            action("ImportSheet")
            {
                ApplicationArea = Basic;
                Caption = 'Open DST-Import';
                RunObject = Page "G/L Budget Entry Import";
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
            }
        }
    }
}
