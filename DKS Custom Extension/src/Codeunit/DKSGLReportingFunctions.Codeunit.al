Codeunit 51001 "DKS GL Reporting Functions"
{
    trigger OnRun()
    begin
    end;
    var w: Dialog;
    GLSetup: Record "General Ledger Setup";
    GLEntryTemp: Record "G/L Entry" temporary;
    DimensionSetEntry: Record "Dimension Set Entry";
    procedure UpdateGLEntryReportingTable()
    var
        "GL Entry": Record "G/L Entry";
        GLEntryCopy: Record "DKS G/L Entry Rapportering";
        FromEntryNo: Integer;
        NoOfRec: Integer;
    begin
        w.Open('Opdaterer rapporteringsgrundlag\' + 'Antal poster #1######');
        GLSetup.Get;
        if GLEntryCopy.FindLast then FromEntryNo:=GLEntryCopy."Entry No.";
        "GL Entry".SetFilter("GL Entry"."Entry No.", '%1..', FromEntryNo + 1);
        if "GL Entry".FindFirst then begin
            NoOfRec:="GL Entry".Count;
            repeat w.Update(1, Format(NoOfRec));
                NoOfRec:=NoOfRec - 1;
                GLEntryCopy.Init;
                GLEntryCopy.TransferFields("GL Entry");
                Clear(DimensionSetEntry);
                DimensionSetEntry.SetRange(DimensionSetEntry."Dimension Set ID", "GL Entry"."Dimension Set ID");
                DimensionSetEntry.SetRange(DimensionSetEntry."Dimension Code", GLSetup."Shortcut Dimension 3 Code");
                if DimensionSetEntry.FindFirst then GLEntryCopy."Funktion (Dim)":=DimensionSetEntry."Dimension Value Code";
                DimensionSetEntry.SetRange(DimensionSetEntry."Dimension Code", GLSetup."Shortcut Dimension 4 Code");
                if DimensionSetEntry.FindFirst then GLEntryCopy."Trading Partner (Dim)":=DimensionSetEntry."Dimension Value Code";
                DimensionSetEntry.SetRange(DimensionSetEntry."Dimension Code", GLSetup."Shortcut Dimension 5 Code");
                if DimensionSetEntry.FindFirst then GLEntryCopy."Projektfase (Dim)":=DimensionSetEntry."Dimension Value Code";
                GLEntryCopy.Insert;
                if "GL Entry"."Reversed Entry No." <> 0 then begin
                    GLEntryTemp."Entry No.":="GL Entry"."Reversed Entry No.";
                    GLEntryTemp."Reversed by Entry No.":="GL Entry"."Entry No.";
                    GLEntryTemp.Insert;
                end;
            until "GL Entry".Next = 0;
        end;
        if GLEntryTemp.FindFirst then begin
            w.Update(1, 'Opdaterer tilbageførte transaktioner');
            repeat GLEntryCopy.Get(GLEntryTemp."Entry No.");
                GLEntryCopy.Reversed:=true;
                GLEntryCopy."Reversed by Entry No.":=GLEntryTemp."Reversed by Entry No.";
                GLEntryCopy.Modify;
            until GLEntryTemp.Next = 0;
        end;
        w.Close;
    end;
    procedure UpdateChartOfAccounts()
    var
        T50016: Record "DKS G/L Account Rapportering";
        CharOfAccounts: Record "G/L Account";
    begin
        w.Open('Opdaterer kontoplan');
        T50016.DeleteAll;
        CharOfAccounts.FindFirst;
        repeat T50016.TransferFields(CharOfAccounts);
            T50016.Insert;
        until CharOfAccounts.Next = 0;
        w.Close;
    end;
}
