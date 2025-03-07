Page 50042 "Pronestor Indlæsning"
{
    PageType = List;
    SourceTable = "Pronestor indlæsning";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(EntryNo; Rec.EntryNo)
                {
                    ApplicationArea = Basic;
                }
                field(Fejl; Rec.Fejl)
                {
                    ApplicationArea = Basic;
                }
                field(Ordredato; Rec.Ordredato)
                {
                    ApplicationArea = Basic;
                }
                field("Bogf.dato"; Rec."Bogf.dato")
                {
                    ApplicationArea = Basic;
                }
                field(Debitornummer; Rec.Debitornummer)
                {
                    ApplicationArea = Basic;
                }
                field(Betalingsnote; Rec.Betalingsnote)
                {
                    ApplicationArea = Basic;
                }
                field("Debitor navn"; Rec."Debitor navn")
                {
                    ApplicationArea = Basic;
                }
                field(Varenummer; Rec.Varenummer)
                {
                    ApplicationArea = Basic;
                }
                field(Antal; Rec.Antal)
                {
                    ApplicationArea = Basic;
                }
                field("Pris incl. moms"; Rec."Pris incl. moms")
                {
                    ApplicationArea = Basic;
                }
                field("Bemærkninger"; Rec.Bemærkninger)
                {
                    ApplicationArea = Basic;
                }
                field("Mødetype (intern/ekstern)"; Rec."Mødetype (intern/ekstern)")
                {
                    ApplicationArea = Basic;
                }
                field("Møde ID"; Rec."Møde ID")
                {
                    ApplicationArea = Basic;
                }
                field("Bestiller/Projekt nr."; Rec."Bestiller/Projekt nr.")
                {
                    ApplicationArea = Basic;
                }
                field("Fejl oplysning"; Rec."Fejl oplysning")
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
            action("Import Files")
            {
                ApplicationArea = Basic;
                Caption = 'Import files';
                Image = ImportChartOfAccounts;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Xmlport.Run(50001);
                //REPORT.RUNMODAL(50014);
                //MESSAGE(Text001);
                end;
            }
            action("Check Lines")
            {
                ApplicationArea = Basic;
                Caption = 'Check Lines';
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    Clear(R50014);
                    R50014.TestLines;
                    CurrPage.Update;
                end;
            }
            action(Post)
            {
                ApplicationArea = Basic;
                Caption = 'Post';
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    R50014.TestLines;
                    R50014."Handle Files Invoice";
                    CurrPage.Update(false);
                end;
            }
        }
    }
    var Text001: label 'Filerne er indlæst';
    R50014: Report "Pronestor Indlæsning";
}
