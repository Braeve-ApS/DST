Page 51004 "BS Betalingsaftaleposter"
{
    PageType = List;
    SourceTable = 51011;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Transmission; Rec.Transmission)
                {
                    ApplicationArea = Basic;
                }
                field(Dato; Rec.Dato)
                {
                    ApplicationArea = Basic;
                }
                field(Tid; Rec.Tid)
                {
                    ApplicationArea = Basic;
                }
                field(Bruger; Rec.Bruger)
                {
                    ApplicationArea = Basic;
                }
                field(Aktivitet; Rec.Aktivitet)
                {
                    ApplicationArea = Basic;
                }
                field(Beskrivelse; Rec.Beskrivelse)
                {
                    ApplicationArea = Basic;
                }
                field("Evt. Opkrævningsnr."; Rec."Evt. Opkrævningsnr.")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Transmissionslog)
            {
                ApplicationArea = Basic;
                Image = TaxDetail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Ctrl+F7';

                trigger OnAction()
                var
                    Trans: Record 51005;
                    TransL: Record 51006;
                begin
                    Trans.ClearMarks;
                    Trans.Reset;
                    Trans.Get(Rec.Transmission);
                    Trans.Mark(true);
                    TransL.ClearMarks;
                    TransL.Reset;
                    TransL.Get(Rec.Transmission, Rec."første Transmissionslinie");
                    TransL.Mark(true);
                    Page.RunModal(51010, Trans);
                end;
            }
            action(Transmissionsdetaljer)
            {
                ApplicationArea = Basic;
                Image = ViewDetails;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    TransL: Record 51006;
                begin
                    TransL.Reset;
                    TransL.SetRange("Transmissionsløbenr.", Rec.Transmission);
                    TransL.SetRange("Linienr.", Rec."Første Transmissionslinie", Rec."Sidste Transmissionslinie");
                    Page.Run(51011, TransL);
                end;
            }
        }
    }
}
