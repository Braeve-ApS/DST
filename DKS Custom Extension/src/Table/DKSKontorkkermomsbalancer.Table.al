Table 50019 "DKS Kontorækker momsbalancer"
{
    fields
    {
        field(1; "Rækkefølge"; Integer)
        {
        }
        field(2; Beskrivelse; Text[30])
        {
        }
        field(3; Kontofilter; Code[180])
        {
        }
        field(4; Type; Option)
        {
            InitValue = Rapportgruppering;
            OptionMembers = "Resultatopg Fra-Til", Rapportgruppering;
        }
    }
    keys
    {
        key(Key1; Type, "Rækkefølge")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if Type = 0 then if Rækkefølge <> 0 THEN Error('Records af typen %1 skal have værdien 0 i feltet Rækkefølge!', Format(Type));
    end;
    var Rec2: Record "DKS Kontorækker momsbalancer";
}
