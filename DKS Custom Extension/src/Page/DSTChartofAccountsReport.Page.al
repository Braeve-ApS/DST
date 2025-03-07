Page 50040 "DST Chart of Accounts Report"
{
    Caption = 'Chart of Accounts';
    CardPageID = "G/L Account Card";
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "DKS G/L Account Rapportering";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                IndentationColumn = NameIndent;
                IndentationControls = Name;

                field("No."; Rec."No.")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = NoEmphasize;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = NameEmphasize;
                }
                field("Income/Balance"; Rec."Income/Balance")
                {
                    ApplicationArea = Basic;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = Basic;
                }
                field("Direct Posting"; Rec."Direct Posting")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field(Totaling; Rec.Totaling)
                {
                    ApplicationArea = Basic;

                    trigger OnLookup(var Text: Text): Boolean var
                        GLaccList: Page "G/L Account List";
                    begin
                        GLaccList.LookupMode(true);
                        if not(GLaccList.RunModal = Action::LookupOK)then exit(false);
                        Text:=GLaccList.GetSelectionFilter;
                        exit(true);
                    end;
                }
                field("Gen. Posting Type"; Rec."Gen. Posting Type")
                {
                    ApplicationArea = Basic;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = Basic;
                    Visible = false;
                }
                field("Net Change"; Rec."Net Change")
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                }
                field("Balance at Date"; Rec."Balance at Date")
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    Visible = false;
                }
                field(Balance; Rec.Balance)
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                }
                field("Budgeted Amount"; Rec."Budgeted Amount")
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                }
                field("Revised Budget Amount"; Rec."Revised Budget Amount")
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                }
                field("Vat Amount"; Rec."Vat Amount")
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                }
            }
        }
        area(factboxes)
        {
            part(Control1905532107; "Dimensions FactBox")
            {
                ApplicationArea = Basic;
                SubPageLink = "Table ID"=const(15), "No."=field("No.");
                Visible = false;
            }
            systempart(Control1900383207; Links)
            {
                Visible = false;
                ApplicationArea = Basic;
            }
            systempart(Control1905767507; Notes)
            {
                Visible = true;
                ApplicationArea = Basic;
            }
        }
    }
    actions
    {
        area(navigation)
        {
            group("A&ccount")
            {
                Caption = 'A&ccount';
                Image = ChartOfAccounts;

                action("Ledger E&ntries")
                {
                    ApplicationArea = Basic;
                    Caption = 'Ledger E&ntries';
                    Image = GLRegisters;
                    Promoted = false;
                    //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                    //PromotedCategory = Process;
                    RunObject = Page "General Ledger Entries";
                    RunPageLink = "G/L Account No."=field("No.");
                    RunPageView = sorting("G/L Account No.");
                    ShortCutKey = 'Ctrl+F7';
                }
                action("Co&mments")
                {
                    ApplicationArea = Basic;
                    Caption = 'Co&mments';
                    Image = ViewComments;
                    RunObject = Page "Comment Sheet";
                    RunPageLink = "Table Name"=const("G/L Account"), "No."=field("No.");
                }
                group(Dimensions)
                {
                    Caption = 'Dimensions';
                    Image = Dimensions;

                    action("Dimensions-Single")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Dimensions-Single';
                        Image = Dimensions;
                        RunObject = Page "Default Dimensions";
                        RunPageLink = "Table ID"=const(15), "No."=field("No.");
                        ShortCutKey = 'Shift+Ctrl+D';
                    }
                    action("Dimensions-&Multiple")
                    {
                        AccessByPermission = TableData Dimension=R;
                        ApplicationArea = Basic;
                        Caption = 'Dimensions-&Multiple';
                        Image = DimensionSets;

                        trigger OnAction()
                        var
                            GLAcc: Record "G/L Account";
                            DefaultDimMultiple: Page "Default Dimensions-Multiple";
                        begin
                            CurrPage.SetSelectionFilter(GLAcc);
                            DefaultDimMultiple.SetMultiRecord(GLAcc, GLAcc.FieldNo("No."));
                            DefaultDimMultiple.RunModal;
                        end;
                    }
                }
                action("E&xtended Texts")
                {
                    ApplicationArea = Basic;
                    Caption = 'E&xtended Texts';
                    Image = Text;
                    RunObject = Page "Extended Text List";
                    RunPageLink = "Table Name"=const("G/L Account"), "No."=field("No.");
                    RunPageView = sorting("Table Name", "No.", "Language Code", "All Language Codes", "Starting Date", "Ending Date");
                }
                action("Receivables-Payables")
                {
                    ApplicationArea = Basic;
                    Caption = 'Receivables-Payables';
                    Image = ReceivablesPayables;
                    RunObject = Page "Receivables-Payables";
                }
                action("Where-Used List")
                {
                    ApplicationArea = Basic;
                    Caption = 'Where-Used List';
                    Image = Track;

                    trigger OnAction()
                    var
                        CalcGLAccWhereUsed: Codeunit "Calc. G/L Acc. Where-Used";
                    begin
                        CalcGLAccWhereUsed.CheckGLAcc(Rec."No.");
                    end;
                }
            }
            group("&Balance")
            {
                Caption = '&Balance';
                Image = Balance;

                action("G/L &Account Balance")
                {
                    ApplicationArea = Basic;
                    Caption = 'G/L &Account Balance';
                    Image = GLAccountBalance;
                    RunObject = Page "G/L Account Balance";
                    RunPageLink = "No."=field("No."), "Global Dimension 1 Filter"=field("Global Dimension 1 Filter"), "Global Dimension 2 Filter"=field("Global Dimension 2 Filter"), "Business Unit Filter"=field("Business Unit Filter");
                }
                action("G/L &Balance")
                {
                    ApplicationArea = Basic;
                    Caption = 'G/L &Balance';
                    Image = GLBalance;
                    RunObject = Page "G/L Balance";
                    RunPageLink = "Global Dimension 1 Filter"=field("Global Dimension 1 Filter"), "Global Dimension 2 Filter"=field("Global Dimension 2 Filter"), "Business Unit Filter"=field("Business Unit Filter");
                    RunPageOnRec = true;
                }
                action("G/L Balance by &Dimension")
                {
                    ApplicationArea = Basic;
                    Caption = 'G/L Balance by &Dimension';
                    Image = GLBalanceDimension;
                    RunObject = Page "G/L Balance by Dimension";
                }
                separator(Action52)
                {
                Caption = '';
                }
                action("G/L Account Balance/Bud&get")
                {
                    ApplicationArea = Basic;
                    Caption = 'G/L Account Balance/Bud&get';
                    Image = Period;
                    RunObject = Page "G/L Account Balance/Budget";
                    RunPageLink = "No."=field("No."), "Global Dimension 1 Filter"=field("Global Dimension 1 Filter"), "Global Dimension 2 Filter"=field("Global Dimension 2 Filter"), "Business Unit Filter"=field("Business Unit Filter"), "Budget Filter"=field("Budget Filter");
                }
                action("G/L Balance/B&udget")
                {
                    ApplicationArea = Basic;
                    Caption = 'G/L Balance/B&udget';
                    Image = ChartOfAccounts;
                    RunObject = Page "G/L Balance/Budget";
                    RunPageLink = "Global Dimension 1 Filter"=field("Global Dimension 1 Filter"), "Global Dimension 2 Filter"=field("Global Dimension 2 Filter"), "Business Unit Filter"=field("Business Unit Filter"), "Budget Filter"=field("Budget Filter");
                    RunPageOnRec = true;
                }
                separator(Action55)
                {
                }
                action("Chart of Accounts &Overview")
                {
                    ApplicationArea = Basic;
                    Caption = 'Chart of Accounts &Overview';
                    Image = Accounts;
                    RunObject = Page "Chart of Accounts Overview";
                }
            }
            action("G/L Register")
            {
                ApplicationArea = Basic;
                Caption = 'G/L Register';
                Image = GLRegisters;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = Page "G/L Registers";
            }
        }
        area(processing)
        {
            group("F&unctions")
            {
                Caption = 'F&unctions';
                Image = "Action";

                action(IndentChartOfAccounts)
                {
                    ApplicationArea = Basic;
                    Caption = 'Indent Chart of Accounts';
                    Image = IndentChartOfAccounts;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Codeunit "G/L Account-Indent";
                }
                action("Update Basis of Reporting")
                {
                    ApplicationArea = Basic;
                    Caption = 'Update basis of Reporting';
                    Image = AutofillQtyToHandle;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;

                    trigger OnAction()
                    begin
                        DKSCheckTvungenDimension.UpdateChartOfAccounts;
                        DKSCheckTvungenDimension.UpdateGLEntryReportingTable;
                        Message(DKS01);
                    end;
                }
            }
            group("Periodic Activities")
            {
                Caption = 'Periodic Activities';

                action("Recurring General Journal")
                {
                    ApplicationArea = Basic;
                    Caption = 'Recurring General Journal';
                    Image = Journal;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Page "Recurring General Journal";
                }
                action("Close Income Statement")
                {
                    ApplicationArea = Basic;
                    Caption = 'Close Income Statement';
                    Image = CloseYear;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = Report "Close Income Statement";
                }
                action(DocsWithoutIC)
                {
                    ApplicationArea = Basic;
                    Caption = 'Posted Documents without Incoming Document';
                    Image = Documents;

                    trigger OnAction()
                    var
                        PostedDocsWithNoIncBuf: Record "Posted Docs. With No Inc. Buf.";
                    begin
                        if Rec."Account Type" = Rec."account type"::Posting then PostedDocsWithNoIncBuf.SetRange("G/L Account No. Filter", Rec."No.")
                        else if Rec.Totaling <> '' then PostedDocsWithNoIncBuf.SetFilter("G/L Account No. Filter", Rec.Totaling)
                            else
                                exit;
                        Page.Run(Page::"Posted Docs. With No Inc. Doc.", PostedDocsWithNoIncBuf);
                    end;
                }
            }
        }
        area(reporting)
        {
            action("Detail Trial Balance")
            {
                ApplicationArea = Basic;
                Caption = 'Detail Trial Balance';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Detail Trial Balance";
            }
            action("Trial Balance")
            {
                ApplicationArea = Basic;
                Caption = 'Trial Balance';
                Image = "Report";
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "Trial Balance";
            }
            action("Trial Balance by Period")
            {
                ApplicationArea = Basic;
                Caption = 'Trial Balance by Period';
                Image = "Report";
                Promoted = false;
                //The property 'PromotedCategory' can only be set if the property 'Promoted' is set to 'true'
                //PromotedCategory = "Report";
                RunObject = Report "Trial Balance by Period";
            }
            action(Action1900210206)
            {
                ApplicationArea = Basic;
                Caption = 'G/L Register';
                Image = GLRegisters;
                Promoted = true;
                PromotedCategory = "Report";
                RunObject = Report "G/L Register";
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        NoEmphasize:=Rec."Account Type" <> Rec."account type"::Posting;
        NameIndent:=Rec.Indentation;
        NameEmphasize:=Rec."Account Type" <> Rec."account type"::Posting;
    end;
    var NoEmphasize: Boolean;
    NameEmphasize: Boolean;
    NameIndent: Integer;
    DKSCheckTvungenDimension: Codeunit "DKS GL Reporting Functions";
    DKS01: label 'Update Completed!';
}
