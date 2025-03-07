Page 51029 "BS Bogf. Opkrævningsoversigt"
{
    CardPageID = "BS Bogf. Opkrævninger";
    Editable = false;
    PageType = List;
    SourceTable = "BS-Opkrævningshoved";
    SourceTableView = sorting("Bogført", "Opkrævningsnr.")where("Bogført"=const(true));

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
                field("Debitorgr."; Rec."Debitorgr.")
                {
                    ApplicationArea = Basic;
                }
                field("Opkrævningsstatus"; Rec."Opkrævningsstatus")
                {
                    ApplicationArea = Basic;
                }
                field("Opkrævningsdato"; Rec."Opkrævningsdato")
                {
                    ApplicationArea = Basic;
                }
                field("Opkrævningsbel¢b"; Rec."Opkrævningsbeløb")
                {
                    ApplicationArea = Basic;
                }
                field("Referenceopkrævning"; Rec."Referenceopkrævning")
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
            action(Indbetalinger)
            {
                ApplicationArea = Basic;
                Image = LedgerEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = false;
                RunObject = Page "BS Bogførte indbetalinger";
                RunPageLink = "Opkrævningsnr."=field("Opkrævningsnr.");
                RunPageView = sorting("Opkrævningsnr.", "Linienr.");
            }
        }
    }
}
