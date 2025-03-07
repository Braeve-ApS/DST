Report 50059 "DKS Børnehusene - MOMS"
{
    // 
    // Denne rapport er bygget på grundlag af R50018.
    // Formålet er, at den skal anvendes af Børnehusene (Louisegården, Mariagaarden, Børnehus Marthagården(Emagrd)).
    // Forventet resultat beregnes på grund af en gennemsnitsbetragtning.
    // Rapporten følger ikke helt strukturen i kontoplanen.
    // Hvert regnskab har én konto som skal afvige i forhold til momsberegning.
    // Tallet i kol[14] vises ikke, men er udelukkende ment som en kontrol af, at alle konti i resultatopgørelsen er med...
    // 
    // Kol[1]:= Realiseret sidste år inkl moms
    // Kol[2]:= Budget hele året inkl moms
    // Kol[3]:= Budget hele året ex moms
    // Kol[4]:= Extra Bevilling (Budget) inkl. moms
    // Kol[5]:= Extra Bevilling (Budget) Ex. moms
    // Kol[6]:= Rev. budget inkl. moms (2+4)
    // Kol[7]:= Rev. budget ex. moms (3+5)
    // Kol[8]:= Realiseret inkl. moms
    // Kol[9]:= Realiseret Ex. moms
    // Kol[10]:= Forventet (beregnet) inkl. moms
    // Kol[11]:= Forventet (beregnet) ex. moms
    // Kol[12]:= Afvigelse inkl. moms
    // Kol[13]:= Afvigelse ex. moms
    // Kol[14]:= Kontrol
    // 
    // Kol[15]:= Realiseret Sidste år EX moms (kommet til efter de andre er lavet
    // 
    // En konto er tilegnet moms af tilskud. denne konto skal IKKE vises i EX moms kolonner.
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/DKS Børnehusene - MOMS.rdlc';

    dataset
    {
        dataitem("DKS Kontorækker momsbalancer"; "DKS Kontorækker momsbalancer")
        {
            DataItemTableView = sorting(Type, "Rækkefølge")where(Type=filter(Rapportgruppering));

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            dataitem("G/L Account"; "G/L Account")
            {
                DataItemTableView = sorting("No.")where("Income/Balance"=filter("Income Statement"));
                RequestFilterFields = "Date Filter", "Budget Filter";

                column(ReportForNavId_1000000001;1000000001)
                {
                }
                trigger OnAfterGetRecord()
                begin
                    for i:=1 to 15 do begin
                        Kol[i]:=0;
                    end;
                    if "G/L Account"."Account Type" = "G/L Account"."account type"::Posting then begin
                        "G/L Account".CalcFields("G/L Account"."Net Change", "G/L Account"."Balance at Date", "G/L Account"."Budgeted Amount");
                        //Kontrol
                        Kol[14]:="G/L Account"."Net Change";
                        //Moms
                        Clear("VAT Setup");
                        "VAT Setup".SetFilter("VAT Setup"."VAT Bus. Posting Group", "G/L Account"."VAT Bus. Posting Group");
                        "VAT Setup".SetRange("VAT Setup"."VAT Prod. Posting Group", "G/L Account"."VAT Prod. Posting Group");
                        "VAT Setup".SetRange("VAT Setup"."VAT Calculation Type", "VAT Setup"."vat calculation type"::"Normal VAT");
                        "VAT Setup".SetFilter("VAT Setup".Kommunemoms, '<>%1', 0); //130411
                        if "VAT Setup".FindFirst then begin
                            VatMarking:='*';
                        end
                        else
                            VatMarking:='';
                        //Find LastFiscalYear
                        LastYearFigure:=0;
                        GLAccountLastYear.CopyFilters("G/L Account");
                        GLAccountLastYear.SetRange(GLAccountLastYear."Date Filter", FiscalYearStart, FiscalYearEnd);
                        GLAccountLastYear.SetRange(GLAccountLastYear."No.", "G/L Account"."No.");
                        GLAccountLastYear.FindFirst;
                        GLAccountLastYear.SetRange(GLAccountLastYear."Date Filter", (CalcDate('<-1Y>', FiscalYearStart)), (CalcDate('<-1Y>', FiscalYearEnd)));
                        GLAccountLastYear.CalcFields(GLAccountLastYear."Net Change");
                        Kol[1]:=GLAccountLastYear."Net Change"; // OK
                        if "G/L Account"."No." = KontoMomsAfDriftstilskud then Kol[15]:=0 //Særregel
                        else
                            Kol[15]:=Kol[1] - (Kol[1] * "VAT Setup".Kommunemoms / (100 + "VAT Setup".Kommunemoms)); //OK
                        //Find BudgetEntireYear
                        Kol[2]:="G/L Account"."Budgeted Amount"; //OK
                        if "G/L Account"."No." = KontoMomsAfDriftstilskud then Kol[3]:=0 //Særregel
                        else
                            Kol[3]:=Kol[2] - (Kol[2] * "VAT Setup".Kommunemoms / (100 + "VAT Setup".Kommunemoms)); //OK
                        //Extra tilskud
                        GLAccount2.Get("G/L Account"."No.");
                        GLAccount2.CopyFilters("G/L Account");
                        GLAccount2.SetRange(GLAccount2."Budget Filter", BudgetExtraFund);
                        GLAccount2.CalcFields(GLAccount2."Budgeted Amount");
                        Kol[4]:=GLAccount2."Budgeted Amount"; //OK
                        if "G/L Account"."No." = KontoMomsAfDriftstilskud then Kol[5]:=0 //Særregel
                        else
                            Kol[5]:=Kol[4] - (Kol[4] * "VAT Setup".Kommunemoms / (100 + "VAT Setup".Kommunemoms)); //OK
                        //Rev.Budget
                        Kol[6]:=Kol[2] + Kol[4]; //OK
                        Kol[7]:=Kol[3] + Kol[5]; //OK
                        //Realiseret
                        Kol[8]:="G/L Account"."Net Change";
                        if "G/L Account"."No." = KontoMomsAfDriftstilskud then Kol[9]:=0 //Særregel
                        else
                            Kol[9]:=Kol[8] - (Kol[8] * "VAT Setup".Kommunemoms / (100 + "VAT Setup".Kommunemoms)); //OK
                        //Forventet hele året (gennemsnit)
                        Kol[10]:=Kol[8] / AntalMaanederGaaet * 12; //OK
                        Kol[11]:=Kol[10] - (Kol[10] * "VAT Setup".Kommunemoms / (100 + "VAT Setup".Kommunemoms)); //OK
                        //Afvigelse
                        Kol[12]:=Kol[10] - Kol[6];
                        Kol[13]:=Kol[11] - Kol[7];
                        CreateTotalBuffer("G/L Account"."No.", Kol[1], Kol[2], Kol[3], Kol[4], Kol[5], Kol[6], Kol[7], Kol[8], Kol[9], Kol[10], Kol[11], Kol[12], Kol[13], Kol[14], Kol[15]);
                    end
                    else
                    begin
                        if "G/L Account".Totaling <> '' then begin
                            TotalBufferTEMP.SetFilter(TotalBufferTEMP."Account No", "G/L Account".Totaling);
                            TotalBufferTEMP.CalcSums(Kol1, Kol2, Kol3, Kol4, Kol5, Kol6, Kol7, Kol8, Kol9, Kol10, Kol11, Kol12, Kol13, Kol15);
                            Kol[1]:=TotalBufferTEMP.Kol1;
                            Kol[2]:=TotalBufferTEMP.Kol2;
                            Kol[3]:=TotalBufferTEMP.Kol3;
                            Kol[4]:=TotalBufferTEMP.Kol4;
                            Kol[5]:=TotalBufferTEMP.Kol5;
                            Kol[6]:=TotalBufferTEMP.Kol6;
                            Kol[7]:=TotalBufferTEMP.Kol7;
                            Kol[8]:=TotalBufferTEMP.Kol8;
                            Kol[9]:=TotalBufferTEMP.Kol9;
                            Kol[10]:=TotalBufferTEMP.Kol10;
                            Kol[11]:=TotalBufferTEMP.Kol11;
                            Kol[12]:=TotalBufferTEMP.Kol12;
                            Kol[13]:=TotalBufferTEMP.Kol13;
                            //Kol[14]:=TotalBufferTEMP.Kol14;//Kontrol - skal ikke vises
                            Kol[15]:=TotalBufferTEMP.Kol15;
                        end;
                    end;
                    SkipCurrentLine:=false;
                    if SkipEmptyLines then if "G/L Account"."Account Type" = "G/L Account"."account type"::Posting then begin
                            SkipCurrentLine:=true;
                            for i:=1 to 15 do begin
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
                    PrintToExcel:=true;
                    "G/L Account".SetFilter("G/L Account"."No.", "DKS Kontorækker momsbalancer".Kontofilter);
                    if BudgetFilterText = '' then "G/L Account".SetRange("G/L Account"."Budget Filter", 'INGEN');
                    BudgetFilterText:="G/L Account".GetFilter("G/L Account"."Budget Filter");
                end;
            }
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(BudgetExtraFund; BudgetExtraFund)
                {
                    ApplicationArea = Basic;
                    Caption = 'Budget ekstra bevilling';
                    TableRelation = "G/L Budget Name".Name;
                }
                field(KontoMomsAfDriftstilskud; KontoMomsAfDriftstilskud)
                {
                    ApplicationArea = Basic;
                    Caption = 'Konto: Moms af driftstilskud';
                    TableRelation = "G/L Account"."No.";
                }
                field(SkipEmptyLines; SkipEmptyLines)
                {
                    ApplicationArea = Basic;
                    Caption = 'Skip tomme linier';
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
        if PrintToExcel then CreateExcelbook;
    end;
    trigger OnPreReport()
    begin
        TotalBufferTEMP.DeleteAll;
        GLFilter:="G/L Account".GetFilters;
        PeriodText:="G/L Account".GetFilter("Date Filter");
        BudgetFilterText:="G/L Account".GetFilter("G/L Account"."Budget Filter");
        AfdFilterTxt:="G/L Account".GetFilter("G/L Account"."Global Dimension 1 Filter");
        AktivFilterTxt:="G/L Account".GetFilter("G/L Account"."Global Dimension 2 Filter");
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
    GLAccountLastYear: Record "G/L Account";
    BudgetEntireYear: Decimal;
    Pct: Decimal;
    Pct_ex: Decimal;
    Kol: array[15]of Decimal;
    "VAT Setup": Record "VAT Posting Setup";
    i: Integer;
    TotalBufferTEMP: Record "Buffer for reporting totals" temporary;
    BudgetedAmountExVat: Decimal;
    VatMarking: Text[1];
    Detail: Option Normalt, "Kun ekskl. moms", "Kun Inkl. moms";
    SkipEmptyLines: Boolean;
    SkipCurrentLine: Boolean;
    BudgetExtraFund: Code[20];
    GLAccount2: Record "G/L Account";
    BudgetRevised: Code[20];
    AntalMaanederGaaet: Integer;
    PrintSection: Boolean;
    KontoMomsAfDriftstilskud: Code[20];
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
    procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(Format(Text005), false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(COMPANYNAME, false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text007), false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(Format(Text001), false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text006), false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(Report::"DKS Børnehusene - MOMS", false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text008), false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(UserId, false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text009), false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(Today, false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text010), false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn("G/L Account".GetFilter("No."), false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(Format(Text011), false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn("G/L Account".GetFilter("Date Filter"), false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn('Budget Filter', false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(BudgetFilterText, false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.NewRow();
        ExcelBuf.AddInfoColumn('Ekstra bevilling Budget', false, true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddInfoColumn(BudgetExtraFund, false, false, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;
    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.AddColumn("G/L Account".FieldCaption("No."), false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn("G/L Account".FieldCaption(Name), false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Moms', false, '', true, false, true, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('Regnskab sidste år INKL. MOMS', false, '', true, false, true, '', ExcelBuf."cell type"::Text); //Kol1
        ExcelBuf.AddColumn('Regnskab sidste år EX. MOMS', false, '', true, false, true, '', ExcelBuf."cell type"::Text); //Kol15
        ExcelBuf.AddColumn('Budget oprindeligt INKL. MOMS Budget ' + BudgetFilterText, false, '', true, false, true, '', ExcelBuf."cell type"::Text); //kol2
        ExcelBuf.AddColumn('Budget oprindeligt EX. MOMS Budget ' + BudgetFilterText, false, '', true, false, true, '', ExcelBuf."cell type"::Text); //kol3
        ExcelBuf.AddColumn('Ekstra Bevilling INKL. MOMS. Budget ' + BudgetExtraFund, false, '', true, false, true, '', ExcelBuf."cell type"::Text); //kol4
        ExcelBuf.AddColumn('Ekstra Bevilling EX. MOMS. Budget ' + BudgetExtraFund, false, '', true, false, true, '', ExcelBuf."cell type"::Text); //kol5
        ExcelBuf.AddColumn('Revideret Budget INKL. MOMS', false, '', true, false, true, '', ExcelBuf."cell type"::Text); //kol6
        ExcelBuf.AddColumn('Revideret Budget EX. MOMS', false, '', true, false, true, '', ExcelBuf."cell type"::Text); //kol7
        ExcelBuf.AddColumn('Forbrug INKL. MOMS pr. ' + Format("G/L Account".GetRangemax("G/L Account"."Date Filter")), false, '', true, false, true, '', ExcelBuf."cell type"::Text); //Kol8
        ExcelBuf.AddColumn('Forbrug EX. MOMS pr. ' + Format("G/L Account".GetRangemax("G/L Account"."Date Filter")), false, '', true, false, true, '', ExcelBuf."cell type"::Text); //Kol9
        ExcelBuf.AddColumn('Forventet Resultat INKL. MOMS', false, '', true, false, true, '', ExcelBuf."cell type"::Text); //kol10
        ExcelBuf.AddColumn('Forventet Resultat EX. MOMS', false, '', true, false, true, '', ExcelBuf."cell type"::Text); //kol11
        ExcelBuf.AddColumn('Afvigelse INKL. MOMS', false, '', true, false, true, '', ExcelBuf."cell type"::Text); //Kol12
        ExcelBuf.AddColumn('Afvigelse EX. MOMS', false, '', true, false, true, '', ExcelBuf."cell type"::Text); //Kol13
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
        //Momstegn
        ExcelBuf.AddColumn(VatMarking, false, '', false, false, false, '', ExcelBuf."cell type"::Text);
        //1. talkolonne
        case true of Kol[1] = 0: begin
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Text);
        end;
        Kol[1] <> 0: begin
            ExcelBuf.AddColumn(Kol[1], false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, CurrFormat, ExcelBuf."cell type"::Text);
        end;
        end;
        //Ny
        case true of Kol[15] = 0: begin
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Text);
        end;
        Kol[15] <> 0: begin
            ExcelBuf.AddColumn(Kol[15], false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, CurrFormat, ExcelBuf."cell type"::Text);
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
        case true of Kol[10] = 0: begin
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Kol[10] <> 0: begin
            ExcelBuf.AddColumn(Kol[10], false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        //11. talkolonne
        case true of Kol[11] = 0: begin
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Kol[11] <> 0: begin
            ExcelBuf.AddColumn(Kol[11], false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        //12. talkolonne
        case true of Kol[12] = 0: begin
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Kol[12] <> 0: begin
            ExcelBuf.AddColumn(Kol[12], false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        //13. talkolonne
        case true of Kol[13] = 0: begin
            ExcelBuf.AddColumn('', false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Kol[13] <> 0: begin
            ExcelBuf.AddColumn(Kol[13], false, '', "G/L Account"."Account Type" <> "G/L Account"."account type"::Posting, false, false, CurrFormat, ExcelBuf."cell type"::Number);
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
    procedure CreateTotalBuffer(AccountNo: Code[10]; Amount1: Decimal; Amount2: Decimal; Amount3: Decimal; Amount4: Decimal; Amount5: Decimal; Amount6: Decimal; Amount7: Decimal; Amount8: Decimal; Amount9: Decimal; Amount10: Decimal; Amount11: Decimal; Amount12: Decimal; Amount13: Decimal; Amount14: Decimal; Amount15: Decimal)
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
        TotalBufferTEMP.Kol11:=Amount11;
        TotalBufferTEMP.Kol12:=Amount12;
        TotalBufferTEMP.Kol13:=Amount13;
        TotalBufferTEMP.Kol14:=Amount14;
        TotalBufferTEMP.Kol15:=Amount15;
        TotalBufferTEMP.Insert;
    end;
    procedure MakeExcelDataBodyTotals(TotalText_Par: Text[100])
    var
        BlankFiller: Text[250];
    begin
        BlankFiller:=PadStr(' ', MaxStrLen(BlankFiller), ' ');
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('', false, '', true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn(TotalText_Par, false, '', true, false, false, '', ExcelBuf."cell type"::Text);
        ExcelBuf.AddColumn('', false, '', true, false, false, '', ExcelBuf."cell type"::Text);
        //1. talkolonne
        case true of Kol[1] = 0: begin
            ExcelBuf.AddColumn(0, false, '', true, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Kol[1] <> 0: begin
            ExcelBuf.AddColumn(Kol[1], false, '', true, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        //Ny
        case true of Kol[15] = 0: begin
            ExcelBuf.AddColumn(0, false, '', true, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Kol[15] <> 0: begin
            ExcelBuf.AddColumn(Kol[15], false, '', true, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        //2. talkolonne
        case true of Kol[2] = 0: begin
            ExcelBuf.AddColumn(0, false, '', true, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Kol[2] <> 0: begin
            ExcelBuf.AddColumn(Kol[2], false, '', true, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        //3. talkolonne
        case true of Kol[3] = 0: begin
            ExcelBuf.AddColumn(0, false, '', true, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Kol[3] <> 0: begin
            ExcelBuf.AddColumn(Kol[3], false, '', true, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        //4. talkolonne
        case true of Kol[4] = 0: begin
            ExcelBuf.AddColumn(0, false, '', true, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Kol[4] <> 0: begin
            ExcelBuf.AddColumn(Kol[4], false, '', true, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        //5. talkolonne
        case true of Kol[5] = 0: begin
            ExcelBuf.AddColumn(0, false, '', true, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Kol[5] <> 0: begin
            ExcelBuf.AddColumn(Kol[5], false, '', true, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        //6. talkolonne
        case true of Kol[6] = 0: begin
            ExcelBuf.AddColumn(0, false, '', true, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Kol[6] <> 0: begin
            ExcelBuf.AddColumn(Kol[6], false, '', true, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        //7. talkolonne
        case true of Kol[7] = 0: begin
            ExcelBuf.AddColumn(0, false, '', true, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Kol[7] <> 0: begin
            ExcelBuf.AddColumn(Kol[7], false, '', true, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        //8. talkolonne
        case true of Kol[8] = 0: begin
            ExcelBuf.AddColumn(0, false, '', true, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Kol[8] <> 0: begin
            ExcelBuf.AddColumn(Kol[2], false, '', true, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        //9. talkolonne
        case true of Kol[9] = 0: begin
            ExcelBuf.AddColumn(0, false, '', true, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Kol[9] <> 0: begin
            ExcelBuf.AddColumn(Kol[3], false, '', true, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        //10. talkolonne
        case true of Kol[10] = 0: begin
            ExcelBuf.AddColumn(0, false, '', true, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Kol[10] <> 0: begin
            ExcelBuf.AddColumn(Kol[4], false, '', true, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        //11. talkolonne
        case true of Kol[11] = 0: begin
            ExcelBuf.AddColumn(0, false, '', true, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Kol[11] <> 0: begin
            ExcelBuf.AddColumn(Kol[5], false, '', true, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        //12. talkolonne
        case true of Kol[12] = 0: begin
            ExcelBuf.AddColumn(0, false, '', true, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Kol[12] <> 0: begin
            ExcelBuf.AddColumn(Kol[6], false, '', true, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
        //13. talkolonne
        case true of Kol[13] = 0: begin
            ExcelBuf.AddColumn(0, false, '', true, false, false, '', ExcelBuf."cell type"::Number);
        end;
        Kol[13] <> 0: begin
            ExcelBuf.AddColumn(Kol[7], false, '', true, false, false, CurrFormat, ExcelBuf."cell type"::Number);
        end;
        end;
    end;
}
