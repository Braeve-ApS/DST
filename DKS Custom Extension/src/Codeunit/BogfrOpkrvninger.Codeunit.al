Codeunit 51030 "Bogfør Opkrævninger"
{
    // // BetalingsService -------------------------------------- >>
    // // ˆ Copyright 1997, 2001 Hands A/S
    // //
    // // DT/PG 28.02.05 >> : ændring vedrører at der nu kan benyttes vare og ikke kun finanskonti
    // 
    // // 19-07-06 CITP
    //   Modificeret så den virker med navision 4.00 sp2
    // 
    // COR/IMT 160413 : Check at alle betalingslinjer er sat til Bogført
    // COR/MIN 190614 : Pågrund af at der ved stop i kørslen bliver oprrettet dublet fakturarer til en opkrævning, skal det tjekkes
    //                  at hvis der er oprettet en faktura, så skal der ikke kunne oprettes en ny.
    // 
    // COR/001/141222/Jim : Force BS as Payment method
    Permissions = TableData "Cust. Ledger Entry"=rm;

    trigger OnRun()
    var
        "Opkrævningshoved": Record "BS-Opkrævningshoved";
        "Opkrævningshoved2": Record "BS-Opkrævningshoved";
        "Opkrævningslinie": Record "BS-Opkrævningslinie";
        "Nyt SalgsHoved": Record "Sales Header";
        "Salg-Bogfør": Codeunit "Sales-Post";
        "Opkrævningslinie2": Record "BS-Opkrævningslinie";
        "Opkrævningshoved3": Record "BS-Opkrævningshoved";
        "Opkrævningslinie3": Record "BS-Opkrævningslinie";
    begin
        if not Confirm('Bogfør alle opkrævninger og fremdatér aftalespecifikationerne ?', false)then exit;
        Opkrævningshoved.Reset;
        Opkrævningshoved.SetCurrentkey("Bogført");
        Opkrævningshoved.SetRange("Bogført", false);
        if Opkrævningshoved.Find('-')then repeat // Kontroller at dette ikke er en referenceopkrævning
 if Opkrævningshoved.Referenceopkrævning then Error('Der kan ikke manuelt oprettes/bogføres referenceopkrævninger !');
                // Kontroller at der ikke tidligere er opkrævet på denne Kunde/Gruppe/Dato/
                Opkrævningshoved2.Reset;
                Opkrævningshoved2.SetCurrentkey("Debitornr.", "Debitorgr.", Opkrævningsdato);
                Opkrævningshoved2.SetRange("Debitornr.", Opkrævningshoved."Debitornr.");
                Opkrævningshoved2.SetRange("Debitorgr.", Opkrævningshoved."Debitorgr.");
                Opkrævningshoved2.SetRange(Opkrævningsdato, Opkrævningshoved.Opkrævningsdato);
                if Opkrævningshoved2.Count <> 1 then if Opkrævningshoved2."Bogført" then Error('Der er tidligere bogført en opkrævning den %1 for Debitor %2 på Debitorgr. %3\\' + 'Jf. bogført Opkrævning %4.', Opkrævningshoved2.Opkrævningsdato, Opkrævningshoved2."Debitornr.", Opkrævningshoved2."Debitorgr.", Opkrævningshoved2."Opkrævningsnr.")
                    else
                        Error('Der ligger allerede en opkrævning den %1 for Debitor %2 på Debitorgr. %3\', 'Jf. Opkrævning %4.', Opkrævningshoved2.Opkrævningsdato, Opkrævningshoved2."Debitornr.", Opkrævningshoved2."Debitorgr.", Opkrævningshoved2."Opkrævningsnr.");
            until Opkrævningshoved.Next = 0;
        if Opkrævningshoved.Find('-')then repeat //>>COR/MIN 190614
 SIH.Reset;
                SIH.SetRange("Tilh. BS-Opkrævning", Opkrævningshoved."Opkrævningsnr.");
                if SIH.FindFirst then begin
                    Opkrævningshoved3:=Opkrævningshoved;
                    Opkrævningshoved3."Bogført":=true;
                    Opkrævningshoved3.Modify;
                    //tilhørende linjer
                    Opkrævningslinie3.Reset;
                    Opkrævningslinie3.SetRange("Opkrævningsnr.", Opkrævningshoved2."Opkrævningsnr.");
                    Opkrævningslinie3.SetRange("Bogført", false);
                    if Opkrævningslinie3.Find('-')then repeat Opkrævningslinie3."Bogført":=true;
                            Opkrævningslinie3.Modify;
                        until Opkrævningslinie3.Next = 0;
                end
                else
                begin
                    //<<COR/MIN 190614
                    Clear("Nyt SalgsHoved");
                    // Dan og bogfør Fakturapost/bilag
                    Opkrævningslinie.Reset;
                    Opkrævningslinie.SetRange("Opkrævningsnr.", Opkrævningshoved."Opkrævningsnr.");
                    if Opkrævningslinie.Find('-')then repeat if Opkrævningslinie."Bilagsnr." = '' then case Opkrævningshoved."Bogføringsmetode" of Opkrævningshoved."Bogføringsmetode"::Salgsfaktura: // =======================================================================
 begin
                                    case Opkrævningshoved.Bilagsmetode of Opkrævningshoved.Bilagsmetode::"Nyt bilag pr. advisering": begin
                                        if Opkrævningslinie.Art = Opkrævningslinie.Art::Advisering then begin
                                            "Dan SalgsfakturaHoved"(Opkrævningshoved, // OpkrævningsHoved
 Opkrævningslinie."Bogføringsdato", // Bogføringsdato
 Opkrævningslinie.Forfaldsdato, // Forfaldsdato
 Opkrævningslinie."Global Dimension 1 Code", // Afdelingskode
 Opkrævningslinie."Global Dimension 2 Code", // Projektkode
 Opkrævningslinie.Sælgerkode, // Sælgerkode
 true, // Opret Fællesoverskrift
 "Nyt SalgsHoved", // Nyt SalgsHoved
 Opkrævningslinie."Funktionskode (Dimension)", //COR
 Opkrævningslinie."Trading Partner (Dimension)", //COR
 Opkrævningslinie."Projekt Fase (Dimension)"); //COR
                                            "Dan SalgsfakturaLinie"("Nyt SalgsHoved", // Salgshoved
 Opkrævningshoved, // Opkrævningshoved
 Opkrævningslinie, // Opkrævningslinie
 Opkrævningslinie."Global Dimension 1 Code", // Afdelingskode
 Opkrævningslinie."Global Dimension 2 Code", // Projektkode
 false, // Medtag IKKE overskrift
 Opkrævningslinie."Funktionskode (Dimension)", //COR
 Opkrævningslinie."Trading Partner (Dimension)", //COR
 Opkrævningslinie."Projekt Fase (Dimension)"); //COR
                                            "Salg-Bogfør".Run("Nyt SalgsHoved");
                                            Opkrævningslinie."Bilagsnr.":="Nyt SalgsHoved"."Last Posting No.";
                                            Opkrævningslinie.Modify;
                                        end;
                                    end;
                                    Opkrævningshoved.Bilagsmetode::"Et bilag pr. opkrævning": begin
                                        if "Nyt SalgsHoved"."No." = '' then "Dan SalgsfakturaHoved"(Opkrævningshoved, // OpkrævningsHoved
 Opkrævningshoved."Bogføringsdato", // Bogføringsdato
 Opkrævningshoved.Forfaldsdato, // Forfaldsdato
 Opkrævningshoved."Global Dimension 1 Code", // Afdelingskode
 Opkrævningshoved."Global Dimension 2 Code", // Projektkode
 Opkrævningshoved.Sælgerkode, // Sælgerkode
 false, // Opret IKKE Fællesoverskrift
 "Nyt SalgsHoved", // Nyt SalgsHoved
 Opkrævningshoved."Funktionskode (Dimension)", //COR
 Opkrævningshoved."Trading Partner (Dimension)", //COR
 Opkrævningshoved."Projekt Fase (Dimension)"); //COR
                                        "Dan SalgsfakturaLinie"("Nyt SalgsHoved", // Salgshoved
 Opkrævningshoved, // Opkrævningshoved
 Opkrævningslinie, // Opkrævningslinie
 Opkrævningslinie."Global Dimension 1 Code", // Afdelingskode
 Opkrævningslinie."Global Dimension 2 Code", // Projektkode
 true, // Medtag overskrift
 Opkrævningslinie."Funktionskode (Dimension)", //COR
 Opkrævningslinie."Trading Partner (Dimension)", //COR
 Opkrævningslinie."Projekt Fase (Dimension)"); //COR
                                    // Hvis dette var opkrævningens sidste linie, bogføres der nu
                                    end;
                                    else
                                        Error('Ukendt %1 - ''%2''', Opkrævningshoved.FieldName(Bilagsmetode), Opkrævningshoved.Bilagsmetode);
                                    end; /*Case*/
                                    if Opkrævningslinie.Art = Opkrævningslinie.Art::Advisering then "Fremryk Specifikation"(Opkrævningshoved, Opkrævningslinie);
                                end;
                                Opkrævningshoved."bogføringsmetode"::Kassekladde: // ========================================================================
 begin
                                    if Opkrævningshoved.Bilagsmetode = Opkrævningshoved.Bilagsmetode::"Et bilag pr. opkrævning" then Error('Når "%1" er ''%2'' kan "%3" ikke være ''%4''', Opkrævningshoved.FieldName("Bogføringsmetode"), Opkrævningshoved."Bogføringsmetode", Opkrævningshoved.FieldName(Bilagsmetode), Opkrævningshoved.Bilagsmetode);
                                    "Bogfør via Kassekladdelinie"(Opkrævningslinie);
                                end;
                                else
                                    Error('Ukendt Bogføringstype "%1"', Opkrævningshoved."Bogføringsmetode");
                                end; //Case
                        until Opkrævningslinie.Next = 0;
                    // Forsinket bogføring ved Salgsfakturabogføring med flere opkrævningslinier
                    if(Opkrævningshoved.Bilagsmetode = Opkrævningshoved.Bilagsmetode::"Et bilag pr. opkrævning") and (Opkrævningshoved."Bogføringsmetode" = Opkrævningshoved."bogføringsmetode"::Salgsfaktura)then begin
                        "Salg-Bogfør".Run("Nyt SalgsHoved");
                        Opkrævningslinie.Reset;
                        Opkrævningslinie.SetRange("Opkrævningsnr.", Opkrævningshoved."Opkrævningsnr.");
                        Opkrævningslinie.SetRange(Art, Opkrævningslinie.Art::Advisering);
                        Opkrævningslinie.ModifyAll("Bilagsnr.", "Nyt SalgsHoved"."Last Posting No.");
                    end;
                    Opkrævningshoved."Bogført":=true;
                    Opkrævningshoved.Modify;
                    //>>COR/IMT 160413 Check at alle betalingslinjer er sat til Bogført
                    Opkrævningslinie2.Reset;
                    Opkrævningslinie2.SetRange("Opkrævningsnr.", Opkrævningshoved."Opkrævningsnr.");
                    Opkrævningslinie2.SetRange("Bogført", false);
                    if Opkrævningslinie2.Find('-')then repeat Opkrævningslinie2."Bogført":=true;
                            Opkrævningslinie2.Modify;
                        until Opkrævningslinie2.Next = 0;
                //<<COR/IMT 160413
                //>>COR/MIN 190614
                end;
            //<<COR/MIN 190614
            until not Opkrævningshoved.Find('-');
        Commit; /*BS2.50.03*/
    //Codeunit.Run(Codeunit::"Udlæs 0601 Opkrævninger");
    end;
    var SIH: Record "Sales Invoice Header";
    procedure "Bogfør via Kassekladdelinie"(var Linie: Record "BS-Opkrævningslinie")Fakturatekst: Text[80]var
        Hoved: Record "BS-Opkrævningshoved";
        BSAftale: Record "BS-Betalingsaftale";
        "Regnskabsopsætning": Record "General Ledger Setup";
        Debitor: Record Customer;
        "DebitorBogf.Gr": Record "Customer Posting Group";
        "Årsagsspor": Record "Reason Code";
        FK: Record "G/L Account";
        KL: Record "Gen. Journal Line";
        KL2: Record "Gen. Journal Line";
        Debitorpost: Record "Cust. Ledger Entry";
        "Salgsopsætning": Record "Sales & Receivables Setup";
        NrSerieStyring: Codeunit "No. Series";
        "FinKld-Bogfør linie": Codeunit "Gen. Jnl.-Post Line";
        LbNr: Integer;
    begin
        Hoved.Get(Linie."Opkrævningsnr.");
        Hoved.TestField("Bogført", false);
        Hoved.TestField("Debitornr.");
        Hoved.TestField("Debitorgr.");
        Hoved.TestField(Opkrævningsdato);
        Linie.TestField("Bogføringsdato");
        Linie.TestField("Bilagsnr.", '');
        if Linie."Beløb" = 0 then Error('Opkrævning "%1", linie %2 indeholder ingen værdi !', Linie."Opkrævningsnr.", Linie."Linienr.");
        BSAftale.Get(Hoved."Debitornr.", Hoved."Debitorgr.");
        BSAftale.CalcFields(Aktiv);
        if not BSAftale.Aktiv then Error('Debitor %1 har ikke en aktiv BetalingsService.', Linie."Opkrævningsnr.");
        // ---------------- Debitorpost ---------------------------
        KL.Reset;
        Clear(KL);
        KL.Validate("Account Type", KL."account type"::Customer);
        KL.Validate("Account No.", Hoved."Debitornr.");
        KL.Validate("Document Type", KL."document type"::Invoice);
        KL.Validate("Posting Date", Linie."Bogføringsdato");
        KL.Validate("Document Date", Linie."Bogføringsdato");
        Salgsopsætning.Get;
        Salgsopsætning.TestField("Invoice Nos.");
        KL.Validate("Document No.", NrSerieStyring.GetNextNo(Salgsopsætning."Invoice Nos.", KL."Posting Date", true));
        KL.Validate(Description, StrSubstNo('BS-Opkrævning %1', Hoved."Opkrævningsnr."));
        KL.Validate("Shortcut Dimension 1 Code", Linie."Global Dimension 1 Code");
        KL.Validate("Shortcut Dimension 2 Code", Linie."Global Dimension 2 Code");
        KL.Validate("Salespers./Purch. Code", Linie.Sælgerkode);
        KL.Validate("System-Created Entry", true);
        if not Årsagsspor.Get('BS')then begin
            Årsagsspor.Init;
            Årsagsspor.Code:='BS';
            Årsagsspor.Description:='BetalingsService';
            Årsagsspor.Insert;
        end;
        KL.Validate("Reason Code", 'BS');
        KL.Validate(Amount, Linie."Beløb");
        Linie.TestField("Tilh. Finanskonto/Vare");
        FK.Get(Linie."Tilh. Finanskonto/Vare");
        KL.Validate("Bal. Account No.", Linie."Tilh. Finanskonto/Vare");
        KL.Validate("Bal. Gen. Posting Type", FK."Gen. Posting Type");
        // KL.Validate("Tillad aut. BS-Opkrævning", true);
        // KL.Validate("Tilhørende BS-Opkrævning", Linie."Opkrævningsnr.");
        KL.Validate("Due Date", Hoved.Opkrævningsdato); // Denne linie altid til sidst !
        "Fremryk Specifikation"(Hoved, Linie);
        Linie."Bilagsnr.":=KL."Document No.";
        Linie.Modify;
        Fakturatekst:=StrSubstNo('%1 %2', KL."Document Type", KL."Document No.");
        "FinKld-Bogfør linie".Run(KL);
    end;
    procedure "Dan SalgsfakturaHoved"("OpkrævningsHoved": Record "BS-Opkrævningshoved"; "Bogføringsdato": Date; Forfaldsdato: Date; Afdelingskode: Code[10]; Projektkode: Code[10]; "Sælgerkode": Code[10]; "Opret Fællesoverskrift": Boolean; var "Nyt SalgsHoved": Record "Sales Header"; FunktionsKode_par: Code[20]; TradingpartnerKode_par: Code[20]; ProjektFaseKode_par: Code[20])Fakturatekst: Text[80]var
        SH: Record "Sales Header";
        "Salgsopsætning": Record "Sales & Receivables Setup";
        BSAftale: Record "BS-Betalingsaftale";
        AdvOpkrLinie: Record "BS-Opkrævningslinie";
        "Årsagsspor": Record "Reason Code";
        NrSerieStyring: Codeunit NoSeriesManagement;
        AdvLinieFundet: Boolean;
        OriginalDueDate: Date;
    begin
        OpkrævningsHoved.TestField("Bogført", false);
        OpkrævningsHoved.TestField("Debitornr.");
        OpkrævningsHoved.TestField("Debitorgr.");
        OpkrævningsHoved.TestField(Opkrævningsdato);
        BSAftale.Get(OpkrævningsHoved."Debitornr.", OpkrævningsHoved."Debitorgr.");
        BSAftale.CalcFields(Aktiv);
        BSAftale.TestField(Aktiv);
        SH.Reset;
        SH.Init;
        SH.Validate("Document Type", SH."document type"::Invoice);
        Salgsopsætning.Get;
        Salgsopsætning.TestField("Invoice Nos.");
        SH."No.":=NrSerieStyring.GetNextNo(Salgsopsætning."Invoice Nos.", "Bogføringsdato", true);
        if(SH."No. Series" <> '') and (Salgsopsætning."Invoice Nos." = Salgsopsætning."Posted Invoice Nos.")then SH."Posting No. Series":=SH."No. Series"
        else
            NrSerieStyring.SetDefaultSeries(SH."Posting No. Series", Salgsopsætning."Posted Invoice Nos.");
        if Salgsopsætning."Shipment on Invoice" then NrSerieStyring.SetDefaultSeries(SH."Shipping No. Series", Salgsopsætning."Posted Shipment Nos.");
        SH.Validate("Sell-to Customer No.", OpkrævningsHoved."Debitornr.");
        SH.Validate("Posting Date", "Bogføringsdato");
        SH.Validate("Document Date", "Bogføringsdato");
        if Forfaldsdato <> 0D then SH.Validate("Due Date", Forfaldsdato)
        else
            SH.Validate("Due Date", OpkrævningsHoved.Opkrævningsdato);
        SH.Validate("Posting Description", StrSubstNo('BS-Opkrævning %1', OpkrævningsHoved."Opkrævningsnr."));
        //SH.VALIDATE("Shortcut Dimension 1 Code",Afdelingskode);
        //SH.VALIDATE("Shortcut Dimension 2 Code",Projektkode);
        SH.Validate("Salesperson Code", Sælgerkode);
        if not Årsagsspor.Get('BS')then begin
            Årsagsspor.Init;
            Årsagsspor.Code:='BS';
            Årsagsspor.Description:='BetalingsService';
            Årsagsspor.Insert;
        end;
        SH.Validate("Reason Code", 'BS');
        SH."Tilh. BS-Opkrævning":=OpkrævningsHoved."Opkrævningsnr.";
        //DST001
        Clear(SH."OIOUBL-GLN");
        //DST001
        //COR/001>>
        OriginalDueDate:=SH."Due Date";
        SH.Validate(SH."Payment Method Code", 'BS1');
        if SH."CCM Collection Method" = '' then Error('Der findes ingen aktiv opkrævningsaftale, på debitor %1', SH."Bill-to Customer No.");
        SH.Validate(SH."Due Date", OriginalDueDate);
        // SH.Validate("CCM Collection Method", );
        //COR/001<<
        SH.Insert;
        // CITP 190706 ->
        SH.Validate("Shortcut Dimension 1 Code", Afdelingskode);
        SH.Validate("Shortcut Dimension 2 Code", Projektkode);
        //COR
        if FunktionsKode_par <> '' then SH.ValidateShortcutDimCode(3, FunktionsKode_par);
        if TradingpartnerKode_par <> '' then SH.ValidateShortcutDimCode(4, TradingpartnerKode_par);
        if ProjektFaseKode_par <> '' then SH.ValidateShortcutDimCode(5, ProjektFaseKode_par);
        //<-
        SH.Modify;
        // <- CITP 190706
        // Returvariable
        "Nyt SalgsHoved":=SH;
        Fakturatekst:=StrSubstNo('%1 %2', SH."Document Type", SH."No.");
        // Opret Fællesbemærkninger
        // ========================
        // Når der bogføres en faktura pr. opkrævningslinie gentages her en evt. fællesbemærkning
        // Kun Fællesbemærkningslinier der ligger før den første adviseringslinie medtages.
        if "Opret Fællesoverskrift" then begin
            AdvOpkrLinie.Reset;
            AdvOpkrLinie.SetRange("Opkrævningsnr.", OpkrævningsHoved."Opkrævningsnr.");
            if AdvOpkrLinie.Find('-')then begin
                AdvLinieFundet:=false;
                while not AdvLinieFundet do begin
                    case AdvOpkrLinie.Art of AdvOpkrLinie.Art::Advisering: AdvLinieFundet:=true;
                    AdvOpkrLinie.Art::Fællesoverskrift: "Dan SalgsfakturaLinie"("Nyt SalgsHoved", OpkrævningsHoved, AdvOpkrLinie, '', // Afdelingskode
 '', // Projektkode
 true, // Medtag overskrift
 '', //COR
 '', //COR
 ''); //COR
                    AdvOpkrLinie.Art::"Intern bemærkning", AdvOpkrLinie.Art::Bemærkning: /*BS2.50.03*/ ; // Bemærkningslinier ignoreres her {BS2.50.03}
                    else
                        Error('Ukendt %1 ''%2''', AdvOpkrLinie.FieldName(Art), AdvOpkrLinie.Art);
                    end; /*Case*/
                    if not AdvOpkrLinie.Find('>')then AdvLinieFundet:=true;
                end; /*While*/
            end;
        end;
    end;
    procedure "Dan SalgsfakturaLinie"(SalgsHoved: Record "Sales Header"; "Opkrævningshoved": Record "BS-Opkrævningshoved"; "Opkrævningslinie": Record "BS-Opkrævningslinie"; Afdelingskode: Code[10]; Projektkode: Code[10]; "Medtag overskrift": Boolean; FunktionsKode_par: Code[20]; TradingpartnerKode_par: Code[20]; ProjektFaseKode_par: Code[20])
    var
        SL: Record "Sales Line";
        Specifikation: Record "BS-Specifikation";
        LbNr: Integer;
    begin
        SL.Reset;
        SL.SetRange("Document Type", SalgsHoved."Document Type");
        SL.SetRange("Document No.", SalgsHoved."No.");
        if SL.Find('+')then LbNr:=SL."Line No." + 10000
        else
            LbNr:=10000;
        // Generel opsætning af Salgslinien
        SL.Reset;
        Clear(SL);
        SL.Validate("Document Type", SalgsHoved."Document Type");
        SL.Validate("Document No.", SalgsHoved."No.");
        SL.Validate("Line No.", LbNr);
        SL.Validate("Sell-to Customer No.", SalgsHoved."Sell-to Customer No.");
        case Opkrævningslinie.Art of Opkrævningslinie.Art::Fællesoverskrift: begin
            if "Medtag overskrift" then begin
                SL.Validate(Type, SL.Type::" ");
                SL.Validate(Description, Truncate(Opkrævningslinie.Beskrivelse, MaxStrLen(SL.Description)));
                SL.Insert;
            end;
        end;
        Opkrævningslinie.Art::Advisering: begin
            if Opkrævningslinie."Beløb" = 0 then Error('Opkrævning "%1", linie %2 indeholder ingen værdi !', Opkrævningslinie."Opkrævningsnr.", Opkrævningslinie."Linienr.");
            Opkrævningslinie.TestField("Tilh. Finanskonto/Vare");
            // DT/PG 28.02.05 >>
            if Opkrævningslinie."Tilhøre type" = Opkrævningslinie."tilhøre type"::Vare then begin
                SL.Validate(Type, SL.Type::Item);
                SL.Validate("No.", Opkrævningslinie."Tilh. Finanskonto/Vare");
                SL.Validate(Quantity, 1);
                SL.Validate("Unit Price", Opkrævningslinie."Tilhøre beløb excl moms");
                SL.Validate("Amount Including VAT", Opkrævningslinie."Tilhøre beløb incl. moms");
            end
            else
            begin
                // DT/PG 28.02.05 <<
                SL.Validate(Type, SL.Type::"G/L Account");
                SL.Validate("No.", Opkrævningslinie."Tilh. Finanskonto/Vare");
                SL.Validate(Quantity, 1);
            end;
            SL.Validate(Description, Truncate(Opkrævningslinie.Beskrivelse, MaxStrLen(SL.Description)));
            //Flyttet
            //SL.VALIDATE("Shortcut Dimension 1 Code",Afdelingskode);
            //SL.VALIDATE("Shortcut Dimension 2 Code",Projektkode);
            SL.Validate("Unit Price", Opkrævningslinie."Beløb");
            SL.Insert;
            // CITP 190706 ->
            SL.Validate("Shortcut Dimension 1 Code", Afdelingskode);
            SL.Validate("Shortcut Dimension 2 Code", Projektkode);
            //COR
            if FunktionsKode_par <> '' then SL.ValidateShortcutDimCode(3, FunktionsKode_par);
            if TradingpartnerKode_par <> '' then SL.ValidateShortcutDimCode(4, TradingpartnerKode_par);
            if ProjektFaseKode_par <> '' then SL.ValidateShortcutDimCode(5, ProjektFaseKode_par);
            //<-
            SL.Modify;
        // <- CITP 190706
        end;
        Opkrævningslinie.Art::"Intern bemærkning": ; // Ignoreres her
        Opkrævningslinie.Art::Bemærkning: /*BS2.50.03 -->*/ begin
            SL.Validate(Type, SL.Type::" ");
            SL.Validate(Description, Truncate(Opkrævningslinie.Beskrivelse, MaxStrLen(SL.Description)));
            SL.Insert;
        end; /*<-- BS2.50.03*/
        else
            Error('Ukendt %1 ''%2''', Opkrævningslinie.FieldName(Art), Opkrævningslinie.Art);
        end; /*Case*/
    end;
    procedure "Fremryk Specifikation"("Opkrævningshoved": Record "BS-Opkrævningshoved"; "Opkrævningslinie": Record "BS-Opkrævningslinie")
    var
        Specifikation: Record "BS-Specifikation";
    begin
        if(Opkrævningslinie."Evt. Specifikationskode" <> '')then if Opkrævningslinie."Evt. Fremrykkelsesdato" <> 0D then begin
                Specifikation.Get(Opkrævningshoved."Debitornr.", Opkrævningshoved."Debitorgr.", Opkrævningslinie."Evt. Specifikationskode");
                if Specifikation."Næste opkrævning" <> Opkrævningslinie."Evt. Fremrykkelsesdato" then begin
                    Specifikation."Næste opkrævning":=Opkrævningslinie."Evt. Fremrykkelsesdato";
                    Specifikation.Modify;
                end;
            end;
    end;
    local procedure "-- Local --"()
    begin
    end;
    local procedure Truncate(Expression: Text[250]; MaxLen: Integer): Text[250]begin
        /*BS2.60.03*/
        if StrLen(Expression) > MaxLen then exit(CopyStr(Expression, 1, MaxLen - 2) + '..')
        else
            exit(Expression);
    end;
}
