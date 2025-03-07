Page 51001 "BS Specifikationstekst"
{
    AutoSplitKey = true;
    PageType = ListPart;
    SourceTable = "BS-Specifkationstekst";

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
                field("Tilhøre type"; Rec."Tilhøre type")
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
                field("Sælgerkode"; Rec."Sælgerkode")
                {
                    ApplicationArea = Basic;
                }
                field("Belæb"; Rec."Beløb")
                {
                    ApplicationArea = Basic;
                }
                field("Beskrivelse Formateret"; Rec."Beskrivelse Formateret")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
            }
        }
    }
    actions
    {
    }
    procedure Formatering(var Spec: Record "BS-Specifikation"; Withconfirm: Boolean)
    var
        SpecLinie: Record "BS-Specifkationstekst";
        "Bel¢bstekst": Text[30];
    begin
        if Spec.Fællesskabelon <> '' then Error('Formatering kan ikke ske på Fællesskabeloner');
        // DT/PG 28.02.05 >>
        if Withconfirm then // DT/PG 28.02.05 <<
 if not Confirm('Alle adviseringslinier reformateres', false)then exit;
        SpecLinie.Reset;
        SpecLinie.SetRange("Debitornr.", Spec."Debitornr.");
        SpecLinie.SetRange("Debitorgr.", Spec."Debitorgr.");
        SpecLinie.SetRange(Specifikationskode, Spec.Kode);
        SpecLinie.SetRange(Art, SpecLinie.Art::Fællesoverskrift);
        SpecLinie.DeleteAll;
        SpecLinie."Debitornr.":=Spec."Debitornr.";
        SpecLinie."Debitorgr.":=Spec."Debitorgr.";
        SpecLinie.Specifikationskode:=Spec.Kode;
        SpecLinie."Linienr.":=1;
        SpecLinie.Art:=SpecLinie.Art::Fællesoverskrift;
        SpecLinie."Beskrivelse Formateret":= //  [12345678901234567890123456789012345678]
        'VEDR¥RENDE                       BEL¥B';
        SpecLinie.Insert;
        SpecLinie."Linienr.":=2;
        SpecLinie.Art:=SpecLinie.Art::Fællesoverskrift;
        SpecLinie."Beskrivelse Formateret":= //  [12345678901234567890123456789012345678]
        '--------------------------------------';
        SpecLinie.Insert;
        SpecLinie.SetRange(Art, SpecLinie.Art::Advisering);
        if SpecLinie.Find('-')then repeat if SpecLinie.Beskrivelse = '' then Error('Der mangler beskrivelse på linie %1', SpecLinie."Linienr.");
                "Bel¢bstekst":=Format(SpecLinie."Beløb", 0, '<Sign><Integer Thousand><Decimals,3>');
                while StrLen("Bel¢bstekst") < 10 do "Bel¢bstekst":=' ' + "Bel¢bstekst";
                if StrLen("Bel¢bstekst") > 10 then "Bel¢bstekst":='**********';
                SpecLinie."Beskrivelse Formateret":=StrSubstNo('#1######################### #2########', SpecLinie.Beskrivelse, "Bel¢bstekst");
                SpecLinie.Modify;
            until SpecLinie.Next = 0;
    end;
}
