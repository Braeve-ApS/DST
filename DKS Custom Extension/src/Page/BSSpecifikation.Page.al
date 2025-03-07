Page 51000 "BS Specifikation"
{
    PageType = List;
    SourceTable = "BS-Specifikation";
    ApplicationArea = Basic;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Kode; Rec.Kode)
                {
                    ApplicationArea = Basic;
                }
                field("Fællesskabelon"; Rec."Fællesskabelon")
                {
                    ApplicationArea = Basic;
                }
                field(Overskrift; Rec.Overskrift)
                {
                    ApplicationArea = Basic;
                }
                field("Næste opkrævning"; Rec."Næste opkrævning")
                {
                    ApplicationArea = Basic;
                }
                field("Opkrævningsinterval"; Rec."Opkrævningsinterval")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Basic;
                }
                field("Sælgerkode"; Rec."Sælgerkode")
                {
                    ApplicationArea = Basic;
                }
                field("Tilh. Linier"; Rec."Tilh. Linier")
                {
                    ApplicationArea = Basic;
                }
            }
            part(Control1000000011; "BS Specifikationstekst")
            {
                SubPageLink = "Debitornr."=field("Debitornr."), Specifikationskode=field(Kode);
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Format)
            {
                ApplicationArea = Basic;
                Caption = 'Formater';
                Image = Text;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    gFormatForm.Formatering(Rec, true);
                end;
            }
            action(Lines)
            {
                ApplicationArea = Basic;
                Caption = 'Lines';
                Image = EditLines;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    if Rec."Fællesskabelon" <> '' then Error('Specifikation af Fællesskabeloner kan ikke ske herfra !');
                    Specifikationstekst.Reset;
                    Specifikationstekst.SetRange("Debitornr.", Rec."Debitornr.");
                    Specifikationstekst.SetRange("Debitorgr.", Rec."Debitorgr.");
                    Specifikationstekst.SetRange(Specifikationskode, Rec.Kode);
                    Page.Run(Page::"BS Specifikationstekst", Specifikationstekst);
                end;
            }
        }
    }
    var gFormatForm: Page "BS Specifikationstekst";
    Specifikationstekst: Record "BS-Specifkationstekst";
}
