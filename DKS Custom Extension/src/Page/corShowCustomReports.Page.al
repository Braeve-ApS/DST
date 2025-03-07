page 50010 "cor Show Custom Reports"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "cor Custom Report List";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(No; Rec.No)
                {
                }
                field(Name; Rec.Name)
                {
                }
                field(ReportID; Rec.ReportID)
                {
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Run Report")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    ReportID: Integer;
                begin
                    ReportID:=Rec.ReportID;
                    if ReportID <> 0 then Report.RunModal(ReportID, true, true);
                end;
            }
        }
    }
}
