Page 50003 "Paragraf 8+12 oversigt"
{
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            part(Control1000000001; "Paragraf 8+12 varer")
            {
                ApplicationArea = Basic;
            }
            part(Control1000000002; "Paragraf 8+12 kunder")
            {
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Update)
            {
                ApplicationArea = Basic;
                Caption = 'Opdater beregning';
                Image = Calculate;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Report "Skatteindberetning 8+12";
            }
        }
    }
}
