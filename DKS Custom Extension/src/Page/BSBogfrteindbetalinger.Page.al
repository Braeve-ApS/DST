Page 51040 "BS Bogførte indbetalinger"
{
    PageType = List;
    SourceTable = 51003;
    SourceTableView = sorting("Opkrævningsnr.", "Linienr.")where("Opkrævningsnr."=filter(<>''));
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Linienr."; Rec."Linienr.")
                {
                    ApplicationArea = Basic;
                }
                field("Opkrævningsnr."; Rec."Opkrævningsnr.")
                {
                    ApplicationArea = Basic;
                }
                field(Transmission; Rec.Transmission)
                {
                    ApplicationArea = Basic;
                }
                field(Transmissionslinie; Rec.Transmissionslinie)
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
                field("BS-Aftalenr."; Rec."BS-Aftalenr.")
                {
                    ApplicationArea = Basic;
                }
                field("BS-Bogf¢ringsdato"; Rec."BS-Bogf¢ringsdato")
                {
                    ApplicationArea = Basic;
                }
                field(Forfaldsdato; Rec.Forfaldsdato)
                {
                    ApplicationArea = Basic;
                }
                field("Opkrævet bel¢b"; Rec."Opkrævet bel¢b")
                {
                    ApplicationArea = Basic;
                }
                field(Indbetalingsdato; Rec.Indbetalingsdato)
                {
                    ApplicationArea = Basic;
                }
                field("Indbetalt bel¢b"; Rec."Indbetalt bel¢b")
                {
                    ApplicationArea = Basic;
                }
                field("Bemærkningstekst"; Rec."Bemærkningstekst")
                {
                    ApplicationArea = Basic;
                }
                field(Gebyr; Rec.Gebyr)
                {
                    ApplicationArea = Basic;
                }
                field(Transaktionsart; Rec.Transaktionsart)
                {
                    ApplicationArea = Basic;
                }
                field(Transaktionstype; Rec.Transaktionstype)
                {
                    ApplicationArea = Basic;
                }
                field(Fejl; Rec.Fejl)
                {
                    ApplicationArea = Basic;
                }
                field(Fejlbeskrivelse; Rec.Fejlbeskrivelse)
                {
                    ApplicationArea = Basic;
                }
                field("Tilh. Debitorpostl¢benr."; Rec."Tilh. Debitorpostl¢benr.")
                {
                    ApplicationArea = Basic;
                }
                field("Tilh. Opkrævningsnr."; Rec."Tilh. Opkrævningsnr.")
                {
                    ApplicationArea = Basic;
                }
                field("Tilh. Bilagsnr."; Rec."Tilh. Bilagsnr.")
                {
                    ApplicationArea = Basic;
                }
                field("Tilh. Bilagsdato"; Rec."Tilh. Bilagsdato")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
    actions
    {
    }
}
