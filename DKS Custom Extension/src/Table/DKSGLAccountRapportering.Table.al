Table 50016 "DKS G/L Account Rapportering"
{
    Caption = 'G/L Account';
    DataCaptionFields = "No.", Name;
    DrillDownPageID = "DST Chart of Accounts Report";
    LookupPageID = "DST Chart of Accounts Report";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            NotBlank = true;
            SQLDataType = Integer;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
        }
        field(3; "Search Name"; Code[100])
        {
            Caption = 'Search Name';
        }
        field(4; "Account Type"; Option)
        {
            Caption = 'Account Type';
            OptionCaption = 'Posting,Heading,Total,Begin-Total,End-Total';
            OptionMembers = Posting, Heading, Total, "Begin-Total", "End-Total";

            trigger OnValidate()
            var
                GLEntry: Record "G/L Entry";
                GLBudgetEntry: Record "G/L Budget Entry";
            begin
            end;
        }
        field(6; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
        }
        field(7; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(2));
        }
        field(9; "Income/Balance"; Option)
        {
            Caption = 'Income/Balance';
            OptionCaption = 'Income Statement,Balance Sheet';
            OptionMembers = "Income Statement", "Balance Sheet";
        }
        field(10; "Debit/Credit"; Option)
        {
            Caption = 'Debit/Credit';
            OptionCaption = 'Both,Debit,Credit';
            OptionMembers = Both, Debit, Credit;
        }
        field(11; "No. 2"; Code[20])
        {
            Caption = 'No. 2';
        }
        field(12; Comment; Boolean)
        {
            CalcFormula = exist("Comment Line" where("Table Name"=const("G/L Account"), "No."=field("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; Blocked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(14; "Direct Posting"; Boolean)
        {
            Caption = 'Direct Posting';
            InitValue = true;
        }
        field(16; "Reconciliation Account"; Boolean)
        {
            Caption = 'Reconciliation Account';
        }
        field(17; "New Page"; Boolean)
        {
            Caption = 'New Page';
        }
        field(18; "No. of Blank Lines"; Integer)
        {
            Caption = 'No. of Blank Lines';
            MinValue = 0;
        }
        field(19; Indentation; Integer)
        {
            Caption = 'Indentation';
            MinValue = 0;
        }
        field(26; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;
        }
        field(28; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            FieldClass = FlowFilter;
        }
        field(29; "Global Dimension 1 Filter"; Code[20])
        {
            CaptionClass = '1,3,1';
            Caption = 'Global Dimension 1 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
        }
        field(30; "Global Dimension 2 Filter"; Code[20])
        {
            CaptionClass = '1,3,2';
            Caption = 'Global Dimension 2 Filter';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Global Dimension No."=const(2));
        }
        field(31; "Balance at Date"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("DKS G/L Entry Rapportering".Amount where("G/L Account No."=field("No."), "G/L Account No."=field(filter(Totaling)), "Business Unit Code"=field("Business Unit Filter"), "Global Dimension 1 Code"=field("Global Dimension 1 Filter"), "Global Dimension 2 Code"=field("Global Dimension 2 Filter"), "Posting Date"=field(upperlimit("Date Filter")), "Funktion (Dim)"=field(Funktionsfilter), "Trading Partner (Dim)"=field("Trading partner Filter"), "Projektfase (Dim)"=field("Projekt fase Filter")));
            Caption = 'Balance at Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(32; "Net Change"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("DKS G/L Entry Rapportering".Amount where("G/L Account No."=field("No."), "G/L Account No."=field(filter(Totaling)), "Business Unit Code"=field("Business Unit Filter"), "Global Dimension 1 Code"=field("Global Dimension 1 Filter"), "Global Dimension 2 Code"=field("Global Dimension 2 Filter"), "Funktion (Dim)"=field(Funktionsfilter), "Trading Partner (Dim)"=field("Trading partner Filter"), "Projektfase (Dim)"=field("Projekt fase Filter"), "Posting Date"=field("Date Filter")));
            Caption = 'Net Change';
            Editable = false;
            FieldClass = FlowField;
        }
        field(33; "Budgeted Amount"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("G/L Budget Entry".Amount where("G/L Account No."=field("No."), "G/L Account No."=field(filter(Totaling)), "Business Unit Code"=field("Business Unit Filter"), "Global Dimension 1 Code"=field("Global Dimension 1 Filter"), "Global Dimension 2 Code"=field("Global Dimension 2 Filter"), Date=field("Date Filter"), "Budget Name"=field("Budget Filter"), "Budget Dimension 1 Code"=field(Funktionsfilter), "Budget Dimension 2 Code"=field("Trading partner Filter"), "Budget Dimension 3 Code"=field("Projekt fase Filter")));
            Caption = 'Budgeted Amount';
            FieldClass = FlowField;
        }
        field(34; Totaling; Text[250])
        {
            Caption = 'Totaling';
            TableRelation = "G/L Account";
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(35; "Budget Filter"; Code[10])
        {
            Caption = 'Budget Filter';
            FieldClass = FlowFilter;
            TableRelation = "G/L Budget Name";
        }
        field(36; Balance; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("DKS G/L Entry Rapportering".Amount where("G/L Account No."=field("No."), "G/L Account No."=field(filter(Totaling)), "Business Unit Code"=field("Business Unit Filter"), "Global Dimension 1 Code"=field("Global Dimension 1 Filter"), "Global Dimension 2 Code"=field("Global Dimension 2 Filter"), "Funktion (Dim)"=field(Funktionsfilter), "Trading Partner (Dim)"=field("Trading partner Filter"), "Projektfase (Dim)"=field("Projekt fase Filter")));
            Caption = 'Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(37; "Budget at Date"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("G/L Budget Entry".Amount where("G/L Account No."=field("No."), "G/L Account No."=field(filter(Totaling)), "Business Unit Code"=field("Business Unit Filter"), "Global Dimension 1 Code"=field("Global Dimension 1 Filter"), "Global Dimension 2 Code"=field("Global Dimension 2 Filter"), Date=field(upperlimit("Date Filter")), "Budget Name"=field("Budget Filter"), "Budget Dimension 1 Code"=field(Funktionsfilter), "Budget Dimension 2 Code"=field("Trading partner Filter"), "Budget Dimension 3 Code"=field("Projekt fase Filter")));
            Caption = 'Budget at Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(39; "Consol. Translation Method"; Option)
        {
            Caption = 'Consol. Translation Method';
            OptionCaption = 'Average Rate (Manual),Closing Rate,Historical Rate,Composite Rate,Equity Rate';
            OptionMembers = "Average Rate (Manual)", "Closing Rate", "Historical Rate", "Composite Rate", "Equity Rate";

            trigger OnValidate()
            var
                ConflictGLAcc: Record "G/L Account";
            begin
            end;
        }
        field(40; "Consol. Debit Acc."; Code[20])
        {
            Caption = 'Consol. Debit Acc.';

            trigger OnValidate()
            var
                ConflictGLAcc: Record "G/L Account";
            begin
            end;
        }
        field(41; "Consol. Credit Acc."; Code[20])
        {
            Caption = 'Consol. Credit Acc.';

            trigger OnValidate()
            var
                ConflictGLAcc: Record "G/L Account";
            begin
            end;
        }
        field(42; "Business Unit Filter"; Code[10])
        {
            Caption = 'Business Unit Filter';
            FieldClass = FlowFilter;
            TableRelation = "Business Unit";
        }
        field(43; "Gen. Posting Type"; Option)
        {
            Caption = 'Gen. Posting Type';
            OptionCaption = ' ,Purchase,Sale';
            OptionMembers = " ", Purchase, Sale;
        }
        field(44; "Gen. Bus. Posting Group"; Code[10])
        {
            Caption = 'Gen. Bus. Posting Group';
            TableRelation = "Gen. Business Posting Group";

            trigger OnValidate()
            var
                GenBusPostingGrp: Record "Gen. Business Posting Group";
            begin
            end;
        }
        field(45; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group";

            trigger OnValidate()
            var
                GenProdPostingGrp: Record "Gen. Product Posting Group";
            begin
            end;
        }
        field(46; Picture; Blob)
        {
            Caption = 'Picture';
            SubType = Bitmap;
        }
        field(47; "Debit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("DKS G/L Entry Rapportering"."Debit Amount" where("G/L Account No."=field("No."), "G/L Account No."=field(filter(Totaling)), "Business Unit Code"=field("Business Unit Filter"), "Global Dimension 1 Code"=field("Global Dimension 1 Filter"), "Global Dimension 2 Code"=field("Global Dimension 2 Filter"), "Posting Date"=field("Date Filter"), "Funktion (Dim)"=field(Funktionsfilter), "Trading Partner (Dim)"=field("Trading partner Filter"), "Projektfase (Dim)"=field("Projekt fase Filter")));
            Caption = 'Debit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(48; "Credit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankZero = true;
            CalcFormula = sum("DKS G/L Entry Rapportering"."Credit Amount" where("G/L Account No."=field("No."), "G/L Account No."=field(filter(Totaling)), "Business Unit Code"=field("Business Unit Filter"), "Global Dimension 1 Code"=field("Global Dimension 1 Filter"), "Global Dimension 2 Code"=field("Global Dimension 2 Filter"), "Posting Date"=field("Date Filter"), "Funktion (Dim)"=field(Funktionsfilter), "Trading Partner (Dim)"=field("Trading partner Filter"), "Projektfase (Dim)"=field("Projekt fase Filter")));
            Caption = 'Credit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(49; "Automatic Ext. Texts"; Boolean)
        {
            Caption = 'Automatic Ext. Texts';
        }
        field(52; "Budgeted Debit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankNumbers = BlankNegAndZero;
            CalcFormula = sum("G/L Budget Entry".Amount where("G/L Account No."=field("No."), "G/L Account No."=field(filter(Totaling)), "Business Unit Code"=field("Business Unit Filter"), "Global Dimension 1 Code"=field("Global Dimension 1 Filter"), "Global Dimension 2 Code"=field("Global Dimension 2 Filter"), Date=field("Date Filter"), "Budget Name"=field("Budget Filter"), "Budget Dimension 1 Code"=field(Funktionsfilter), "Budget Dimension 2 Code"=field("Trading partner Filter"), "Budget Dimension 3 Code"=field("Projekt fase Filter")));
            Caption = 'Budgeted Debit Amount';
            FieldClass = FlowField;
        }
        field(53; "Budgeted Credit Amount"; Decimal)
        {
            AutoFormatType = 1;
            BlankNumbers = BlankNegAndZero;
            CalcFormula = -sum("G/L Budget Entry".Amount where("G/L Account No."=field("No."), "G/L Account No."=field(filter(Totaling)), "Business Unit Code"=field("Business Unit Filter"), "Global Dimension 1 Code"=field("Global Dimension 1 Filter"), "Global Dimension 2 Code"=field("Global Dimension 2 Filter"), Date=field("Date Filter"), "Budget Name"=field("Budget Filter"), "Budget Dimension 1 Code"=field(Funktionsfilter), "Budget Dimension 2 Code"=field("Projekt fase Filter"), "Budget Dimension 3 Code"=field("Projekt fase Filter")));
            Caption = 'Budgeted Credit Amount';
            FieldClass = FlowField;
        }
        field(54; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code';
            TableRelation = "Tax Area";
        }
        field(55; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable';
        }
        field(56; "Tax Group Code"; Code[10])
        {
            Caption = 'Tax Group Code';
            TableRelation = "Tax Group";
        }
        field(57; "VAT Bus. Posting Group"; Code[10])
        {
            Caption = 'VAT Bus. Posting Group';
            TableRelation = "VAT Business Posting Group";
        }
        field(58; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            TableRelation = "VAT Product Posting Group";
        }
        field(60; "Additional-Currency Net Change"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            CalcFormula = sum("G/L Entry"."Additional-Currency Amount" where("G/L Account No."=field("No."), "G/L Account No."=field(filter(Totaling)), "Business Unit Code"=field("Business Unit Filter"), "Global Dimension 1 Code"=field("Global Dimension 1 Filter"), "Global Dimension 2 Code"=field("Global Dimension 2 Filter"), "Posting Date"=field("Date Filter")));
            Caption = 'Additional-Currency Net Change';
            Editable = false;
            FieldClass = FlowField;
        }
        field(61; "Add.-Currency Balance at Date"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            CalcFormula = sum("G/L Entry"."Additional-Currency Amount" where("G/L Account No."=field("No."), "G/L Account No."=field(filter(Totaling)), "Business Unit Code"=field("Business Unit Filter"), "Global Dimension 1 Code"=field("Global Dimension 1 Filter"), "Global Dimension 2 Code"=field("Global Dimension 2 Filter"), "Posting Date"=field(upperlimit("Date Filter"))));
            Caption = 'Add.-Currency Balance at Date';
            Editable = false;
            FieldClass = FlowField;
        }
        field(62; "Additional-Currency Balance"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            CalcFormula = sum("G/L Entry"."Additional-Currency Amount" where("G/L Account No."=field("No."), "G/L Account No."=field(filter(Totaling)), "Business Unit Code"=field("Business Unit Filter"), "Global Dimension 1 Code"=field("Global Dimension 1 Filter"), "Global Dimension 2 Code"=field("Global Dimension 2 Filter")));
            Caption = 'Additional-Currency Balance';
            Editable = false;
            FieldClass = FlowField;
        }
        field(63; "Exchange Rate Adjustment"; Option)
        {
            Caption = 'Exchange Rate Adjustment';
            OptionCaption = 'No Adjustment,Adjust Amount,Adjust Additional-Currency Amount';
            OptionMembers = "No Adjustment", "Adjust Amount", "Adjust Additional-Currency Amount";
        }
        field(64; "Add.-Currency Debit Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            CalcFormula = sum("G/L Entry"."Add.-Currency Debit Amount" where("G/L Account No."=field("No."), "G/L Account No."=field(filter(Totaling)), "Business Unit Code"=field("Business Unit Filter"), "Global Dimension 1 Code"=field("Global Dimension 1 Filter"), "Global Dimension 2 Code"=field("Global Dimension 2 Filter"), "Posting Date"=field("Date Filter")));
            Caption = 'Add.-Currency Debit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(65; "Add.-Currency Credit Amount"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            CalcFormula = sum("G/L Entry"."Add.-Currency Credit Amount" where("G/L Account No."=field("No."), "G/L Account No."=field(filter(Totaling)), "Business Unit Code"=field("Business Unit Filter"), "Global Dimension 1 Code"=field("Global Dimension 1 Filter"), "Global Dimension 2 Code"=field("Global Dimension 2 Filter"), "Posting Date"=field("Date Filter")));
            Caption = 'Add.-Currency Credit Amount';
            Editable = false;
            FieldClass = FlowField;
        }
        field(66; "Default IC Partner G/L Acc. No"; Code[20])
        {
            Caption = 'Default IC Partner G/L Acc. No';
            TableRelation = "IC G/L Account"."No.";
        }
        field(70; "Omit Default Descr. in Jnl."; Boolean)
        {
            Caption = 'Omit Default Descr. in Jnl.';
        }
        field(1100; "Cost Type No."; Code[20])
        {
            Caption = 'Cost Type No.';
            Editable = false;
            TableRelation = "Cost Type";
            ValidateTableRelation = false;
        }
        field(1700; "Default Deferral Template Code"; Code[10])
        {
            Caption = 'Default Deferral Template Code';
            TableRelation = "Deferral Template"."Deferral Code";
        }
        field(50000; Funktionsfilter; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Dimension Code"=const('FUNKTION'));
        }
        field(50010; "Trading partner Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Dimension Code"=const('TRADING PARTNER'));
        }
        field(50020; "Projekt fase Filter"; Code[20])
        {
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code where("Dimension Code"=const('PROJEKT FASE'));
        }
        field(50100; "Revised Budget Filter"; Code[10])
        {
            Caption = 'Revised Budget Filter';
            FieldClass = FlowFilter;
            TableRelation = "G/L Budget Name";
        }
        field(50101; "Revised Budget Amount"; Decimal)
        {
            CalcFormula = sum("G/L Budget Entry".Amount where("G/L Account No."=field("No."), "G/L Account No."=field(filter(Totaling)), "Business Unit Code"=field("Business Unit Filter"), "Global Dimension 1 Code"=field("Global Dimension 1 Filter"), "Global Dimension 2 Code"=field("Global Dimension 2 Filter"), Date=field("Date Filter"), "Budget Name"=field("Revised Budget Filter"), "Budget Dimension 1 Code"=field(Funktionsfilter), "Budget Dimension 2 Code"=field("Trading partner Filter"), "Budget Dimension 3 Code"=field("Projekt fase Filter")));
            Caption = 'Revised Budget Amount';
            FieldClass = FlowField;
        }
        field(50102; "Vat Amount"; Decimal)
        {
            CalcFormula = sum("DKS G/L Entry Rapportering"."VAT Amount" where("G/L Account No."=field("No."), "G/L Account No."=field(filter(Totaling)), "Business Unit Code"=field("Business Unit Filter"), "Global Dimension 1 Code"=field("Global Dimension 1 Filter"), "Global Dimension 2 Code"=field("Global Dimension 2 Filter"), "Posting Date"=field("Date Filter"), "Funktion (Dim)"=field(Funktionsfilter), "Trading Partner (Dim)"=field("Trading partner Filter"), "Projektfase (Dim)"=field("Projekt fase Filter")));
            Caption = 'Momsbeløb';
            FieldClass = FlowField;
        }
    }
    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
        key(Key2; "Search Name")
        {
        }
    }
    fieldgroups
    {
    }
    trigger OnDelete()
    var
        GLBudgetEntry: Record "G/L Budget Entry";
        CommentLine: Record "Comment Line";
        ExtTextHeader: Record "Extended Text Header";
        AnalysisViewEntry: Record "Analysis View Entry";
        AnalysisViewBudgetEntry: Record "Analysis View Budget Entry";
        MoveEntries: Codeunit MoveEntries;
    begin
    end;
    var Text000: label 'You cannot change %1 because there are one or more ledger entries associated with this account.';
    Text001: label 'You cannot change %1 because this account is part of one or more budgets.';
    GLSetup: Record "General Ledger Setup";
    DimMgt: Codeunit DimensionManagement;
    GLSetupRead: Boolean;
    Text002: label 'There is another %1: %2; which refers to the same %3, but with a different %4: %5.';
    procedure SetupNewGLAcc(OldGLAcc: Record "G/L Account"; BelowOldGLAcc: Boolean)
    var
        OldGLAcc2: Record "G/L Account";
    begin
    end;
    procedure CheckGLAcc()
    begin
    end;
    procedure GetCurrencyCode(): Code[10]begin
    end;
    procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
    end;
    procedure TranslationMethodConflict(var GLAcc: Record "G/L Account"): Boolean begin
    end;
}
