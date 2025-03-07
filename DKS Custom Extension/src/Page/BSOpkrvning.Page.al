Page 50043 "BS Opkrævning"
{
    AutoSplitKey = true;
    PageType = Worksheet;
    SourceTable = "BS-Opkrævningslinie";
    SourceTableView = sorting("Opkrævningsnr.", "Linienr.")where("Bogført"=filter(false));
    ApplicationArea = basic;

    layout
    {
        area(content)
        {
            field(TilFin; TilFin)
            {
                ApplicationArea = Basic;
                Caption = 'Tilh. Finanskonto/Vare';

                trigger OnValidate()
                begin
                    UpdateFormen;
                end;
            }
            field(TilType; TilType)
            {
                ApplicationArea = Basic;
                Caption = 'Tilhørstype';

                trigger OnValidate()
                begin
                    UpdateFormen;
                end;
            }
            repeater(Group)
            {
                field("Opkrævningsnr."; Rec."Opkrævningsnr.")
                {
                    ApplicationArea = Basic;
                }
                field("Linienr."; Rec."Linienr.")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Debitornr."; Rec."Debitornr.")
                {
                    ApplicationArea = Basic;
                }
                field("Evt. Specifikationskode"; Rec."Evt. Specifikationskode")
                {
                    ApplicationArea = Basic;
                }
                field("Evt. Fremrykkelsesdato"; Rec."Evt. Fremrykkelsesdato")
                {
                    ApplicationArea = Basic;
                }
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
                field("Tilh. Finanskonto/Vare"; Rec."Tilh. Finanskonto/Vare")
                {
                    ApplicationArea = Basic;
                }
                field("Beløb"; rec."Beløb")
                {
                    ApplicationArea = Basic;
                }
                field("Ref. Debitorpost"; Rec."Ref. Debitorpost")
                {
                    ApplicationArea = Basic;
                }
                field("Bogføringsdato"; rec."Bogføringsdato")
                {
                    ApplicationArea = Basic;
                }
                field("Bilagsnr."; Rec."Bilagsnr.")
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
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Sælgerkode"; Rec.Sælgerkode)
                {
                    ApplicationArea = Basic;
                }
                field("Tilhøre type"; Rec."Tilhøre type")
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
            }
        }
    }
    actions
    {
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean begin
        //Jim 300517
        Rec."Debitornr.":=xRec."Debitornr.";
        Rec."Evt. Specifikationskode":=xRec."Evt. Specifikationskode";
    //<<
    end;
    trigger OnModifyRecord(): Boolean begin
    //CurrPage.UPDATE(FALSE);
    end;
    var T51009: Record "BS-Opkrævningshoved";
    T51010: Record "BS-Opkrævningslinie";
    F50043: Page "BS Opkrævning";
    T15: Record "G/L Account";
    F18: Page "G/L Account List";
    TilFin: Code[20];
    TilType: Option "  ", Finans, Vare;
    "Bogført": Boolean;
    procedure UpdateFormen()
    begin
        if TilFin <> '' then Rec.SetFilter("Tilh. Finanskonto/Vare", '*' + TilFin + '*')
        else
            Rec.SetRange("Tilh. Finanskonto/Vare");
        if TilType <> 0 then begin
            if TilType = 1 then Rec.SetRange("Tilhøre type", 0)
            else if TilType = 2 then Rec.SetRange("Tilhøre type", 1)end
        else
            Rec.SetRange("Tilhøre type");
        CurrPage.Update(false);
    //CurrPage.UPDATE;
    end;
}
