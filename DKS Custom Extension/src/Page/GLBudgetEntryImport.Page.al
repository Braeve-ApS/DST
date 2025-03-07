Page 50008 "G/L Budget Entry Import"
{
    Caption = 'DST import fra budgetmodel';
    LinksAllowed = false;
    PageType = List;
    SourceTable = "G/L Budget Entry Import Buffer";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Budget Name"; Rec."Budget Name")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account No."; Rec."G/L Account No.")
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
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
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic;
                }
                field(Description; Rec.Description)
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
            action(Import)
            {
                ApplicationArea = Basic;
                Caption = 'Import fra fil';
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    //Xmlport.Run(50003);
                    XmlPort.Run(50003, false, true)end;
            }
            group("Skriv til Budget")
            {
                Caption = 'Skriv til Budget';
                Image = Interaction;

                action(Replace)
                {
                    ApplicationArea = Basic;
                    Caption = 'Erstat eksisterende budget';
                    Image = CancelledEntries;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if not Confirm(Text001)then Error(Text002);
                        Rec.FindFirst;
                        GLBudgetEntry.SetRange(GLBudgetEntry."Budget Name", Rec."Budget Name");
                        GLBudgetEntry.DeleteAll(true);
                        AddEntries;
                    end;
                }
                action(Add)
                {
                    ApplicationArea = Basic;
                    Caption = 'Tilføj til eksisterende budget';
                    Image = Entries;
                    Promoted = true;
                    PromotedCategory = Process;

                    trigger OnAction()
                    begin
                        if not Confirm(Text003)then Error(Text002);
                        AddEntries;
                    end;
                }
            }
        }
    }
    var Text001: label 'Denne funktion vil slette ALLE eksisterende budgetposter med samme budgetnavn inden importen foretages!\Funktionen kan ikke fortrydes!\\\Fortsæt J/N?';
    Text002: label 'Funktionen er afbrudt!';
    GLBudgetEntry: Record "G/L Budget Entry";
    Text003: label 'Denne funktion tilføjer de importerede budgetposter til eksisterende budget.\Fortsæt J/N?';
    Text004: label 'Budget %1 er nu opdateret!\Skal de indlæste poster i dette vindue slettes?';
    local procedure AddEntries()
    var
        i: Integer;
    begin
        Clear(GLBudgetEntry);
        if GLBudgetEntry.FindLast then;
        i:=GLBudgetEntry."Entry No.";
        Rec.FindFirst;
        repeat i+=1;
            GLBudgetEntry.Init;
            GLBudgetEntry."Entry No.":=i;
            GLBudgetEntry.Validate("Budget Name", Rec."Budget Name");
            GLBudgetEntry.Validate(GLBudgetEntry."G/L Account No.", Rec."G/L Account No.");
            GLBudgetEntry.Validate(GLBudgetEntry.Date, Rec.Date);
            GLBudgetEntry.Validate(GLBudgetEntry."Global Dimension 1 Code", Rec."Global Dimension 1 Code");
            GLBudgetEntry.Validate(GLBudgetEntry."Global Dimension 2 Code", Rec."Global Dimension 2 Code");
            GLBudgetEntry.Validate(GLBudgetEntry.Amount, Rec.Amount);
            GLBudgetEntry.Validate(Description, Rec.Description);
            GLBudgetEntry.Insert(true);
        until Rec.Next = 0;
        if Confirm(Text004, false, GLBudgetEntry."Budget Name")then Rec.DeleteAll;
    end;
}
