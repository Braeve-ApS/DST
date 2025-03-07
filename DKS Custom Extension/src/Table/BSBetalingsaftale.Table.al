Table 51008 "BS-Betalingsaftale"
{
    fields
    {
        field(1; "Debitornr."; Code[20])
        {
            NotBlank = true;
            TableRelation = Customer;

            trigger OnValidate()
            begin
                /*BS2.60.03*/
                if xRec."Debitornr." <> '' then Error('%1 kan kun ændres ved oprettelse. Slet linien og opret på ny.', FieldName("Debitornr."));
                Stamoplysninger.Get;
                Debitor.Get("Debitornr.");
                if Stamoplysninger."Debitorgr. min. værdi" = Stamoplysninger."Debitorgr. max. værdi" then Validate("Debitorgr.", Stamoplysninger."Debitorgr. min. værdi");
                if Debitor."VAT Registration No." <> '' then if Stamoplysninger."Validér CVR-Nummer"(Debitor."VAT Registration No.", true, false)then Validate("CPR-/CVR-Nr.", Debitor."VAT Registration No.");
            end;
        }
        field(2; "Debitorgr."; Integer)
        {
            MaxValue = 99999;
            MinValue = 1;
            NotBlank = true;

            trigger OnValidate()
            begin
                //>>COR/MIN 110714
                /*
                {BS2.60.03 >>}
                IF xRec."Debitorgr." <> 0 THEN
                  ERROR(
                    '%1 kan kun ændres ved oprettelse. Slet linien og opret på ny.',
                    FIELDNAME("Debitorgr."));
                {<< BS2.60.03}
                */
                //MESSAGE('Ved ændring af debitorgruppenr - husk at oprette nye BS-specifikationer eller kommer debitoren ikke med i oprettelsen?');
                //<<COR/MIN 110714
                //>>COR/MIN 180814
                /*
                CLEAR(BSSpecifikation);
                BSSpecifikation.SETRANGE("Debitornr.","Debitornr.");
                BSSpecifikation.MODIFYALL("Debitorgr.","Debitorgr.");
                CLEAR(BSSpecifkationstekst);
                BSSpecifkationstekst.SETRANGE("Debitornr.","Debitornr.");
                BSSpecifkationstekst.MODIFYALL("Debitorgr.","Debitorgr.");
                */
                Clear(BSSpecifikation);
                BSSpecifikation.SetRange("Debitornr.", "Debitornr.");
                if BSSpecifikation.FindFirst then begin
                    //BSSpecifikation."Debitorgr." := "Debitorgr.";
                    BSSpecifikation2:=BSSpecifikation;
                    BSSpecifikation2.Rename(BSSpecifikation."Debitornr.", "Debitorgr.", BSSpecifikation.Kode);
                end;
                Clear(BSSpecifkationstekst);
                BSSpecifkationstekst.SetRange("Debitornr.", "Debitornr.");
                if BSSpecifkationstekst.FindFirst then repeat BSSpecifkationstekst2:=BSSpecifkationstekst;
                        BSSpecifkationstekst2.Rename("Debitornr.", "Debitorgr.", BSSpecifkationstekst.Specifikationskode, BSSpecifkationstekst."Linienr.");
                    until BSSpecifkationstekst.Next = 0;
                //<<COR/MIN 180814
                Stamoplysninger.Get;
                if "Debitorgr." < Stamoplysninger."Debitorgr. min. værdi" then Error('%1 skal mindst være %2', FieldName("Debitorgr."), Stamoplysninger."Debitorgr. min. værdi");
                if "Debitorgr." > Stamoplysninger."Debitorgr. max. værdi" then Error('%1 må højest være %2', FieldName("Debitorgr."), Stamoplysninger."Debitorgr. max. værdi");
            end;
        }
        field(5; "CPR-/CVR-Nr."; Code[10])
        {
            trigger OnValidate()
            var
                BSAftale: Record "BS-Betalingsaftale";
                lCustomer: Record Customer;
            begin
                if "CPR-/CVR-Nr." <> '' then begin
                    Stamoplysninger."Validér CPR-/CVR-Nummer"("CPR-/CVR-Nr.", false, false);
                    // Dubletkontrol {2.50.02}
                    Stamoplysninger.Find('-');
                    if Stamoplysninger."Dubletkontrol på CPR/CVR-Nr." then begin
                        BSAftale.Reset;
                        BSAftale.SetCurrentkey("CPR-/CVR-Nr.");
                        BSAftale.SetRange("CPR-/CVR-Nr.", "CPR-/CVR-Nr.");
                        if BSAftale.Find('=><')then Error('Der findes allerede en Betalingsaftale (Debitor ''%1'') med %2 ''%3'' !', BSAftale."Debitornr.", BSAftale.FieldName("CPR-/CVR-Nr."), BSAftale."CPR-/CVR-Nr.");
                    end;
                end;
                if "CPR-/CVR-Nr." <> '' then if lCustomer.Get("Debitornr.")then begin
                        lCustomer.Validate("Social Security No.", "CPR-/CVR-Nr.");
                        lCustomer.Modify;
                    end;
            end;
        }
        field(10; Bankkonto; Code[10])
        {
            TableRelation = "Customer Bank Account".Code where("Customer No."=field("Debitornr."));

            trigger OnLookup()
            var
                DebBank: Record "Customer Bank Account";
                form_Bankkonto: Page "Customer Bank Account Card";
            begin
                DebBank.Reset;
                DebBank.SetRange("Customer No.", "Debitornr.");
                /*BS2.60.03 >>*/
                if Bankkonto <> '' then begin
                    DebBank.Get("Debitornr.", Bankkonto);
                    form_Bankkonto.SetRecord(DebBank);
                    form_Bankkonto.SetTableview(DebBank);
                end
                else if DebBank.Find('-')then begin
                        form_Bankkonto.SetRecord(DebBank);
                        form_Bankkonto.SetTableview(DebBank);
                    end;
                form_Bankkonto.LookupMode(true);
                if form_Bankkonto.RunModal = Action::LookupOK then Validate(Bankkonto, DebBank.Code);
            /*<< BS2.60.03*/
            end;
        }
        field(11; "Tillad aut. tilmelding"; Boolean)
        {
            trigger OnValidate()
            begin
                if "Tillad aut. tilmelding" then Message('Tilmelding af en Debitor til PBS BetalingsService forudsætter skriftlig tilladelse !\' + 'Har en kundes betalingsaftale været afmeldt siden sidste tilladelse, skal denne generhverves !\\' + 'Ved at svare "Ja" i dette felt angiver du at denne tilladelse foreligger.\\' + 'Feltet nulstilles når næste ajourføringskørsel gennemføres.');
            end;
        }
        field(15; Aktiv; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."Anvender BetalingsService" WHERE("No."=FIELD("Debitornr.")));
        }
        field(16; "PBS Status"; Option)
        {
            Editable = false;
            OptionMembers = "Under tilmelding", Tilmeldt, Inaktiv;
        }
        field(17; "PBS Dato"; Date)
        {
            Editable = false;
        }
        field(31; "Aftalenr."; Code[9])
        {
            Editable = false;
            Numeric = true;
        }
        field(35; "Ikrafttrædelsesdato"; Date)
        {
            Editable = false;
        }
        field(36; Afmeldingsdato; Date)
        {
            Editable = false;
        }
        field(60; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Description = 'COR';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
        }
        field(61; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Description = 'COR';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(2));
        }
        field(95; Aftaler; Integer)
        {
            CalcFormula = count("BS-Specifikation" where("Debitornr."=field("Debitornr."), "Debitorgr."=field("Debitorgr.")));
            Description = 'Flowfield';
            Editable = false;
            FieldClass = FlowField;
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
        field(60000; "Gammel Aftale"; Integer)
        {
        }
    }
    keys
    {
        key(Key1; "Debitornr.", "Debitorgr.")
        {
            Clustered = true;
        }
        key(Key2; "CPR-/CVR-Nr.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        //"DeaktiveringOk?"('Betalingsaftalen kan ikke slettes !');
        Specifikation.Reset;
        Specifikation.SetRange("Debitornr.", "Debitornr.");
        Specifikation.SetRange("Debitorgr.", "Debitorgr.");
        Specifikation.DeleteAll;
        Specifikationstekst.Reset;
        Specifikationstekst.SetRange("Debitornr.", "Debitornr.");
        Specifikationstekst.SetRange("Debitorgr.", "Debitorgr.");
        Specifikationstekst.DeleteAll;
        OpkrævningsHoved.Reset;
        OpkrævningsHoved.SetRange("Debitornr.", "Debitornr.");
        OpkrævningsHoved.SetRange("Debitorgr.", "Debitorgr.");
        OpkrævningsLinie.Reset;
        if OpkrævningsHoved.Find('-')then repeat OpkrævningsLinie.SetRange("Opkrævningsnr.", OpkrævningsHoved."Opkrævningsnr.");
                OpkrævningsLinie.DeleteAll;
            until OpkrævningsHoved.Next = 0;
        OpkrævningsHoved.DeleteAll;
    end;
    trigger OnInsert()
    begin
        "PBS Status":="pbs status"::Inaktiv;
    end;
    var Debitor: Record Customer;
    Stamoplysninger: Record "BS-Stamoplysninger";
    Specifikation: Record "BS-Specifikation";
    Specifikationstekst: Record "BS-Specifkationstekst";
    "OpkrævningsHoved": Record "BS-Opkrævningshoved";
    "OpkrævningsLinie": Record "BS-Opkrævningslinie";
    BSSpecifikation: Record "BS-Specifikation";
    BSSpecifikation2: Record "BS-Specifikation";
    BSSpecifkationstekst: Record "BS-Specifkationstekst";
    BSSpecifkationstekst2: Record "BS-Specifkationstekst";
    local procedure "DeaktiveringOk?"(Fejltekst: Text[80])
    begin
        // Lokal Procedure - Anvender globale parametre
        OpkrævningsHoved.Reset;
        OpkrævningsHoved.SetCurrentkey("Debitornr.", "Debitorgr.");
        OpkrævningsHoved.SetRange("Debitornr.", "Debitornr.");
        OpkrævningsHoved.SetRange("Debitorgr.", "Debitorgr.");
        OpkrævningsHoved.SetRange(Bogført, false);
        if OpkrævningsHoved.Find('=<>')then //>>COR/IMT 040316
 if not Confirm('Der ligger aktive opkrævninger.\Skal Debitor slettes J/N', false)then //<<COR/IMT 040316
 Error(Fejltekst + '\\' + 'Der ligger aktive opkrævninger.');
        OpkrævningsHoved.SetRange(Bogført, true);
        OpkrævningsHoved.SetRange(Afsluttet, false);
        if OpkrævningsHoved.Find('=<>')then Error(Fejltekst + '\\' + 'Der findes stadig uafsluttede opkrævninger.');
    end;
}
