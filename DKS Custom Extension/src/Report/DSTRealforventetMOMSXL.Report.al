Report 50018 "DST Real / forventet - MOMS XL"
{
    // // NAVK.01 PGR/20181122: Limited to SUPER users
    ProcessingOnly = true;

    dataset
    {
        dataitem("G/L Account"; "DKS G/L Account Rapportering")
        {
            DataItemTableView = sorting("No.")where("No."=filter('1'..'59999'));
            RequestFilterFields = "No.", "Account Type", "Date Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter", Funktionsfilter, "Trading partner Filter", "Projekt fase Filter", "Budget Filter";

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            trigger OnAfterGetRecord()
            begin
                for i:=1 to 10 do begin
                    Kol[i]:=0;
                end;
                if "G/L Account"."Account Type" = "G/L Account"."account type"::Posting then begin
                    "G/L Account".CalcFields("G/L Account"."Net Change", "G/L Account"."Balance at Date", "G/L Account"."Budgeted Amount", "G/L Account"."Vat Amount");
                    //Find LastFiscalYear
                    LastYearFigure:=0;
                    GLAccountLastYear.CopyFilters("G/L Account");
                    GLAccountLastYear.SetRange(GLAccountLastYear."Date Filter", FiscalYearStart, FiscalYearEnd);
                    GLAccountLastYear.SetRange(GLAccountLastYear."No.", "G/L Account"."No.");
                    GLAccountLastYear.FindFirst;
                    GLAccountLastYear.SetRange(GLAccountLastYear."Date Filter", (CalcDate('<-1Y>', FiscalYearStart)), (CalcDate('<-1Y>', FiscalYearEnd)));
                    GLAccountLastYear.CalcFields(GLAccountLastYear."Net Change", GLAccountLastYear."Vat Amount");
                    Kol[1]:=GLAccountLastYear."Net Change" + GLAccountLastYear."Vat Amount";
                    //Find BudgetEntireYear
                    GLAccountLastYear.SetRange(GLAccountLastYear."Date Filter", FiscalYearStart, FiscalYearEnd);
                    GLAccountLastYear.CalcFields(GLAccountLastYear."Budgeted Amount");
                    Kol[2]:=GLAccountLastYear."Budgeted Amount";
                    Clear("VAT Setup");
                    "VAT Setup".SetFilter("VAT Setup"."VAT Bus. Posting Group", AfdFilterTxt);
                    "VAT Setup".SetRange("VAT Setup"."VAT Prod. Posting Group", "G/L Account"."VAT Prod. Posting Group");
                    "VAT Setup".SetRange("VAT Setup"."VAT Calculation Type", "VAT Setup"."vat calculation type"::"Normal VAT");
                    "VAT Setup".SetFilter("VAT Setup".Kommunemoms, '<>%1', 0); //130411
                    if "VAT Setup".FindFirst then VatMarking:='*'
                    else
                        VatMarking:='';
                    Kol[3]:=GLAccountLastYear."Budgeted Amount" - (GLAccountLastYear."Budgeted Amount" * "VAT Setup".Kommunemoms / (100 + "VAT Setup".Kommunemoms)); //130411
                    //Særregel moms af driftstilskud
                    if "G/L Account"."No." = '13016' then Kol[3]:=0;
                    Kol[4]:="G/L Account"."Net Change" + "G/L Account"."Vat Amount";
                    //Kol[5]:=Kol[4]-(Kol[4]*"VAT Setup"."VAT %"/(100+"VAT Setup"."VAT %"));
                    Kol[5]:=Kol[4] - (Kol[4] * "VAT Setup".Kommunemoms / (100 + "VAT Setup".Kommunemoms)); //130411
                    //Særregel moms af driftstilskud
                    if "G/L Account"."No." = '13016' then Kol[5]:=0;
                    //Forventet hele året Inkl. moms
                    if BeregningsMetodeForventet = Beregningsmetodeforventet::Gennemsnit then Kol[6]:=Kol[4] / AntalMaanederGaaet * 12
                    else
                        Kol[6]:=Kol[4] + Kol[2] - "G/L Account"."Budgeted Amount";
                    BudgetedAmountExVat:="G/L Account"."Budgeted Amount" - ("G/L Account"."Budgeted Amount" * "VAT Setup".Kommunemoms / (100 + "VAT Setup".Kommunemoms)); //130411
                    //Særregel moms af driftstilskud
                    if "G/L Account"."No." = '13016' then BudgetedAmountExVat:=0;
                    //("G/L Account"."Budgeted Amount"*"VAT Setup"."VAT %"/(100+"VAT Setup"."VAT %"));
                    //Kol[7]:=Kol[5]+Kol[3]-BudgetedAmountExVat; 23-08-12
                    Kol[7]:=Kol[6] - (Kol[6] * "VAT Setup".Kommunemoms / (100 + "VAT Setup".Kommunemoms)); //23-08-12
                    Kol[8]:=-Kol[6] + Kol[2];
                    Kol[9]:=-Kol[7] + Kol[3];
                    CreateTotalBuffer("G/L Account"."No.", Kol[1], Kol[2], Kol[3], Kol[4], Kol[5], Kol[6], Kol[7], Kol[8], Kol[9], Kol[10]);
                end
                else
                begin
                    VatMarking:='';
                    if "G/L Account".Totaling <> '' then begin
                        TotalBufferTEMP.SetFilter(TotalBufferTEMP."Account No", "G/L Account".Totaling);
                        TotalBufferTEMP.CalcSums(Kol1, Kol2, Kol3, Kol4, Kol5, Kol6, Kol7, Kol8, Kol9, Kol10);
                        Kol[1]:=TotalBufferTEMP.Kol1;
                        Kol[2]:=TotalBufferTEMP.Kol2;
                        Kol[3]:=TotalBufferTEMP.Kol3;
                        Kol[4]:=TotalBufferTEMP.Kol4;
                        Kol[5]:=TotalBufferTEMP.Kol5;
                        Kol[6]:=TotalBufferTEMP.Kol6;
                        Kol[7]:=TotalBufferTEMP.Kol7;
                        Kol[8]:=TotalBufferTEMP.Kol8;
                        Kol[9]:=TotalBufferTEMP.Kol9;
                    end;
                end;
                //Incl. Moms
                if Kol[8] = 0 then Pct:=0
                else
                begin
                    if Kol[2] <> 0 then begin
                        if Kol[2] > 0 then Pct:=Kol[8] * 100 / Kol[2]
                        else
                            Pct:=-Kol[8] * 100 / Kol[2];
                    end
                    else if Kol[8] < 0 then Pct:=-100
                        else
                            Pct:=100;
                end;
                //Pct:=ROUND(Pct,0.01,'='); //020517
                //Ex. Moms
                if Kol[9] = 0 then Pct_ex:=0
                else
                begin
                    if Kol[3] <> 0 then begin
                        if Kol[3] > 0 then Pct_ex:=Kol[9] * 100 / Kol[3]
                        else
                            Pct_ex:=-Kol[9] * 100 / Kol[3];
                    end
                    else if Kol[9] < 0 then Pct_ex:=-100
                        else
                            Pct_ex:=100;
                end;
                //Pct_ex:=ROUND(Pct_ex,0.01,'='); //020517
                case Detail of 1: begin
                    Kol[2]:=0;
                    Kol[4]:=0;
                    Kol[6]:=0;
                    Kol[8]:=0;
                    Pct:=0;
                end;
                2: begin
                    Kol[3]:=0;
                    Kol[5]:=0;
                    Kol[7]:=0;
                    Kol[9]:=0;
                    Pct_ex:=0;
                end;
                end;
                SkipCurrentLine:=false;
                if SkipEmptyLines then if "G/L Account"."Account Type" = "G/L Account"."account type"::Posting then begin
                        SkipCurrentLine:=true;
                        for i:=1 to 9 do begin
                            if Kol[i] <> 0 then SkipCurrentLine:=false;
                        end;
                        if Pct <> 0 then SkipCurrentLine:=false;
                        if Pct_ex <> 0 then SkipCurrentLine:=false;
                    end;
                if SkipCurrentLine then CurrReport.Skip;
                if PrintToExcel then MakeExcelDataBody;
            end;
            trigger OnPreDataItem()
            begin
                if BudgetFilterText = '' then "G/L Account".SetRange("G/L Account"."Budget Filter", 'INGEN');
                if "G/L Account".GetFilter("G/L Account"."Revised Budget Filter") = '' then "G/L Account".Copyfilter("G/L Account"."Budget Filter", "G/L Account"."Revised Budget Filter");
                if PL_Only then "G/L Account".SetRange("G/L Account"."Income/Balance", "G/L Account"."income/balance"::"Income Statement");
                BudgetFilterText:="G/L Account".GetFilter("G/L Account"."Budget Filter");
                RevBudgetFilterText:="G/L Account".GetFilter("G/L Account"."Revised Budget Filter");
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(BeregningsMetodeForventet; BeregningsMetodeForventet)
                {
                    ApplicationArea = Basic;
                    Caption = 'Beregningsmetode forventet resultat';
                }
                field(Detail; Detail)
                {
                    ApplicationArea = Basic;
                    Caption = 'Visning';
                }
                field(SkipEmptyLines; SkipEmptyLines)
                {
                    ApplicationArea = Basic;
                    Caption = 'Skip tomme linier';
                }
                field(PL_Only; PL_Only)
                {
                    ApplicationArea = Basic;
                    Caption = 'Kun resultatopgørelse';
                }
            }
        }
        actions
        {
        }
        trigger OnOpenPage()
        begin
            SkipEmptyLines:=true;
        end;
    }
    labels
    {
    }
    trigger OnPostReport()
    begin
        if PrintToExcel then CreateExcelbook;
    end;
    trigger OnPreReport()
    var
        DKSGLAccountRapportering: Record "DKS G/L Account Rapportering";
    begin
        PrintToExcel:=true;
        // NAVK.01 >>
        if DKSGLAccountRapportering.WritePermission then begin
            // NAVK.01 <<
            DKSReporFunctions.UpdateChartOfAccounts;
            DKSReporFunctions.UpdateGLEntryReportingTable;
        // NAVK.01 >>
        end;
        // NAVK.01 <<
        if PrintToExcel then Commit; // Sikrer at der skrives til 50017, hvad Exceldannelsen i sig selv ikke gør..
        TotalBufferTEMP.DeleteAll;
        GLFilter:="G/L Account".GetFilters;
        PeriodText:="G/L Account".GetFilter("Date Filter");
        BudgetFilterText:="G/L Account".GetFilter("G/L Account"."Budget Filter");
        //RevBudgetFilterText:="G/L Account".GETFILTER("G/L Account"."Revised Budget Filter");
        AfdFilterTxt:="G/L Account".GetFilter("G/L Account"."Global Dimension 1 Filter");
        AktivFilterTxt:="G/L Account".GetFilter("G/L Account"."Global Dimension 2 Filter");
        FunkFulterText:="G/L Account".GetFilter("G/L Account".Funktionsfilter);
        TradingParnFilterTxt:="G/L Account".GetFilter("G/L Account"."Trading partner Filter");
        ProjectFilterTxt:="G/L Account".GetFilter("G/L Account"."Projekt fase Filter");
        FiscalYearStart:=Dmy2date(1, 1, Date2dmy("G/L Account".GetRangeMin("G/L Account"."Date Filter"), 3));
        FiscalYearEnd:=Dmy2date(31, 12, Date2dmy("G/L Account".GetRangeMin("G/L Account"."Date Filter"), 3));
        AntalMaanederGaaet:=Date2dmy("G/L Account".GetRangemax("G/L Account"."Date Filter"), 2);
        if PrintToExcel then MakeExcelInfo;
    end;
    var ExcelBuf: Record "Excel Buffer" temporary;
    GLFilter: Text[250];
    PeriodText: Text[30];
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
    FiscalYearStart: Date;
    FiscalYearEnd: Date;
    LastYearFigure: Decimal;
    GLAccountLastYear: Record "DKS G/L Account Rapportering";
    BudgetEntireYear: Decimal;
    Pct: Decimal;
    Pct_ex: Decimal;
    Kol: array[10]of Decimal;
    "VAT Setup": Record "VAT Posting Setup";
    i: Integer;
    TotalBufferTEMP: Record "Buffer for reporting totals" temporary;
    BudgetedAmountExVat: Decimal;
    VatMarking: Text[1];
    Detail: Option Normalt, "Kun ekskl. moms", "Kun Inkl. moms";
    SkipEmptyLines: Boolean;
    SkipCurrentLine: Boolean;
    BeregningsMetodeForventet: Option Gennemsnit, Restbudget;
    AntalMaanederGaaet: Integer;
    Text000: label 'Period: %1';
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
    PL_Only: Boolean;
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
        ExcelBuf.AddInfoColumn('50018', false, false, false, false, '', ExcelBuf."cell type"::Text);
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
        //ExcelBuf.NewRow;
        //ExcelBuf.AddInfoColumn('Rev. Budget Filter',FALSE,'',TRUE,FALSE,FALSE,'');
        //ExcelBuf.AddInfoColumn(RevBudgetFilterText,FALSE,'',FALSE,FALSE,FALSE,'');
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;
    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.AddColumn("G/L Account".FieldCaption("No."), false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("G/L Account".FieldCaption(Name), false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Moms', false, '', true, false, true, '', ExcelBuf."cell type"::Text); //020517
        ExcelBuf.AddColumn('INKL. MOMS Regnskab sidste år', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('INKL. MOMS Budget hele året. Budget ' + BudgetFilterText, false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('EKSKL. MOMS Budget hele året. Budget ' + BudgetFilterText, false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('INKL. MOMS Realiseret pr. dato', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('EKSKL. MOMS Realiseret pr. dato', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('INKL. MOMS Forventet resultat hele året', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('EKSKL. MOMS Forventet resultat hele året', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('INKL. MOMS Afv. i kr. budget og forv. resultat', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('EKSKL. MOMS Afv. i kr. budget og forv. resultat', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Afv. i pct. af budget (inkl. moms)', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Afv. i pct. af budget (ekskl. moms)', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
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
        ExcelBuf.AddColumn(VatMarking, false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Text); //020517
        CurrFormat:='#,###';
        //1. talkolonne
        case true of Kol[1] = 0: begin
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Kol[1] <> 0: begin
            ExcelBuf.AddColumn(Kol[1], false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        //2. talkolonne
        case true of Kol[2] = 0: begin
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Kol[2] <> 0: begin
            ExcelBuf.AddColumn(Kol[2], false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        //3. talkolonne
        case true of Kol[3] = 0: begin
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Kol[3] <> 0: begin
            ExcelBuf.AddColumn(Kol[3], false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        //4. talkolonne
        case true of Kol[4] = 0: begin
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Kol[4] <> 0: begin
            ExcelBuf.AddColumn(Kol[4], false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        //5. talkolonne
        case true of Kol[5] = 0: begin
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Kol[5] <> 0: begin
            ExcelBuf.AddColumn(Kol[5], false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        //6. talkolonne
        case true of Kol[6] = 0: begin
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Kol[6] <> 0: begin
            ExcelBuf.AddColumn(Kol[6], false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        //7. talkolonne
        case true of Kol[7] = 0: begin
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Kol[7] <> 0: begin
            ExcelBuf.AddColumn(Kol[7], false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        //8. talkolonne
        case true of Kol[8] = 0: begin
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Kol[8] <> 0: begin
            ExcelBuf.AddColumn(Kol[8], false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        //9. talkolonne
        case true of Kol[9] = 0: begin
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Kol[9] <> 0: begin
            ExcelBuf.AddColumn(Kol[9], false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        //10. talkolonne
        case true of Pct = 0: begin
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Pct <> 0: begin
            ExcelBuf.AddColumn(Pct, false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        //11. talkolonne
        case true of Pct_ex = 0: begin
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Pct_ex <> 0: begin
            ExcelBuf.AddColumn(Pct_ex, false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
    end;
    procedure CreateExcelbook()
    begin
        //ExcelBuf.CreateBook;
        //ExcelBuf.CreateSheet(Text002,Text001,COMPANYNAME,USERID);
        //ExcelBuf.GiveUserControl;
        // ExcelBuf.CreateBookAndOpenExcel(ServerFileName, Text002, Text001, COMPANYNAME, UserId);
        ExcelBuf.CreateNewBook(Text002);
        ExcelBuf.WriteSheet(Text001, COMPANYNAME, UserId);
        ExcelBuf.CloseBook();
        ExcelBuf.SetFriendlyFilename(ServerFileName);
        ExcelBuf.OpenExcel();
        Error('');
    end;
    procedure CreateTotalBuffer(AccountNo: Code[10]; Amount1: Decimal; Amount2: Decimal; Amount3: Decimal; Amount4: Decimal; Amount5: Decimal; Amount6: Decimal; Amount7: Decimal; Amount8: Decimal; Amount9: Decimal; Amount10: Decimal)
    begin
        TotalBufferTEMP."Account No":=AccountNo;
        TotalBufferTEMP.Kol1:=Amount1;
        TotalBufferTEMP.Kol2:=Amount2;
        TotalBufferTEMP.Kol3:=Amount3;
        TotalBufferTEMP.Kol4:=Amount4;
        TotalBufferTEMP.Kol5:=Amount5;
        TotalBufferTEMP.Kol6:=Amount6;
        TotalBufferTEMP.Kol7:=Amount7;
        TotalBufferTEMP.Kol8:=Amount8;
        TotalBufferTEMP.Kol9:=Amount9;
        TotalBufferTEMP.Kol10:=Amount10;
        TotalBufferTEMP.Insert;
    end;
}
