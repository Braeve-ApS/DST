Page 50004 "KMD Brugere"
{
    PageType = List;
    SourceTable = "KMD Bruger";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Ekspeditionsnummer; Rec.Ekspeditionsnummer)
                {
                    ApplicationArea = Basic;
                }
                field(Bruger; Rec.Bruger)
                {
                    ApplicationArea = Basic;
                }
                field(Regnskabsnavn; Rec.Regnskabsnavn)
                {
                    ApplicationArea = Basic;
                }
                field("Indlæsningsdato"; Rec.Indlæsningsdato)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
    actions
    {
    }
}
