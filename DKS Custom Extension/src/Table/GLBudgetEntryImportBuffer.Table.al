Table 50012 "G/L Budget Entry Import Buffer"
{
    Caption = 'DST Import G/L Budget Entry';
    DrillDownPageID = "G/L Budget Entries";
    LookupPageID = "G/L Budget Entries";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Budget Name"; Code[10])
        {
            Caption = 'Budget Name';
            TableRelation = "G/L Budget Name";
        }
        field(3; "G/L Account No."; Code[20])
        {
            Caption = 'G/L Account No.';
            TableRelation = "G/L Account";
        }
        field(4; Date; Date)
        {
            Caption = 'Date';
            ClosingDates = true;
        }
        field(5; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
        }
        field(6; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(2));
        }
        field(7; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';
        }
        field(9; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(10; "Business Unit Code"; Code[10])
        {
            Caption = 'Business Unit Code';
            TableRelation = "Business Unit";
        }
        field(11; "User ID"; Code[50])
        {
            Caption = 'User ID';
            Editable = false;
            TableRelation = User."User Name";

            //This property is currently not supported
            //TestTableRelation = false;
            trigger OnLookup()
            var
                UserMgt: Codeunit "User Management";
            begin
            end;
        }
        field(12; "Budget Dimension 1 Code"; Code[20])
        {
            AccessByPermission = TableData Dimension=R;
            CaptionClass = GetCaptionClass(1);
            Caption = 'Budget Dimension 1 Code';
        }
        field(13; "Budget Dimension 2 Code"; Code[20])
        {
            AccessByPermission = TableData Dimension=R;
            CaptionClass = GetCaptionClass(2);
            Caption = 'Budget Dimension 2 Code';
        }
        field(14; "Budget Dimension 3 Code"; Code[20])
        {
            AccessByPermission = TableData "Dimension Combination"=R;
            CaptionClass = GetCaptionClass(3);
            Caption = 'Budget Dimension 3 Code';
        }
        field(15; "Budget Dimension 4 Code"; Code[20])
        {
            AccessByPermission = TableData "Dimension Combination"=R;
            CaptionClass = GetCaptionClass(4);
            Caption = 'Budget Dimension 4 Code';
        }
        field(16; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
    }
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Budget Name", "G/L Account No.", Date)
        {
            SumIndexFields = Amount;
        }
        key(Key3; "Budget Name", "G/L Account No.", "Business Unit Code", "Global Dimension 1 Code", "Global Dimension 2 Code", "Budget Dimension 1 Code", "Budget Dimension 2 Code", "Budget Dimension 3 Code", "Budget Dimension 4 Code", Date)
        {
            SumIndexFields = Amount;
        }
        key(Key4; "Budget Name", "G/L Account No.", Description, Date)
        {
        }
        key(Key5; "G/L Account No.", Date, "Budget Name", "Dimension Set ID")
        {
            SumIndexFields = Amount;
        }
        key(Key6; "Last Date Modified", "Budget Name")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    var
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
    begin
        CheckForMoreYears(Rec);
    end;
    var Text000: label 'The dimension value %1 has not been set up for dimension %2.';
    Text001: label '1,5,,Budget Dimension 1 Code';
    Text002: label '1,5,,Budget Dimension 2 Code';
    Text003: label '1,5,,Budget Dimension 3 Code';
    Text004: label '1,5,,Budget Dimension 4 Code';
    GLBudgetName: Record "G/L Budget Name";
    GLSetup: Record "General Ledger Setup";
    DimVal: Record "Dimension Value";
    DimMgt: Codeunit DimensionManagement;
    GLSetupRetrieved: Boolean;
    Text005: label 'Fejl! \Der findes data for andre budgetter end %1 i datasættet/filen!';
    local procedure GetCaptionClass(BudgetDimType: Integer): Text[250]begin
        if GetFilter("Budget Name") <> '' then if GLBudgetName.Name <> GetRangeMin("Budget Name")then if not GLBudgetName.Get(GetRangeMin("Budget Name"))then Clear(GLBudgetName);
        case BudgetDimType of 1: begin
            if GLBudgetName."Budget Dimension 1 Code" <> '' then exit('1,5,' + GLBudgetName."Budget Dimension 1 Code");
            exit(Text001);
        end;
        2: begin
            if GLBudgetName."Budget Dimension 2 Code" <> '' then exit('1,5,' + GLBudgetName."Budget Dimension 2 Code");
            exit(Text002);
        end;
        3: begin
            if GLBudgetName."Budget Dimension 3 Code" <> '' then exit('1,5,' + GLBudgetName."Budget Dimension 3 Code");
            exit(Text003);
        end;
        4: begin
            if GLBudgetName."Budget Dimension 4 Code" <> '' then exit('1,5,' + GLBudgetName."Budget Dimension 4 Code");
            exit(Text004);
        end;
        end;
    end;
    local procedure CheckForMoreYears(GLBudgetEntryImportBuffer: Record "G/L Budget Entry Import Buffer")
    var
        rec2: Record "G/L Budget Entry Import Buffer";
    begin
        rec2.SetFilter(rec2."Budget Name", '<>%1', GLBudgetEntryImportBuffer."Budget Name");
        if not rec2.IsEmpty then Error(Text005, GLBudgetEntryImportBuffer."Budget Name");
    end;
}
