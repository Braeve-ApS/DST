Page 51027 "BS Bogf. Opkrævninger"
{
    PageType = Card;
    SourceTable = "BS-Opkrævningshoved";
    SourceTableView = sorting("Bogført", "Opkrævningsnr.")where("Bogført"=const(true));

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
                field("Opkrævningsdato"; Rec.Opkrævningsdato)
                {
                    ApplicationArea = Basic;
                }
                field("Bogføringsmetode"; Rec."Bogføringsmetode")
                {
                    ApplicationArea = Basic;
                }
                field(Bilagsmetode; Rec.Bilagsmetode)
                {
                    ApplicationArea = Basic;
                }
                field("Opkrævningsbeløb"; rec."Opkrævningsbeløb")
                {
                    ApplicationArea = Basic;
                }
                field("Opkrævningsstatus"; Rec.Opkrævningsstatus)
                {
                    ApplicationArea = Basic;
                }
                field(Label; Label)
                {
                    ApplicationArea = Basic;
                    Style = Unfavorable;
                    StyleExpr = true;
                }
            }
            group(Fakturering)
            {
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Sælgerkode"; Rec.Sælgerkode)
                {
                    ApplicationArea = Basic;
                }
                field("Bogføringsdato"; rec."Bogføringsdato")
                {
                    ApplicationArea = Basic;
                }
                field(Bilagsdato; Rec.Bilagsdato)
                {
                    ApplicationArea = Basic;
                }
                field(Forfaldsdato; Rec.Forfaldsdato)
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control1000000017; "BS OpkrævningsLinier")
            {
                ApplicationArea = Basic;
                SubPageLink = "Opkrævningsnr."=field("Opkrævningsnr.");
                SubPageView = sorting("Opkrævningsnr.", "Linienr.");
            }
        }
    }
    actions
    {
    }
    trigger OnAfterGetCurrRecord()
    begin
        InfoUpdate;
    end;
    trigger OnAfterGetRecord()
    begin
        InfoUpdate;
    end;
    var Label: Text;
    local procedure InfoUpdate()
    begin
        if Rec.Referenceopkrævning then Label:='Referenceopkrævning'
        else
            Label:='';
    end;
}
