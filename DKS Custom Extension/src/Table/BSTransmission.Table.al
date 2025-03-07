Table 51005 "BS-Transmission"
{
    // // BetalingsService -------------------------------------- >>
    // // ˆ Copyright 1997, 2001 Hands A/S
    //DrillDownPageID = UnknownPage51010;
    //LookupPageID = UnknownPage51010;
    PasteIsValid = false;

    fields
    {
        field(1; "L¢benr."; Integer)
        {
            Description = 'L¢benr.';
            Editable = false;
        }
        field(5; Dato; Date)
        {
            Description = 'Den aktuelle dato';
            Editable = false;
        }
        field(6; Klokkeslet; Time)
        {
            Description = 'Det aktuelle klokkeslet';
            Editable = false;
        }
        field(7; Bruger; Code[50])
        {
            Description = 'Den aktuelle bruger';
            Editable = false;
            TableRelation = User;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(10; Type; Option)
        {
            Description = 'Afsendelse eller modtagelse';
            Editable = true;
            OptionMembers = Afsendelse, Modtagelse;
        }
        field(11; Leverance; Code[10])
        {
            Description = 'Leverancens type : 0601, 0602 etc.';
            Editable = false;
        }
        field(12; "Leverance Dato"; Date)
        {
            Description = 'Overf¢res fra filen ved indlæsning';
        }
        field(13; "Leverance ID"; Code[10])
        {
            Description = 'Overf¢res fra filen ved indlæsning';
        }
        field(15; Information; Text[250])
        {
            Description = 'Beskrivende tekst';
            Editable = false;
        }
        field(20; Status; Option)
        {
            Description = '"Indlæses", "Afsluttet" eller "Afvist"';
            OptionMembers = "Indlæses", Afsluttet, Afvist;
        }
        field(21; Linier; Integer)
        {
            CalcFormula = count("BS-Transmissionsdata" where("Transmissionsløbenr."=field("L¢benr.")));
            Description = 'Antal tilh¢rende detail-linier';
            Editable = false;
            FieldClass = FlowField;
        }
        field(22; "Afvent./Fejllinier"; Boolean)
        {
            CalcFormula = exist("BS-Transmissionsdata" where("Transmissionsløbenr."=field("L¢benr."), "Indlæsning afventer"=const(true)));
            Description = 'Findes der fejllinier ?';
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "L¢benr.")
        {
            Clustered = true;
        }
        key(Key2; Dato, Klokkeslet)
        {
        }
        key(Key3; Bruger, Dato, Klokkeslet)
        {
        }
        key(Key4; "Leverance Dato", "Leverance ID")
        {
        }
        key(Key5; Leverance, "Leverance Dato", "Leverance ID")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        if Confirm('Helt sikker ?')then begin
            Detail.Reset;
            Detail.SetRange("Transmissionsløbenr.", "L¢benr.");
            Detail.DeleteAll;
        end;
    end;
    trigger OnInsert()
    begin
    //ERROR('Der er ikke muligt - manuelt - at tilf¢je records til tabel %1',TABLENAME);
    end;
    trigger OnModify()
    begin
    //ERROR('Der er ikke muligt at redigere records i tabel %1',TABLENAME);
    end;
    trigger OnRename()
    begin
        Error('Omd¢bning er ikke tilladt på tabel %1', TableName);
    end;
    var Detail: Record "BS-Transmissionsdata";
}
