Table 51009 "BS-Opkrævningshoved"
{
    // 
    // // BetalingsService -------------------------------------- >>
    // // ˆ Copyright 1997, 2001 Hands A/S
    // //
    // // DIA103 projektkode = 20
    // 
    // COR/MIN 301013 Ændret flowfield fra Sum(BS-Opkrævningslinie.Beløb WHERE (Opkrævningsnr.=FIELD(Opkrævningsnr.)))
    //                til Sum(BS-Opkrævningslinie."Tilhøre beløb incl. moms" WHERE (Opkrævningsnr.=FIELD(Opkrævningsnr.)))
    DataCaptionFields = "Opkrævningsnr.";
    PasteIsValid = false;

    fields
    {
        field(1; "Opkrævningsnr."; Code[9])
        {
        }
        field(10; "Debitornr."; Code[20])
        {
            TableRelation = Customer;

            trigger OnValidate()
            begin
                if xRec."Debitornr." <> '' then Error('%1 kan kun ændres ved oprettelse.\\Nulstil evt. opkrævningen og prøv igen.', FieldName("Debitornr."));
            /* Opgrade to AL 
                BSAftale.Reset;
                BSAftale.SetRange("Debitornr.", "Debitornr.");
                // BSAftale.SetRange(Aktiv, true);
                Message('Vælg en BetalingsService aftale');
                if Page.RunModal(Page::"BS Betalingsaftale", BSAftale) = Action::LookupOK then begin
                    BSAftale.CalcFields(Aktiv);
                    BSAftale.TestField(Aktiv);
                    BSAftale.TestField("Debitornr.", "Debitornr.");
                    "Debitorgr." := BSAftale."Debitorgr.";
                end else
                    Error('Der skal vælges en aktiv betalingsaftale');

                Specifikation.Reset;
                Specifikation.SetRange("Debitornr.", "Debitornr.");
                Specifikation.SetRange("Debitorgr.", "Debitorgr.");
                if Specifikation.Find('=><') then begin
                    Message('Vælg evt. en specifikation');
                    if Page.RunModal(Page::"BS Specifikation", Specifikation) = Action::LookupOK then begin
                        Specifikation.TestField("Debitornr.", "Debitornr.");
                        Specifikation.TestField("Debitorgr.", "Debitorgr.");

                        Specifikation."Validér Aftale"(Specifikation);

                        Specifikationstekst.Reset;
                        if Specifikation.Fællesskabelon <> '' then begin
                            Specifikationstekst.SetRange("Debitornr.", '');
                            Specifikationstekst.SetRange("Debitorgr.", 0);
                            Specifikationstekst.SetRange(Specifikationskode, Specifikation.Fællesskabelon);
                        end else begin
                            Specifikationstekst.SetRange("Debitornr.", Specifikation."Debitornr.");
                            Specifikationstekst.SetRange("Debitorgr.", Specifikation."Debitorgr.");
                            Specifikationstekst.SetRange(Specifikationskode, Specifikation.Kode);
                        end;

                        // Fjern evt. opkrævningslinier før oprettelse (Dette burde aldrig forekomme ! - men for at være heeelt sikker...)

                        "Opkr.Linie".Reset;
                        "Opkr.Linie".SetRange("Opkrævningsnr.", "Opkrævningsnr.");
                        "Opkr.Linie".DeleteAll;

                        LbNr := 10000;

                        if Specifikationstekst.Find('-') then
                            repeat
                                "Opkr.Linie".Init;
                                "Opkr.Linie"."Opkrævningsnr." := "Opkrævningsnr.";
                                "Opkr.Linie"."Evt. Specifikationskode" := Specifikation.Kode;
                                "Opkr.Linie"."Evt. Fremrykkelsesdato" := CalcDate(Specifikation.Opkrævningsinterval, Specifikation."Næste opkrævning");
                                "Opkr.Linie"."Linienr." := LbNr;
                                "Opkr.Linie".Art := Specifikationstekst.Art;
                                "Opkr.Linie".Sats := Specifikationstekst.Sats;
                                "Opkr.Linie".Beskrivelse := Specifikationstekst."Beskrivelse Formateret";
                                "Opkr.Linie"."Tilh. Finanskonto/Vare" := Specifikationstekst."Tilh. Finanskonto/Vare";
                                "Opkr.Linie"."Global Dimension 1 Code" := Specifikationstekst."Global Dimension 1 Code";
                                "Opkr.Linie"."Global Dimension 2 Code" := Specifikationstekst."Global Dimension 2 Code";
                                "Opkr.Linie".Sælgerkode := Specifikationstekst.Sælgerkode;
                                "Opkr.Linie".Beløb := Specifikationstekst.Beløb;

                                LbNr := LbNr + 10000;
                                "Opkr.Linie".Insert;
                            until Specifikationstekst.Next = 0;
                    end;

                end;
                */
            end;
        }
        field(11; "Debitorgr."; Integer)
        {
            Editable = false;
            MaxValue = 99999;
            MinValue = 1;
        }
        field(15; "Referenceopkrævning"; Boolean)
        {
        }
        field(20; "Opkrævningsdato"; Date)
        {
        }
        field(21; "Opkrævningsbeløb"; Decimal)
        {
            CalcFormula = sum("BS-Opkrævningslinie"."Tilhøre beløb incl. moms" where("Opkrævningsnr."=field("Opkrævningsnr.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "Opkrævningsstatus"; Option)
        {
            Editable = false;
            OptionMembers = Oprettes, Afventer, "Gennemført", "Ej gennemført";
        }
        field(23; Afsluttet; Boolean)
        {
            Editable = false;
            InitValue = false;
        }
        field(25; "Bogføringsdato"; Date)
        {
        }
        field(26; Bilagsdato; Date)
        {
        }
        field(27; Forfaldsdato; Date)
        {
        }
        field(30; "Bogført"; Boolean)
        {
            Editable = false;
        }
        field(60; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            Description = 'Dia';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
        }
        field(61; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            Description = 'Dia';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(2));
        }
        field(62; "Sælgerkode"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";
        }
        field(80; "Bogføringsmetode"; Option)
        {
            Description = 'BS2.50.01';
            OptionMembers = Salgsfaktura, Kassekladde;

            trigger OnValidate()
            begin
                if(Bogføringsmetode = Bogføringsmetode::Kassekladde) AND (Bilagsmetode = Bilagsmetode::"Et bilag pr. opkrævning")THEN begin
                    Bilagsmetode:=Bilagsmetode::"Nyt bilag pr. advisering"; // Tildeling sker af hensyn til visningen i error-boksen !
                    Error('Når %1 er ''%2'' skal %3 være ''%4'' !', FieldName(Bogføringsmetode), Bogføringsmetode, FieldName(Bilagsmetode), Bilagsmetode);
                end;
                "Opkr.Linie".Reset;
                "Opkr.Linie".SetRange("Opkrævningsnr.", "Opkrævningsnr.");
                "Opkr.Linie".SetRange(Art, "Opkr.Linie".Art::Advisering);
                if "Opkr.Linie".Find('=><')then Error('Bogførings- og bilagsmetode kan ikke ændres når først der er oprettet adviseringslinier !');
                if Bilagsmetode = Bilagsmetode::"Nyt bilag pr. advisering" then begin
                    if(Bogføringsdato <> 0D) OR (Bilagsdato <> 0D) OR (Forfaldsdato <> 0D) OR ("Global Dimension 1 Code" <> '') OR ("Global Dimension 2 Code" <> '') OR (Sælgerkode <> '')THEN Error('Bogførings- og bilagsmetode kan ikke ændres når først der er ændret bogføringsoplysninger på hovedet !');
                end;
            end;
        }
        field(81; Bilagsmetode; Option)
        {
            Description = 'BS2.50.01';
            OptionMembers = "Nyt bilag pr. advisering", "Et bilag pr. opkrævning";

            trigger OnValidate()
            begin
                Validate(Bogføringsmetode);
            end;
        }
        field(50000; "Funktionskode (Dimension)"; Code[20])
        {
            Description = 'COR';
            TableRelation = "Dimension Value".Code where("Dimension Code"=filter('FUNKTION'));
        }
        field(50001; "Trading Partner (Dimension)"; Code[20])
        {
            Description = 'COR';
            TableRelation = "Dimension Value".Code where("Dimension Code"=filter('TRADING PARTNER'));
        }
        field(50002; "Projekt Fase (Dimension)"; Code[20])
        {
            Description = 'COR';
            TableRelation = "Dimension Value".Code where("Dimension Code"=filter('PROJEKT FASE'));
        }
    }
    keys
    {
        key(Key1; "Opkrævningsnr.")
        {
            Clustered = true;
        }
        key(Key2; "Bogført")
        {
        }
        key(Key3; "Bogført", "Opkrævningsstatus", "Debitorgr.", "Debitornr.")
        {
        }
        key(Key4; "Debitornr.", "Debitorgr.", "Opkrævningsdato")
        {
        }
        key(Key5; "Bogført", "Opkrævningsdato")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        if Referenceopkrævning then TestField(Opkrævningsstatus, Opkrævningsstatus::Oprettes)
        else
            TestField(Bogført, false);
        "Opkr.Linie".Reset;
        "Opkr.Linie".SetRange("Opkrævningsnr.", "Opkrævningsnr.");
        "Opkr.Linie".SetFilter("Bilagsnr.", '<>%1', '');
        if "Opkr.Linie".Find('=<>')then Error('Denne opkrævning er delvist Bogført, og skal bogføres færdig.');
        "Opkr.Linie".SetRange("Bilagsnr.");
        "Opkr.Linie".DeleteAll;
    end;
    trigger OnInsert()
    var
        Stamoplysninger: Record "BS-Stamoplysninger";
    begin
        TestField(Bogført, false);
        if "Opkrævningsnr." = '' then begin
            if not Confirm('Opret manuel opkrævning ?', false)then Error('Afvist');
            Stamoplysninger.LockTable;
            Stamoplysninger.Get;
            Stamoplysninger.TestField("Sidste Opkrævningsnr.");
            Stamoplysninger."Sidste Opkrævningsnr.":=IncStr(Stamoplysninger."Sidste Opkrævningsnr.");
            Stamoplysninger.Modify;
            "Opkrævningsnr.":=Stamoplysninger."Sidste Opkrævningsnr.";
            Bogføringsmetode:=Stamoplysninger.Bogføringsmetode;
            Bilagsmetode:=Stamoplysninger.Bilagsmetode;
        end
        else
            Error('Opkrævningsnummer kan ikke angives manuelt !\\Tryk [Enter] i det blanke felt for at hente et nyt nummer i serien.');
    end;
    trigger OnModify()
    begin
        TestField(Bogført, false);
    end;
    trigger OnRename()
    begin
        Error('Det er ikke muligt at omdøbe en Opkrævning');
    end;
    var BSAftale: Record "BS-Betalingsaftale";
    Specifikation: Record "BS-Specifikation";
    Specifikationstekst: Record "BS-Specifkationstekst";
    "Opkr.Linie": Record "BS-Opkrævningslinie";
    LbNr: Integer;
    DimMgt: Codeunit DimensionManagement;
    procedure ">> BS2.60.02LA <<"()
    begin
    end;
    procedure "Lang Advisering"("Opkr.Hoved": Record "BS-Opkrævningshoved")LangAdvisering: Boolean var
        "Opkr.Linie": Record "BS-Opkrævningslinie";
        StamOplysninger: Record "BS-Stamoplysninger";
    begin
        StamOplysninger.Find('-');
        if StamOplysninger.Adviseringstype = StamOplysninger.Adviseringstype::"Lang (60 tegn)" then exit(true);
        // Bestem og kontroller Adviseringslængde
        "Opkr.Linie".Reset;
        "Opkr.Linie".SetRange("Opkrævningsnr.", "Opkr.Hoved"."Opkrævningsnr.");
        "Opkr.Linie".SetFilter(Art, '%1|%2|%3', "Opkr.Linie".Art::Advisering, "Opkr.Linie".Art::Fællesoverskrift, "Opkr.Linie".Art::Bemærkning);
        LangAdvisering:=false;
        if "Opkr.Linie".Find('-')then repeat LangAdvisering:=StrLen("Opkr.Linie".Beskrivelse) > 38;
            until LangAdvisering or ("Opkr.Linie".Next = 0);
        if LangAdvisering then if StamOplysninger.Adviseringstype = StamOplysninger.Adviseringstype::"Kort (38 tegn)" then Error('Feltet ''%1'' i linie %2 på BS-Opkrævning %3 (%4/%5) er %6 tegn langt.\\' + 'Når den valgte %7 er ''%8'', kan der maksimalt indtastes 38 tegn i dette felt.', "Opkr.Linie".FieldName(Beskrivelse), "Opkr.Linie"."Linienr.", "Opkr.Hoved"."Opkrævningsnr.", "Opkr.Hoved"."Debitornr.", "Opkr.Hoved"."Debitorgr.", StrLen("Opkr.Linie".Beskrivelse), StamOplysninger.FieldName(Adviseringstype), StamOplysninger.Adviseringstype);
    end;
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.SaveDefaultDim(Database::"BS-Opkrævningshoved", "Opkrævningsnr.", FieldNumber, ShortcutDimCode);
        Modify;
    end;
}
