Page 50005 "KMD Kladde"
{
    PageType = Worksheet;
    SourceTable = "KMD Kladde";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Linienummer; Rec.Linienummer)
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
                field("Bogføringsdato"; rec."Bogføringsdato")
                {
                    ApplicationArea = Basic;
                }
                field("Bilagsnr."; Rec."Bilagsnr.")
                {
                    ApplicationArea = Basic;
                }
                field("Kontonr."; Rec."Kontonr.")
                {
                    ApplicationArea = Basic;
                }
                field(Beskrivelse; Rec.Beskrivelse)
                {
                    ApplicationArea = Basic;
                }
                field("Beløb"; rec."Beløb")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
    actions
    {
    }
    trigger OnOpenPage()
    begin
        Rec.FilterGroup(2);
        Rec.SetRange(Regnskabsnavn, COMPANYNAME);
        Rec.FilterGroup(0);
    end;
}
