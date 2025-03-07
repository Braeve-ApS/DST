Report 51001 "BS Dan Ref. Opkrævninger"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No."=field("No.");

                // DataItemTableView = sorting(Open, Positive, "Customer No.", Field51001, "Posting Date") where(Open = const(true), Positive = const(true), Field51001 = const(Yes));
                column(ReportForNavId_1000000001;1000000001)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    /* todo if "Cust. Ledger Entry"."Tilh. BS-Opkrævning" <> '' then
                        if not AnfTilladGenopkrævning or (AnfUdvidetSikkerhed and ("Due Date" >= Today)) then
                            CurrReport.Skip;
                    */
                    if AnfSkæringsdato < "Posting Date" then CurrReport.Skip;
                    if AnfMedtag = Anfmedtag::"Kun forfaldne poster" then if AnfForfaldsdato < "Due Date" then CurrReport.Skip;
                    BetalingsAftale.Reset;
                    BetalingsAftale.LockTable;
                    /*  if not Opkrævningshoved.Get("Cust. Ledger Entry"."Tilh. BS-Opkrævning") then begin
                        BetalingsAftale.SetRange("Debitornr.", "Cust. Ledger Entry"."Customer No.");
                        if not BetalingsAftale.Find('-') then
                            Error(
                              'Der findes ingen Betalingsaftale på Debitor %1 !\\' +
                              'Fejlen opstår, fordi Debitorpost %2 på denne Debitor er markert til automatisk opkrævning.\\' +
                              'Kør evt. kørslen "Aftaleajourføring", der bl.a. opretter nye Betalingsaftaler.',
                              "Customer No.",
                              "Entry No.");
                    end else
                        BetalingsAftale.Get(Opkrævningshoved."Debitornr.", Opkrævningshoved."Debitorgr.");
                    */
                    IndsætRefLinie(BetalingsAftale, "Cust. Ledger Entry");
                end;
            }
            trigger OnAfterGetRecord()
            begin
            //  PBar.Update;
            end;
            trigger OnPostDataItem()
            begin
                //  PBar.Close;
                Message('%1 referenceopkrævninger blev oprettet', Oprettet);
            end;
            trigger OnPreDataItem()
            begin
                Opkrævningshoved.Reset;
                Opkrævningshoved.SetCurrentkey(Bogført, Opkrævningsstatus, "Debitorgr.", "Debitornr.");
                Opkrævningshoved.SetRange(Bogført, true);
                Opkrævningshoved.SetRange(Opkrævningsstatus, Opkrævningshoved.Opkrævningsstatus::Oprettes);
                if Opkrævningshoved.Find('=<>')then Error('Der kan ikke oprettes referenceopkrævninger, så længe der ligger uafsendte oprkævninger.');
                Opkrævningshoved.Reset;
                Stamoplysninger.Get;
                if AnfSkæringsdato = 0D then Error('Der skal angives en Skæringsdato');
                if AnfForfaldsdato = 0D then Error('Der skal angives en Forfaldsdato');
                if AnfOpkrævningsdato = 0D then Error('Der skal angives en Opkrævningsdato');
                Clear(Oprettet);
            //  PBar.Open('Danner referenceopkrævninger :', Count);
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                field("AnfTilladGenopkrævning"; AnfTilladGenopkrævning)
                {
                    ApplicationArea = Basic;
                    Caption = 'Tillad genopkrævning';
                    ToolTip = 'Angiv om tidligere BS-opkrævede poster må genopkræves. Kombinér evt. med feltet "Udvidet sikkerhed".';
                }
                field(AnfUdvidetSikkerhed; AnfUdvidetSikkerhed)
                {
                    ApplicationArea = Basic;
                    Caption = 'Udvidet sikkerhed';
                    ToolTip = 'Udvidet sikkerhed, forhindrer referenceopkrævning af ikke forfaldne åbne poster, der allerede er blevet BS-opkrævet';
                }
                field(AnfMedtag; AnfMedtag)
                {
                    ApplicationArea = Basic;
                    Caption = 'Hvilke poster ?';
                    ToolTip = 'Hvilke poster skal medtages ?';
                }
                field("AnfSkæringsdato"; AnfSkæringsdato)
                {
                    ApplicationArea = Basic;
                    Caption = 'Medtag posteringer til og med';
                    ToolTip = 'Debitorposter med bogføringsdato frem til denne dato medtages';
                }
                field(AnfForfaldsdato; AnfForfaldsdato)
                {
                    ApplicationArea = Basic;
                    Caption = 'Forfaldsdato';
                    ToolTip = 'Alle forfaldne poster frem til denne dato medtages';
                }
                field("AnfOpkrævningsdato"; AnfOpkrævningsdato)
                {
                    ApplicationArea = Basic;
                    Caption = 'Opkrævningsdato';
                    ToolTip = 'Den dato referenceopkrævningerne skal foretages hos BetalingsService. NB! Opkrævning af referenceopkrævninger bør ikke finde sted på samme dato som alm. opkrævninger !';
                }
                field(AnfAdviseringstype; AnfAdviseringstype)
                {
                    ApplicationArea = Basic;
                    Caption = 'Adviseringstype';
                    ToolTip = 'Her vælges hvorledes de enkelte opkrævninger skal specificeres (adviseres) på BS-Opkrævningen.';
                }
                field("AnfFællesadvisering"; AnfFællesadvisering)
                {
                    ApplicationArea = Basic;
                    Caption = 'Evt. Fællesadviseringstekst';
                    ToolTip = 'Hvis Adviseringstypen er "Som Specificeret", kan der her indtasten en fælles adviseringslinie, der vil blive anvendt på alle referenceopkrævninger.';
                }
                field(AnfLangAdvisering; AnfLangAdvisering)
                {
                    ApplicationArea = Basic;
                    Caption = 'Benyt lang advisering';
                    ToolTip = 'Ved lang advisering anvendes alle 60 mulige tegn. Ved advisering som specificeret, medtages en større del af bogføringsteksten. På henvisningsadviseringen medtags forfaldsdatoen.';
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    var Stamoplysninger: Record "BS-Stamoplysninger";
    "Opkrævningslinie": Record "BS-Opkrævningslinie";
    "Opkrævningshoved": Record "BS-Opkrævningshoved";
    BetalingsAftale: Record "BS-Betalingsaftale";
    // PBar: Codeunit "Om BetalingsService";
    AnfMedtag: Option "Kun forfaldne poster", "Både åbne og forfaldne";
    AnfAdviseringstype: Option "Henvisning til Dato og Bilagsnr", "Som specificeret", Posteringstekst;
    "AnfOpkrævningsdato": Date;
    "AnfSkæringsdato": Date;
    AnfForfaldsdato: Date;
    "AnfFællesadvisering": Text[24];
    Oprettet: Integer;
    AnfUdvidetSikkerhed: Boolean;
    "AnfTilladGenopkrævning": Boolean;
    ">> BS2.60.02LA <<": Integer;
    AnfLangAdvisering: Boolean;
    local procedure "IndsætNyOpkrævning"(BetalingsAftale: Record "BS-Betalingsaftale"; "NyOpkrævningsdato": Date): Code[9]var
        "NyOpkrævning": Record "BS-Opkrævningshoved";
        "NyOpkrævningslinie": Record "BS-Opkrævningslinie";
        LinieNr: Integer;
        BeskrivelsesHeader: array[4, 3]of Text[60];
    begin
        // Lokal procedure. Anvender globale variable !
        NyOpkrævning.Reset;
        NyOpkrævning.SetRange(Afsluttet, false);
        NyOpkrævning.SetRange("Debitornr.", BetalingsAftale."Debitornr.");
        NyOpkrævning.SetRange("Debitorgr.", BetalingsAftale."Debitorgr.");
        NyOpkrævning.SetRange(Opkrævningsdato, NyOpkrævningsdato);
        if not NyOpkrævning.Find('=<>')then begin
            NyOpkrævning.Reset;
            Clear(NyOpkrævning);
            Clear(Stamoplysninger);
            Stamoplysninger.Get;
            Stamoplysninger."Sidste Opkrævningsnr.":=IncStr(Stamoplysninger."Sidste Opkrævningsnr.");
            Stamoplysninger.Modify;
            NyOpkrævning."Opkrævningsnr.":=Stamoplysninger."Sidste Opkrævningsnr.";
            NyOpkrævning."Debitornr.":=BetalingsAftale."Debitornr.";
            NyOpkrævning."Debitorgr.":=BetalingsAftale."Debitorgr.";
            NyOpkrævning.Opkrævningsdato:=NyOpkrævningsdato;
            NyOpkrævning.Bogført:=true;
            NyOpkrævning.Referenceopkrævning:=true;
            NyOpkrævning.Insert;
            Clear(NyOpkrævningslinie);
            NyOpkrævningslinie."Opkrævningsnr.":=NyOpkrævning."Opkrævningsnr.";
            NyOpkrævningslinie."Debitornr.":=NyOpkrævning."Debitornr.";
            NyOpkrævningslinie.Art:=NyOpkrævningslinie.Art::Fællesoverskrift;
            LinieNr:=10000;
            case AnfAdviseringstype of Anfadviseringstype::"Henvisning til Dato og Bilagsnr": begin
                if AnfMedtag = Anfmedtag::"Kun forfaldne poster" then begin
                    NyOpkrævningslinie."Linienr.":=LinieNr;
                    NyOpkrævningslinie.Beskrivelse:='OPKRÆVNING AF FORFALDNE POSTER :';
                    NyOpkrævningslinie.Insert;
                    LinieNr:=LinieNr + 10000;
                    NyOpkrævningslinie."Linienr.":=LinieNr;
                    NyOpkrævningslinie.Beskrivelse:='';
                    NyOpkrævningslinie.Insert;
                    LinieNr:=LinieNr + 10000;
                end;
                if not AnfLangAdvisering then begin
                    NyOpkrævningslinie."Linienr.":=LinieNr;
                    NyOpkrævningslinie.Beskrivelse:=HentLinie(1, 1);
                    NyOpkrævningslinie.Insert;
                    LinieNr:=LinieNr + 10000;
                    NyOpkrævningslinie."Linienr.":=LinieNr;
                    NyOpkrævningslinie.Beskrivelse:=HentLinie(1, 2);
                    NyOpkrævningslinie.Insert;
                    LinieNr:=LinieNr + 10000;
                end
                else
                begin
                    NyOpkrævningslinie."Linienr.":=LinieNr;
                    NyOpkrævningslinie.Beskrivelse:=HentLinie(3, 1);
                    NyOpkrævningslinie.Insert;
                    LinieNr:=LinieNr + 10000;
                    NyOpkrævningslinie."Linienr.":=LinieNr;
                    NyOpkrævningslinie.Beskrivelse:=HentLinie(3, 2);
                    NyOpkrævningslinie.Insert;
                    LinieNr:=LinieNr + 10000;
                end;
            end;
            Anfadviseringstype::"Som specificeret", Anfadviseringstype::Posteringstekst: begin
                if not AnfLangAdvisering then begin
                    NyOpkrævningslinie."Linienr.":=LinieNr;
                    NyOpkrævningslinie.Beskrivelse:=HentLinie(2, 1);
                    NyOpkrævningslinie.Insert;
                    LinieNr:=LinieNr + 10000;
                    NyOpkrævningslinie."Linienr.":=LinieNr;
                    NyOpkrævningslinie.Beskrivelse:=HentLinie(2, 2);
                    NyOpkrævningslinie.Insert;
                    LinieNr:=LinieNr + 10000;
                end
                else
                begin
                    NyOpkrævningslinie."Linienr.":=LinieNr;
                    NyOpkrævningslinie.Beskrivelse:=HentLinie(4, 1);
                    NyOpkrævningslinie.Insert;
                    LinieNr:=LinieNr + 10000;
                    NyOpkrævningslinie."Linienr.":=LinieNr;
                    NyOpkrævningslinie.Beskrivelse:=HentLinie(4, 2);
                    NyOpkrævningslinie.Insert;
                    LinieNr:=LinieNr + 10000;
                end;
            end;
            else
                Error('Ukendt Adviseringstype "%1"', AnfAdviseringstype);
            end; //Case
            Oprettet:=Oprettet + 1;
        end;
        exit(NyOpkrævning."Opkrævningsnr.");
    end;
    local procedure "IndsætRefLinie"(KildeBetalingsaftale: Record "BS-Betalingsaftale"; KildeDebitorpost: Record "Cust. Ledger Entry")
    var
        OPKH: Record "BS-Opkrævningshoved";
        OPKL: Record "BS-Opkrævningslinie";
        LbNr: Integer;
        ">> BS2.60.02LA <<": Integer;
        Referencedato: Date;
        Forfaldsdato: Date;
        Beløbstekst: Text[17];
        OprBeløbstekst: Text[30];
        BilagsNrTekst: Text[15];
    begin
        // Lokal procedure. Anvender globale variable !
        OPKH.Get(IndsætNyOpkrævning(KildeBetalingsaftale, AnfOpkrævningsdato));
        OPKL.Reset;
        Clear(OPKL);
        OPKL.SetRange("Opkrævningsnr.", OPKH."Opkrævningsnr.");
        if OPKL.Find('+')then LbNr:=OPKL."Linienr." + 10000
        else
            LbNr:=10000;
        OPKL.Reset;
        Clear(OPKL);
        OPKL."Opkrævningsnr.":=OPKH."Opkrævningsnr.";
        OPKL."Linienr.":=LbNr;
        OPKL."Debitornr.":=KildeBetalingsaftale."Debitornr.";
        OPKL.Art:=OPKL.Art::Advisering;
        if not AnfLangAdvisering then begin
            //CITP VIN >>
            KildeDebitorpost.CalcFields(KildeDebitorpost."Remaining Amt. (LCY)");
            //CITP VIN <<
            Beløbstekst:=Format(KildeDebitorpost."Remaining Amt. (LCY)", 0, '<Sign><Integer Thousand><Decimals,3>');
            while StrLen(Beløbstekst) < 13 do Beløbstekst:=' ' + Beløbstekst;
            Referencedato:=KildeDebitorpost."Posting Date";
            case AnfAdviseringstype of Anfadviseringstype::"Henvisning til Dato og Bilagsnr": begin
                BilagsNrTekst:=KildeDebitorpost."Document No.";
                OPKL.Beskrivelse:=StrSubstNo(HentLinie(1, 3), Referencedato, BilagsNrTekst, Beløbstekst);
            end;
            Anfadviseringstype::"Som specificeret": OPKL.Beskrivelse:=StrSubstNo(HentLinie(2, 3), AnfFællesadvisering, Beløbstekst);
            Anfadviseringstype::Posteringstekst: OPKL.Beskrivelse:=StrSubstNo(HentLinie(2, 3), CopyStr(KildeDebitorpost.Description, 1, 24), Beløbstekst);
            else
                Error('Ukendt Adviseringstype "%1"', AnfAdviseringstype);
            end; //Case
        end
        else
        begin
            //CITP VIN >>
            KildeDebitorpost.CalcFields(KildeDebitorpost."Remaining Amt. (LCY)");
            //CITP VIN <<
            Beløbstekst:=Format(KildeDebitorpost."Remaining Amt. (LCY)", 0, '<Sign><Integer Thousand><Decimals,3>');
            while StrLen(Beløbstekst) < 13 do Beløbstekst:=' ' + Beløbstekst;
            Referencedato:=KildeDebitorpost."Posting Date";
            case AnfAdviseringstype of Anfadviseringstype::"Henvisning til Dato og Bilagsnr": begin
                BilagsNrTekst:=KildeDebitorpost."Document No.";
                Forfaldsdato:=KildeDebitorpost."Due Date";
                //CITP VIN >>
                KildeDebitorpost.CalcFields(KildeDebitorpost."Original Amt. (LCY)");
                //CITP VIN <<
                OprBeløbstekst:=Format(KildeDebitorpost."Original Amt. (LCY)", 0, '<Sign><Integer Thousand><Decimals,3>');
                OPKL.Beskrivelse:=StrSubstNo(HentLinie(3, 3), Referencedato, Forfaldsdato, BilagsNrTekst, OprBeløbstekst, Beløbstekst);
            end;
            Anfadviseringstype::"Som specificeret": OPKL.Beskrivelse:=StrSubstNo(HentLinie(4, 3), AnfFællesadvisering, Beløbstekst);
            Anfadviseringstype::Posteringstekst: OPKL.Beskrivelse:=StrSubstNo(HentLinie(2, 3), CopyStr(KildeDebitorpost.Description, 1, 47), Beløbstekst);
            else
                Error('Ukendt Adviseringstype "%1"', AnfAdviseringstype);
            end; //Case
        end;
        OPKL.Beløb:=KildeDebitorpost."Remaining Amt. (LCY)";
        OPKL."Ref. Debitorpost":="Cust. Ledger Entry"."Entry No.";
        OPKL.Insert;
    end;
    procedure HentLinie(Type: Integer; Offset: Integer): Text[60]begin
        case Type of 1: case Offset of 1: exit('DATO     FAKTURA             RESTBEL¥B');
            2: exit('--------------------------------------');
            3: exit('#1###### #2############# #3###########');
            end; //Case [12345678901234567890123456789012345678]
        2: case Offset of 1: exit('VEDR¥RENDE                       BEL¥B');
            2: exit('--------------------------------------');
            3: exit('#1###################### #2###########');
            end; //Case [12345678901234567890123456789012345678]
        3: case Offset of 1: exit('DATO     FORFALD  FAKTURA            OPR.BEL¥B     RESTBEL¥B');
            2: exit('------------------------------------------------------------');
            3: exit('#1###### #2###### #3############ #4############ #5##########');
            end; //Case [123456789012345678901234567890123456789012345678901234567890]
        4: case Offset of 1: exit('VEDR¥RENDE                                         RESTBEL¥B');
            2: exit('------------------------------------------------------------');
            3: exit('#1############################################# #2##########');
            end; //Case [123456789012345678901234567890123456789012345678901234567890]
        end; //Case
    end;
}
