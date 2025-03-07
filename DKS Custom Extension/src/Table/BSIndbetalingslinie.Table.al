Table 51003 "BS-Indbetalingslinie"
{
    fields
    {
        field(1; "Linienr."; Integer)
        {
        }
        field(2; "Opkrævningsnr."; Code[9])
        {
        }
        field(3; Transmission; Integer)
        {
        //TableRelation = "BS-Transmission";
        }
        field(4; Transmissionslinie; Integer)
        {
        //TableRelation = "BS-Transmissionsdata"."Linienr." where ("Transmissionsl¢benr."=field(Transmission));
        }
        field(11; "Debitornr."; Code[20])
        {
            TableRelation = Customer;
        }
        field(15; "Debitorgr."; Integer)
        {
            MaxValue = 99999;
            MinValue = 1;
        }
        field(16; "BS-Aftalenr."; Code[9])
        {
        }
        field(17; "BS-Bogf¢ringsdato"; Date)
        {
        }
        field(20; Forfaldsdato; Date)
        {
        }
        field(21; "Opkrævet bel¢b"; Decimal)
        {
        }
        field(25; Indbetalingsdato; Date)
        {
        }
        field(26; "Indbetalt bel¢b"; Decimal)
        {
        }
        field(30; "Bemærkningstekst"; Text[80])
        {
        }
        field(35; Gebyr; Decimal)
        {
        }
        field(40; Transaktionsart; Option)
        {
            OptionMembers = "Automatisk betaling", "Ikke adviseret betaling", "Afmeldt betaling", "FI-betaling";
        }
        field(41; Transaktionstype; Option)
        {
            OptionMembers = , "Gennemf¢rt", Afvist, Afmeldt, "Tilbagef¢rt";
        }
        field(42; Fejl; Boolean)
        {
        }
        field(43; Fejlbeskrivelse; Text[80])
        {
        }
        field(50; "Tilh. Debitorpostl¢benr."; Integer)
        {
        }
        field(51; "Tilh. Opkrævningsnr."; Code[9])
        {
        }
        field(52; "Tilh. Bilagsnr."; Code[10])
        {
        }
        field(53; "Tilh. Bilagsdato"; Date)
        {
        }
    }
    keys
    {
        key(Key1; "Opkrævningsnr.", "Linienr.")
        {
            Clustered = true;
        }
        key(Key2; "Debitornr.", "Debitorgr.")
        {
        }
        key(Key3; Transmission, Transmissionslinie)
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        TestField("Opkrævningsnr.", '');
    end;
    var AftaleHoved: Record "BS-Specifikation";
    procedure "Hent og bogf¢r Indbetalinger"()
    var
        "BS-Indbetalingslinie": Record "BS-Indbetalingslinie";
    //TransRec: Record UnknownRecord51005;
    begin
    /* "BS-Indbetalingslinie".Reset;

         with "BS-Indbetalingslinie" do begin
           SetRange("Opkrævningsnr.",'');
           DeleteAll;

           TransRec.Reset;
           TransRec.SetRange(Type,TransRec.Type::Modtagelse);
           TransRec.SetRange(Leverance,'0602');
           TransRec.SetRange(Status,TransRec.Status::Indlæses);
           if TransRec.Find('=<>') then begin
             Codeunit.Run(Codeunit::"Opret Indbetalingskladde",TransRec);

             Reset; LockTable;
             SetRange("Opkrævningsnr.",'');

             if not Find('=<>') then begin
               Message('Den seneste indlæsning indeholdt ingen linier.\'+
                       'Indlæsningen afsluttes.');
               TransRec.Status := TransRec.Status::Afsluttet;
               TransRec.Modify;
               exit;
             end;

             SetRange(Fejl,true);
             if Find('=<>') then begin
               Message('Bogf¢ringen blev afbrudt, da én eller flere indbetalinger ikke var gyldig.\'+
                       'Se kladdens fejltekst for nærmere forklaring, ret fejlen og pr¢v igen.');
               exit;
             end;

             SetRange(Fejl);
             Commit;
             Codeunit.Run(Codeunit::"Bogfør Indbetalingskladde");
             TransRec.Status := TransRec.Status::Afsluttet;
             TransRec.Modify;
           end else
             Error('Der fandtes ingen uafsluttede indbetalinger');
         end; */
    end;
}
