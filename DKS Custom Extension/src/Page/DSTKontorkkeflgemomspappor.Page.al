page 50009 "DST Kontorækkefølge momspappor"
{
    ApplicationArea = All;
    Caption = 'DST Kontorækkefølge momspappor';
    PageType = List;
    SourceTable = "DKS Kontorækker momsbalancer";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Type"; Rec."Type")
                {
                    ToolTip = 'Specifies the value of the Type field.';
                }
                field("Rækkefølge"; Rec."Rækkefølge")
                {
                    ToolTip = 'Specifies the value of the Rækkefølge field.';
                }
                field(Beskrivelse; Rec.Beskrivelse)
                {
                    ToolTip = 'Specifies the value of the Beskrivelse field.';
                }
                field(Kontofilter; Rec.Kontofilter)
                {
                    ToolTip = 'Specifies the value of the Kontofilter field.';
                }
            }
        }
    }
}
