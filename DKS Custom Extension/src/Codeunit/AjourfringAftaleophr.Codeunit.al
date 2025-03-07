Codeunit 51012 "Ajourføring - Aftaleophør"
{
    // // BetalingsService -------------------------------------- >>
    // // ˆ Copyright 1997, 2001 Hands A/S
    TableNo = "BS-Betalingsaftale";

    trigger OnRun()
    begin
        if "Ajourf.Kladdelinie".Findlast then if not Confirm('Der ligger allerede transaktioner i ajourf¢ringskladden. Fortsæt ?')then Error('Ajourf¢ringen blev annulleret');
        Batch(Rec);
        Message('Ajourf¢ring afsluttet.\\Jf. Ajourf¢ringskladden for afsendelse af ajourf¢ringer.');
    end;
    var Stamoplysninger: Record "BS-Stamoplysninger";
    "Ajourf.Kladdelinie": Record 51004;
    procedure Batch(var Aftale: Record "BS-Betalingsaftale")
    var
        LbNr: Integer;
    begin
        // Find nyt Liniel¢benr.
        "Ajourf.Kladdelinie".Reset;
        if not "Ajourf.Kladdelinie".Find('+')then Clear("Ajourf.Kladdelinie");
        LbNr:="Ajourf.Kladdelinie"."Linienr." + 10000;
        "Ajourf.Kladdelinie".Reset;
        "Ajourf.Kladdelinie".SetRange("Ajourføringsart", "Ajourf.Kladdelinie"."Ajourføringsart"::"Aftaleophør");
        "Ajourf.Kladdelinie".SetRange("Debitornr.", Aftale."Debitornr.");
        "Ajourf.Kladdelinie".SetRange("Debitorgr.", Aftale."Debitorgr.");
        if "Ajourf.Kladdelinie".Find('=<>')then Error('Der kan kun oprettes én transaktion af samme type pr. aftale');
        "Ajourf.Kladdelinie".Reset;
        "Ajourf.Kladdelinie".Init;
        "Ajourf.Kladdelinie"."Linienr.":=LbNr;
        "Ajourf.Kladdelinie"."Ajourføringsart":="Ajourf.Kladdelinie"."Ajourføringsart"::"Aftaleophør";
        "Ajourf.Kladdelinie"."Debitornr.":=Aftale."Debitornr.";
        "Ajourf.Kladdelinie"."Debitorgr.":=Aftale."Debitorgr.";
        "Ajourf.Kladdelinie"."Fejl i kundenr.":=Aftale."Aftalenr." = 'UKENDT';
        "Ajourf.Kladdelinie".Insert;
    end;
}
