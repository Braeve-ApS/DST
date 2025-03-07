Table 51001 "BS-Specifkationstekst"
{
    fields
    {
        field(1; "Debitornr."; Code[20])
        {
            TableRelation = Customer;
        }
        field(3; Specifikationskode; Code[10])
        {
            NotBlank = true;
        }
        field(4; "Linienr."; Integer)
        {
        }
        field(5; "Debitorgr."; Integer)
        {
            MaxValue = 99999;
            MinValue = 1;
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
                    "Debitornr.":=xRec."Debitornr.";
                    "Debitorgr.":=xRec."Debitorgr.";
                    Specifikationskode:=xRec.Specifikationskode;
                    "Linienr.":=xRec."Linienr.";
                    Art:=xArt;
                    if Art = Art::Advisering then HentDimensioner;
                end;
            end;
        }
        field(15; Sats; Code[10])
        {
            trigger OnValidate()
            begin
                if Sats <> '' then TestField(Art, Art::Advisering)
                else
                begin
                    Clear(Beløb);
                    Clear("Tilh. Finanskonto/Vare");
                end;
            end;
        }
        field(16; "Beskrivelse Formateret"; Text[60])
        {
            trigger OnValidate()
            begin
                // >> BS2.60.03 >>
                if StrLen("Beskrivelse Formateret") > 38 then begin
                    StamOpl.Find('-');
                    if StamOpl.Adviseringstype = StamOpl.Adviseringstype::"Kort (38 tegn)" then Error('Når den valgte %1 er ''%2'', kan der maksimalt indtastes 38 tegn i dette felt.', StamOpl.FieldName(Adviseringstype), StamOpl.Adviseringstype);
                end;
            // << BS2.60.03 <<
            end;
        }
        field(17; Beskrivelse; Text[27])
        {
            Description = 'Maximalt 27 tegn';
        }
        field(20; "Tilh. Finanskonto/Vare"; Code[20])
        {
            TableRelation = if("Tilhøre type"=const(Finans))"G/L Account"
            else if("Tilhøre type"=const(Vare))Item;

            trigger OnValidate()
            var
                lSalgshoved: Record "Sales Header";
                lSalgslinie: Record "Sales Line";
                "//CITPMAK": Integer;
                ItemRec: Record Item;
                SalesPost: Codeunit "Sales-Post";
                TempSalesLine: Record "Sales Line";
                TotalSalesLineLCY: Record "Sales Line";
                VATAmount: Decimal;
                VATAmountText: Text[30];
                ProfitLCY: Decimal;
                ProfitPct: Decimal;
                TotalAmount2: Decimal;
                TotalAmount1: Decimal;
                TotalSalesLine: Record "Sales Line";
                Item: Record Item;
            begin
                if "Tilh. Finanskonto/Vare" <> '' then begin
                    TestField(Art, Art::Advisering);
                    // DT/OG 28.02.05 >>
                    if "Tilhøre type" = "tilhøre type"::Finans then begin
                        // DT/OG 28.02.05 <<
                        Finanskonto.Reset;
                        Finanskonto.Get("Tilh. Finanskonto/Vare");
                        Finanskonto.TestField("Account Type", Finanskonto."account type"::Posting);
                    // DT/OG 28.02.05 >>
                    end
                    else
                    begin
                        lSalgshoved.Init;
                        lSalgshoved."Document Type":=lSalgslinie."document type"::Invoice;
                        lSalgshoved."No.":='XXXXX';
                        lSalgshoved.Validate("Sell-to Customer No.", "Debitornr.");
                        lSalgshoved.Insert;
                        lSalgslinie.Init;
                        lSalgslinie."Document Type":=lSalgslinie."document type"::Invoice;
                        lSalgslinie."Document No.":='XXXXX';
                        lSalgslinie.Validate("Sell-to Customer No.", "Debitornr.");
                        lSalgslinie.Validate(Type, lSalgslinie.Type::Item);
                        lSalgslinie.Validate("No.", "Tilh. Finanskonto/Vare");
                        lSalgslinie.Validate(Quantity, 1);
                        // CITP 291106 ->
                        //Beløb := lSalgslinie."Amount Including VAT";
                        Beløb:=lSalgslinie."Line Amount";
                        // <- CITP 291106
                        lSalgshoved.Delete;
                        //>>DST001
                        if "Tilhøre type" = "tilhøre type"::Vare then begin
                            if Item.Get("Tilh. Finanskonto/Vare")then Beskrivelse:=CopyStr(Item.Description, 1, 27);
                        end;
                    //<<DST001
                    end;
                // DT/OG 28.02.05 <<
                end;
            end;
        }
        field(25; "Beløb"; Decimal)
        {
            trigger OnValidate()
            begin
                if Beløb <> 0 THEN TestField(Art, Art::Advisering);
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

            trigger OnValidate()
            begin
                if Sælgerkode <> '' then /*BS2.50.03*/ TestField(Art, Art::Advisering); /*BS2.50.03*/
            end;
        }
        field(63; "Tilhøre type"; Option)
        {
            OptionMembers = Finans, Vare;
        }
    }
    keys
    {
        key(Key1; "Debitornr.", "Debitorgr.", Specifikationskode, "Linienr.")
        {
            Clustered = true;
        }
        key(Key2; Sats)
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
    //Konv 2017
    /*
        IF "Debitornr." <> '' THEN BEGIN
          Specifikation.GET("Debitornr.","Debitorgr.",Specifikationskode);
          IF Specifikation.Fællesskabelon <> '' THEN
            ERROR(
              'Der kan ikke oprettes linier til specifikation %1.\'+
              'Specifikationen er tilknyttet Fællesskabelon %2 !',
              Specifikationskode,
              Specifikation.Fællesskabelon);
        END;
        
        IF Art = Art::Advisering THEN
          HentDimensioner;
        */
    end;
    var xArt: Integer;
    Specifikation: Record "BS-Specifikation";
    Finanskonto: Record "G/L Account";
    ">> BS2.60.02LA <<": Integer;
    StamOpl: Record "BS-Stamoplysninger";
    local procedure HentDimensioner()
    begin
        // Lokal procedure - Anvender globale variable
        Specifikation.Get("Debitornr.", "Debitorgr.", Specifikationskode);
        if "Global Dimension 1 Code" = '' then Validate("Global Dimension 1 Code", Specifikation."Global Dimension 1 Code");
        if "Global Dimension 2 Code" = '' then Validate("Global Dimension 2 Code", Specifikation."Global Dimension 2 Code");
        if Sælgerkode = '' then Validate(Sælgerkode, Specifikation.Sælgerkode);
    end;
}
