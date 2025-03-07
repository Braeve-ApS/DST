Page 50002 "Paragraf 8+12 kunder"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Paragraf 8+12 indberetning";
    SourceTableView = where(Type=const(Customer));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Nummer; Rec.Nummer)
                {
                    ApplicationArea = Basic;
                }
                field(Navn; Rec.Navn)
                {
                    ApplicationArea = Basic;
                }
                field("Cpr-Nr"; Rec."Cpr-Nr")
                {
                    ApplicationArea = Basic;
                }
                field("Paragraf 8"; Rec."Paragraf 8")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Paragraf 12"; Rec."Paragraf 12")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Date Filter"; Rec."Date Filter")
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
            action(Card)
            {
                ApplicationArea = Basic;
                Caption = 'Kort';
                Image = Card;
                RunObject = Page "Customer Card";
                RunPageLink = "No."=field(Nummer);
            }
            action(Entries)
            {
                ApplicationArea = Basic;
                Caption = 'Poster';
                Image = Entries;
                RunObject = Page "Customer Ledger Entries";
                RunPageLink = "Customer No."=field(Nummer);
            }
        }
    }
}
