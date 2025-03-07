Report 50005 "DST_Detail Trial Balance"
{
    // // NAVK.01 PGR/20181122: Limited to SUPER users
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/DST_Detail Trial Balance.rdlc';
    Caption = 'Detail Trial Balance';

    dataset
    {
        dataitem("G/L Account"; "DKS G/L Account Rapportering")
        {
            DataItemTableView = where("Account Type"=const(Posting));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Income/Balance", "Date Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter", Funktionsfilter, "Trading partner Filter", "Projekt fase Filter";

            column(ReportForNavId_6710;6710)
            {
            }
            column(PeriodGLDtFilter; StrSubstNo(Text000, GLDateFilter))
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(ExcludeBalanceOnly; ExcludeBalanceOnly)
            {
            }
            column(PrintReversedEntries; PrintReversedEntries)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(PrintClosingEntries; PrintClosingEntries)
            {
            }
            column(PrintOnlyCorrections; PrintOnlyCorrections)
            {
            }
            column(GLAccTableCaption; "G/L Account".TableCaption + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(EmptyString;'')
            {
            }
            column(No_GLAcc; "G/L Account"."No.")
            {
            }
            column(DetailTrialBalCaption; DetailTrialBalCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(PeriodCaption; PeriodCaptionLbl)
            {
            }
            column(OnlyCorrectionsCaption; OnlyCorrectionsCaptionLbl)
            {
            }
            column(NetChangeCaption; NetChangeCaptionLbl)
            {
            }
            column(GLEntryDebitAmtCaption; GLEntryDebitAmtCaptionLbl)
            {
            }
            column(GLEntryCreditAmtCaption; GLEntryCreditAmtCaptionLbl)
            {
            }
            column(GLBalCaption; GLBalCaptionLbl)
            {
            }
            column(OBS; OBS)
            {
            }
            column(ReasonFilter; ReasonFilter)
            {
            }
            dataitem(PageCounter; "Integer")
            {
                DataItemTableView = sorting(Number)where(Number=const(1));

                column(ReportForNavId_8098;8098)
                {
                }
                column(Name_GLAcc; "G/L Account".Name)
                {
                }
                column(StartBalance; StartBalance)
                {
                AutoFormatType = 1;
                }
                dataitem("G/L Entry"; "DKS G/L Entry Rapportering")
                {
                    DataItemLink = "G/L Account No."=field("No."), "Posting Date"=field("Date Filter"), "Global Dimension 1 Code"=field("Global Dimension 1 Filter"), "Global Dimension 2 Code"=field("Global Dimension 2 Filter"), "Business Unit Code"=field("Business Unit Filter"), "Funktion (Dim)"=field(Funktionsfilter), "Trading Partner (Dim)"=field("Trading partner Filter"), "Projektfase (Dim)"=field("Projekt fase Filter");
                    DataItemLinkReference = "G/L Account";
                    DataItemTableView = sorting("G/L Account No.", "Posting Date");
                    RequestFilterFields = "Reason Code";

                    column(ReportForNavId_7069;7069)
                    {
                    }
                    column(VATAmount_GLEntry; "G/L Entry"."VAT Amount")
                    {
                    IncludeCaption = true;
                    }
                    column(DebitAmount_GLEntry; "G/L Entry"."Debit Amount")
                    {
                    }
                    column(CreditAmount_GLEntry; "G/L Entry"."Credit Amount")
                    {
                    }
                    column(PostingDate_GLEntry; Format("G/L Entry"."Posting Date", 0, 1))
                    {
                    }
                    column(DocumentNo_GLEntry; "G/L Entry"."Document No.")
                    {
                    }
                    column(Description_GLEntry; "G/L Entry".Description)
                    {
                    }
                    column(GLBalance; GLBalance)
                    {
                    AutoFormatType = 1;
                    }
                    column(EntryNo_GLEntry; "G/L Entry"."Entry No.")
                    {
                    }
                    column(ClosingEntry; ClosingEntry)
                    {
                    }
                    column(Reversed_GLEntry; "G/L Entry".Reversed)
                    {
                    }
                    column(GlobalDim1_GLEntry; "G/L Entry"."Global Dimension 1 Code")
                    {
                    }
                    column(GlobalDim2_GLEntry; "G/L Entry"."Global Dimension 2 Code")
                    {
                    }
                    column(FunktionDim_GLEntry; "G/L Entry"."Funktion (Dim)")
                    {
                    }
                    column(TradingDim_GLEntry; "G/L Entry"."Trading Partner (Dim)")
                    {
                    }
                    column(ProjektDim_GLEntry; "G/L Entry"."Projektfase (Dim)")
                    {
                    }
                    column(ReasonCode_GLEntry; "G/L Entry"."Reason Code")
                    {
                    }
                    column(Amount_GLEntry; "G/L Entry".Amount)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if PrintOnlyCorrections then if not(("G/L Entry"."Debit Amount" < 0) or ("G/L Entry"."Credit Amount" < 0))then CurrReport.Skip;
                        if not PrintReversedEntries and "G/L Entry".Reversed then CurrReport.Skip;
                        GLBalance:=GLBalance + "G/L Entry".Amount;
                        if("G/L Entry"."Posting Date" = ClosingDate("G/L Entry"."Posting Date")) and not PrintClosingEntries then begin
                            "G/L Entry"."Debit Amount":=0;
                            "G/L Entry"."Credit Amount":=0;
                        end;
                        if "G/L Entry"."Posting Date" = ClosingDate("G/L Entry"."Posting Date")then ClosingEntry:=true
                        else
                            ClosingEntry:=false;
                    end;
                    trigger OnPreDataItem()
                    begin
                        GLBalance:=StartBalance;
                        CurrReport.CreateTotals("G/L Entry".Amount, "G/L Entry"."Debit Amount", "G/L Entry"."Credit Amount", "G/L Entry"."VAT Amount");
                    end;
                }
                trigger OnAfterGetRecord()
                begin
                    CurrReport.PrintonlyIfDetail:=ExcludeBalanceOnly or (StartBalance = 0);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                StartBalance:=0;
                if GLDateFilter <> '' then if "G/L Account".GetRangeMin("G/L Account"."Date Filter") <> 0D then begin
                        "G/L Account".SetRange("G/L Account"."Date Filter", 0D, ClosingDate("G/L Account".GetRangeMin("G/L Account"."Date Filter") - 1));
                        "G/L Account".CalcFields("G/L Account"."Net Change");
                        StartBalance:="G/L Account"."Net Change";
                        "G/L Account".SetFilter("G/L Account"."Date Filter", GLDateFilter);
                    end;
                if PrintOnlyOnePerPage then begin
                    GLEntryPage.Reset;
                    GLEntryPage.SetRange("G/L Account No.", "G/L Account"."No.");
                    if CurrReport.PrintonlyIfDetail and GLEntryPage.FindFirst then PageGroupNo:=PageGroupNo + 1;
                end;
            end;
            trigger OnPreDataItem()
            begin
                PageGroupNo:=1;
                CurrReport.NewPagePerRecord:=PrintOnlyOnePerPage;
            end;
        }
    }
    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field(NewPageperGLAcc; PrintOnlyOnePerPage)
                    {
                        ApplicationArea = Basic;
                        Caption = 'New Page per G/L Acc.';
                    }
                    field(ExcludeGLAccsHaveBalanceOnly; ExcludeBalanceOnly)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Exclude G/L Accs. That Have a Balance Only';
                        MultiLine = true;
                    }
                    field(InclClosingEntriesWithinPeriod; PrintClosingEntries)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Include Closing Entries Within the Period';
                        MultiLine = true;
                    }
                    field(IncludeReversedEntries; PrintReversedEntries)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Include Reversed Entries';
                    }
                    field(PrintCorrectionsOnly; PrintOnlyCorrections)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Print Corrections Only';
                    }
                }
            }
        }
        actions
        {
        }
    }
    labels
    {
    PostingDateCaption='Posting Date';
    DocNoCaption='Document No.';
    DescCaption='Description';
    VATAmtCaption='VAT Amount';
    EntryNoCaption='Entry No.';
    }
    trigger OnPreReport()
    var
        DKSGLAccountRapportering: Record "DKS G/L Account Rapportering";
    begin
        GLFilter:="G/L Account".GetFilters;
        GLDateFilter:="G/L Account".GetFilter("Date Filter");
        //>>DST
        // NAVK.01 >>
        if DKSGLAccountRapportering.WritePermission then begin
            // NAVK.01 <<
            DKSReporFunctions.UpdateChartOfAccounts;
            DKSReporFunctions.UpdateGLEntryReportingTable;
        // NAVK.01 >>
        end;
        // NAVK.01 <<
        if "G/L Entry".GetFilter("G/L Entry"."Reason Code") <> '' then OBS:='Der er sat filter på feltet Årsagskode. Dette filter gælder kun for de poster der vises, og IKKE for primosaldiene!'
        else
            OBS:='';
        ReasonFilter:="G/L Entry".GetFilter("G/L Entry"."Reason Code");
    //<<DST
    end;
    var Text000: label 'Period: %1';
    GLDateFilter: Text[30];
    GLFilter: Text;
    GLBalance: Decimal;
    StartBalance: Decimal;
    PrintOnlyOnePerPage: Boolean;
    ExcludeBalanceOnly: Boolean;
    PrintClosingEntries: Boolean;
    PrintOnlyCorrections: Boolean;
    PrintReversedEntries: Boolean;
    PageGroupNo: Integer;
    GLEntryPage: Record "G/L Entry";
    ClosingEntry: Boolean;
    DetailTrialBalCaptionLbl: label 'Detail Trial Balance';
    PageCaptionLbl: label 'Page';
    BalanceCaptionLbl: label 'This also includes general ledger accounts that only have a balance.';
    PeriodCaptionLbl: label 'This report also includes closing entries within the period.';
    OnlyCorrectionsCaptionLbl: label 'Only corrections are included.';
    NetChangeCaptionLbl: label 'Net Change';
    GLEntryDebitAmtCaptionLbl: label 'Debit';
    GLEntryCreditAmtCaptionLbl: label 'Credit';
    GLBalCaptionLbl: label 'Balance';
    "--DST--": Integer;
    DKSReporFunctions: Codeunit "DKS GL Reporting Functions";
    OBS: Text[250];
    ReasonFilter: Text[250];
    procedure InitializeRequest(NewPrintOnlyOnePerPage: Boolean; NewExcludeBalanceOnly: Boolean; NewPrintClosingEntries: Boolean; NewPrintReversedEntries: Boolean; NewPrintOnlyCorrections: Boolean)
    begin
        PrintOnlyOnePerPage:=NewPrintOnlyOnePerPage;
        ExcludeBalanceOnly:=NewExcludeBalanceOnly;
        PrintClosingEntries:=NewPrintClosingEntries;
        PrintReversedEntries:=NewPrintReversedEntries;
        PrintOnlyCorrections:=NewPrintOnlyCorrections;
    end;
}
