Codeunit 51011 "Ajourføring - Automatisk"
{
    // // BetalingsService -------------------------------------- >>
    // // ˆ Copyright 1997, 2001 Hands A/S
    trigger OnRun()
    begin
        if not Confirm('Tilmelding af Betalingsaftaler foretages på grundlag af de aktuelle aftaleforhold.\\' + '** Debitorene genneml¢bes og nye aftaler oprettes.\' + '** Inaktive Betalingsaftaler kontrolleres og afmeldes om n¢dvendigt.\' + '** Tilmelding foretages hvor CPR- og kontooplysninger er udfyldt og "Tillad Tilmelding" er angivet.\\' + 'Fortsæt med automatisk Ajourf¢ring ?', true)then exit;
        "Automatisk Ajourf¢ring";
        Message('Resultat af ajourf¢ringen :\\' + '%1 nye betalingsaftale(r) oprettet.\' + '%2 nye aftale(r) klargjort til tilmelding\' + '%3 aftale(r) afmeldt på grund af inaktivering\\' + 'Til- og afmeldinger er oprettet i Ajourf¢ringskladden, hvorfra de skal afsendes til PBS.\' + 'Nye aftaler skal påf¢res CPR- og Kontooplysninger f¢r evt. tilmeldelse kan finde sted.', Oprettet, Tilmeldt, Afmeldt);
    end;
    var Oprettet: Integer;
    Tilmeldt: Integer;
    Afmeldt: Integer;
    procedure "Automatisk Ajourf¢ring"()
    var
        Stamoplysninger: Record "BS-Stamoplysninger";
        Betalingsaftale: Record "BS-Betalingsaftale";
        Specifikation: Record "BS-Specifikation";
        AjourLinie: Record 51004;
        Debitorbankkonto: Record "Customer Bank Account";
        Debitor: Record Customer;
        Tilmeld: Codeunit "Ajourføring - Ny aftale";
        Afmeld: Codeunit "Ajourføring - Aftaleophør";
        PB: Codeunit 51049;
        SpecOk: Boolean;
        KontoInfoOk: Boolean;
    begin
        Clear(Oprettet);
        Clear(Tilmeldt);
        Clear(Afmeldt);
        Debitor.Reset;
        Debitor.SetCurrentkey(Debitor."Anvender BetalingsService");
        Debitor.SetRange(Debitor."Anvender BetalingsService", true);
        if Debitor.Find('-')then begin
            PB.Open('Nye Betalingsaftaler lokaliseres :', Debitor.Count);
            Betalingsaftale.Reset;
            repeat PB.Update;
                Betalingsaftale.SetRange("Debitornr.", Debitor."No.");
                if not Betalingsaftale.Find('=><')then begin
                    Clear(Betalingsaftale);
                    Betalingsaftale."Debitornr.":=Debitor."No.";
                    Betalingsaftale."Debitorgr.":=Stamoplysninger."Aktuelle Debitorgruppe";
                    Betalingsaftale."PBS Status":=Betalingsaftale."pbs status"::Inaktiv;
                    Betalingsaftale.Insert;
                    Oprettet:=Oprettet + 1;
                end;
            until Debitor.Next = 0;
            PB.Close;
        end;
        Betalingsaftale.Reset;
        PB.Open('Betalingsaftalerne ajourf¢res :', Betalingsaftale.Count);
        if Betalingsaftale.Find('-')then repeat PB.Update;
                // Sikring af grundlæggende integritet
                Betalingsaftale.CalcFields(Aktiv);
                KontoInfoOk:=Betalingsaftale.Aktiv;
                if KontoInfoOk then KontoInfoOk:=Debitorbankkonto.Get(Betalingsaftale."Debitornr.", Betalingsaftale.Bankkonto);
                if KontoInfoOk then KontoInfoOk:=(Debitorbankkonto."Bank Branch No." <> '') and (Debitorbankkonto."Bank Account No." <> '');
                if KontoInfoOk then KontoInfoOk:=Betalingsaftale."CPR-/CVR-Nr." <> '';
                // Valide aftaler tilmeldes
                if KontoInfoOk and (Betalingsaftale."PBS Status" = Betalingsaftale."pbs status"::Inaktiv) and Betalingsaftale."Tillad aut. tilmelding" then begin
                    AjourLinie.Reset;
                    AjourLinie.SetRange("Ajourføringsart", AjourLinie."Ajourføringsart"::"Ny aftale");
                    AjourLinie.SetRange("Debitornr.", Betalingsaftale."Debitornr.");
                    AjourLinie.SetRange("Debitorgr.", Betalingsaftale."Debitorgr.");
                    if not AjourLinie.Find('=<>')then begin
                        Tilmeld.Batch(Betalingsaftale);
                        Tilmeldt:=Tilmeldt + 1;
                    end;
                end
                else if(Betalingsaftale."PBS Status" = Betalingsaftale."pbs status"::Tilmeldt) and (Betalingsaftale.Aktiv = false)then begin
                        // Hvor Debitor ikke længere anvender BS, men stadig har en aktiv aftale, afmeldes
                        AjourLinie.Reset;
                        AjourLinie.SetRange("Ajourføringsart", AjourLinie."Ajourføringsart"::"Aftaleophør");
                        AjourLinie.SetRange("Debitornr.", Betalingsaftale."Debitornr.");
                        AjourLinie.SetRange("Debitorgr.", Betalingsaftale."Debitorgr.");
                        if not AjourLinie.Find('=<>')then begin
                            Afmeld.Batch(Betalingsaftale);
                            Afmeldt:=Afmeldt + 1;
                        end;
                    end;
            until Betalingsaftale.Next = 0;
        Betalingsaftale.Reset;
        Betalingsaftale.SetRange("Tillad aut. tilmelding", true);
        Betalingsaftale.ModifyAll("Tillad aut. tilmelding", false);
        PB.Close;
    end;
}
