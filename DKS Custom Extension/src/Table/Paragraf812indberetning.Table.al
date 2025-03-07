Table 50001 "Paragraf 8+12 indberetning"
{
    fields
    {
        field(1; Type; Option)
        {
            OptionMembers = Item, Customer;
        }
        field(5; Nummer; Code[20])
        {
        }
        field(10; Navn; Text[50])
        {
        }
        field(20; "Cpr-Nr"; Code[12])
        {
        }
        field(30; "Paragraf 8"; Decimal)
        {
        }
        field(40; "Paragraf 12"; Decimal)
        {
        }
        field(50; Salesamount; Decimal)
        {
            Caption = 'Salgsbeløb';
        }
        field(60; "Date Filter"; Text[50])
        {
            Caption = 'Datofilter';
        }
    }
    keys
    {
        key(Key1; Type, Nummer)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
