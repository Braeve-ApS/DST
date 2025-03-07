Page 51009 "BS Betalingsaftale"
{
    PageType = Worksheet;
    SourceTable = "BS-Betalingsaftale";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Debitornr."; Rec."Debitornr.")
                {
                    ApplicationArea = Basic;
                }
                field("Debitorgr."; Rec."Debitorgr.")
                {
                    ApplicationArea = Basic;
                }
                field("CPR-/CVR-Nr."; Rec."CPR-/CVR-Nr.")
                {
                    ApplicationArea = Basic;
                }
                field("Debitor.Name"; Debitor.Name)
                {
                    ApplicationArea = Basic;
                    Caption = 'Navn';
                }
                field("Tillad aut. tilmelding"; Rec."Tillad aut. tilmelding")
                {
                    ApplicationArea = Basic;
                }
                field(Bankkonto; Rec.Bankkonto)
                {
                    ApplicationArea = Basic;

                    trigger OnLookup(var Text: Text): Boolean var
                        DebBankKonto: Record "Customer Bank Account";
                    begin
                        if Rec."Debitornr." <> '' then begin
                            DebBankKonto.Reset;
                            DebBankKonto.SetRange("Customer No.", Rec."Debitornr.");
                            if Page.RunModal(Page::"Customer Bank Account List", DebBankKonto) = Action::LookupOK then Rec.Validate(Bankkonto, DebBankKonto.Code);
                        end;
                    end;
                }
                field(Aktiv; Rec.Aktiv)
                {
                    ApplicationArea = Basic;
                }
                field("PBS Dato"; Rec."PBS Dato")
                {
                    ApplicationArea = Basic;
                }
                field("PBS Status"; Rec."PBS Status")
                {
                    ApplicationArea = Basic;
                }
                field("Aftalenr."; Rec."Aftalenr.")
                {
                    ApplicationArea = Basic;
                }
                field("Ikrafttrædelsesdato"; Rec."Ikrafttrædelsesdato")
                {
                    ApplicationArea = Basic;
                }
                field(Afmeldingsdato; Rec.Afmeldingsdato)
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
                field("Funktionskode (Dimension)"; Rec."Funktionskode (Dimension)")
                {
                    ApplicationArea = Basic;
                }
                field("Trading Partner (Dimension)"; Rec."Trading Partner (Dimension)")
                {
                    ApplicationArea = Basic;
                }
                field("Projekt Fase (Dimension)"; Rec."Projekt Fase (Dimension)")
                {
                    ApplicationArea = Basic;
                }
                field(Aftaler; Rec.Aftaler)
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
            action(Specifikationer)
            {
                ApplicationArea = Basic;
                Image = EntriesList;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page "BS Specifikation";
                RunPageLink = "Debitornr."=field("Debitornr."), "Debitorgr."=field("Debitorgr.");
                RunPageView = sorting("Debitornr.", "Debitorgr.", Kode);
            }
            separator(Action1000000022)
            {
            }
            group(Payment)
            {
                Caption = 'Payment';

                action(Betalingsaftaleposter)
                {
                    ApplicationArea = Basic;
                    Image = Entries;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "BS Betalingsaftaleposter";
                    RunPageLink = "Debitornr."=field("Debitornr."), "Debitorgr."=field("Debitorgr.");
                    RunPageView = sorting("Debitornr.", "Debitorgr.", "Løbenr.");
                    ShortCutKey = 'Ctrl+F5';
                }
                action("BogfOpkrævninger")
                {
                    ApplicationArea = Basic;
                    Caption = 'Opkrævninger';
                    Image = Documents;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "BS Bogf. Opkrævninger";
                    RunPageLink = "Debitornr."=field("Debitornr."), "Debitorgr."=field("Debitorgr.");
                    RunPageView = sorting("Bogført", Opkrævningsstatus, "Debitorgr.", "Debitornr.")where("Bogført"=const(true));
                }
                separator(Action1000000026)
                {
                }
                action(TilmeldAftale)
                {
                    ApplicationArea = Basic;
                    Caption = 'Tilmeld Aftale';
                    Image = AddContacts;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit 51010;
                }
                action(AfmeldAftale)
                {
                    ApplicationArea = Basic;
                    Caption = 'Afmeld aftale';
                    Image = RemoveContacts;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit 51012;
                }
                separator(Action1000000029)
                {
                }
                action("TælRecords")
                {
                    ApplicationArea = Basic;
                    Caption = 'Tæl Records';
                    Image = CodesList;
                    Promoted = true;
                    PromotedCategory = Process;
                    Visible = false;

                    trigger OnAction()
                    begin
                        Message('%1 records eksisterer indenfor aktuelle afgrænsning', Rec.Count);
                    end;
                }
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
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Clear(Debitor);
    end;
    var Stamoplysninger: Record "BS-Stamoplysninger";
    Debitor: Record Customer;
    procedure InfoUpdate()
    begin
        if Rec."Debitornr." <> '' then begin
            if Debitor."No." <> Rec."Debitornr." then Debitor.Get(Rec."Debitornr.");
        end
        else
            Clear(Debitor);
    end;
}
