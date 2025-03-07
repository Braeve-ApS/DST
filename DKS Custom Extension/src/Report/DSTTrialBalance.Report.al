Report 50015 "DST Trial Balance"
{
    // // NAVK.01 PGR/20181122: Limited to SUPER users
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/DST Trial Balance.rdlc';
    Caption = 'Trial Balance';

    dataset
    {
        dataitem("G/L Account"; "DKS G/L Account Rapportering")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Account Type", "Date Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";

            column(ReportForNavId_6710;6710)
            {
            }
            column(STRSUBSTNO_Text000_PeriodText_; StrSubstNo(Text000, PeriodText))
            {
            }
            column(CurrReport_PAGENO; CurrReport.PageNo)
            {
            }
            column(COMPANYNAME; COMPANYNAME)
            {
            }
            column(PeriodText; PeriodText)
            {
            }
            column(G_L_Account__TABLECAPTION__________GLFilter; "G/L Account".TableCaption + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(G_L_Account_No_; "G/L Account"."No.")
            {
            }
            column(Trial_BalanceCaption; Trial_BalanceCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Net_ChangeCaption; Net_ChangeCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(G_L_Account___No__Caption; "G/L Account".FieldCaption("G/L Account"."No."))
            {
            }
            column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaption; PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl)
            {
            }
            column(G_L_Account___Net_Change_Caption; G_L_Account___Net_Change_CaptionLbl)
            {
            }
            column(G_L_Account___Net_Change__Control22Caption; G_L_Account___Net_Change__Control22CaptionLbl)
            {
            }
            column(G_L_Account___Balance_at_Date_Caption; G_L_Account___Balance_at_Date_CaptionLbl)
            {
            }
            column(G_L_Account___Balance_at_Date__Control24Caption; G_L_Account___Balance_at_Date__Control24CaptionLbl)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(BudgetFiltertext; BudgetFilterText)
            {
            }
            column(RevBudgetFiltertext; RevBudgetFilterText)
            {
            }
            column(BudgetOption; Budgetoption)
            {
            }
            column(AfdFilterText; AfdFilterTxt)
            {
            }
            column(AktivFiltertext; AktivFilterTxt)
            {
            }
            column(TradingpartnerFiltertxt; TradingParnFilterTxt)
            {
            }
            column(FunkFiltertxt; FunkFulterText)
            {
            }
            column(ProjectFiltertext; ProjectFilterTxt)
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number)where(Number=const(1));

                column(ReportForNavId_5444;5444)
                {
                }
                column(G_L_Account___No__; "G/L Account"."No.")
                {
                }
                column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__Name; PadStr('', "G/L Account".Indentation * 2) + "G/L Account".Name)
                {
                }
                column(G_L_Account___Net_Change_; "G/L Account"."Net Change")
                {
                }
                column(G_L_Account___Net_Change__Control22;-"G/L Account"."Net Change")
                {
                AutoFormatType = 1;
                }
                column(G_L_Account___Balance_at_Date_; "G/L Account"."Balance at Date")
                {
                }
                column(G_L_Account___Balance_at_Date__Control24;-"G/L Account"."Balance at Date")
                {
                AutoFormatType = 1;
                }
                column(G_L_Account___Account_Type_; Format("G/L Account"."Account Type", 0, 2))
                {
                }
                column(No__of_Blank_Lines; "G/L Account"."No. of Blank Lines")
                {
                }
                column(GL_BudgetedAmount; "G/L Account"."Budgeted Amount")
                {
                }
                column(GL_Revised_BudgetedAmount; "G/L Account"."Revised Budget Amount")
                {
                }
                column(Afvigelse; "G/L Account"."Revised Budget Amount" - "G/L Account"."Net Change")
                {
                }
                dataitem(BlankLineRepeater; "Integer")
                {
                    column(ReportForNavId_7;7)
                    {
                    }
                    column(BlankLineNo; BlankLineNo)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if BlankLineNo = 0 then CurrReport.Break;
                        BlankLineNo-=1;
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    BlankLineNo:="G/L Account"."No. of Blank Lines" + 1;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                //CALCFIELDS("Net Change","Balance at Date");
                //>>DST
                "G/L Account".CalcFields("G/L Account"."Net Change", "G/L Account"."Balance at Date", "G/L Account"."Budgeted Amount", "G/L Account"."Revised Budget Amount");
                GLAccount2.CopyFilters("G/L Account");
                GLAccount2.SetRange(GLAccount2."No.", "G/L Account"."No.");
                GLAccount2.FindFirst;
                GLAccount2.SetRange(GLAccount2."Date Filter", FiscalYearStart, FiscalYearEnd);
                GLAccount2.CalcFields(GLAccount2."Budgeted Amount", GLAccount2."Revised Budget Amount");
                //Which budget to show:
                if Budgetoption = Budgetoption::"Periodens budget" then begin
                    BudgetAmount:="G/L Account"."Budgeted Amount";
                    RevisedBudgetAmount:="G/L Account"."Revised Budget Amount";
                end
                else
                begin
                    BudgetAmount:=GLAccount2."Budgeted Amount";
                    RevisedBudgetAmount:=GLAccount2."Revised Budget Amount";
                end;
                SkipCurrentLine:=false;
                if SkipEmptyLines then if "G/L Account"."Account Type" = "G/L Account"."account type"::Posting then begin
                        if("G/L Account"."Net Change" = 0) and ("G/L Account"."Balance at Date" = 0) and (BudgetAmount = 0) and (RevisedBudgetAmount = 0)then SkipCurrentLine:=true;
                    end;
                if SkipCurrentLine then CurrReport.Skip;
                if PrintToExcel then MakeExcelDataBody;
                //<<DST
                if ChangeGroupNo then begin
                    PageGroupNo+=1;
                    ChangeGroupNo:=false;
                end;
                ChangeGroupNo:="G/L Account"."New Page";
            end;
            trigger OnPreDataItem()
            begin
                //>>DST
                if PL_Only then "G/L Account".SetRange("G/L Account"."Income/Balance", "G/L Account"."income/balance"::"Income Statement");
                if BudgetFilterText = '' then "G/L Account".SetRange("G/L Account"."Budget Filter", 'INGEN');
                if "G/L Account".GetFilter("G/L Account"."Revised Budget Filter") = '' then "G/L Account".Copyfilter("G/L Account"."Budget Filter", "G/L Account"."Revised Budget Filter");
                BudgetFilterText:="G/L Account".GetFilter("G/L Account"."Budget Filter");
                RevBudgetFilterText:="G/L Account".GetFilter("G/L Account"."Revised Budget Filter");
                //<<DST
                PageGroupNo:=0;
                ChangeGroupNo:=false;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(PrintToExcel; PrintToExcel)
                {
                    ApplicationArea = Basic;
                    Caption = 'Udskriv til Excel';
                }
                field(SkipEmptyLines; SkipEmptyLines)
                {
                    ApplicationArea = Basic;
                    Caption = 'Skip tomme lonier';
                }
                field(PL_Only; PL_Only)
                {
                    ApplicationArea = Basic;
                    Caption = 'Kun resultatopgørelse';
                }
                field(Budgetoption; Budgetoption)
                {
                    ApplicationArea = Basic;
                    Caption = 'Vis budget for';
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    }
    trigger OnPostReport()
    begin
        //>>DST
        if PrintToExcel then CreateExcelbook;
    //<<DST
    end;
    trigger OnPreReport()
    var
        DKSGLAccountRapportering: Record "DKS G/L Account Rapportering";
    begin
        GLFilter:="G/L Account".GetFilters;
        PeriodText:="G/L Account".GetFilter("Date Filter");
        //>>DST
        // NAVK.01 >>
        if DKSGLAccountRapportering.WritePermission then begin
            // NAVK.01 <<
            DKSReporFunctions.UpdateChartOfAccounts;
            DKSReporFunctions.UpdateGLEntryReportingTable;
        // NAVK.01 >>
        end;
        // NAVK.01 <<
        if PrintToExcel then Commit; //Sikrer, at der bliver skrevet - hvilket ikke sker ved normalt..
        GLFilter:="G/L Account".GetFilters;
        PeriodText:="G/L Account".GetFilter("Date Filter");
        BudgetFilterText:="G/L Account".GetFilter("G/L Account"."Budget Filter");
        RevBudgetFilterText:="G/L Account".GetFilter("G/L Account"."Revised Budget Filter");
        AfdFilterTxt:="G/L Account".GetFilter("G/L Account"."Global Dimension 1 Filter");
        AktivFilterTxt:="G/L Account".GetFilter("G/L Account"."Global Dimension 2 Filter");
        FunkFulterText:="G/L Account".GetFilter("G/L Account".Funktionsfilter);
        TradingParnFilterTxt:="G/L Account".GetFilter("G/L Account"."Trading partner Filter");
        ProjectFilterTxt:="G/L Account".GetFilter("G/L Account"."Projekt fase Filter");
        FiscalYearStart:=Dmy2date(1, 1, Date2dmy("G/L Account".GetRangeMin("G/L Account"."Date Filter"), 3));
        FiscalYearEnd:=Dmy2date(31, 12, Date2dmy("G/L Account".GetRangeMin("G/L Account"."Date Filter"), 3));
        if PrintToExcel then MakeExcelInfo;
    //<<DST
    end;
    var Text000: label 'Period: %1';
    GLFilter: Text;
    PeriodText: Text[30];
    Trial_BalanceCaptionLbl: label 'Trial Balance';
    CurrReport_PAGENOCaptionLbl: label 'Page';
    Net_ChangeCaptionLbl: label 'Net Change';
    BalanceCaptionLbl: label 'Balance';
    PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl: label 'Name';
    G_L_Account___Net_Change_CaptionLbl: label 'Debit';
    G_L_Account___Net_Change__Control22CaptionLbl: label 'Credit';
    G_L_Account___Balance_at_Date_CaptionLbl: label 'Debit';
    G_L_Account___Balance_at_Date__Control24CaptionLbl: label 'Credit';
    PageGroupNo: Integer;
    ChangeGroupNo: Boolean;
    BlankLineNo: Integer;
    ExcelBuf: Record "Excel Buffer" temporary;
    PrintToExcel: Boolean;
    CurrFormat: Text[30];
    DKSReporFunctions: Codeunit "DKS GL Reporting Functions";
    BudgetFilterText: Text[30];
    RevBudgetFilterText: Text[30];
    AfdFilterTxt: Text[250];
    AktivFilterTxt: Text[250];
    TradingParnFilterTxt: Text[250];
    FunkFulterText: Text[250];
    ProjectFilterTxt: Text[250];
    PL_Only: Boolean;
    Budgetoption: Option "Årets budget", "Periodens budget";
    BudgetAmount: Decimal;
    RevisedBudgetAmount: Decimal;
    Budgetlabel: Text[30];
    GLAccount2: Record "DKS G/L Account Rapportering";
    FiscalYearStart: Date;
    FiscalYearEnd: Date;
    SkipEmptyLines: Boolean;
    SkipCurrentLine: Boolean;
    Text001: label 'Trial Balance';
    Text002: label 'Data';
    Text003: label 'Debit';
    Text004: label 'Credit';
    Text005: label 'Company Name';
    Text006: label 'Report No.';
    Text007: label 'Report Name';
    Text008: label 'User ID';
    Text009: label 'Date';
    Text010: label 'G/L Filter';
    Text011: label 'Period Filter';
    ServerFileName: Text;
    procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(Format(Text005), false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(COMPANYNAME, false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn(Format(Text007), false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(Format(Text001), false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn(Format(Text006), false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn('50015', false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn(Format(Text008), false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(UserId, false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn(Format(Text009), false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(Today, false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn(Format(Text010), false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn("G/L Account".GetFilter("No."), false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn(Format(Text011), false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn("G/L Account".GetFilter("Date Filter"), false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn('Afd. Filter', false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(AfdFilterTxt, false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn('Akt. Filter', false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(AktivFilterTxt, false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn('Funk. Filter', false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(FunkFulterText, false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn('Trading Partner Filter', false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(TradingParnFilterTxt, false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn('Projekt Fase filter', false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(ProjectFilterTxt, false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn('Budget Filter', false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(BudgetFilterText, false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn('Rev. Budget Filter', false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(RevBudgetFilterText, false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;
    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.AddColumn("G/L Account".FieldCaption("No."), false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("G/L Account".FieldCaption(Name), false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Bevægelse', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Saldo', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Budget', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Rev. Budget', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Afvigelse', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
    end;
    procedure MakeExcelDataBody()
    var
        BlankFiller: Text[250];
    begin
        BlankFiller:=PadStr(' ', MaxStrLen(BlankFiller), ' ');
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn("G/L Account"."No.", false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Text);
        if "G/L Account".Indentation = 0 then ExcelBuf.AddColumn("G/L Account".Name, false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '@', ExcelBuf."cell type"::Text)
        else
            ExcelBuf.AddColumn(CopyStr(BlankFiller, 1, 2 * "G/L Account".Indentation) + "G/L Account".Name, false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '@', ExcelBuf."cell type"::Text);
        CurrFormat:='#,##0';
        case true of "G/L Account"."Net Change" = 0: begin
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Number);
        end;
        "G/L Account"."Net Change" <> 0: begin
            ExcelBuf.AddColumn("G/L Account"."Net Change", false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        case true of "G/L Account"."Balance at Date" = 0: begin
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Number);
        end;
        "G/L Account"."Balance at Date" <> 0: begin
            ExcelBuf.AddColumn("G/L Account"."Balance at Date", false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        case true of BudgetAmount = 0: begin
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Number);
        end;
        BudgetAmount <> 0: begin
            ExcelBuf.AddColumn(BudgetAmount, false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        case true of RevisedBudgetAmount = 0: begin
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Number);
        end;
        RevisedBudgetAmount <> 0: begin
            ExcelBuf.AddColumn(RevisedBudgetAmount, false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        case true of(RevisedBudgetAmount - "G/L Account"."Net Change") = 0: begin
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Number);
        end;
        (RevisedBudgetAmount - "G/L Account"."Net Change") <> 0: begin
            ExcelBuf.AddColumn(RevisedBudgetAmount - "G/L Account"."Net Change", false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
    end;
    procedure CreateExcelbook()
    begin
        // ExcelBuf.CreateBookAndOpenExcel(ServerFileName, Text002, Text001, COMPANYNAME, UserId);
        ExcelBuf.CreateNewBook(Text002);
        ExcelBuf.WriteSheet(Text001, COMPANYNAME, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename(ServerFileName);
        ExcelBuf.OpenExcel();
        Error('');
    end;
}
