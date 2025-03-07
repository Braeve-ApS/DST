Codeunit 51004 "DKS Check Tvungen Dimension"
{
    // //CheckHeader(DocNoPar); //Midlertidig udkommenteret på grund af at den breser PBS overførsler
    // COR 19-08-11
    trigger OnRun()
    begin
    end;
    var CalledFromTable_Global: Integer;
    DocumentNoGlobal: Code[20];
    LineNoGlobal: Integer;
    TemplateNameGlobal: Code[20];
    BatchNameGlobal: Code[20];
    DocTypeGlobal: Integer;
    GLAccount: Record "G/L Account";
    PLAccount: Boolean;
    DimensionSetEntry: Record "Dimension Set Entry";
    procedure DimCheckGLJournal()
    var
        GenJnlLine: Record "Gen. Journal Line";
        DimensionEnforcement: Record "DKS Dimension enforcement";
        DimensionSetEntry: Record "Dimension Set Entry";
        DimensionSetEntry2: Record "Dimension Set Entry";
    begin
        GenJnlLine.SetRange(GenJnlLine."Journal Template Name", TemplateNameGlobal);
        GenJnlLine.SetRange(GenJnlLine."Journal Batch Name", BatchNameGlobal);
        GenJnlLine.Find('-');
        repeat PLAccount:=false;
            if GLAccount.Get(GenJnlLine."Account No.")then if GLAccount."Income/Balance" = GLAccount."income/balance"::"Income Statement" then PLAccount:=true;
            if GLAccount.Get(GenJnlLine."Bal. Account No.")then if GLAccount."Income/Balance" = GLAccount."income/balance"::"Income Statement" then PLAccount:=true;
            if PLAccount then begin
                FindDimensionSet(GenJnlLine."Dimension Set ID", 'Konto ' + GenJnlLine."Account No.", Format(GenJnlLine."Line No."));
            end;
        until GenJnlLine.Next = 0;
    end;
    procedure DimCheckDocLine()
    var
        DimensionEnforcement: Record "DKS Dimension enforcement";
        Label: Text[30];
        RecRef: RecordRef;
    begin
    /*DocumentDimension.SETRANGE(DocumentDimension."Table ID",CalledFromTable_Global,CalledFromTable_Global+1);
        DocumentDimension.SETRANGE(DocumentDimension."Document Type",DocTypeGlobal);
        DocumentDimension.SETRANGE(DocumentDimension."Document No.",DocumentNoGlobal);
        //DocumentDimension.SETRANGE(DocumentDimension."Line No.",LineNoGlobal);
        IF DocumentDimension.FINDFIRST THEN
          REPEAT
            IF DimensionEnforcement.GET(DocumentDimension."Dimension Code",DocumentDimension."Dimension Value Code") THEN
              IF DimensionEnforcement."Forces Dimension"<>'' THEN
                BEGIN
                  DocumentDimension2.COPYFILTERS(DocumentDimension);
                  DocumentDimension2.SETRANGE(DocumentDimension2."Dimension Code",DimensionEnforcement."Forces Dimension");
                  DocumentDimension2.SETFILTER(DocumentDimension2."Dimension Value Code",'<>%1','');
                  DocumentDimension2.SETRANGE(DocumentDimension2."Line No.",DocumentDimension."Line No.");
                  IF NOT DocumentDimension2.FINDFIRST THEN
                    BEGIN
                      IF DocumentDimension."Line No."=0 THEN
                        Label:='(bilagshovedet)'
                      ELSE
                        Label:='';
                      ERROR('Bilag nr. %1\'+
                            'Linje nr.: %2 %4\'+
                            'mangler dimensionen %3.\'+
                            '[CU 51004]',DocumentNoGlobal,FORMAT(DocumentDimension."Line No."),DimensionEnforcement."Forces Dimension",
                                         Label);
                    END;
                END;
          UNTIL DocumentDimension.NEXT=0;
        */
    end;
    procedure PerformCheck(CalledFromTable: Integer; DocNoPar: Code[10]; LineEntryNoPar: Integer; TemplateNamePar: Code[20]; BatchNamePar: Code[20]; DocumentOption: Integer)
    var
        DKSDimensionenforcement: Record "DKS Dimension enforcement";
    begin
        //Kaldes fra: CU80,CU90,CU231,CU232
        //IF RSInfo.FINDFIRST THEN
        //  IF RSInfo."Nyt regnskab"=COMPANYNAME THEN
        if DKSDimensionenforcement.IsEmpty then exit
        else
        begin
            CalledFromTable_Global:=CalledFromTable;
            DocumentNoGlobal:=DocNoPar;
            LineNoGlobal:=LineEntryNoPar;
            TemplateNameGlobal:=TemplateNamePar;
            BatchNameGlobal:=BatchNamePar;
            DocTypeGlobal:=DocumentOption;
            case CalledFromTable of 81: DimCheckGLJournal;
            36: begin
                CheckSalesDocument;
                CheckHeader(DocNoPar); //Midlertidig udkommenteret på grund af at den breser PBS overførsler
            end;
            38: CheckPurchDocument;
            end;
        end;
    end;
    procedure CheckHeader(DocNo_Par: Code[20])
    var
        SalesHeaderLocal: Record "Sales Header";
        GLSetup: Record "General Ledger Setup";
        LabelLocal: Text[100];
    begin
    /*LSetup.GET;
        DocumentDimensionLocal.SETRANGE(DocumentDimensionLocal."Table ID",36);
        DocumentDimensionLocal.SETRANGE(DocumentDimensionLocal."Document No.",DocNo_Par);
        DocumentDimensionLocal.SETRANGE(DocumentDimensionLocal."Line No.",DocumentDimensionLocal."Line No.",0);
        DocumentDimensionLocal.SETRANGE(DocumentDimensionLocal."Dimension Code",GLSetup."Global Dimension 1 Code");
        DocumentDimensionLocal.SETFILTER(DocumentDimensionLocal."Dimension Value Code",'<>%1','');
        IF NOT DocumentDimensionLocal.FINDFIRST THEN
          BEGIN
            SalesHeaderLocal.SETRANGE(SalesHeaderLocal."No.",DocNo_Par);
            IF SalesHeaderLocal.FIND('-') THEN
              IF SalesHeaderLocal."Reason Code"='BS' THEN
                LabelLocal:='BS - Debitor nr. '+SalesHeaderLocal."Sell-to Customer No."+' '+SalesHeaderLocal."Sell-to Customer Name";
            ERROR('Bilag nr. %1\'+
                  'mangler dimensionen %2.\'+
                  LabelLocal+'\'+
                  '[CU 51004]',DocNo_Par,GLSetup."Global Dimension 1 Code");
          END;
        */
    end;
    local procedure CheckSalesDocument()
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
    begin
        SalesHeader.SetRange(SalesHeader."No.", DocumentNoGlobal);
        if SalesHeader.FindFirst then begin
            FindDimensionSet(SalesHeader."Dimension Set ID", Format(SalesHeader."Document Type"), 'Bilagshovedet');
            SalesLine.SetRange(SalesLine."Document Type", SalesHeader."Document Type");
            SalesLine.SetRange(SalesLine."Document No.", SalesHeader."No.");
            SalesLine.SetFilter(SalesLine.Quantity, '<>%1', 0);
            if SalesLine.FindSet then repeat FindDimensionSet(SalesLine."Dimension Set ID", Format(SalesLine."Document Type"), Format(SalesLine."Line No."));
                until SalesLine.Next = 0;
        end;
    end;
    local procedure CheckPurchDocument()
    var
        PurchaseHeader: Record "Purchase Header";
        PurchaseLine: Record "Purchase Line";
    begin
        PurchaseHeader.SetRange(PurchaseHeader."No.", DocumentNoGlobal);
        if PurchaseHeader.FindFirst then begin
            FindDimensionSet(PurchaseHeader."Dimension Set ID", Format(PurchaseHeader."Document Type"), 'Bilagshovedet');
            PurchaseLine.SetRange(PurchaseLine."Document Type", PurchaseHeader."Document Type");
            PurchaseLine.SetRange(PurchaseLine."Document No.", PurchaseHeader."No.");
            PurchaseLine.SetFilter(PurchaseLine.Quantity, '<>%1', 0);
            if PurchaseLine.FindSet then repeat FindDimensionSet(PurchaseLine."Dimension Set ID", Format(PurchaseLine."Document Type"), Format(PurchaseLine."Line No."));
                until PurchaseLine.Next = 0;
        end;
    end;
    local procedure FindDimensionSet(ID: Integer; DocType: Text; LineNo: Text)
    begin
        Clear(DimensionSetEntry);
        if ID = 0 then exit;
        DimensionSetEntry.SetRange(DimensionSetEntry."Dimension Set ID", ID);
        if DimensionSetEntry.FindSet then CheckEnforcement(DocType, LineNo);
    end;
    local procedure CheckEnforcement(DocType: Text; LineNo: Text)
    var
        Dimensionenforcement: Record "DKS Dimension enforcement";
        DimensionSetEntry2: Record "Dimension Set Entry";
    begin
        repeat if Dimensionenforcement.Get(DimensionSetEntry."Dimension Code", DimensionSetEntry."Dimension Value Code")then begin
                if Dimensionenforcement."Forces Dimension" <> '' then begin
                    DimensionSetEntry2.CopyFilters(DimensionSetEntry);
                    DimensionSetEntry2.SetRange(DimensionSetEntry2."Dimension Code", Dimensionenforcement."Forces Dimension");
                    DimensionSetEntry2.SetFilter(DimensionSetEntry2."Dimension Value Code", '<>%1', '');
                    if DimensionSetEntry2.IsEmpty then Error('%1\' + '%4\' + 'Linje nr.: %2\' + 'mangler dimensionen %3.\' + '[CU 51004]', BatchNameGlobal, LineNo, Dimensionenforcement."Forces Dimension", DocType);
                end;
            end;
        until DimensionSetEntry.Next = 0;
    end;
}
