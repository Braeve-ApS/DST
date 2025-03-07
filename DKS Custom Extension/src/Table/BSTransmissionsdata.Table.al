Table 51006 "BS-Transmissionsdata"
{
    // // BetalingsService -------------------------------------- >>
    // // ˆ Copyright 1997, 2001 Hands A/S
    // DrillDownPageID = UnknownPage51011;
    // LookupPageID = UnknownPage51011;
    PasteIsValid = false;

    fields
    {
        field(1; "Transmissionsløbenr."; Integer)
        {
            Editable = false;
            TableRelation = "BS-Transmission";
        }
        field(2; "Linienr."; Integer)
        {
        }
        field(10; Data; Text[128])
        {
        }
        field(20; "Indlæsning afventer"; Boolean)
        {
            Editable = false;
            InitValue = false;
        }
        field(50; "Evt. Bilagsnr."; Code[10])
        {
        }
        field(51; "Evt. Debitorpost"; Integer)
        {
        }
    }
    keys
    {
        key(Key1; "Transmissionsløbenr.", "Linienr.")
        {
            Clustered = true;
        }
        key(Key2; "Indlæsning afventer")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    begin
        Error('Der er ikke muligt - manuelt - at slette records i tabel %1', TableName);
    end;
    trigger OnInsert()
    begin
        Error('Der er ikke muligt - manuelt - at tilf¢je records til tabel %1', TableName);
    end;
    trigger OnModify()
    begin
        Error('Der er ikke muligt at redigere records i tabel %1', TableName);
    end;
    var HelpTxt: Text;
    procedure OpbygBSLinie(Type: Char; "Placering fra": Integer; "Placering til": Integer; "Værdi": Text[128])
    var
        "Feltlængde": Integer;
        I: Integer;
        J: Integer;
    begin
        //Jim - original code
        //WHILE STRLEN(Data) < 128 DO
        //  Data := Data + ' ';
        if("Placering fra" = 0) or ("Placering til" = 0) or ("Placering til" < "Placering fra")then Error('Syntaksfejl:\\Frapos : %1\Tilpos : %2\\Ulovlige værdier.', "Placering fra", "Placering til");
        Feltlængde:=("Placering til" - "Placering fra") + 1;
        if Feltlængde < StrLen(Værdi)then Error('Syntaksfejl:\\Feltlængde : %1\Værdi : %2\Længde : %3\\For lidt plads til værdien.\\%4', Feltlængde, Værdi, StrLen(Værdi), Værdi);
        if Type = 'N' then begin
            for I:=1 to StrLen(Værdi)do if not(Værdi[I]in['0' .. '9'])then Error('Syntaksfejl:\\Værdi : %1\\Numeriske udtryk må kun indeholde tallene fra 0 - 9', Værdi);
            while StrLen(Værdi) < Feltlængde do Værdi:='0' + Værdi;
        end;
        if Type = 'F' then begin
            if StrLen(Værdi) <> 1 then Error('Syntaksfejl:\\Værdi : %1\\Filler udtryk skal indeholde netop 1 tegn', Værdi);
        end;
        //Jim - Original
        // FOR I := 1 TO Feltlængde DO BEGIN
        //  J := "Placering fra" + (I-1);
        //
        //  IF Type <> 'F' THEN
        //    Data[J] := Værdi[I]
        //  ELSE
        //    Data[J] := Værdi[1];
        // END;
        //>>Jim - New Code
        if Type = 'X' then begin
            while(StrLen(Værdi)) < Feltlængde do Værdi:=Værdi + ' ';
        end;
        HelpTxt:=(Format(Værdi[1]));
        if Type <> 'F' then Data+=Værdi
        else
            for I:=1 to Feltlængde do Data+=Værdi;
    //<<
    end;
    procedure BulkFormatDec("Værdi": Decimal): Text[250]begin
        exit(DelChr(Format(Værdi), '=', ' -.,'));
    end;
    procedure BulkFormatTxt("Værdi": Text[250]): Text[250]begin
        exit(DelChr(Værdi, '=', ' -.,'));
    end;
    procedure BulkFormatDate("Værdi": Date): Code[6]var
        "År": Code[2];
        "Måned": Code[2];
        Dag: Code[2];
    begin
        År:=CopyStr(Format(Date2dmy(Værdi, 3)), 3, 2);
        Måned:=Format(Date2dmy(Værdi, 2));
        Dag:=Format(Date2dmy(Værdi, 1));
        while StrLen(År) < 2 do År:='0' + År;
        while StrLen(Måned) < 2 do Måned:='0' + Måned;
        while StrLen(Dag) < 2 do Dag:='0' + Dag;
        exit(Dag + Måned + År);
    end;
}
