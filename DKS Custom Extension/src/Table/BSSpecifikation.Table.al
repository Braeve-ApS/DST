Table 51000 "BS-Specifikation"
{
    // // BetalingsService -------------------------------------- >>
    // // ˆ Copyright 1997, 2001 Hands A/S
    // // DIA103 projektkode = 20
    // COR/MIN 180814 skal kunne rename
    PasteIsValid = false;

    fields
    {
        field(1; "Debitornr."; Code[20])
        {
            TableRelation = Customer;

            trigger OnValidate()
            begin
                if "Debitornr." <> '' then begin
                    Debitor.Get("Debitornr.");
                    Validate("Global Dimension 1 Code", Debitor."Global Dimension 1 Code");
                    Validate("Global Dimension 2 Code", Debitor."Global Dimension 2 Code");
                    Validate(Sælgerkode, Debitor."Salesperson Code");
                end;
            end;
        }
        field(3; Kode; Code[10])
        {
            NotBlank = true;
        }
        field(4; "Debitorgr."; Integer)
        {
            MaxValue = 99999;
            MinValue = 1;
        }
        field(5; "Fællesskabelon"; Code[10])
        {
            TableRelation = if("Debitornr."=filter(<>''))"BS-Specifikation".Kode where("Debitornr."=const(''));

            trigger OnValidate()
            begin
                if("Debitornr." = '') and (Fællesskabelon <> '')then Error('Én Fællesskabelon kan ikke defineres ved en anden.');
                if(Fællesskabelon <> xRec.Fællesskabelon) and (Fællesskabelon <> '')then begin
                    CalcFields("Tilh. Linier");
                    if "Tilh. Linier" <> 0 then if not Confirm('Vil du slette de tilhørende linier, og tilknytte specifikationen til Fællesskabelon %1 ?', false, Fællesskabelon)then FieldError(Fællesskabelon, 'kunne ikke ændres !')
                        else
                        begin
                            L.Reset;
                            L.SetRange("Debitornr.", "Debitornr.");
                            L.SetRange("Debitorgr.", "Debitorgr.");
                            L.SetRange(Specifikationskode, Kode);
                            L.DeleteAll;
                            Clear(Overskrift);
                            Modify;
                        end;
                end;
            end;
        }
        field(10; Overskrift; Text[30])
        {
        }
        field(20; "Næste opkrævning"; Date)
        {
            trigger OnValidate()
            begin
                if "Debitornr." = '' then Error('%1 kan ikke angives på en Fællesskabelon', FieldName("Næste opkrævning"));
            end;
        }
        field(21; "Opkrævningsinterval"; Text[30])
        {
            DateFormula = true;
            InitValue = '1M';

            trigger OnValidate()
            begin
                if "Debitornr." = '' then Error('"%1" kan ikke angives på en Fællesskabelon', FieldName(Opkrævningsinterval));
                if Opkrævningsinterval = '' then begin
                    Opkrævningsinterval:='1M';
                    Message('Der skal angives et repeterings datointerval i "%1"', FieldName(Opkrævningsinterval));
                    ;
                end;
                if CalcDate(Opkrævningsinterval, Today) <= Today then Error('"%1" skal pege frem i tiden', FieldName(Opkrævningsinterval));
            end;
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
        field(85; "Tilh. Linier"; Integer)
        {
            CalcFormula = count("BS-Specifkationstekst" where("Debitornr."=field("Debitornr."), "Debitorgr."=field("Debitorgr."), Specifikationskode=field(Kode)));
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "Debitornr.", "Debitorgr.", Kode)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    var
        Specifikationstekst: Record "BS-Specifkationstekst";
    begin
        // Std.Specifikation
        if "Debitornr." = '' then begin
            Specifikation.Reset;
            Specifikation.SetFilter("Debitornr.", '<>%1', '');
            Specifikation.SetRange(Fællesskabelon, Kode);
            if Specifikation.Find('=<>')then Error('Fællesskabelon %1 kan ikke slettes !\\' + 'Den er tilknyttet en eller flere debitorer.\(Debitor %2)', Kode, Specifikation."Debitornr.");
        end
        else
        begin
            Specifikationstekst.Reset;
            Specifikationstekst.SetRange("Debitornr.", "Debitornr.");
            Specifikationstekst.SetRange("Debitorgr.", "Debitorgr.");
            Specifikationstekst.SetRange(Specifikationskode, Kode);
            Specifikationstekst.DeleteAll;
        end;
    end;
    trigger OnRename()
    begin
    //>>COR/MIN 180814
    /*oprindelig kode
        ERROR('Omdøbning af specifikationer understøttes ikke !');
        */
    //<<COR/MIN 180814
    end;
    var Specifikation: Record "BS-Specifikation";
    FSkabelon: Record "BS-Specifikation";
    Debitor: Record Customer;
    L: Record "BS-Specifkationstekst";
    procedure "Validér Aftale"(SpecRec: Record "BS-Specifikation"): Decimal var
        recSpecifikationstekst: Record "BS-Specifkationstekst";
        Sumbeløb: Decimal;
    begin
        // Lokal procedure - Anvender globale variable
        recSpecifikationstekst.Reset;
        if SpecRec.Fællesskabelon <> '' then begin
            recSpecifikationstekst.SetRange("Debitornr.", '');
            recSpecifikationstekst.SetRange("Debitorgr.", 0);
            recSpecifikationstekst.SetRange(Specifikationskode, SpecRec.Fællesskabelon);
        end
        else
        begin
            recSpecifikationstekst.SetRange("Debitornr.", SpecRec."Debitornr.");
            recSpecifikationstekst.SetRange("Debitorgr.", SpecRec."Debitorgr.");
            recSpecifikationstekst.SetRange(Specifikationskode, SpecRec.Kode);
        end;
        Clear(Sumbeløb);
        if recSpecifikationstekst.Find('-')then repeat Sumbeløb:=Sumbeløb + recSpecifikationstekst."Beløb";
            until recSpecifikationstekst.Next = 0
        else
        begin
            if SpecRec.Fællesskabelon <> '' then Error('Fællesskabelon %1 indeholder ingen specifikation', Kode)
            else
                Error('Specifikation %1 for debitor %2 (%3) indeholder ingen tekst', SpecRec.Kode, SpecRec."Debitornr.", SpecRec."Debitorgr.");
        end;
        if Sumbeløb = 0 then if SpecRec.Fællesskabelon <> '' then Error('Det samlede beløb på Fællesskabelon %1 er 0 (nul)', SpecRec.Kode)
            else
                Error('Det samlede beløb på specifikation %1 for debitor %2 (%3) er 0 (nul)', SpecRec.Kode, SpecRec."Debitornr.", SpecRec."Debitorgr.");
        exit(Sumbeløb);
    end;
    procedure ">> BS2.60.02LA <<"()
    begin
    end;
    procedure "Lang Advisering"(Specifikation: Record "BS-Specifikation")LangAdvisering: Boolean var
        SpecTekst: Record "BS-Specifkationstekst";
        StamOplysninger: Record "BS-Stamoplysninger";
    begin
        StamOplysninger.Find('-');
        if StamOplysninger.Adviseringstype = StamOplysninger.Adviseringstype::"Lang (60 tegn)" then exit(true);
        // Bestem og kontroller Adviseringslængde
        SpecTekst.Reset;
        if Specifikation.Fællesskabelon <> '' then begin
            SpecTekst.SetFilter("Debitornr.", '');
            SpecTekst.SetRange("Debitorgr.", 0);
            SpecTekst.SetRange(Specifikationskode, Specifikation.Fællesskabelon);
        end
        else
        begin
            SpecTekst.SetRange("Debitornr.", Specifikation."Debitornr.");
            SpecTekst.SetRange("Debitorgr.", Specifikation."Debitorgr.");
            SpecTekst.SetRange(Specifikationskode, Specifikation.Kode);
        end;
        SpecTekst.SetFilter(Art, '%1|%2|%3', SpecTekst.Art::Advisering, SpecTekst.Art::Fællesoverskrift, SpecTekst.Art::Bemærkning);
        LangAdvisering:=false;
        if SpecTekst.Find('-')then repeat LangAdvisering:=StrLen(SpecTekst."Beskrivelse Formateret") > 38;
            until LangAdvisering or (SpecTekst.Next = 0);
        if LangAdvisering then if StamOplysninger.Adviseringstype = StamOplysninger.Adviseringstype::"Kort (38 tegn)" then Error('Feltet ''%1'' i linie %2 på specifikation %3 (%4/%5) er %6 tegn langt.\\' + 'Når den valgte %7 er ''%8'', kan der maksimalt indtastes 38 tegn i dette felt.', SpecTekst.FieldName("Beskrivelse Formateret"), SpecTekst."Linienr.", Specifikation.Kode, Specifikation."Debitornr.", Specifikation."Debitorgr.", StrLen(SpecTekst."Beskrivelse Formateret"), StamOplysninger.FieldName(Adviseringstype), StamOplysninger.Adviseringstype);
    end;
}
