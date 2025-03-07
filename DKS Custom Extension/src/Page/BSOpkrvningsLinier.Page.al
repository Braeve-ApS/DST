Page 51026 "BS OpkrævningsLinier"
{
    PageType = ListPart;
    SourceTable = "BS-Opkrævningslinie";
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Art; Rec.Art)
                {
                    ApplicationArea = Basic;
                }
                field(Sats; Rec.Sats)
                {
                    ApplicationArea = Basic;
                }
                field(Beskrivelse; Rec.Beskrivelse)
                {
                    ApplicationArea = Basic;
                }
                field("Beløb"; Rec."Beløb")
                {
                    ApplicationArea = Basic;
                }
                field("Tilh. Finanskonto/Vare"; Rec."Tilh. Finanskonto/Vare")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Funktionskode (Dimension)"; Rec."Funktionskode (Dimension)")
                {
                    ApplicationArea = Basic;
                }
                field("Trading Partner (Dimension)"; Rec."Trading Partner (Dimension)")
                {
                    ApplicationArea = Basic;
                }
                field("Projekt Fase (Dimension)"; Rec."Projekt Fase (Dimension)")
                {
                    ApplicationArea = Basic;
                }
                field("Sælgerkode"; Rec.Sælgerkode)
                {
                    ApplicationArea = Basic;
                }
                field("Bogføringsdato"; Rec."Bogføringsdato")
                {
                    ApplicationArea = Basic;
                }
                field(Bilagsdato; Rec.Bilagsdato)
                {
                    ApplicationArea = Basic;
                }
                field(Forfaldsdato; Rec.Forfaldsdato)
                {
                    ApplicationArea = Basic;
                }
                field("Bilagsnr."; Rec."Bilagsnr.")
                {
                    ApplicationArea = Basic;
                }
                field("Tilhøre beløb excl moms"; Rec."Tilhøre beløb excl moms")
                {
                    ApplicationArea = Basic;
                }
                field("Tilhøre beløb incl. moms"; Rec."Tilhøre beløb incl. moms")
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
