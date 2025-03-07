XmlPort 50000 "Import KMD Løn"
{
    // PI: Version 4.0 Dataport 50000
    // Status: Ikke testet
    Direction = Import;
    Format = FixedText;

    schema
    {
    textelement(root)
    {
    tableelement("Gen. Journal Line";
    "Gen. Journal Line")
    {
    XmlName = 'gnl';

    textelement(ekspnr)
    {
    XmlName = 'EkspNr';
    Width = 7;
    }
    textelement(postdato)
    {
    XmlName = 'PostDato';
    Width = 8;
    }
    textelement(regkonto)
    {
    XmlName = 'RegKonto';
    Width = 10;
    }
    textelement("Ørepostering")
    {
    XmlName = 'ØrePostering';
    Width = 12;
    }
    textelement(fortegn)
    {
    XmlName = 'Fortegn';
    Width = 1;
    }
    textelement(debetkredit)
    {
    XmlName = 'DebetKredit';
    Width = 1;
    }
    trigger OnBeforeInsertRecord()
    begin
        //4.0 OnAfterImportrecord
        LinieNummer:=LinieNummer + 10000;
        KMDBrugerTabel.Reset;
        Evaluate(EkspNrMinRange, CopyStr(EkspNr, 4));
        KMDBrugerTabel.Ekspeditionsnummer:=EkspNrMinRange;
        if not KMDBrugerTabel.Find('>=')then Error('Interval kan ikke findes til ekspeditionsnummer %1.', EkspNrMinRange);
        if KMDBrugerTabel.Ekspeditionsnummer <> EkspNrMinRange then if KMDBrugerTabel.Next(-1) = 0 then Error('Interval kan ikke findes til ekspeditionsnummer %1.', EkspNrMinRange);
        KMDBrugerTabel.TestField(Bruger);
        KMDBrugerTabel.Indlæsningsdato:=Today;
        KMDBrugerTabel.Modify;
        "KMD Kladde".Init;
        "KMD Kladde".Linienummer:=LinieNummer;
        "KMD Kladde".Bruger:=KMDBrugerTabel.Bruger;
        "KMD Kladde".Regnskabsnavn:=KMDBrugerTabel.Regnskabsnavn;
        "KMD Kladde".Indlæsningsdato:=Today;
        i:=StripLeadingZero(RegKonto);
        if i > 0 then RegKonto:=DelStr(RegKonto, 1, i);
        "KMD Kladde"."Kontonr.":=RegKonto;
        "KMD Kladde".Bogføringsdato:=FormaterDato(PostDato);
        "KMD Kladde"."Bilagsnr.":=BilagsNr;
        Filnavn:=currXMLport.Filename;
        while StrPos(Filnavn, '\') > 0 do Filnavn:=DelStr(Filnavn, 1, StrPos(Filnavn, '\'));
        "KMD Kladde".Beskrivelse:=Filnavn;
        "KMD Kladde".Beløb:=FormaterDecTal("Ørepostering");
        "KMD Kladde".Insert;
    end;
    }
    trigger OnBeforePassVariable()
    begin
        //4.0 On PredataItem
        if Sti = '' then Error('Filnavn mangler.');
        if BilagsNr = '' then Error('Bilagsnummer mangler.');
        "KMD Kladde".DeleteAll;
        LinieNummer:=0;
    end;
    }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    var "KMD Kladde": Record "KMD Kladde";
    KMDBrugerTabel: Record "KMD Bruger";
    KMDBruger: Integer;
    EkspNrMinRange: Integer;
    i: Integer;
    Sti: Text[250];
    Filnavn: Text[250];
    BilagsNr: Code[20];
    LinieNummer: Integer;
    procedure FormaterDato(DatoStr: Text[10]): Date var
        Dg: Integer;
        Md: Integer;
        "År": Integer;
        TmpDato: Date;
    begin
        Evaluate(Dg, CopyStr(DatoStr, 7, 2));
        Evaluate(Md, CopyStr(DatoStr, 5, 2));
        Evaluate(År, CopyStr(DatoStr, 1, 4));
        DatoStr:=Format(Dg) + '-' + Format(Md) + '-' + Format(År);
        Evaluate(TmpDato, DatoStr);
        exit(TmpDato);
    end;
    procedure StripLeadingZero(KtoNr: Text[10]): Integer var
        j: Integer;
        Tegn: Text[1];
    begin
        for j:=1 to StrLen(KtoNr)do if CopyStr(KtoNr, j, 1) <> '0' then exit(j - 1);
    end;
    procedure FormaterDecTal(Strøre: Text[30]): Decimal var
        DecPostering: Decimal;
    begin
        Evaluate(DecPostering, Strøre);
        DecPostering:=DecPostering / 100;
        if Fortegn = '-' then DecPostering:=-DecPostering;
        /*
        IF DebetKredit = 'K' THEN
          DecPostering := -DecPostering;
         */
        exit(DecPostering);
    end;
}
