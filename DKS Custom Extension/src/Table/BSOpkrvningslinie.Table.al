Table 51010 "BS-Opkrævningslinie"
{
    // 
    // 
    // // BetalingsService -------------------------------------- >>
    // // ˆ Copyright 1997, 2001 Hands A/S
    // // DT/PG 28.02.05
    // // nye felter: Tilhøre type
    // //             Tilhøre beløb excl moms
    // //             Tilhøre beløb incl. moms
    // 
    // COR/MIN 081013 Huske den valgte afd. og akt. kode. Samt funktionskode og trading partner
    // COR/MIN 301013 Tilføje nyt sumideksfelt til primærnøgle: tihøre beløb incl. moms
    DrillDownPageID = "BS OpkrævningsLinier";
    PasteIsValid = false;

    fields
    {
        field(1; "Opkrævningsnr."; Code[9])
        {
            TableRelation = "BS-Opkrævningshoved";
        }
        field(2; "Linienr."; Integer)
        {
        }
        field(5; "Debitornr."; Code[20])
        {
            Editable = false;
            TableRelation = Customer;
        }
        field(6; "Evt. Specifikationskode"; Code[10])
        {
            Editable = false;
            TableRelation = "BS-Specifikation".Kode where("Debitornr."=field("Debitornr."));
        }
        field(7; "Evt. Fremrykkelsesdato"; Date)
        {
        }
        field(10; Art; Option)
        {
            Description = 'BS2.50.03';
            OptionMembers = Advisering, "Intern bemærkning", "Fællesoverskrift", "Bemærkning";

            trigger OnValidate()
            begin
                if Art <> xRec.Art then begin
                    xArt:=Art;
                    Init;
                    "Opkrævningsnr.":=xRec."Opkrævningsnr.";
                    "Linienr.":=xRec."Linienr.";
                    Art:=xArt;
                end;
            end;
        }
        field(15; Sats; Code[10])
        {
            trigger OnValidate()
            begin
                TestField(Art, Art::Advisering);
            end;
        }
        field(16; Beskrivelse; Text[60])
        {
            trigger OnValidate()
            begin
                // >> BS2.60.03 >>
                if Art in[Art::Advisering, Art::Fællesoverskrift, Art::Bemærkning]then if StrLen(Beskrivelse) > 38 then begin
                        StamOpl.Find('-');
                        if StamOpl.Adviseringstype = StamOpl.Adviseringstype::"Kort (38 tegn)" then Error('Når den valgte %1 er ''%2'', kan der maksimalt indtastes 38 tegn i dette felt.', StamOpl.FieldName(Adviseringstype), StamOpl.Adviseringstype);
                    end;
                // << BS2.60.03 <<
                if Art = Art::Advisering then begin
                    if(xRec.Beskrivelse = '') and (Beskrivelse <> '')then begin
                        Hoved.Get("Opkrævningsnr.");
                        case Hoved.Bilagsmetode of Hoved.Bilagsmetode::"Nyt bilag pr. advisering": begin
                            // Overfør fællesoplysninger, såfremt de ikke er angivet i forvejen.
                            if Bogføringsdato = 0D THEN Bogføringsdato:=Hoved.Bogføringsdato;
                            if Bilagsdato = 0D then Bilagsdato:=Hoved.Bilagsdato;
                            if Forfaldsdato = 0D then Forfaldsdato:=Hoved.Forfaldsdato;
                            if "Global Dimension 1 Code" = '' then Validate("Global Dimension 1 Code", Hoved."Global Dimension 1 Code");
                            if "Global Dimension 2 Code" = '' then Validate("Global Dimension 2 Code", Hoved."Global Dimension 2 Code");
                            if Sælgerkode = '' then Validate(Sælgerkode, Hoved.Sælgerkode);
                        end;
                        Hoved.Bilagsmetode::"Et bilag pr. opkrævning": begin
                            Clear(Bogføringsdato);
                            Clear(Bilagsdato);
                            Clear(Forfaldsdato);
                            Clear("Global Dimension 1 Code");
                            Clear("Global Dimension 2 Code");
                            Clear(Sælgerkode);
                        end;
                        else
                            Error('Ukendt Bilagsmetode ''%1'' angivet i BS-Stamoplysningerne !', Hoved.Bilagsmetode);
                        end; //Case
                    end;
                end;
            end;
        }
        field(20; "Tilh. Finanskonto/Vare"; Code[20])
        {
            TableRelation = if("Tilhøre type"=const(Finans))"G/L Account" where("Account Type"=const(Posting))
            else if("Tilhøre type"=const(Vare))Item;

            trigger OnValidate()
            begin
                TestField(Art, Art::Advisering);
                TestField(Beskrivelse);
            end;
        }
        field(25; "Beløb"; Decimal)
        {
            BlankZero = true;

            trigger OnValidate()
            begin
                TestField(Art, Art::Advisering);
                TestField(Beskrivelse);
                //>>Jim 300517
                if Beløb <> xRec.Beløb THEN begin
                    "Tilhøre beløb excl moms":=Beløb;
                    "Tilhøre beløb incl. moms":=Beløb;
                end;
            //<<
            end;
        }
        field(35; "Ref. Debitorpost"; Integer)
        {
            Editable = false;
        }
        field(40; "Bogføringsdato"; Date)
        {
            trigger OnValidate()
            begin
                TestField(Art, Art::Advisering);
                TestField(Beskrivelse);
            end;
        }
        field(41; "Bilagsnr."; Code[10])
        {
            Editable = false;
            TableRelation = "Sales Invoice Header"."No.";
            //This property is currently not supported
            //TestTableRelation = true;
            ValidateTableRelation = true;

            trigger OnLookup()
            begin
                Navigér.SetDoc(Bogføringsdato, "Bilagsnr.");
                Navigér.Run;
            end;
        }
        field(45; Bilagsdato; Date)
        {
            trigger OnValidate()
            begin
                TestField(Art, Art::Advisering);
                TestField(Beskrivelse);
            end;
        }
        field(46; Forfaldsdato; Date)
        {
            trigger OnValidate()
            begin
                TestField(Art, Art::Advisering);
                TestField(Beskrivelse);
            end;
        }
        field(60; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));

            trigger OnValidate()
            begin
                TestField(Art, Art::Advisering);
                TestField(Beskrivelse);
            end;
        }
        field(61; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(2));

            trigger OnValidate()
            begin
                TestField(Art, Art::Advisering);
                TestField(Beskrivelse);
                //>>COR/MIN 081013
                "Global Dimension 1 Code":=Rec."Global Dimension 1 Code";
                Modify;
            //<<COR/MIN 081013
            end;
        }
        field(62; "Sælgerkode"; Code[10])
        {
            TableRelation = "Salesperson/Purchaser";

            trigger OnValidate()
            begin
                TestField(Art, Art::Advisering);
                TestField(Beskrivelse);
                //>>COR/MIN 081013
                "Global Dimension 2 Code":=Rec."Global Dimension 2 Code";
                Modify;
            //<<COR/MIN 081013
            end;
        }
        field(63; "Tilhøre type"; Option)
        {
            Description = 'DT/PG';
            OptionMembers = Finans, Vare;
        }
        field(64; "Tilhøre beløb excl moms"; Decimal)
        {
            Description = 'DT/PG';
        }
        field(65; "Tilhøre beløb incl. moms"; Decimal)
        {
            Description = 'DT/PG';
        }
        field(50000; "Funktionskode (Dimension)"; Code[20])
        {
            Description = 'COR';
            TableRelation = "Dimension Value".Code where("Dimension Code"=filter('FUNKTION'));

            trigger OnValidate()
            begin
                //>>COR/MIN 081013
                "Funktionskode (Dimension)":=Rec."Funktionskode (Dimension)";
                Modify;
            //<<COR/MIN 081013
            end;
        }
        field(50001; "Trading Partner (Dimension)"; Code[20])
        {
            Description = 'COR';
            TableRelation = "Dimension Value".Code where("Dimension Code"=filter('TRADING PARTNER'));

            trigger OnValidate()
            begin
                //>>COR/MIN 081013
                "Trading Partner (Dimension)":=Rec."Trading Partner (Dimension)";
                Modify;
            //<<COR/MIN 081013
            end;
        }
        field(50002; "Projekt Fase (Dimension)"; Code[20])
        {
            Description = 'COR';
            TableRelation = "Dimension Value".Code where("Dimension Code"=filter('PROJEKT FASE'));
        }
        field(50003; "Bogført"; Boolean)
        {
            Description = 'COR';
        }
    }
    keys
    {
        key(Key1; "Opkrævningsnr.", "Linienr.")
        {
            Clustered = true;
            SumIndexFields = "Beløb", "Tilhøre beløb incl. moms";
        }
        key(Key2; Sats)
        {
        }
        key(Key3; "Debitornr.", "Global Dimension 2 Code", "Bogføringsdato")
        {
        }
        key(Key4; "Ref. Debitorpost")
        {
        }
        key(Key5; "Bogført", "Tilh. Finanskonto/Vare")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        OpsætLinie;
    end;
    var xArt: Integer;
    Hoved: Record "BS-Opkrævningshoved";
    "Navigér": Page Navigate;
    ">> BS2.60.02LA <<": Integer;
    StamOpl: Record "BS-Stamoplysninger";
    local procedure "OpsætLinie"()
    begin
    // Lokal procedure - Anvender globale variable
    // Kode mangler !!
    end;
    procedure FindOprDebitorpost(OPKL: Record "BS-Opkrævningslinie"; var DP: Record "Cust. Ledger Entry"): Boolean begin
        if OPKL."Ref. Debitorpost" = 0 then begin
            DP.Reset;
            DP.SetCurrentkey("Document No.", "Document Type", "Customer No.");
            DP.SetRange("Document Type", DP."document type"::Invoice);
            DP.SetRange("Document No.", OPKL."Bilagsnr.");
            DP.SetRange("Customer No.", OPKL."Debitornr.");
            DP.SetRange("Posting Date", OPKL.Bogføringsdato);
            DP.SetRange("Reason Code", 'BS');
            exit(DP.Find('=<>'));
        end
        else
            exit(DP.Get(OPKL."Ref. Debitorpost"));
    end;
}
