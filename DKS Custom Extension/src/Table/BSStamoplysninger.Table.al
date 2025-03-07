Table 51007 "BS-Stamoplysninger"
{
    fields
    {
        field(1; "Primærnøgle"; Code[10])
        {
            Editable = false;
        }
        field(10; "Sti til indlæsningskatalog"; Text[80])
        {
        }
        field(11; "Sti til udlæsningskatalog"; Text[80])
        {
        }
        field(12; "Sti til PBS Mailbox"; Text[80])
        {
        }
        field(15; "Kundenr. notation"; Option)
        {
            OptionMembers = "Variabel (uden foranstillede 0'er)", Fast;

            trigger OnValidate()
            begin
                if "Kundenr. notation" = "kundenr. notation"::"Variabel (uden foranstillede 0'er)" then Clear("Kundenr. fast længde");
            end;
        }
        field(16; "Kundenr. fast længde"; Integer)
        {
            trigger OnValidate()
            begin
                TestField("Kundenr. notation", "kundenr. notation"::Fast);
            end;
        }
        field(19; "Dubletkontrol på CPR/CVR-Nr."; Boolean)
        {
        }
        field(20; "Specificeret CVR-Nr."; Code[8])
        {
            CharAllowed = '09';
            Numeric = true;

            trigger OnValidate()
            begin
                if(xRec."Specificeret CVR-Nr." <> '') and ("Specificeret CVR-Nr." = '')then Message('Værdien i feltet %1 på tabellen %2 vil blive anvendt i stedet for.', Firmaoplysninger.FieldName("VAT Registration No."), Firmaoplysninger.TableName);
                if "Specificeret CVR-Nr." <> '' then "Validér CVR-Nummer"("Specificeret CVR-Nr.", false, false);
            end;
        }
        field(25; Delsystemkode; Code[3])
        {
        }
        field(26; "Debitorgr. min. værdi"; Integer)
        {
            InitValue = 1;
            MaxValue = 99999;
            MinValue = 1;

            trigger OnValidate()
            begin
                if "Debitorgr. max. værdi" < "Debitorgr. min. værdi" then "Debitorgr. max. værdi":="Debitorgr. min. værdi";
            end;
        }
        field(27; "Debitorgr. max. værdi"; Integer)
        {
            InitValue = 1;
            MaxValue = 99999;
            MinValue = 1;

            trigger OnValidate()
            begin
                if "Debitorgr. max. værdi" < "Debitorgr. min. værdi" then "Debitorgr. max. værdi":="Debitorgr. min. værdi";
            end;
        }
        field(30; "Sidste Opkrævningsnr."; Code[9])
        {
            Numeric = true;

            trigger OnValidate()
            begin
                while StrLen("Sidste Opkrævningsnr.") < 9 do "Sidste Opkrævningsnr.":='0' + "Sidste Opkrævningsnr.";
            end;
        }
        field(31; "Sidste Indbetalingsnr."; Code[10])
        {
        }
        field(35; "Indbetalings Modkonto"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(36; "Indbetalings Gebyrkonto"; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(40; "BetalingsService type"; Option)
        {
            InitValue = "BS-Total";
            OptionMembers = "BS-Basis", "BS-Total";

            trigger OnValidate()
            begin
                if "BetalingsService type" <> "betalingsservice type"::"BS-Total" then Error('Denne version af "BetalingsService til Navision Financials" understøtter kun "BS-Total"');
                // Den efterfølgende kode forbereder en evt. implementering af BS-Basis
                if "BetalingsService type" <> xRec."BetalingsService type" then begin
                    Betalingsaftale.Reset;
                    if Betalingsaftale.Find('-')then Error('%1 kan ikke ændres når først der er oprettet betalingsaftaler')
                    else
                        Message('Forskellene mellem "BS-Basis" og "BS-Total" er afgørende for løsningens virkemåde.\' + 'Gennemlæs dokumentationen nøje før %1 fastlægges.\\' + 'Når først systemet tages i brug, kan denne indstilling ikke længere ændres !', FieldName("BetalingsService type"));
                end;
            end;
        }
        field(41; Adviseringstype; Option)
        {
            Description = 'BS2.60.03';
            OptionMembers = "Kort (38 tegn)", "Lang (60 tegn)", Blandet;
        }
        field(50; "Bogføringsmetode"; Option)
        {
            OptionMembers = Salgsfaktura, Kassekladde;

            trigger OnValidate()
            begin
                if(Bogføringsmetode = Bogføringsmetode::Kassekladde) AND (Bilagsmetode = Bilagsmetode::"Et bilag pr. opkrævning")THEN begin
                    Bilagsmetode:=Bilagsmetode::"Nyt bilag pr. advisering"; // Tildeling sker af hensyn til visningen i error-boksen !
                    Error('Når %1 er ''%2'' skal %3 være ''%4'' !', FieldName(Bogføringsmetode), Bogføringsmetode, FieldName(Bilagsmetode), Bilagsmetode);
                end;
            end;
        }
        field(51; Bilagsmetode; Option)
        {
            OptionMembers = "Nyt bilag pr. advisering", "Et bilag pr. opkrævning";

            trigger OnValidate()
            begin
                if(Bogføringsmetode = Bogføringsmetode::Kassekladde) AND (Bilagsmetode = Bilagsmetode::"Et bilag pr. opkrævning")THEN begin
                    Bilagsmetode:=Bilagsmetode::"Nyt bilag pr. advisering"; // Tildeling sker af hensyn til visningen i error-boksen !
                    Error('Når %1 er ''%2'' skal %3 være ''%4'' !', FieldName(Bogføringsmetode), Bogføringsmetode, FieldName(Bilagsmetode), Bilagsmetode);
                end;
            end;
        }
    }
    keys
    {
        key(Key1; "Primærnøgle")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Firmaoplysninger: Record "Company Information";
    Betalingsaftale: Record "BS-Betalingsaftale";
    procedure "Juster År-2000 dato"(Tekst: Text[8])Dato: Date var
        Dag: Integer;
        "Måned": Integer;
        "År": Integer;
    begin
        // PBS Anvender en to-cifret notation ved angivelse af årstal. Dette indebærer ikke i sig selv nogen År-2000 problematik,
        // da det vil være utænkeligt at transaktioner og betalingsoplysninger vil strække sig mere end 100 år frem eller tilbage
        // i tiden.
        //
        // Det vedtages derfor :
        //
        // Hvis Dags dato ligger før den 1. Januar 2090 og BS-Årstal er større eller lig '90' -
        //  - så Indsættes '19' foran årstallet.
        //
        // Hvis Dags dato ligger efter den 31. December 1996 og BS-Årstal er mindre eller lig '96' -
        // -  så Indsættes '20' foran årstallet.
        //
        // Senere revisioner af "BetalingsService til Navision Financials" bør fremrykke denne opdeling.
        if Tekst = '000000' then Dato:=0D
        else
        begin
            Evaluate(Dag, CopyStr(Tekst, 1, 2));
            Evaluate(Måned, CopyStr(Tekst, 3, 2));
            Evaluate(År, CopyStr(Tekst, 5, 2));
            if År >= 90 then Dato:=Dmy2date(Dag, Måned, 1900 + År);
            if År <= 89 then Dato:=Dmy2date(Dag, Måned, 2000 + År)end;
    end;
    procedure "Juster Kundenr."(var Kundenr: Text[250])
    begin
        case "Kundenr. notation" of "kundenr. notation"::"Variabel (uden foranstillede 0'er)": begin
            while Kundenr[1] = '0' do if StrLen(Kundenr) > 1 then Kundenr:=CopyStr(Kundenr, 2)
                else
                    Clear(Kundenr);
            if Kundenr = '' then Error('Under fjernelse af foranstillede nuller forsvandt kundenummeret helt.'); /*2.50.02*/
        end;
        "kundenr. notation"::Fast: if "Kundenr. fast længde" > 0 then Kundenr:=CopyStr(Kundenr, (StrLen(Kundenr) - "Kundenr. fast længde") + 1)
            else
                Error('Feltet %1 i %2 skal være forskellig fra 0', FieldName("Kundenr. fast længde"), TableName);
        end; //Case
    end;
    procedure "Hent CVR-Nummer"()Resultat: Text[250]var
        StamOpl: Record "BS-Stamoplysninger";
        SourceLen: Integer;
        i: Integer;
    begin
        StamOpl.Get;
        if StamOpl."Specificeret CVR-Nr." = '' then begin
            Clear(Resultat);
            Firmaoplysninger.Get;
            SourceLen:=StrLen(Firmaoplysninger."VAT Registration No.");
            if SourceLen > MaxStrLen("Specificeret CVR-Nr.")then Error('Et gyldigt CVR-/Momsnummer består maksimalt af %1 cifre mellem 0 og 9\\' + /*2.50.02*/ 'Værdien i feltet %2 på tabellen %3 består af %4 tegn.', MaxStrLen("Specificeret CVR-Nr."), Firmaoplysninger.FieldName("VAT Registration No."), Firmaoplysninger.TableName, SourceLen);
            for i:=1 to SourceLen do if Firmaoplysninger."VAT Registration No."[i]in['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']then /*2.60.05*/ Resultat:=Resultat + Format(Firmaoplysninger."VAT Registration No."[i])end
        else
            Resultat:=StamOpl."Specificeret CVR-Nr.";
        while StrLen(Resultat) < MaxStrLen("Specificeret CVR-Nr.")do Resultat:='0' + Resultat;
        "Validér CVR-Nummer"(Resultat, false, false); /*BS2.60.03*/
    end;
    procedure "Validér CPR-/CVR-Nummer"(Nummer: Code[10]; "Query": Boolean; QueryMsg: Boolean)Valid: Boolean var
        "Vægt": Code[10];
        S: Integer;
        V: Integer;
        "Sum": Integer;
        I: Integer;
        Ok: Boolean;
        ErrText: Text[250];
    begin
        /*BS2.60.03*/
        Valid:=true;
        Clear(ErrText);
        case StrLen(Nummer)of 8: /*CVR-nummer*/ /*2.50.02*/ begin
            Vægt:='27654321';
            for I:=1 to 8 do begin
                Ok:=Evaluate(V, CopyStr(Vægt, I, 1));
                Ok:=Evaluate(S, CopyStr(Nummer, I, 1));
                Sum:=Sum + S * V;
            end;
            if Sum MOD 11 <> 0 then begin
                Valid:=false;
                ErrText:=StrSubstNo('"%1" er ikke et gyldigt CVR-nummer.', Nummer);
            end;
        end;
        10: /*CPR-nummer*/ if StrCheckSum(Nummer, '4327654321', 11) <> 0 then begin
                Valid:=false;
                ErrText:=StrSubstNo('"%1" er ikke et gyldigt CPR-nummer.', Nummer);
            end;
        else
        begin
            Valid:=false;
            ErrText:=StrSubstNo('"%1" (%2 tegn) er ikke et gyldigt nummer.\\' + 'Et CPR-nummer er 10 tegn langt.\' + 'Et CVR-nummer er 8 tegn langt.', Nummer, StrLen(Nummer));
        end;
        end;
        if not Valid then begin
            if Query then begin
                if QueryMsg then Message('%1', ErrText);
            end
            else
                Error('%1', ErrText);
        end;
    end;
    procedure "Validér CPR-Nummer"(Nummer: Code[10]; "Query": Boolean; QueryMsg: Boolean)Valid: Boolean var
        "Vægt": Code[10];
        S: Integer;
        V: Integer;
        "Sum": Integer;
        I: Integer;
        Ok: Boolean;
        ErrText: Text[250];
    begin
        /*BS2.60.03*/
        Valid:=true;
        Clear(ErrText);
        case StrLen(Nummer)of 10: /*CPR-nummer*/ if StrCheckSum(Nummer, '4327654321', 11) <> 0 then begin
                Valid:=false;
                ErrText:=StrSubstNo('"%1" er ikke et gyldigt CPR-nummer.', Nummer);
            end;
        else
        begin
            Valid:=false;
            ErrText:=StrSubstNo('"%1" (%2 tegn) er ikke et gyldigt CPR-nummer.\\' + 'Et CPR-nummer er 10 tegn langt.', Nummer, StrLen(Nummer));
        end;
        end;
        if not Valid then begin
            if Query then begin
                if QueryMsg then Message('%1', ErrText);
            end
            else
                Error('%1', ErrText);
        end;
    end;
    procedure "Validér CVR-Nummer"(Nummer: Code[10]; "Query": Boolean; QueryMsg: Boolean)Valid: Boolean var
        "Vægt": Code[10];
        S: Integer;
        V: Integer;
        "Sum": Integer;
        I: Integer;
        Ok: Boolean;
        ErrText: Text[250];
    begin
        /*BS2.60.03*/
        Valid:=true;
        Clear(ErrText);
        case StrLen(Nummer)of 8: /*CVR-nummer*/ /*2.50.02*/ begin
            Vægt:='27654321';
            for I:=1 to 8 do begin
                Ok:=Evaluate(V, CopyStr(Vægt, I, 1));
                Ok:=Evaluate(S, CopyStr(Nummer, I, 1));
                Sum:=Sum + S * V;
            end;
            if Sum MOD 11 <> 0 then begin
                Valid:=false;
                ErrText:=StrSubstNo('"%1" er ikke et gyldigt CVR-nummer.', Nummer);
            end;
        end;
        else
        begin
            Valid:=false;
            ErrText:=StrSubstNo('"%1" (%2 tegn) er ikke et gyldigt CVR-nummer.\\' + 'Et CVR-nummer er 8 tegn langt.', Nummer, StrLen(Nummer));
        end;
        end; //Case
        if not Valid then begin
            if Query then begin
                if QueryMsg then Message('%1', ErrText);
            end
            else
                Error('%1', ErrText);
        end;
    end;
    procedure "Dan filnavn"(): Text[12]var
        Tid: Time;
        "År": Integer;
        Dage: Integer;
        Timer: Integer;
        Minutter: Integer;
        Sekunder: Integer;
        Expr: Decimal;
        ExprTxt: Text[30];
    begin
        /*BS2.60.03A*/
        Tid:=Time;
        År:=Date2dmy(Today, 3) - 1970;
        //Dage := TODAY - CALCDATE('-LÅ',TODAY);
        Dage:=Today - CalcDate('<-CY>', Today);
        Evaluate(Timer, Format(Tid, 0, '<Hours24>'));
        Evaluate(Minutter, Format(Tid, 0, '<Minutes>'));
        Evaluate(Sekunder, Format(Tid, 0, '<Seconds>'));
        // Beregn antallet af 1/10 sekunder siden år 1. Januar 1970 kl. 00:00
        Expr:=År * 365;
        Expr:=(Expr + Dage) * 24;
        Expr:=(Expr + Timer) * 60;
        Expr:=(Expr + Minutter) * 60;
        Expr:=(Expr + Sekunder);
        ExprTxt:=Dec2Hex(Expr);
        // ----> Fyld ud med foranstillede nuller
        while StrLen(ExprTxt) < 8 do ExprTxt:='0' + ExprTxt;
        // ----> Returner et 8+3 filnavn ud fra de 11 tegn
        exit(CopyStr(ExprTxt, 1, 8) + '.BS');
    end;
    procedure Dec2Hex(Expr: Decimal): Text[30]var
        Hex: Text[30];
        Faktor: Decimal;
        "-- Gamle ----": Integer;
        Tid: Time;
        ExprTxt: Text[16];
        WorkTxt: Text[30];
        Pos: Decimal;
        UpperPower: Integer;
        "Tæller": Integer;
    begin
        Hex:='';
        while Expr > 0 do begin
            Faktor:=Expr MOD 16;
            Hex:=CopyStr('0123456789ABCDEF', Faktor + 1, 1) + Hex;
            Expr:=Expr DIV 16 end;
        exit(Hex);
    end;
    procedure "BetalingsService = BS-Total"(): Boolean begin
        Find('-');
        exit("BetalingsService type" = "betalingsservice type"::"BS-Total");
    end;
    procedure "Aktuelle Debitorgruppe"(): Integer begin
        Find('-');
        exit("Debitorgr. min. værdi");
    end;
}
