Page 50041 "DST Finansposter-rapportering"
{
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "DKS G/L Entry Rapportering";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ApplicationArea = Basic;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field("VAT Amount"; Rec."VAT Amount")
                {
                    ApplicationArea = Basic;
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
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
                field("Funktion (Dim)"; Rec."Funktion (Dim)")
                {
                    ApplicationArea = Basic;
                }
                field("Trading Partner (Dim)"; Rec."Trading Partner (Dim)")
                {
                    ApplicationArea = Basic;
                }
                field("Projektfase (Dim)"; Rec."Projektfase (Dim)")
                {
                    ApplicationArea = Basic;
                }
                field("Entry No."; Rec."Entry No.")
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
