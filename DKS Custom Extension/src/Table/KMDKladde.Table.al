Table 50005 "KMD Kladde"
{
    // - 01.02.15
    //   Ny tabel til KMD Lønindlæsning
    DataPerCompany = false;
    LookupPageID = "KMD Kladde";

    fields
    {
        field(1; Bruger; Code[10])
        {
        }
        field(2; Regnskabsnavn; Text[30])
        {
            TableRelation = Company;
        }
        field(3; "Indlæsningsdato"; Date)
        {
            Editable = false;
        }
        field(6; Linienummer; Integer)
        {
        }
        field(7; "Kontonr."; Code[20])
        {
            TableRelation = "G/L Account";
        }
        field(8; "Bogføringsdato"; Date)
        {
            ClosingDates = true;
        }
        field(9; "Bilagsnr."; Code[20])
        {
        }
        field(10; Beskrivelse; Text[50])
        {
        }
        field(11; "Beløb"; Decimal)
        {
            AutoFormatType = 1;
        }
    }
    keys
    {
        key(Key1; Linienummer)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var KladdetypeRec: Record "Gen. Journal Template";
    KladdeNavnRec: Record "Gen. Journal Batch";
}
