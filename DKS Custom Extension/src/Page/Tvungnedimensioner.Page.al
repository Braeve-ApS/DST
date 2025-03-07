Page 50018 "Tvungne dimensioner"
{
    PageType = List;
    SourceTable = "DKS Dimension enforcement";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Dimension Code"; Rec."Dimension Code")
                {
                    ApplicationArea = Basic;
                }
                field("Dimension Value"; Rec."Dimension Value")
                {
                    ApplicationArea = Basic;
                }
                field("Forces Dimension"; Rec."Forces Dimension")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
    actions
    {
    }
}
