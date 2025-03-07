Page 50000 "VAT Reconcillation"
{
    // All data are written in a TEMPORARY table (70015).
    // License to this table is not needed!
    // DST001/030717/Jim : Department Filter added
    Caption = 'Momsafstemning';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = "VAT Reconcillation";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(Filters)
            {
                Caption = 'Filtre';

                field(DateFilter; DateFilter)
                {
                    ApplicationArea = Basic;
                    Caption = 'Date Filter';

                    trigger OnValidate()
                    var
                        Filtertokens: Codeunit "Filter Tokens";
                    begin
                        Filtertokens.MakeDateFilter(DateFilter);
                    end;
                }
                group(Control1000000019)
                {
                    field(DepFilter; DepFilter)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Afdelingsfilter';
                        TableRelation = "Dimension Value".Code where("Global Dimension No."=const(1));
                    }
                    field(ActFilter; ActFilter)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Aktivitetsfilter';
                        TableRelation = "Dimension Value".Code where("Global Dimension No."=const(2));
                    }
                }
            }
            repeater(Group)
            {
                Caption = 'Afstemning';

                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = IsBoldGlobal;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = Basic;
                    Style = Strong;
                    StyleExpr = IsBoldGlobal;
                }
                field("VAT Business Posting Group"; Rec."VAT Business Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("VAT Product Posting Group"; Rec."VAT Product Posting Group")
                {
                    ApplicationArea = Basic;
                }
                field("VAT pct. acc. to setup"; Rec."VAT pct. acc. to setup")
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                }
                field("Net Change"; Rec."Net Change")
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                }
                field("Theoretical calculated VAT"; Rec."Theoretical calculated VAT")
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                }
                field("Actual Sales VAT"; Rec."Actual Sales VAT")
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    Style = Strong;
                    StyleExpr = IsBoldGlobal;
                }
                field("Actual Purchase VAT"; Rec."Actual Purchase VAT")
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    Style = Strong;
                    StyleExpr = IsBoldGlobal;
                }
                field("Calculated VAT Pct."; Rec."Calculated VAT Pct.")
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Variance in LCY"; Rec."Variance in LCY")
                {
                    ApplicationArea = Basic;
                    BlankZero = true;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Reconcile)
            {
                ApplicationArea = Basic;
                Caption = 'Beregn afstemning';
                Image = Approvals;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'F7';
                ToolTip = 'Fill in Date Filter, and click for reconcillation';

                trigger OnAction()
                begin
                    UpdateList(DateFilter);
                end;
            }
            action("G/L Entries")
            {
                ApplicationArea = Basic;
                Caption = 'Finansposter';
                Image = LedgerEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Ctrl+F7';
                ToolTip = 'G/L entries';

                trigger OnAction()
                var
                    GLEntries: Record "G/L Entry";
                begin
                    GLEntries.SetCurrentkey("G/L Account No.", "Posting Date");
                    GLEntries.SetRange(GLEntries."G/L Account No.", Rec."Account No.");
                    GLEntries.SetFilter(GLEntries."Posting Date", Rec.DateFilterUsed);
                    //>>DST001
                    if DepFilter <> '' then GLEntries.SetFilter(GLEntries."Global Dimension 1 Code", DepFilter)
                    else
                        GLEntries.SetRange(GLEntries."Global Dimension 1 Code");
                    if ActFilter <> '' then GLEntries.SetFilter(GLEntries."Global Dimension 2 Code", ActFilter)
                    else
                        GLEntries.SetRange(GLEntries."Global Dimension 2 Code");
                    //<<DST001
                    Page.RunModal(20, GLEntries);
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        IsBoldGlobal:=Rec.IsBold;
    end;
    var DateFilter: Text[50];
    IsBoldGlobal: Boolean;
    GLAccount: Record "G/L Account";
    GLEntry: Record "G/L Entry";
    w: Dialog;
    NetChange: Decimal;
    SalesVat: array[2]of Decimal;
    PurchVAT: array[2]of Decimal;
    i: Integer;
    FromDate: Date;
    ToDate: Date;
    Text01: label 'Date filter is missing!';
    Text02: label 'Specification of VAT accounts';
    Text03: label '  Balance per:';
    Text04: label '  Manually created entries:';
    Text05: label 'Manually created entries total:';
    Text06: label '  System generated entries:';
    Text07: label '  Settlement entries total:';
    Text08: label 'Account %1 %2';
    DepFilter: Code[50];
    ActFilter: Code[50];
    procedure UpdateList(DateFilter: Text[30])
    begin
        Rec.DeleteAll;
        Clear(GLAccount);
        Clear(GLEntry);
        Clear(NetChange);
        Clear(SalesVat);
        Clear(PurchVAT);
        if DateFilter = '' then Error(Text01);
        w.Open('Calculating #1############################');
        GLAccount.SetRange(GLAccount."Account Type", GLAccount."account type"::Posting);
        GLAccount.FindSet;
        repeat GLEntry.SetCurrentkey("G/L Account No.", "Posting Date");
            GLEntry.SetRange(GLEntry."G/L Account No.", GLAccount."No.");
            GLEntry.SetFilter(GLEntry."Posting Date", DateFilter);
            //>>DST001
            if DepFilter <> '' then GLEntry.SetFilter(GLEntry."Global Dimension 1 Code", DepFilter)
            else
                GLEntry.SetRange(GLEntry."Global Dimension 1 Code");
            if ActFilter <> '' then GLEntry.SetFilter(GLEntry."Global Dimension 2 Code", ActFilter)
            else
                GLEntry.SetRange(GLEntry."Global Dimension 2 Code");
            //<<DST001
            if GLEntry.FindSet then begin
                w.Update(1, GLAccount.Name);
                SalesVat[1]:=0;
                PurchVAT[1]:=0;
                repeat if GLEntry."Gen. Posting Type" = GLEntry."gen. posting type"::Sale then begin
                        SalesVat[1]+=GLEntry."VAT Amount";
                    end;
                    if GLEntry."Gen. Posting Type" = GLEntry."gen. posting type"::Purchase then begin
                        PurchVAT[1]+=GLEntry."VAT Amount";
                    end;
                until GLEntry.Next = 0;
                SalesVat[2]+=SalesVat[1];
                PurchVAT[2]+=PurchVAT[1];
                if(SalesVat[1] <> 0) or (PurchVAT[1] <> 0)then begin
                    GLAccount.SetFilter(GLAccount."Date Filter", DateFilter);
                    //>>DST001
                    if DepFilter <> '' then GLAccount.SetFilter(GLAccount."Global Dimension 1 Filter", DepFilter);
                    if ActFilter <> '' then GLAccount.SetFilter(GLAccount."Global Dimension 2 Filter", ActFilter);
                    //<<DST001
                    GLAccount.CalcFields(GLAccount."Net Change");
                    NetChange:=GLAccount."Net Change";
                    CreateRecord(DateFilter);
                end;
            end;
        until GLAccount.Next = 0;
        FromDate:=GLEntry.GetRangeMin(GLEntry."Posting Date");
        ToDate:=GLEntry.GetRangemax(GLEntry."Posting Date");
        CreateTotals;
        CreateAccountSpec(DateFilter);
        w.Close;
    end;
    procedure CreateRecord(DateFilter: Text[30])
    begin
        Rec.Init;
        Rec.Type:=Rec.Type::Reconcile;
        Rec."Account No.":=GLAccount."No.";
        Rec.Name:=GLAccount.Name;
        Rec."VAT Business Posting Group":=GLAccount."VAT Bus. Posting Group";
        Rec."VAT Product Posting Group":=GLAccount."VAT Prod. Posting Group";
        Rec."VAT pct. acc. to setup":=GetVATPct(GLAccount);
        Rec."Net Change":=NetChange;
        Rec."Theoretical calculated VAT":=ROUND(Rec."Net Change" * Rec."VAT pct. acc. to setup" / 100, 0.01);
        Rec."Actual Sales VAT":=SalesVat[1];
        Rec."Actual Purchase VAT":=PurchVAT[1];
        if NetChange <> 0 then Rec."Calculated VAT Pct.":=(SalesVat[1] + PurchVAT[1]) * 100 / NetChange
        else
            Rec."Calculated VAT Pct.":=999999;
        Rec."Variance in LCY":=Rec."Actual Sales VAT" + Rec."Actual Purchase VAT" - Rec."Theoretical calculated VAT";
        Rec.DateFilterUsed:=DateFilter;
        Rec.IsBold:=true;
        Rec.Insert;
    end;
    procedure GetVATPct(GLAccount: Record "G/L Account")VatPct: Decimal var
        VATPostingSetup: Record "VAT Posting Setup";
    begin
        VATPostingSetup.SetRange(VATPostingSetup."VAT Bus. Posting Group", GLAccount."VAT Bus. Posting Group");
        VATPostingSetup.SetRange(VATPostingSetup."VAT Prod. Posting Group", GLAccount."VAT Prod. Posting Group");
        if VATPostingSetup.FindFirst then exit(VATPostingSetup."VAT %")
        else
            exit(0);
    end;
    procedure CreateTotals()
    begin
        for i:=1 to 1 do begin
            Rec.Init;
            Rec."Account No.":='';
            Rec.Type:=Rec.Type::Total;
            Rec.EntryNo:=i;
            Rec.Insert;
        end;
        Rec.Init;
        Rec."Account No.":='';
        Rec.Type:=Rec.Type::Total;
        Rec.EntryNo:=i + 1;
        Rec.Name:='Total:';
        Rec."Actual Sales VAT":=SalesVat[2];
        Rec."Actual Purchase VAT":=PurchVAT[2];
        Rec.IsBold:=true;
        Rec.Insert;
    end;
    procedure CreateAccountSpec(DateFilter: Text[30])
    var
        VatPostingSetup: Record "VAT Posting Setup";
        GLAccountTEMP: Record "G/L Account" temporary;
        Counter: Decimal;
    begin
        VatPostingSetup.FindFirst;
        repeat if VatPostingSetup."Sales VAT Account" <> '' then begin
                GLAccountTEMP."No.":=VatPostingSetup."Sales VAT Account";
                if GLAccountTEMP.Insert then;
            end;
            if VatPostingSetup."Purchase VAT Account" <> '' then begin
                GLAccountTEMP."No.":=VatPostingSetup."Purchase VAT Account";
                if GLAccountTEMP.Insert then;
            end;
            if VatPostingSetup."Reverse Chrg. VAT Acc." <> '' then begin
                GLAccountTEMP."No.":=VatPostingSetup."Reverse Chrg. VAT Acc.";
                if GLAccountTEMP.Insert then;
            end;
        until VatPostingSetup.Next = 0;
        for i:=1 to 3 do begin
            Rec.Init;
            Rec."Account No.":=' ';
            Rec.Type:=Rec.Type::Accounts;
            if i = 2 then Rec.Name:=StrSubstNo('---------- %1 ----------', Text02);
            Rec.EntryNo:=i;
            Rec.IsBold:=true;
            Rec.Insert;
        end;
        Clear(GLAccountTEMP);
        if GLAccountTEMP.FindFirst then repeat Clear(GLAccount);
                GLAccount.Get(GLAccountTEMP."No.");
                //Header
                InsertLine(2, GLAccountTEMP."No.", StrSubstNo(Text08, GLAccountTEMP."No.", GLAccount.Name), 0, 0, true);
                //Primo
                GLAccount.SetRange(GLAccount."Date Filter", 0D, FromDate - 1);
                //>>DST001
                if DepFilter <> '' then GLAccount.SetFilter(GLAccount."Global Dimension 1 Filter", DepFilter);
                if ActFilter <> '' then GLAccount.SetFilter(GLAccount."Global Dimension 2 Filter", ActFilter);
                //<<DST001
                GLAccount.CalcFields(GLAccount."Net Change");
                InsertLine(2, GLAccountTEMP."No.", Text03 + Format(FromDate - 1), 0, GLAccount."Net Change", true);
                //Manual
                Clear(GLEntry);
                GLEntry.SetCurrentkey("G/L Account No.", "Posting Date");
                GLEntry.SetRange(GLEntry."G/L Account No.", GLAccountTEMP."No.");
                GLEntry.SetRange(GLEntry."Posting Date", FromDate, ToDate);
                //>>DST001
                if DepFilter <> '' then GLEntry.SetFilter(GLEntry."Global Dimension 1 Code", DepFilter)
                else
                    GLEntry.SetRange(GLEntry."Global Dimension 1 Code");
                if ActFilter <> '' then GLEntry.SetFilter(GLEntry."Global Dimension 2 Code", ActFilter)
                else
                    GLEntry.SetRange(GLEntry."Global Dimension 2 Code");
                //<<DST001
                GLEntry.SetRange(GLEntry."System-Created Entry", false);
                Clear(Counter);
                if GLEntry.FindSet then begin
                    InsertLine(2, GLAccountTEMP."No.", Text04, 0, 0, true);
                    repeat InsertLine(2, GLAccountTEMP."No.", '    ' + Format(GLEntry."Posting Date") + '  ' + GLEntry."Document No." + '  ' + GLEntry.Description, GLEntry.Amount, 0, false);
                        Counter+=GLEntry.Amount;
                    until GLEntry.Next = 0;
                    InsertLine(2, GLAccountTEMP."No.", Text05, 0, Counter, true);
                end;
                //Auto
                GLEntry.SetRange(GLEntry."System-Created Entry", true);
                GLEntry.SetFilter(GLEntry."Gen. Posting Type", '<>%1', GLEntry."gen. posting type"::Settlement);
                Clear(Counter);
                if GLEntry.FindSet then begin
                    repeat Counter+=GLEntry.Amount;
                    until GLEntry.Next = 0;
                    InsertLine(2, GLAccountTEMP."No.", Text06, 0, Counter, true);
                end;
                //Settlement
                GLEntry.SetFilter(GLEntry."Gen. Posting Type", '%1', GLEntry."gen. posting type"::Settlement);
                Clear(Counter);
                if GLEntry.FindSet then begin
                    repeat Counter+=GLEntry.Amount;
                    until GLEntry.Next = 0;
                    InsertLine(2, GLAccountTEMP."No.", Text07, 0, Counter, true);
                end;
                //Balance
                GLAccount.SetRange(GLAccount."Date Filter", 0D, ToDate);
                GLAccount.CalcFields(GLAccount."Net Change");
                InsertLine(2, GLAccountTEMP."No.", Text03 + Format(ToDate), 0, GLAccount."Net Change", true);
                //Space
                InsertLine(2, GLAccountTEMP."No.", '', 0, 0, false);
            until GLAccountTEMP.Next = 0;
    end;
    procedure InsertLine(TypeLocal: Integer; AccountLocal: Code[20]; DescriptionLocal: Text[80]; SalesVATAmount: Decimal; PurchVATAmount: Decimal; IsBoldPar: Boolean)
    begin
        i+=10;
        Rec.Init;
        Rec.Type:=TypeLocal;
        Rec."Account No.":=AccountLocal;
        Rec.EntryNo:=i;
        Rec.Name:=DescriptionLocal;
        Rec."Actual Sales VAT":=SalesVATAmount;
        Rec."Actual Purchase VAT":=PurchVATAmount;
        Rec.IsBold:=IsBoldPar;
        Rec.Insert;
    end;
}
