Table 51004 "BS-Ajourføringslinie"
{
    fields
    {
        field(2; "Linienr."; Integer)
        {
        }
        field(10; "Ajourføringsart"; Option)
        {
            OptionMembers = "Ny aftale", "Aftaleophør", "Stop af betaling";

            trigger OnValidate()
            begin
                if "Ajourføringsart" <> "Ajourføringsart"::"Stop af betaling" then Clear(Betalingsdato);
            end;
        }
        field(11; "Debitornr."; Code[20])
        {
            TableRelation = Customer;

            trigger OnValidate()
            begin
                if "Debitornr." = '' then begin
                    Clear("Debitorgr.");
                end
                else
                begin
                    Betalingsaftale.Reset;
                    Betalingsaftale.SetRange("Debitornr.", "Debitornr.");
                    if Page.RunModal(Page::"BS Betalingsaftale", Betalingsaftale) = Action::LookupOK then "Debitorgr.":=Betalingsaftale."Debitorgr."
                    else
                        Message('%1 skal indtastes manuelt', Betalingsaftale.FieldName("Debitorgr."));
                end;
            end;
        }
        field(12; "Debitorgr."; Integer)
        {
            MaxValue = 99999;
            MinValue = 0;
        }
        field(15; Betalingsdato; Date)
        {
            trigger OnValidate()
            begin
                TestField("Ajourføringsart", "Ajourføringsart"::"Stop af betaling");
                TestField("Debitornr.");
                TestField("Debitorgr.");
                Betalingsaftale.Get("Debitornr.", "Debitorgr.");
                if(Betalingsaftale."Aftalenr." = '') or (Betalingsaftale."Aftalenr." = '000000000')then Error('Betalingsaftale %1 - %2 har intet Aftalenr.\\' + 'PBS kan kun stoppe betalinger på aftaler med tilknyttet aftalenummer.\\' + 'Bestil leverancen "0603 - Aftaleoplysninger fra BetalingsService" hos PBS,\' + 'og indlæs denne f¢r der fors¢ges igen.', Betalingsaftale."Debitornr.", Betalingsaftale."Debitorgr.");
            end;
        }
        field(85; "Fejl i kundenr."; Boolean)
        {
            Editable = false;
        }
        field(90; Systemoprettelse; Boolean)
        {
            Editable = false;
        }
        field(95; Rettelsesreference; Integer)
        {
            Description = 'Udfyldes ved rettelser for at undgå fejl ifm. tilmelding af en "aktiv" aftale';
            TableRelation = "BS-Ajourføringslinie";
        }
    }
    keys
    {
        key(Key1; "Linienr.")
        {
            Clustered = true;
        }
        key(Key2; "Ajourføringsart")
        {
        }
        key(Key3; "Debitornr.", "Debitorgr.")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        if Systemoprettelse then Error('Denne ajour¢ring er oprettet af systemet og kan ikke vedligeholdes manuelt');
    end;
    trigger OnModify()
    begin
        if Systemoprettelse then Error('Denne ajour¢ring er oprettet af systemet og kan ikke vedligeholdes manuelt');
    end;
    trigger OnRename()
    begin
        Error('%1 kan ikke omd¢bes', TableName);
    end;
    var Stamoplysninger: Record "BS-Stamoplysninger";
    Specifikation: Record "BS-Specifikation";
    Betalingsaftale: Record "BS-Betalingsaftale";
    Debitor: Record Customer;
    local procedure "Initiér"()
    var
        Rec2: Record "BS-Ajourføringslinie";
    begin
        // Lokal procedure - Anvender globale variable
        Rec2.Reset;
        if Rec2.FindLast()then "Linienr.":=Rec2."Linienr." + 10000
        else
            Rec2."Linienr.":=10000 end;
}
