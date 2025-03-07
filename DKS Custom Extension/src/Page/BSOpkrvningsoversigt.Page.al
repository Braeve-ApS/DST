Page 51028 "BS Opkrævningsoversigt"
{
    CardPageID = "BS Opkrævninger";
    Editable = false;
    PageType = List;
    SourceTable = "BS-Opkrævningshoved";
    SourceTableView = sorting("Bogført", "Opkrævningsnr.")where("Bogført"=const(false));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Opkrævningsnr."; Rec."Opkrævningsnr.")
                {
                    ApplicationArea = Basic;
                }
                field("Debitornr."; Rec."Debitornr.")
                {
                    ApplicationArea = Basic;
                }
                field("Opkrævningsdato"; Rec."Opkrævningsdato")
                {
                    ApplicationArea = Basic;
                }
                field("Debitorgr."; Rec."Debitorgr.")
                {
                    ApplicationArea = Basic;
                }
                field("Opkrævningsbel¢b"; Rec."Opkrævningsbeløb")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(cor_deleteMarked)
            {
                Image = DeleteRow;
                ApplicationArea = All;
                Caption = 'Slet markerede';

                trigger OnAction()
                var
                    lBSOpkrævningshoved_loc: Record "BS-Opkrævningshoved";
                begin
                    CurrPage.SetSelectionFilter(lBSOpkrævningshoved_loc);
                    "lBSOpkrævningshoved_loc".SetRange("Bogført", false);
                    if "lBSOpkrævningshoved_loc".Count > 1 then if not Confirm(StrSubstNo('Du er nu ved at slette %1 antal opkrævninger, fortsæt?', "lBSOpkrævningshoved_loc".Count), TRUE)then Error('');
                    if "lBSOpkrævningshoved_loc".FINDSET then repeat "lBSOpkrævningshoved_loc".Delete(true);
                        until "lBSOpkrævningshoved_loc".NEXT = 0;
                end;
            }
        }
    }
}
