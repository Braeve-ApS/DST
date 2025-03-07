Table 51011 "BS-Betalingsaftalepost"
{
    // // BetalingsService -------------------------------------- >>
    // // ˆ Copyright 1997, 2001 Hands A/S
    PasteIsValid = false;

    fields
    {
        field(1; "Debitornr."; Code[20])
        {
            TableRelation = Customer;
        }
        field(2; "Debitorgr."; Integer)
        {
        }
        field(3; "Løbenr."; Integer)
        {
        }
        field(5; Dato; Date)
        {
        }
        field(6; Tid; Time)
        {
        }
        field(7; Bruger; Code[50])
        {
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(10; Transmission; Integer)
        {
        //TableRelation = "BS-Transmission";
        }
        field(11; "Første Transmissionslinie"; Integer)
        {
        //TableRelation = "BS-Transmissionsdata"."Linienr." where ("Transmissionsl¢benr."=field(Transmission));
        }
        field(12; "Sidste Transmissionslinie"; Integer)
        {
        }
        field(15; Aktivitet; Option)
        {
            OptionMembers = "Bemærkning", Fejl, "Opkrævning", Indbetaling, Tilmelding, Afmelding, "Stop af betaling";
        }
        field(20; Beskrivelse; Text[80])
        {
        }
        field(30; "Evt. Opkrævningsnr."; Code[9])
        {
            TableRelation = "BS-Opkrævningshoved";
        }
        field(31; "Evt. Debitorpost løbenr."; Integer)
        {
            Enabled = false;
            TableRelation = "Cust. Ledger Entry"."Entry No.";
        }
        field(40; "Post indsat af"; Text[80])
        {
        }
        field(90; Leverancetype; Code[10])
        {
            //CalcFormula = lookup("BS-Transmission".Leverance where ("L¢benr."=field(Transmission)));
            Editable = false;
        //FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "Debitornr.", "Debitorgr.", "Løbenr.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    procedure "Tildel løbenr."()"NytLøbenr": Integer var
        Aftalepost: Record "BS-Betalingsaftalepost";
    begin
        Aftalepost.Reset;
        Aftalepost.SetRange("Debitornr.", "Debitornr.");
        Aftalepost.SetRange("Debitorgr.", "Debitorgr.");
        if Aftalepost.FindLast()then "Løbenr.":=Aftalepost."Løbenr." + 1
        else
            "Løbenr.":=1;
        "NytLøbenr":="Løbenr.";
    end;
}
