pageextension 50015 "cor GL Entries" extends "General Ledger Entries"
{
    actions
    {
        addafter("Ent&ry")
        {
            action("DST Correct Dimensions")
            {
                Caption = 'DST Correct Dimensions';
                ApplicationArea = Dimensions;
                Image = Edit;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    CorrectionDimensionOnGLEntry: Page 50027;
                begin
                    Clear(CorrectionDimensionOnGLEntry);
                    CorrectionDimensionOnGLEntry.CallIn(Rec."Entry No.");
                    CorrectionDimensionOnGLEntry.RunModal();
                end;
            }
        }
    }
}
