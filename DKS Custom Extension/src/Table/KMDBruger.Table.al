Table 50004 "KMD Bruger"
{
    // - 01.02.14
    //   Ny tabel til KMD Lønindlæsning
    DataPerCompany = false;
    LookupPageID = "KMD Brugere";

    fields
    {
        field(1; Ekspeditionsnummer; Integer)
        {
            MinValue = 0;
        }
        field(2; Bruger; Code[10])
        {
            NotBlank = true;
        }
        field(3; Regnskabsnavn; Text[30])
        {
            TableRelation = Company;
        }
        field(5; "Indlæsningsdato"; Date)
        {
            Editable = false;
        }
    }
    keys
    {
        key(Key1; Ekspeditionsnummer)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var range: Text[30];
    i: Integer;
}
