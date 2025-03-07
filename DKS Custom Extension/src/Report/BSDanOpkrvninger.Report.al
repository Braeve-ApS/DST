Report 51000 "BS Dan Opkrævninger"
{
    // // BetalingsService -------------------------------------- >>
    // 
    // BS2.50.04 - Div. adviseringsrelaterede felter initialiseres nu kun på adviseringslinier.
    // //
    // // DT/PG 28.02.05 >> : ændring vedrører at der nu kan benyttes vare og ikke kun finanskonti
    // 
    // //19-07-06 CITP
    //   Modificeret så den fungere med navision 4.00 Sp2
    //   Finder bla. Beløb inkl moms hvis nogen
    // COR/IMT 230513 : Tilføje at alle Debitor der starter med "53" b liver incl. moms.
    // COR/MIN 091013 : Genaktiveret afdelingskode og aktivitetskode, så de bliver dannet som før. Samt tilføje funktion og trading partner
    //                  på linjerne
    // COr/MIN 301013 : tage hensyn til at der er valgt inkl. moms på debitor
    // COR/MIN 070113-1 : hvis det ikke er en vare, så skal Tilhøre Beløb inkl og eksl. moms beregnes alligevel
    // COR/MIN 070113-2 : skal ikke ændre deb's spec.tekst til oprindelig værdi hvis der er forskel
    // COR/MIN 070113-3 : skal tage Beløb fra spec.tekst
    // COR/MIN 070113-4 : skal tage Beløb fra spec.tekst
    // COR/MIN 040214   : hvis det er vare så skal dimensioner tages fra varekort
    // COR/MIN 190115   : afrunde så Beløb gange 1,25 ikke bliver med for mange cifre
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            RequestFilterFields = "No.", "Customer Posting Group", "Salesperson Code", Blocked;

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            dataitem("BS-Betalingsaftale"; "BS-Betalingsaftale")
            {
                DataItemLink = "Debitornr."=field("No.");
                DataItemTableView = sorting("Debitornr.", "Debitorgr.");
                RequestFilterFields = "Debitorgr.";

                column(ReportForNavId_1000000001;1000000001)
                {
                }
                trigger OnAfterGetRecord()
                var
                    lSalgshoved: Record "Sales Header";
                    lSalgslinie: Record "Sales Line";
                    //lBSform: Page "BS Specifikationstekst";
                    "//CITPMAK": Integer;
                    ItemRec: Record Item;
                    SalesPost: Codeunit "Sales-Post";
                    TempSalesLine: Record "Sales Line";
                    TotalSalesLineLCY: Record "Sales Line";
                    VATAmount: Decimal;
                    VATAmountText: Text[30];
                    ProfitLCY: Decimal;
                    ProfitPct: Decimal;
                    TotalAdjCostLCY: Decimal;
                    TotalAmount2: Decimal;
                    TotalAmount1: Decimal;
                    TotalSalesLine: Record "Sales Line";
                begin
                    /* CalcFields(Aktiv);
                    if not Aktiv then
                        CurrReport.Skip;
                    */
                    Spec.Reset;
                    Spec.SetRange("Debitornr.", "Debitornr.");
                    Spec.SetRange("Debitorgr.", "Debitorgr.");
                    Spec.SetFilter("Næste opkrævning", '..%1', Skæringsdato);
                    if Spec.Find('-')then repeat // Test for udfyldt Beløb
 if Spec."Validér Aftale"(Spec) = 0 then if Spec.Fællesskabelon <> '' then Error('Standard Specifikation %1 :\\' + 'Der skal angives en opkrævningsværdi.', Spec.Fællesskabelon)
                                else
                                    Error('Specifikation %1 på Betalingsaftale %2 (%3) :\\' + 'Der skal angives en opkrævningsværdi.', Spec.Kode, Spec."Debitornr.", Spec."Debitorgr.");
                            /*BS2.60.02LA >>*/
                            LangAdvisering:=Spec."Lang Advisering"(Spec);
                            /*<< BS2.60.02LA*/
                            // Dan ny opkrævning (eller hent aktuelle ved sammenføjning)
                            Opkrævningshoved.Reset;
                            Opkrævningshoved.LockTable;
                            if Dublet(Spec."Debitornr.", Spec."Debitorgr.", "Opkræves d.", DubletNr)then begin
                                IndsætFællesOverskrift:=false;
                                Opkrævningshoved.Get(DubletNr);
                                if Opkrævningshoved.Bogført OR ("Overlappende Betalinger" = "overlappende betalinger"::Afvis)THEN Error('Specifikation %1 på Betalingsaftale %2 (%3) : \\Der er allerede opkrævet på denne aftale den %4 !', Spec.Kode, Spec."Debitornr.", Spec."Debitorgr.", "Opkræves d.")
                                else
                                begin // Find den aktuelle opkrævning
                                    "Cnt-Sammenføjninger":="Cnt-Sammenføjninger" + 1;
                                    // Indsæt separator mellem sammenføjningerne
                                    Opkrævningslinie.Reset;
                                    Opkrævningslinie.SetRange("Opkrævningsnr.", Opkrævningshoved."Opkrævningsnr.");
                                    if Opkrævningslinie.Find('+')then begin
                                        LbNr:=Opkrævningslinie."Linienr." + 10000;
                                        if "Indsæt Separator" then begin
                                            Opkrævningslinie.Init;
                                            Opkrævningslinie."Opkrævningsnr.":=Opkrævningshoved."Opkrævningsnr.";
                                            Opkrævningslinie."Linienr.":=LbNr;
                                            Opkrævningslinie.Art:=Opkrævningslinie.Art::Bemærkning;
                                            /*BS2.60.02LA >>*/
                                            if LangAdvisering then Opkrævningslinie.Beskrivelse:='------------------------------------------------------------'
                                            else
                                                /*<< BS2.60.02LA*/
                                                Opkrævningslinie.Beskrivelse:='--------------------------------------';
                                            Opkrævningslinie.Insert;
                                            LbNr:=LbNr + 10000;
                                        end;
                                    end
                                    else
                                        LbNr:=10000;
                                end;
                            end
                            else
                            begin // Dan ny opkrævning
                                "Cnt-Opkrævninger":="Cnt-Opkrævninger" + 1;
                                IndsætFællesOverskrift:=true;
                                Stamoplysninger."Sidste Opkrævningsnr.":=IncStr(Stamoplysninger."Sidste Opkrævningsnr.");
                                Stamoplysninger.Modify;
                                Opkrævningshoved.Init;
                                Opkrævningshoved."Opkrævningsnr.":=Stamoplysninger."Sidste Opkrævningsnr.";
                                Opkrævningshoved."Debitornr.":="Debitornr.";
                                Opkrævningshoved."Debitorgr.":="Debitorgr.";
                                Opkrævningshoved.Opkrævningsdato:="Opkræves d.";
                                Opkrævningshoved.Bogføringsdato:=Bogføringsdato;
                                Opkrævningshoved.Bogføringsmetode:=Stamoplysninger.Bogføringsmetode;
                                Opkrævningshoved.Bilagsmetode:=Stamoplysninger.Bilagsmetode;
                                //Dimensioner (COR)
                                GLSetup.Get;
                                //Afdeling
                                if "BS-Betalingsaftale"."Global Dimension 1 Code" <> '' then Opkrævningshoved."Global Dimension 1 Code":="BS-Betalingsaftale"."Global Dimension 1 Code"
                                else
                                begin
                                    if DefaultDimension.Get(18, "BS-Betalingsaftale"."Debitornr.", GLSetup."Global Dimension 1 Code")then Opkrævningshoved."Global Dimension 1 Code":=DefaultDimension."Dimension Value Code";
                                end;
                                //Aktivitet
                                if "BS-Betalingsaftale"."Global Dimension 2 Code" <> '' then Opkrævningshoved."Global Dimension 2 Code":="BS-Betalingsaftale"."Global Dimension 2 Code"
                                else
                                begin
                                    if DefaultDimension.Get(18, "BS-Betalingsaftale"."Debitornr.", GLSetup."Global Dimension 2 Code")then Opkrævningshoved."Global Dimension 2 Code":=DefaultDimension."Dimension Value Code";
                                end;
                                //Funktion
                                if "BS-Betalingsaftale"."Funktionskode (Dimension)" <> '' then Opkrævningshoved."Funktionskode (Dimension)":="BS-Betalingsaftale"."Funktionskode (Dimension)"
                                else
                                begin
                                    if DefaultDimension.Get(18, "BS-Betalingsaftale"."Debitornr.", GLSetup."Shortcut Dimension 3 Code")then Opkrævningshoved."Funktionskode (Dimension)":=DefaultDimension."Dimension Value Code";
                                end;
                                //Trading Partner
                                if "BS-Betalingsaftale"."Trading Partner (Dimension)" <> '' then Opkrævningshoved."Trading Partner (Dimension)":="BS-Betalingsaftale"."Trading Partner (Dimension)"
                                else
                                begin
                                    if DefaultDimension.Get(18, "BS-Betalingsaftale"."Debitornr.", GLSetup."Shortcut Dimension 4 Code")then Opkrævningshoved."Trading Partner (Dimension)":=DefaultDimension."Dimension Value Code";
                                end;
                                //Projekt fase
                                if "BS-Betalingsaftale"."Projekt Fase (Dimension)" <> '' then Opkrævningshoved."Projekt Fase (Dimension)":="BS-Betalingsaftale"."Projekt Fase (Dimension)"
                                else
                                begin
                                    if DefaultDimension.Get(18, "BS-Betalingsaftale"."Debitornr.", GLSetup."Shortcut Dimension 5 Code")then Opkrævningshoved."Projekt Fase (Dimension)":=DefaultDimension."Dimension Value Code";
                                end;
                                //<- COR
                                Opkrævningshoved.Insert;
                                LbNr:=10000;
                            end;
                            SpecTekst.Reset;
                            if Spec.Fællesskabelon <> '' then begin
                                SpecTekst.SetFilter("Debitornr.", '');
                                SpecTekst.SetRange("Debitorgr.", 0);
                                SpecTekst.SetRange(Specifikationskode, Spec.Fællesskabelon);
                            end
                            else
                            begin
                                SpecTekst.SetRange("Debitornr.", Spec."Debitornr.");
                                SpecTekst.SetRange("Debitorgr.", Spec."Debitorgr.");
                                SpecTekst.SetRange(Specifikationskode, Spec.Kode);
                            end;
                            if SpecTekst.Find('-')then repeat if(IndsætFællesOverskrift and (SpecTekst.Art = SpecTekst.Art::Fællesoverskrift)) or (SpecTekst.Art <> SpecTekst.Art::Fællesoverskrift)then begin
                                        Opkrævningslinie.Reset;
                                        Opkrævningslinie.Init;
                                        Opkrævningslinie."Opkrævningsnr.":=Opkrævningshoved."Opkrævningsnr.";
                                        Opkrævningslinie."Debitornr.":=Opkrævningshoved."Debitornr.";
                                        Opkrævningslinie."Evt. Specifikationskode":=Spec.Kode;
                                        Opkrævningslinie."Evt. Fremrykkelsesdato":=CalcDate(Spec.Opkrævningsinterval, Spec."Næste opkrævning");
                                        Opkrævningslinie."Linienr.":=LbNr;
                                        Opkrævningslinie.Art:=SpecTekst.Art;
                                        Opkrævningslinie.Sats:=SpecTekst.Sats;
                                        Opkrævningslinie.Beskrivelse:=SpecTekst."Beskrivelse Formateret";
                                        if SpecTekst.Beløb <> 0 THEN SpecTekst.TestField("Tilh. Finanskonto/Vare");
                                        if SpecTekst.Art = SpecTekst.Art::Advisering then begin
                                            // <DIA> TKR/CITP/20040406
                                            // Udelad adviseringslinier med 0-Beløb
                                            // DT/PG 28.02.05 >>
                                            if SpecTekst."Tilhøre type" = SpecTekst."Tilhøre type"::Vare then begin
                                                // Korrekt Beløb + moms
                                                lSalgshoved.Init;
                                                lSalgshoved."Document Type":=lSalgslinie."document type"::Invoice;
                                                lSalgshoved.Validate("Sell-to Customer No.", Customer."No.");
                                                lSalgshoved."Posting Date":=Bogføringsdato;
                                                lSalgshoved."No.":='XXXXX';
                                                lSalgshoved.Validate("Prices Including VAT", true);
                                                lSalgshoved.Insert(true);
                                                lSalgslinie.Init;
                                                lSalgslinie.Validate("Document Type", lSalgslinie."document type"::Invoice);
                                                lSalgslinie.Validate("Document No.", lSalgshoved."No.");
                                                lSalgslinie.Validate(Type, lSalgslinie.Type::Item);
                                                lSalgslinie.Validate("No.", SpecTekst."Tilh. Finanskonto/Vare");
                                                lSalgslinie.Validate(Quantity, 1);
                                                lSalgslinie."Line No.":=lSalgslinie."Line No." + 10000;
                                                lSalgslinie.Insert(true);
                                                // 19-07-06 CITP -->
                                                //SalesPost.GetSalesLines(lSalgshoved,TempSalesLine,0);
                                                Clear(SalesPost);
                                                SalesPost.SumSalesLinesTemp(lSalgshoved, lSalgslinie, 0, TotalSalesLine, TotalSalesLineLCY, VATAmount, VATAmountText, ProfitLCY, ProfitPct, TotalAdjCostLCY);
                                                if lSalgshoved."Prices Including VAT" then begin
                                                    TotalAmount2:=TotalSalesLine.Amount;
                                                    TotalAmount1:=TotalAmount2 + VATAmount;
                                                    TotalSalesLine."Line Amount":=TotalAmount1 + TotalSalesLine."Inv. Discount Amount";
                                                    lSalgslinie.Amount:=TotalAmount1;
                                                    lSalgslinie."Amount Including VAT":=TotalAmount2;
                                                end
                                                else
                                                begin
                                                    TotalAmount1:=TotalSalesLine.Amount;
                                                    TotalAmount2:=TotalSalesLine."Amount Including VAT";
                                                    lSalgslinie.Amount:=TotalAmount1;
                                                    lSalgslinie."Amount Including VAT":=TotalAmount2;
                                                end;
                                                if lSalgshoved.Amount <> 0 then if Abs(lSalgshoved.Amount - TotalAmount1) > 0.1 then begin
                                                        lSalgshoved.TestField(Amount, TotalAmount1);
                                                        lSalgslinie."Amount Including VAT":=TotalAmount1;
                                                    end;
                                                if lSalgshoved."Amount Including VAT" <> 0 then if Abs(lSalgshoved."Amount Including VAT" - TotalAmount2) > 0.1 then begin
                                                        lSalgshoved.TestField("Amount Including VAT", TotalAmount2);
                                                        lSalgslinie."Amount Including VAT":=TotalAmount2;
                                                    end;
                                            // <-- 19-07-06 CITP
                                            //>>COR/MIN 070113-2
                                            /*kode udkommenteret
                                                IF lSalgslinie."Amount Including VAT" <> SpecTekst.Beløb THEN BEGIN
                                                   SpecTekst.Beløb := lSalgslinie."Amount Including VAT";
                                                   SpecTekst.MODIFY;
                                                   lBSform.Formatering(Spec,FALSE);
                                                   SpecTekst2.GET(SpecTekst."Debitornr.",SpecTekst."Debitorgr.",
                                                                  SpecTekst.Specifikationskode,SpecTekst."Linienr.");
                                                   Opkrævningslinie.Beskrivelse := SpecTekst2."Beskrivelse Formateret";
                                                END;
                                                */
                                            //<<COR/MIN 070113-2
                                            end;
                                            // DT/PG 28.02.05 <<
                                            if SpecTekst.Beløb <> 0 THEN begin
                                                Opkrævningslinie."Tilh. Finanskonto/Vare":=SpecTekst."Tilh. Finanskonto/Vare";
                                                // Detailspecifikation af dimensioner har kun første prioritet over hovedspec. når der er IKKE er tale om
                                                // en standardspecifikation. Er disse dog blanke, tillades detailspecifikationen alligevel.
                                                if Spec.Fællesskabelon <> '' then begin
                                                    //>>COR/MIN 091013
                                                    /*
                                                    //oprindelig kode
                                                    {IF Spec."Global Dimension 1 Code" <> '' THEN
                                                      Opkrævningslinie."Global Dimension 1 Code" := Spec."Global Dimension 1 Code";
                                                    IF Spec."Global Dimension 2 Code" <> '' THEN
                                                      Opkrævningslinie."Global Dimension 2 Code" := Spec."Global Dimension 2 Code";}  //Udgået COR
                                                    */
                                                    if Spec."Global Dimension 1 Code" <> '' then Opkrævningslinie."Global Dimension 1 Code":=Spec."Global Dimension 1 Code";
                                                    if Spec."Global Dimension 2 Code" <> '' then Opkrævningslinie."Global Dimension 2 Code":=Spec."Global Dimension 2 Code";
                                                    //<<COR/MIN 091013
                                                    if Spec.Sælgerkode <> '' then Opkrævningslinie.Sælgerkode:=Spec.Sælgerkode;
                                                end
                                                else
                                                begin
                                                    //>>COR/MIN 091013
                                                    /*
                                                    //oprindelig kode
                                                    {Opkrævningslinie."Global Dimension 1 Code" := SpecTekst."Global Dimension 1 Code";
                                                    Opkrævningslinie."Global Dimension 2 Code" := SpecTekst."Global Dimension 2 Code";} //Udgået COR
                                                    */
                                                    Opkrævningslinie."Global Dimension 1 Code":=SpecTekst."Global Dimension 1 Code";
                                                    Opkrævningslinie."Global Dimension 2 Code":=SpecTekst."Global Dimension 2 Code";
                                                    //<<COR/MIN 091013
                                                    Opkrævningslinie.Sælgerkode:=SpecTekst.Sælgerkode;
                                                end;
                                                Opkrævningslinie.Bogføringsdato:=Bogføringsdato;
                                                // DT/PG 28.02.05 >>
                                                Opkrævningslinie."Tilhøre type":=SpecTekst."Tilhøre type";
                                                if SpecTekst."Tilhøre type" = SpecTekst."Tilhøre type"::Vare then begin
                                                    // Korrekt Beløb + moms
                                                    //>>COR/MIN 070113-4
                                                    /*oprindelig kode
                                                    Opkrævningslinie."Tilhøre Beløb excl moms" := lSalgslinie.Amount;
                                                    Opkrævningslinie."Tilhøre Beløb incl. moms" := lSalgslinie."Amount Including VAT";
                                                    */
                                                    Opkrævningslinie."Tilhøre beløb excl moms":=SpecTekst.Beløb;
                                                    Opkrævningslinie."Tilhøre Beløb incl. moms":=SpecTekst.Beløb;
                                                    //<<COR/MIN 070113-4
                                                    //>>COR/MIN 301013
                                                    if Customer."PBS Incl moms" then //dvs. der er ikke beregnet moms
 if Opkrævningslinie."Tilhøre beløb excl moms" = Opkrævningslinie."Tilhøre Beløb incl. moms" then //>>COR/MIN 190115
 /*oprindelig kode"Tilhøre beløb incl. moms"
                                                            Opkrævningslinie."Tilhøre Beløb incl. moms" := Opkrævningslinie."Tilhøre Beløb incl. moms"*1.25;
                                                            */
                                                            Opkrævningslinie."Tilhøre Beløb incl. moms":=ROUND(Opkrævningslinie."Tilhøre Beløb incl. moms" * 1.25, 0.01, '=');
                                                    //<<COR/MIN 190115
                                                    //<<COR/MIN 301013
                                                    //>>COR/MIN 070113-3
                                                    /*oprindelig kode
                                                    Opkrævningslinie.Beløb := lSalgslinie."Amount Including VAT";
                                                    */
                                                    Opkrævningslinie.Beløb:=SpecTekst.Beløb;
                                                //<<COR/MIN 070113-3
                                                //>>COR/MIN 070113-2
                                                /*oprindelig kode udkommenteret
                                                    IF Opkrævningslinie.Beløb <> SpecTekst.Beløb THEN BEGIN
                                                       SpecTekst.Beløb := Opkrævningslinie.Beløb;
                                                       SpecTekst.MODIFY;
                                                       lBSform.Formatering(Spec,FALSE);
                                                       SpecTekst2.GET(SpecTekst."Debitornr.",SpecTekst."Debitorgr.",
                                                                      SpecTekst.Specifikationskode,SpecTekst."Linienr.");
                                                       Opkrævningslinie.Beskrivelse := SpecTekst2."Beskrivelse Formateret";
                                                    END;
                                                    */
                                                //<<COR/MIN 070113-2
                                                end
                                                else
                                                begin
                                                    // DT/PG 28.02.05 <<
                                                    Opkrævningslinie.Beløb:=SpecTekst.Beløb;
                                                    //>>COR/IMT 230513
                                                    if CopyStr(Spec."Debitornr.", 1, 2) = '53' then //>>COR/MIN 190115
 /*oprindelig kode
                                                        Opkrævningslinie."Tilhøre Beløb incl. moms" := SpecTekst.Beløb*1.25
                                                        */
                                                        Opkrævningslinie."Tilhøre Beløb incl. moms":=ROUND(SpecTekst.Beløb * 1.25, 0.01, '=')
                                                    //<<COR/MIN 190115
                                                    //>>COR/MIN 070113-1
                                                    else
                                                    begin
                                                        Opkrævningslinie."Tilhøre beløb incl. moms":=SpecTekst.Beløb;
                                                        Opkrævningslinie."Tilhøre beløb excl moms":=SpecTekst.Beløb;
                                                    end;
                                                    //<<COR/MIN 070113-1
                                                    //<<COR/IMT 230513
                                                    //>>COR/MIN 301013
                                                    if Customer."PBS Incl moms" then /*oprindelig kode
                                                        Opkrævningslinie."Tilhøre Beløb incl. moms" := SpecTekst.Beløb*1.25
                                                        */ Opkrævningslinie."Tilhøre Beløb incl. moms":=ROUND(SpecTekst.Beløb * 1.25, 0.01, '=')
                                                    //>>COR/MIN 070113-1
                                                    else
                                                    begin
                                                        Opkrævningslinie."Tilhøre beløb incl. moms":=SpecTekst.Beløb;
                                                        Opkrævningslinie."Tilhøre beløb excl moms":=SpecTekst.Beløb;
                                                    end;
                                                //<<COR/MIN 070113-1
                                                //<<COR/MIN 301013
                                                end;
                                                //>>COR/MIN 091013
                                                /*
                                                //oprindelig kode
                                                //COR
                                                IF Opkrævningslinie."Global Dimension 1 Code"='' THEN
                                                  Opkrævningslinie."Global Dimension 1 Code":=FindDimension(Opkrævningslinie."Tilhøre type",
                                                                                                            Opkrævningslinie."Tilh. Finanskonto/Vare",1);
                                                IF Opkrævningslinie."Global Dimension 2 Code"='' THEN
                                                  Opkrævningslinie."Global Dimension 2 Code":=FindDimension(Opkrævningslinie."Tilhøre type",
                                                                                                            Opkrævningslinie."Tilh. Finanskonto/Vare",2);
                                                IF Opkrævningslinie."Funktionskode (Dimension)"='' THEN
                                                  Opkrævningslinie."Funktionskode (Dimension)":=FindDimension(Opkrævningslinie."Tilhøre type",
                                                                                                              Opkrævningslinie."Tilh. Finanskonto/Vare",3);
                                                IF Opkrævningslinie."Trading Partner (Dimension)"='' THEN
                                                  Opkrævningslinie."Trading Partner (Dimension)":=FindDimension(Opkrævningslinie."Tilhøre type",
                                                                                                                Opkrævningslinie."Tilh. Finanskonto/Vare",4);
                                                IF Opkrævningslinie."Projekt Fase (Dimension)"='' THEN
                                                  Opkrævningslinie."Projekt Fase (Dimension)":=FindDimension(Opkrævningslinie."Tilhøre type",
                                                                                                             Opkrævningslinie."Tilh. Finanskonto/Vare",5);

                                                  IF Opkrævningslinie."Global Dimension 1 Code"='' THEN
                                                    Opkrævningslinie."Global Dimension 1 Code":=Opkrævningshoved."Global Dimension 1 Code";
                                                  IF Opkrævningslinie."Global Dimension 2 Code"='' THEN
                                                    Opkrævningslinie."Global Dimension 2 Code":=Opkrævningshoved."Global Dimension 2 Code";
                                                  IF Opkrævningslinie."Funktionskode (Dimension)"='' THEN
                                                    Opkrævningslinie."Funktionskode (Dimension)":=Opkrævningshoved."Funktionskode (Dimension)";
                                                  IF Opkrævningslinie."Trading Partner (Dimension)"='' THEN
                                                    Opkrævningslinie."Trading Partner (Dimension)":=Opkrævningshoved."Trading Partner (Dimension)";
                                                  IF Opkrævningslinie."Projekt Fase (Dimension)"='' THEN
                                                    Opkrævningslinie."Projekt Fase (Dimension)":=Opkrævningshoved."Projekt Fase (Dimension)";
                                                //<- COR
                                                */
                                                //<<COR/MIN 091013
                                                //>>COR/MIN 091013
                                                GLSetup.Get;
                                                if Opkrævningslinie."Funktionskode (Dimension)" = '' then if DefaultDimension.Get(18, "BS-Betalingsaftale"."Debitornr.", GLSetup."Shortcut Dimension 3 Code")then Opkrævningslinie."Funktionskode (Dimension)":=DefaultDimension."Dimension Value Code";
                                                if Opkrævningslinie."Trading Partner (Dimension)" = '' then if DefaultDimension.Get(18, "BS-Betalingsaftale"."Debitornr.", GLSetup."Shortcut Dimension 4 Code")then Opkrævningslinie."Trading Partner (Dimension)":=DefaultDimension."Dimension Value Code";
                                                //<<COR/MIN 091013
                                                //>>COR/MIN 040214
                                                if SpecTekst."Tilhøre type" = SpecTekst."Tilhøre type"::Vare then begin
                                                    if FindDimension(Opkrævningslinie."Tilhøre type", Opkrævningslinie."Tilh. Finanskonto/Vare", 1) <> '' then Opkrævningslinie."Global Dimension 1 Code":=FindDimension(Opkrævningslinie."Tilhøre type", Opkrævningslinie."Tilh. Finanskonto/Vare", 1);
                                                    if FindDimension(Opkrævningslinie."Tilhøre type", Opkrævningslinie."Tilh. Finanskonto/Vare", 2) <> '' then Opkrævningslinie."Global Dimension 2 Code":=FindDimension(Opkrævningslinie."Tilhøre type", Opkrævningslinie."Tilh. Finanskonto/Vare", 2);
                                                    if FindDimension(Opkrævningslinie."Tilhøre type", Opkrævningslinie."Tilh. Finanskonto/Vare", 3) <> '' then Opkrævningslinie."Funktionskode (Dimension)":=FindDimension(Opkrævningslinie."Tilhøre type", Opkrævningslinie."Tilh. Finanskonto/Vare", 3);
                                                    if FindDimension(Opkrævningslinie."Tilhøre type", Opkrævningslinie."Tilh. Finanskonto/Vare", 4) <> '' then Opkrævningslinie."Trading Partner (Dimension)":=FindDimension(Opkrævningslinie."Tilhøre type", Opkrævningslinie."Tilh. Finanskonto/Vare", 4);
                                                    if FindDimension(Opkrævningslinie."Tilhøre type", Opkrævningslinie."Tilh. Finanskonto/Vare", 5) <> '' then Opkrævningslinie."Projekt Fase (Dimension)":=FindDimension(Opkrævningslinie."Tilhøre type", Opkrævningslinie."Tilh. Finanskonto/Vare", 5);
                                                end;
                                                //<<COR/MIN 040214
                                                Opkrævningslinie.Insert;
                                                LbNr:=LbNr + 10000;
                                            end;
                                        end
                                        else
                                        begin
                                            Opkrævningslinie.Insert;
                                            LbNr:=LbNr + 10000;
                                        end;
                                        // </DIA>
                                        lSalgshoved.SetFilter("No.", 'XXXXX');
                                        lSalgshoved.DeleteAll(true);
                                    end;
                                until SpecTekst.Next = 0;
                        until Spec.Next = 0;
                end;
            }
            trigger OnAfterGetRecord()
            begin
            //  PBar.Update;
            end;
            trigger OnPostDataItem()
            begin
            //  PBar.Close;
            end;
            trigger OnPreDataItem()
            begin
                Stamoplysninger.Reset;
                Stamoplysninger.LockTable;
                Stamoplysninger.Get;
                Stamoplysninger.TestField("Sidste Opkrævningsnr.");
                //  PBar.Open('Danner opkrævninger :', Count);
                Clear("Cnt-Opkrævninger");
                Clear("Cnt-Sammenføjninger");
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
                field("Skæringsdato"; Skæringsdato)
                {
                    ApplicationArea = Basic;
                    Caption = 'Skæringsdato';
                }
                field("Opkræves d."; "Opkræves d.")
                {
                    ApplicationArea = Basic;
                    Caption = 'Opkræves d.';
                }
                field("Bogføringsdato"; "Bogføringsdato")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bogf. dato';
                }
                field("Overlappende Betalinger"; "Overlappende Betalinger")
                {
                    ApplicationArea = Basic;
                    Caption = 'Overlappende aftaler';
                }
                field("Indsæt Separator"; "Indsæt Separator")
                {
                    ApplicationArea = Basic;
                    Caption = 'Seperator v/ sammenf.';
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
    Spec: Record "BS-Specifikation";
    SpecTekst: Record "BS-Specifkationstekst";
    "Opkrævningshoved": Record "BS-Opkrævningshoved";
    "Opkrævningslinie": Record "BS-Opkrævningslinie";
    //  PBar: Codeunit "Om BetalingsService";
    "Overlappende Betalinger": Option Afvis, "Sammenføj";
    "Skæringsdato": Date;
    Bogføringsdato: Date;
    "Opkræves d.": Date;
    DubletNr: Code[10];
    LbNr: Integer;
    "Cnt-Opkrævninger": Integer;
    "Cnt-Sammenføjninger": Integer;
    "Indsæt Separator": Boolean;
    "IndsætFællesOverskrift": Boolean;
    ">> BS2.60.02LA <<": Integer;
    LangAdvisering: Boolean;
    SpecTekst2: Record "BS-Specifkationstekst";
    GLSetup: Record "General Ledger Setup";
    DefaultDimension: Record "Default Dimension";
    procedure Dublet(DebNr: Code[20]; DebGr: Integer; Dato: Date; var DubletNr: Code[10]): Boolean var
        "Opkrævningshoved": Record "BS-Opkrævningshoved";
    begin
        Opkrævningshoved.Reset;
        Opkrævningshoved.SetCurrentkey("Debitornr.", "Debitorgr.");
        Opkrævningshoved.SetRange("Debitornr.", DebNr);
        Opkrævningshoved.SetRange("Debitorgr.", DebGr);
        Opkrævningshoved.SetRange(Opkrævningsdato, Dato);
        if Opkrævningshoved.Find('=<>')then begin
            DubletNr:=Opkrævningshoved."Opkrævningsnr.";
            exit(true);
        end
        else
        begin
            Clear(DubletNr);
            exit(false);
        end;
    end;
    procedure FindDimension(TilhørerTypePar: Option; FinansVarenr: Code[20]; "DimShortCutNo.": Integer)ReturDimension: Code[20]var
        DefaultDimensionLocal: Record "Default Dimension";
        GLSetupLocal: Record "General Ledger Setup";
    begin
        GLSetupLocal.Get;
        if TilhørerTypePar = 0 then DefaultDimensionLocal.SetRange(DefaultDimensionLocal."Table ID", 15);
        if TilhørerTypePar = 1 then DefaultDimensionLocal.SetRange(DefaultDimensionLocal."Table ID", 27);
        DefaultDimensionLocal.SetRange(DefaultDimensionLocal."No.", FinansVarenr);
        case "DimShortCutNo." of 1: DefaultDimensionLocal.SetRange(DefaultDimensionLocal."Dimension Code", GLSetupLocal."Shortcut Dimension 1 Code");
        2: DefaultDimensionLocal.SetRange(DefaultDimensionLocal."Dimension Code", GLSetupLocal."Shortcut Dimension 2 Code");
        3: DefaultDimensionLocal.SetRange(DefaultDimensionLocal."Dimension Code", GLSetupLocal."Shortcut Dimension 3 Code");
        4: DefaultDimensionLocal.SetRange(DefaultDimensionLocal."Dimension Code", GLSetupLocal."Shortcut Dimension 4 Code");
        5: DefaultDimensionLocal.SetRange(DefaultDimensionLocal."Dimension Code", GLSetupLocal."Shortcut Dimension 5 Code");
        end;
        if DefaultDimensionLocal.FindFirst then exit(DefaultDimensionLocal."Dimension Value Code")
        else
            exit('');
    end;
}
