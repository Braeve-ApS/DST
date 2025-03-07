Page 51025 "BS Opkrævninger"
{
    // Mangler 2 Actions
    PageType = Card;
    SourceTable = "BS-Opkrævningshoved";
    SourceTableView = sorting("Bogført", "Opkrævningsnr.")where("Bogført"=const(false));

    layout
    {
        area(content)
        {
            group(Generelt)
            {
                field("Opkrævningsnr."; Rec."Opkrævningsnr.")
                {
                    ApplicationArea = Basic;
                }
                field("Debitornr."; Rec."Debitornr.")
                {
                    ApplicationArea = Basic;
                }
                field("Debitorgr."; Rec."Debitorgr.")
                {
                    ApplicationArea = Basic;
                }
                field("Opkrævningsdato"; Rec."Opkrævningsdato")
                {
                    ApplicationArea = Basic;
                }
                field("Bogf¢ringsmetode"; Rec."Bogføringsmetode")
                {
                    ApplicationArea = Basic;
                }
                field(Bilagsmetode; Rec.Bilagsmetode)
                {
                    ApplicationArea = Basic;
                }
                field("Opkrævningsbel¢b"; Rec."Opkrævningsbeløb")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Fakturering)
            {
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                    Enabled = DimensionsEnabled;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                    Enabled = DimensionsEnabled;
                }
                field("Funktionskode (Dimension)"; Rec."Funktionskode (Dimension)")
                {
                    ApplicationArea = Basic;
                    Enabled = DimensionsEnabled;
                }
                field("Trading Partner (Dimension)"; Rec."Trading Partner (Dimension)")
                {
                    ApplicationArea = Basic;
                    Enabled = DimensionsEnabled;
                }
                field("Projekt Fase (Dimension)"; Rec."Projekt Fase (Dimension)")
                {
                    ApplicationArea = Basic;
                    Enabled = DimensionsEnabled;
                }
                field("Sælgerkode"; Rec."Sælgerkode")
                {
                    ApplicationArea = Basic;
                    Enabled = DimensionsEnabled;
                }
                field("Bogf¢ringsdato"; Rec."Bogføringsdato")
                {
                    ApplicationArea = Basic;
                    Enabled = DimensionsEnabled;
                }
                field(Bilagsdato; Rec.Bilagsdato)
                {
                    ApplicationArea = Basic;
                    Enabled = DimensionsEnabled;
                }
                field(Forfaldsdato; Rec.Forfaldsdato)
                {
                    ApplicationArea = Basic;
                    Enabled = DimensionsEnabled;
                }
            }
            part(Control1000000019; "BS OpkrævningsLinier")
            {
                ApplicationArea = Basic;
                SubPageLink = "Opkrævningsnr."=field("Opkrævningsnr.");
                SubPageView = sorting("Opkrævningsnr.", "Linienr.");
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(OpretOpkraevninger)
            {
                ApplicationArea = Basic;
                Caption = 'Opret Opkrævninger';
                Image = CreateDocuments;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "BS Dan Opkrævninger";
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        InfoUpdate;
    end;
    trigger OnAfterGetRecord()
    begin
        InfoUpdate;
    end;
    trigger OnOpenPage()
    begin
        InfoUpdate;
    end;
    var Stamopl: Record "BS-Stamoplysninger";
    Opkh: Record "BS-Opkrævningshoved";
    Opkl: Record "BS-Opkrævningslinie";
    "Første": Text[30];
    DimensionsEnabled: Boolean;
    procedure InfoUpdate()
    begin
        DimensionsEnabled:=Rec.Bilagsmetode = Rec.Bilagsmetode::"Et bilag pr. opkrævning";
    end;
}
