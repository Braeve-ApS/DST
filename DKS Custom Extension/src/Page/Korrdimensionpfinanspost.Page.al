Page 50027 "Korr. dimension på finanspost"
{
    layout
    {
        area(content)
        {
            grid(Control1000000001)
            {
                Editable = false;
                ShowCaption = false;

                group(Control1000000007)
                {
                    ShowCaption = False;

                    field("GLAccount.""No."""; GLAccount."No.")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Konto';
                        Style = Strong;
                        StyleExpr = true;
                    }
                    field(PostingDate; PostingDate)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Bogføringsdato';
                    }
                    field(DocumentNo; DocumentNo)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Bilagsnr.';
                    }
                    field(Description; Description)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Beskrivelse';
                    }
                }
                group(Control1000000018)
                {
                    ShowCaption = False;

                    field("GLAccount.Name"; GLAccount.Name)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Navn';
                        Style = Strong;
                        StyleExpr = true;
                    }
                    field(Amount; Amount)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Beløb';
                    }
                    field("VAT Amount"; "VAT Amount")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Momsbeløb';
                    }
                    field("Dim-ID"; "Dim-ID")
                    {
                        ApplicationArea = Basic;
                        Caption = 'Dimensions ID';
                    }
                }
            }
            group(Dimensioner)
            {
                Caption = 'Dimensioner';

                grid(Control1000000011)
                {
                    ShowCaption = false;

                    group(Control1000000026)
                    {
                        ShowCaption = false;
                        Editable = false;

                        field("Label[1]"; Label[1])
                        {
                            ApplicationArea = Basic;
                        }
                        field("Label[2]"; Label[2])
                        {
                            ApplicationArea = Basic;
                        }
                        field("Label[3]"; Label[3])
                        {
                            ApplicationArea = Basic;
                        }
                        field("Label[4]"; Label[4])
                        {
                            ApplicationArea = Basic;
                        }
                        field("Label[5]"; Label[5])
                        {
                            ApplicationArea = Basic;
                        }
                    }
                    group("Nuværende Værdi")
                    {
                        Caption = 'Nuværende Værdi';
                        Editable = false;

                        field("Afdeling[1]"; Afdeling[1])
                        {
                            ApplicationArea = Basic;
                        }
                        field("Aktivitet[1]"; Aktivitet[1])
                        {
                            ApplicationArea = Basic;
                        }
                        field("Funktion[1]"; Funktion[1])
                        {
                            ApplicationArea = Basic;
                        }
                        field("TradingPartner[1]"; TradingPartner[1])
                        {
                            ApplicationArea = Basic;
                        }
                        field("ProjektFase[1]"; ProjektFase[1])
                        {
                            ApplicationArea = Basic;
                        }
                    }
                    group("Rettes til:")
                    {
                        Caption = 'Rettes til:';

                        field("Afdeling[2]"; Afdeling[2])
                        {
                            ApplicationArea = Basic;
                            Caption = 'Afdeling';
                            Editable = false;
                            ShowCaption = false;
                        }
                        field("Aktivitet[2]"; Aktivitet[2])
                        {
                            ApplicationArea = Basic;
                            Caption = 'Aktivitet';
                            ShowCaption = false;

                            trigger OnLookup(var Text: Text): Boolean begin
                                DimensionValue.SetRange(DimensionValue."Dimension Code", GLSetup."Global Dimension 2 Code");
                                if Page.RunModal(537, DimensionValue) = Action::LookupOK then begin
                                    Aktivitet[2]:=DimensionValue.Code;
                                end;
                            end;
                        }
                        field("Funktion[2]"; Funktion[2])
                        {
                            ApplicationArea = Basic;
                            Caption = 'Funktion';
                            ShowCaption = false;

                            trigger OnLookup(var Text: Text): Boolean begin
                                DimensionValue.SetRange(DimensionValue."Dimension Code", GLSetup."Shortcut Dimension 3 Code");
                                if Page.RunModal(537, DimensionValue) = Action::LookupOK then begin
                                    Funktion[2]:=DimensionValue.Code;
                                end;
                            end;
                        }
                        field("TradingPartner[2]"; TradingPartner[2])
                        {
                            ApplicationArea = Basic;
                            Caption = 'Tradingpartner';
                            ShowCaption = false;

                            trigger OnLookup(var Text: Text): Boolean begin
                                DimensionValue.SetRange(DimensionValue."Dimension Code", GLSetup."Shortcut Dimension 4 Code");
                                if Page.RunModal(537, DimensionValue) = Action::LookupOK then begin
                                    TradingPartner[2]:=DimensionValue.Code;
                                end;
                            end;
                        }
                        field("ProjektFase[2]"; ProjektFase[2])
                        {
                            ApplicationArea = Basic;
                            Caption = 'ProjektFase';
                            ShowCaption = false;

                            trigger OnLookup(var Text: Text): Boolean begin
                                DimensionValue.SetRange(DimensionValue."Dimension Code", GLSetup."Shortcut Dimension 5 Code");
                                if Page.RunModal(537, DimensionValue) = Action::LookupOK then begin
                                    ProjektFase[2]:=DimensionValue.Code;
                                end;
                            end;
                        }
                    }
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(ChangeDimension)
            {
                ApplicationArea = Basic;
                Caption = 'Udfør skift af dimensionsværdier';
                Image = ChangeDimensions;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    CU51005: Codeunit "DKS Korr. Dimensionsværdi";
                begin
                    if Confirm('ADVARSEL!\' + 'Denne funktion vil ændre dimensionsværdierne til det som er anf¢rt i kolonnen til h¢jre!\' + 'Fortsæt J/N?', false)then begin
                        CU51005.CorrectDimension(GL_Entry."Entry No.", Aktivitet[2], Funktion[2], TradingPartner[2], ProjektFase[2]);
                        CallIn(GL_Entry."Entry No.");
                    end
                    else
                        Error(' ');
                end;
            }
        }
    }
    trigger OnOpenPage()
    begin
        GLSetup.Get;
        Clear(Label);
        if Dimension.Get(GLSetup."Global Dimension 1 Code")then Label[1]:=Dimension.Name;
        if Dimension.Get(GLSetup."Global Dimension 2 Code")then Label[2]:=Dimension.Name;
        if Dimension.Get(GLSetup."Shortcut Dimension 3 Code")then Label[3]:=Dimension.Name;
        if Dimension.Get(GLSetup."Shortcut Dimension 4 Code")then Label[4]:=Dimension.Name;
        if Dimension.Get(GLSetup."Shortcut Dimension 5 Code")then Label[5]:=Dimension.Name;
    end;
    var GL_Entry: Record "G/L Entry";
    PostingDate: Date;
    DocumentNo: Code[20];
    Description: Text[50];
    Amount: Decimal;
    "VAT Amount": Decimal;
    Afdeling: array[2]of Code[20];
    Aktivitet: array[2]of Code[20];
    Funktion: array[2]of Code[20];
    TradingPartner: array[2]of Code[20];
    ProjektFase: array[2]of Code[20];
    GLSetup: Record "General Ledger Setup";
    CU51005: Codeunit "DKS Korr. Dimensionsværdi";
    DimensionSetEntry: Record "Dimension Set Entry";
    "Dim-ID": Integer;
    Dummy: Text;
    GLAccount: Record "G/L Account";
    DimensionValue: Record "Dimension Value";
    Label: array[5]of Text;
    Dimension: Record Dimension;
    procedure CallIn(EntryNo_Par: Integer)
    begin
        if GL_Entry.Get(EntryNo_Par)then begin
            GLSetup.Get;
            PostingDate:=GL_Entry."Posting Date";
            DocumentNo:=GL_Entry."Document No.";
            Description:=GL_Entry.Description;
            Amount:=GL_Entry.Amount;
            "VAT Amount":=GL_Entry."VAT Amount";
            "Dim-ID":=GL_Entry."Dimension Set ID";
            GLSetup.Get;
            DimensionSetEntry.SetRange(DimensionSetEntry."Dimension Set ID", GL_Entry."Dimension Set ID");
            GLAccount.Get(GL_Entry."G/L Account No.");
            //Afd
            DimensionSetEntry.SetRange(DimensionSetEntry."Dimension Code", GLSetup."Global Dimension 1 Code");
            if DimensionSetEntry.FindFirst then begin
                Afdeling[1]:=DimensionSetEntry."Dimension Value Code";
                Afdeling[2]:=DimensionSetEntry."Dimension Value Code";
            end;
            //Akt
            DimensionSetEntry.SetRange(DimensionSetEntry."Dimension Code", GLSetup."Global Dimension 2 Code");
            if DimensionSetEntry.FindFirst then begin
                Aktivitet[1]:=DimensionSetEntry."Dimension Value Code";
                Aktivitet[2]:=DimensionSetEntry."Dimension Value Code";
            end;
            //Funk
            DimensionSetEntry.SetRange(DimensionSetEntry."Dimension Code", GLSetup."Shortcut Dimension 3 Code");
            if DimensionSetEntry.FindFirst then begin
                Funktion[1]:=DimensionSetEntry."Dimension Value Code";
                Funktion[2]:=DimensionSetEntry."Dimension Value Code";
            end;
            //Trading
            DimensionSetEntry.SetRange(DimensionSetEntry."Dimension Code", GLSetup."Shortcut Dimension 4 Code");
            if DimensionSetEntry.FindFirst then begin
                TradingPartner[1]:=DimensionSetEntry."Dimension Value Code";
                TradingPartner[2]:=DimensionSetEntry."Dimension Value Code";
            end;
            //ProjektFase
            DimensionSetEntry.SetRange(DimensionSetEntry."Dimension Code", GLSetup."Shortcut Dimension 5 Code");
            if DimensionSetEntry.FindFirst then begin
                ProjektFase[1]:=DimensionSetEntry."Dimension Value Code";
                ProjektFase[2]:=DimensionSetEntry."Dimension Value Code";
            end;
        end;
    end;
}
