Table 50020 "Pronestor indlæsning"
{
    // COR/JKA 230511 : Created
    // COR/JKA 200112 : New Field "Description"
    // DST001/030717/Jim: DateTime OrderDate
    Caption = 'Pronestor indlæsning';

    fields
    {
        field(1; EntryNo; Integer)
        {
            Caption = 'EntryNo';
        }
        field(2; "Debitor navn"; Text[30])
        {
        }
        field(4; Betalingsnote; Text[30])
        {
        }
        field(8; "Pris incl. moms"; Decimal)
        {
        }
        field(9; "Bemærkninger"; Text[250])
        {
        }
        field(10; Debitornummer; Code[20])
        {
        }
        field(12; "Mødetype (intern/ekstern)"; Text[20])
        {
        }
        field(13; "Møde ID"; Text[30])
        {
        }
        field(14; Varenummer; Code[20])
        {
        }
        field(15; Antal; Decimal)
        {
        }
        field(30; Ordredato; Date)
        {
        }
        field(36; "Bogf.dato"; Date)
        {
        }
        field(40; "Bestiller/Projekt nr."; Text[80])
        {
        }
        field(95; Fejl; Boolean)
        {
        }
        field(96; "Fejl oplysning"; Text[80])
        {
        }
        field(100; OrdredatoDT; DateTime)
        {
            Description = 'DST001';
        }
    }
    keys
    {
        key(Key1; EntryNo)
        {
            Clustered = true;
        }
        key(Key2; Debitornummer, Betalingsnote, Ordredato)
        {
        }
        key(Key3; Debitornummer, "Møde ID", Ordredato)
        {
        }
    }
    fieldgroups
    {
    }
}
