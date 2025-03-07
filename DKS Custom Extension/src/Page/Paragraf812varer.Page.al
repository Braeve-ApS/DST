Page 50001 "Paragraf 8+12 varer"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;
    PageType = ListPart;
    SourceTable = "Paragraf 8+12 indberetning";
    SourceTableView = where(Type=const(Item));

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
                field(Salesamount; Rec.Salesamount)
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
                Caption = 'Varekort';
                Image = Card;
                RunObject = Page "Item Card";
                RunPageLink = "No."=field(Nummer);
            }
            action(Entries)
            {
                ApplicationArea = Basic;
                Caption = 'Vareposter';
                Image = Entries;
                RunObject = Page "Item Ledger Entries";
                RunPageLink = "Item No."=field(Nummer);
            }
        }
    }
}
