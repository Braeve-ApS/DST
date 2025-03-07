Codeunit 51010 "Ajourføring - Ny aftale"
{
    // // BetalingsService -------------------------------------- >>
    // // ˆ Copyright 1997, 2001 Hands A/S
    TableNo = "BS-Betalingsaftale";

    trigger OnRun()
    begin
        with "Ajourf.Kladdelinie" do begin
            if Find('+')then if not Confirm('Der ligger allerede transaktioner i ajourf¢ringskladden. Fortsæt ?')then Error('Ajourf¢ringen blev annulleret');
        end;
        Batch(Rec);
        Message('Tilmeldingen er klargjort.\\Jf. Ajourf¢ringskladden for afsendelse til PBS.');
    end;
    var "Ajourf.Kladdelinie": Record 51004;
    procedure Batch(var Aftale: Record "BS-Betalingsaftale")
    var
        LbNr: Integer;
        KontoInfoOk: Boolean;
        DebitorBankkonto: Record "Customer Bank Account";
    begin
        Aftale.CalcFields(Aktiv);
        if not Aftale.Aktiv then Error('Betalingsaftale %1 (%2) er ikke aktiv !', Aftale."Debitornr.", Aftale."Debitorgr.");
        KontoInfoOk:=DebitorBankkonto.Get(Aftale."Debitornr.", Aftale.Bankkonto);
        if KontoInfoOk then KontoInfoOk:=(DebitorBankkonto."Bank Branch No." <> '') and (DebitorBankkonto."Bank Account No." <> '');
        if KontoInfoOk then KontoInfoOk:=Aftale."CPR-/CVR-Nr." <> '';
        if not KontoInfoOk then Error('Tilmelding kan ikke godkendes på Betalingsaftale %1 (%2) !\\' + 'CPR- eller Kontooplysninger mangler.', Aftale."Debitornr.", Aftale."Debitorgr.");
        if Aftale."PBS Status" <> Aftale."pbs status"::Inaktiv then Error('Betalingsaftale %1 (%2) er allerede tilmeldt !', Aftale."Debitornr.", Aftale."Debitorgr.");
        // Find nyt Liniel¢benr.
        "Ajourf.Kladdelinie".Reset;
        if not "Ajourf.Kladdelinie".Find('+')then Clear("Ajourf.Kladdelinie");
        LbNr:="Ajourf.Kladdelinie"."Linienr." + 10000;
        // Indsæt Tilmelding
        with "Ajourf.Kladdelinie" do begin
            Reset;
            SetRange("Ajourføringsart", "Ajourføringsart"::"Ny aftale");
            SetRange("Debitornr.", Aftale."Debitornr.");
            SetRange("Debitorgr.", Aftale."Debitorgr.");
            if Find('=<>')then Error('Der kan kun oprettes én transaktion af samme type pr. aftale');
            Reset;
            Init;
            "Linienr.":=LbNr;
            "Ajourføringsart":="Ajourføringsart"::"Ny aftale";
            "Debitornr.":=Aftale."Debitornr.";
            "Debitorgr.":=Aftale."Debitorgr.";
            Insert;
        end;
    end;
}
