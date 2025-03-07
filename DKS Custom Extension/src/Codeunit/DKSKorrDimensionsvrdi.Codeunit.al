Codeunit 51005 "DKS Korr. Dimensionsværdi"
{
    Permissions = TableData "G/L Entry"=rm,
        TableData "Dimension Set ID Filter Line"=rimd;

    trigger OnRun()
    begin
    end;
    var GLEntry: Record "G/L Entry";
    GLEntryReporting: Record "DKS G/L Entry Rapportering";
    GLSetup: Record "General Ledger Setup";
    Text001: label 'is not within your range of allowed posting dates';
    Finkld: Record "Gen. Journal Line" temporary;
    procedure CorrectDimension(EntryNo_Par: Integer; AktivitetPar: Code[20]; FunktionPar: Code[20]; TradingPatnerPar: Code[20]; ProjektfasePar: Code[20])
    var
        CU11: Codeunit "Gen. Jnl.-Check Line";
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        Error01: Label 'This function can only be used in the DST company. Use "Correct Dimensions" instead.';
    begin
        //Called from Page 50027
        if CompanyName <> 'Diakonissestiftelsen' then Error(Error01);
        if GLEntry.Get(EntryNo_Par)then begin
            if CU11.DateNotAllowed(GLEntry."Posting Date")then GLEntry.FieldError(GLEntry."Posting Date", Text001);
            GLSetup.Get;
            if GLEntry.Reversed then Error('Finansposten er tilbageført og kan ikke ændres.');
            GenJournalTemplate.SetRange(GenJournalTemplate.Type, GenJournalTemplate.Type::General);
            GenJournalTemplate.SetRange(GenJournalTemplate.Recurring, false);
            GenJournalTemplate.FindFirst;
            GenJournalBatch.Init;
            GenJournalBatch."Journal Template Name":=GenJournalTemplate.Name;
            GenJournalBatch.Name:='TEMP';
            if GenJournalBatch.Insert then;
            Finkld.DeleteAll;
            Finkld.Init;
            Finkld."Journal Template Name":=GenJournalTemplate.Name;
            Finkld."Journal Batch Name":='TEMP';
            Finkld.Validate(Finkld."Shortcut Dimension 1 Code", GLEntry."Global Dimension 1 Code");
            Finkld.Validate(Finkld."Shortcut Dimension 2 Code", AktivitetPar);
            Finkld.ValidateShortcutDimCode(3, FunktionPar);
            Finkld.ValidateShortcutDimCode(4, TradingPatnerPar);
            Finkld.ValidateShortcutDimCode(5, ProjektfasePar);
            Finkld.Insert(true);
            GLEntry."Global Dimension 2 Code":=AktivitetPar;
            GLEntry."Dimension Set ID":=Finkld."Dimension Set ID";
            GLEntry.Modify;
            GenJournalBatch.Delete;
            if GLEntryReporting.Get(EntryNo_Par)then begin
                GLEntryReporting."Global Dimension 2 Code":=AktivitetPar;
                GLEntryReporting."Funktion (Dim)":=FunktionPar;
                GLEntryReporting."Trading Partner (Dim)":=TradingPatnerPar;
                GLEntryReporting."Projektfase (Dim)":=ProjektfasePar;
                GLEntryReporting.Modify;
            end;
            Message('Posten er opdateret...');
        end;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Dimension Correction Mgt", 'OnAfterVerifyIfDimensionCanBeChanged', '', false, false)]
    local procedure DimensionCorrectionMgt_OnAfterVerifyIfDimensionCanBeChanged()
    var
        Error02: Label 'This function is not in use due to the companys policy on "Department VAT".\Use the function "DST Correct Dimensions" instead.';
    begin
        If Companyname = 'Diakonissestiftelsen' then Error(Error02);
    end;
}
