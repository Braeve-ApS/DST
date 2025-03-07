Report 50014 "Pronestor Indlæsning"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem("Integer"; "Integer")
        {
            DataItemTableView = sorting(Number)where(Number=const(1));

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            trigger OnAfterGetRecord()
            begin
                ImportFile(Filename);
                TestLines;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field(PostDate; PostDate)
                {
                    ApplicationArea = Basic;
                    Caption = 'Posting Date';
                }
                field(Filename; Filename)
                {
                    ApplicationArea = Basic;
                    Caption = 'File Name';

                    trigger OnAssistEdit()
                    var
                    // FileDialog: dotnet OpenFileDialog;
                    begin
                        UploadIntoStream(Text001, '', '', Filename, Instr);
                    /* FileDialog := FileDialog.OpenFileDialog;
                        FileDialog.Multiselect := false;
                        FileDialog.Title := Text001;
                        FileDialog.ShowDialog();

                        Filename := FileDialog.FileName;
                        */
                    end;
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
    var Filename: Text[1024];
    ServerFileName: Text[1024];
    FileInfo: Text[1024];
    ClientFileName: Text[1024];
    ClientTempPath: Text[1024];
    PostDate: Date;
    "GlProjektNr.": Text[50];
    GlMødeID: Text[30];
    GlMødeID_loc: Text[30];
    Text001: label 'Indlæs fil';
    Text002: label 'XML-filer (*.xml)|*.xml|Alle filer (*.*)|*.*';
    Text50020: label 'Vare %1 er spærret';
    FirstInvoice: Code[20];
    LastInvoice: Code[20];
    FirstCreMemo: Code[20];
    LastCreMemo: Code[20];
    Instr: instream;
    procedure ImportFile(PathAndFileName: Text[1024])
    var
        PronestorData: Record "Pronestor indlæsning";
        SalesFile: File;
        ItemRelocationFile: File;
        FileLine: Text[1024];
        FieldSeparator: Text[1];
        DateTxt: Text[30];
        NextEntryNo: Integer;
        LineFieldText: Text[100];
        LineFieldNo: Integer;
        LineCharNo: Integer;
        EndOfField: Boolean;
        Day_loc: Integer;
        Month_loc: Integer;
        Year_loc: Integer;
    begin
        //DST001: Denne funktion er erstattet af XMLPORT 50001 03-07-17 / Jim
        PronestorData.DeleteAll;
        PronestorData.Reset;
        if PronestorData.FindLast then NextEntryNo:=PronestorData.EntryNo
        else
            NextEntryNo:=0;
        FieldSeparator:=';'; // ; if Fields are separated by ; only. " if Fields are surrounded by "
        /*
        ItemRelocationFile.TextMode(true);
        ItemRelocationFile.WriteMode(false);
        ItemRelocationFile.Open(PathAndFileName);
        while ItemRelocationFile.Read(FileLine) <> 0 do begin
        */
        while Instr.ReadText(FileLine) <> 0 do begin
            NextEntryNo:=NextEntryNo + 1;
            Clear(PronestorData);
            PronestorData.EntryNo:=NextEntryNo;
            LineCharNo:=1;
            LineFieldNo:=0;
            while LineCharNo < StrLen(FileLine)do begin
                if(FieldSeparator = ';') or ((FieldSeparator = '"') and (CopyStr(FileLine, LineCharNo, 1) = '"'))then // This must be the start of a Field
 begin
                    LineFieldNo:=LineFieldNo + 1;
                    if FieldSeparator = '"' then LineCharNo:=LineCharNo + 1; // Skip " starting the Field
                    LineFieldText:='';
                    EndOfField:=false;
                    while not EndOfField do begin
                        if LineCharNo > StrLen(FileLine)then EndOfField:=true
                        else if CopyStr(FileLine, LineCharNo, 1) = FieldSeparator then EndOfField:=true;
                        if not EndOfField then begin
                            LineFieldText:=LineFieldText + CopyStr(FileLine, LineCharNo, 1);
                            LineCharNo:=LineCharNo + 1;
                        end;
                    end;
                    LineFieldText:=ANSItoASCII(LineFieldText);
                    LineCharNo:=LineCharNo + 1; // Skip Separator ending the Field
                    case LineFieldNo of 1: if LineFieldText <> '' then Evaluate(PronestorData."Debitor navn", CopyStr(LineFieldText, 1, 30));
                    2: if LineFieldText <> '' then Evaluate(PronestorData.Betalingsnote, CopyStr(LineFieldText, 1, 30));
                    3: if LineFieldText <> '' then Evaluate(PronestorData.Varenummer, LineFieldText);
                    4: if LineFieldText <> '' then Evaluate(PronestorData.Antal, LineFieldText);
                    5: if LineFieldText <> '' then Evaluate(PronestorData.Debitornummer, LineFieldText);
                    6: if LineFieldText <> '' then Evaluate(PronestorData."Pris incl. moms", LineFieldText);
                    7: if LineFieldText <> '' then Evaluate(PronestorData."Mødetype (intern/ekstern)", LineFieldText);
                    8: if LineFieldText <> '' then Evaluate(PronestorData."Møde ID", CopyStr(LineFieldText, 1, 30));
                    9: if LineFieldText <> '' then Evaluate(PronestorData.Bemærkninger, LineFieldText);
                    10: if LineFieldText <> '' then Evaluate(PronestorData."Bestiller/Projekt nr.", LineFieldText);
                    11: if LineFieldText <> '' then begin
                            LineFieldText:=CopyStr(LineFieldText, 1, 6) + CopyStr(LineFieldText, 9, 2);
                            Evaluate(PronestorData.Ordredato, LineFieldText);
                        end end;
                    //Undersøg om Debitor findes
                    PronestorData.Debitornummer:=GetDebFromSateRel(PronestorData.Debitornummer);
                    //Undersøg om vare findes
                    PronestorData.Varenummer:=GetItemFromNAV(PronestorData.Varenummer);
                    //Bogføringsdato
                    PronestorData."Bogf.dato":=PostDate;
                end
                else
                    LineCharNo:=LineCharNo + 1; // Skip , or whatever seperates the fields between the two "
            end;
            PronestorData.Insert;
        end;
    /*
            ItemRelocationFile.Close;
           */
    end;
    procedure TestLines()
    var
        Item_Relocation_Data_Test: Record "Pronestor indlæsning";
    begin
        Item_Relocation_Data_Test.Reset;
        if Item_Relocation_Data_Test.FindFirst then repeat if(Item_Relocation_Data_Test.Fejl) or (Item_Relocation_Data_Test."Fejl oplysning" <> '')then begin
                    Item_Relocation_Data_Test.Fejl:=false;
                    Item_Relocation_Data_Test."Fejl oplysning":='';
                    Item_Relocation_Data_Test.Modify;
                end;
                //Kontrol af manglende Debitor Nr.
                if not Item_Relocation_Data_Test.Fejl then if Item_Relocation_Data_Test.Debitornummer = '' then begin
                        Item_Relocation_Data_Test."Fejl oplysning":='Debitornummeret mangler';
                        Item_Relocation_Data_Test.Fejl:=true;
                        Item_Relocation_Data_Test.Modify;
                    end;
                //Kontrol af manglende Vare Nr.
                if not Item_Relocation_Data_Test.Fejl then if Item_Relocation_Data_Test.Varenummer = '' then begin
                        Item_Relocation_Data_Test."Fejl oplysning":='Varenummeret mangler';
                        Item_Relocation_Data_Test.Fejl:=true;
                        Item_Relocation_Data_Test.Modify;
                    end;
            until Item_Relocation_Data_Test.Next = 0;
    end;
    procedure "Handle Files Invoice"()
    var
        SalesHeaderInv: Record "Sales Header";
        SalesHeaderCrM: Record "Sales Header";
        ConsData: Record "Pronestor indlæsning";
        Dag: Code[10];
        "Måned": Code[10];
        "År": Code[10];
        GlDebitor: Text[30];
        GlNote: Text[30];
        GlDato: Date;
        InvoiceCreated: Boolean;
        CrMemoCreated: Boolean;
        UseAmountFromFile: Boolean;
        VatPctInFile: Decimal;
        TestItem: Record Item;
    begin
        GlDebitor:='';
        GlNote:='';
        GlDato:=0D;
        "GlProjektNr.":='';
        UseAmountFromFile:=true;
        //Er beløbet i filen incl. moms.
        VatPctInFile:=25;
        ConsData.Reset;
        ConsData.SetRange(Fejl, false);
        if ConsData.Find('-')then repeat TestItem.Get(ConsData.Varenummer);
                if TestItem.Blocked = true then Error(StrSubstNo(Text50020, ConsData.Varenummer));
                if ConsData."Bogf.dato" = 0D then begin
                    ConsData."Bogf.dato":=Today;
                    ConsData.Modify;
                end;
            until ConsData.Next = 0;
        ConsData.Reset;
        ConsData.SetCurrentkey(Debitornummer, "Møde ID", Ordredato);
        ConsData.SetRange(Fejl, false);
        if ConsData.Find('-')then repeat if(GlDebitor <> ConsData.Debitornummer) or (GlMødeID <> ConsData."Møde ID")then begin // Create new salesheader
                    InvoiceCreated:=false;
                    CrMemoCreated:=false;
                    GlDebitor:=ConsData.Debitornummer;
                    GlNote:=ConsData.Betalingsnote;
                    GlMødeID:=ConsData."Møde ID";
                end;
                // Add salesline to the salesheader
                if ConsData.Antal >= 0 then begin
                    if not InvoiceCreated then begin
                        CreateSalesheader(ConsData.Debitornummer, ConsData."Bogf.dato", SalesHeaderInv, false, CopyStr(ConsData.Betalingsnote, 1, 50), ConsData.Ordredato, ConsData."Møde ID");
                        InvoiceCreated:=true;
                    end;
                    CreateSalesLine(SalesHeaderInv, ConsData.Varenummer, ConsData.Antal, UseAmountFromFile, (ConsData."Pris incl. moms" * ConsData.Antal), VatPctInFile, CopyStr(ConsData.Bemærkninger, 1, 50), ConsData.Ordredato, GlDato, ConsData."Bestiller/Projekt nr.", ConsData.Betalingsnote, ConsData."Møde ID");
                end
                else
                begin
                    if not CrMemoCreated then begin
                        CreateSalesheader(ConsData.Debitornummer, ConsData."Bogf.dato", SalesHeaderCrM, true, CopyStr(ConsData.Betalingsnote, 1, 50), ConsData.Ordredato, ConsData."Møde ID");
                        CrMemoCreated:=true;
                    end;
                    CreateSalesLine(SalesHeaderCrM, ConsData.Varenummer, -ConsData.Antal, UseAmountFromFile, (-ConsData."Pris incl. moms" * ConsData.Antal), VatPctInFile, CopyStr(ConsData.Bemærkninger, 1, 50), ConsData.Ordredato, GlDato, ConsData."Bestiller/Projekt nr.", ConsData.Betalingsnote, ConsData."Møde ID");
                end;
                GlDato:=ConsData.Ordredato;
                ConsData.Delete;
            until ConsData.Next = 0;
        //>>DST001
        UpdateEfakNote;
    //<<DST001
    end;
    procedure CreateSalesheader(CustomerNo: Code[20]; PostingDate: Date; var SalesHeader: Record "Sales Header"; pCrMemo: Boolean; Attention_loc: Text[50]; Orderdate: Date; MødeID: Text[30])
    var
        Customer: Record Customer;
    begin
        Customer.Get(CustomerNo);
        Clear(SalesHeader);
        if pCrMemo then SalesHeader."Document Type":=SalesHeader."document type"::"Credit Memo"
        else
            SalesHeader."Document Type":=SalesHeader."document type"::Invoice;
        SalesHeader."Posting Date":=PostingDate;
        SalesHeader.Insert(true);
        //>>DST001
        if pCrMemo then begin
            if FirstCreMemo = '' then FirstCreMemo:=SalesHeader."No.";
            LastCreMemo:=SalesHeader."No.";
        end
        else
        begin
            if FirstInvoice = '' then FirstInvoice:=SalesHeader."No.";
            LastInvoice:=SalesHeader."No.";
        end;
        //<<DST001
        SalesHeader.Validate("Sell-to Customer No.", Customer."No.");
        //COR/IMT Ændre Kundeattention
        if Attention_loc <> '' then SalesHeader."Sell-to Contact":=Attention_loc;
        if MødeID <> '' then SalesHeader."External Document No.":='MødeID: ' + MødeID;
        if PostingDate <> 0D then SalesHeader.Validate("Posting Date", PostingDate);
        if Orderdate <> 0D then SalesHeader.Validate(SalesHeader."Order Date", Orderdate);
        SalesHeader.Modify(true);
    end;
    procedure CreateSalesLine(SalesHeader: Record "Sales Header"; pItemNo: Code[20]; pQuantity: Decimal; pUseAmount: Boolean; pAmount: Decimal; pVatPct: Decimal; Remarks_loc: Text[50]; pOrderdate: Date; pGlDato: Date; "pProjektnr.": Text[50]; pBetalingsnote: Text[30]; pMødeID: Text[30])
    var
        SalesLine: Record "Sales Line";
    begin
        Clear(SalesLine);
        SalesLine."Document Type":=SalesHeader."Document Type";
        SalesLine."Document No.":=SalesHeader."No.";
        SalesLine."Line No.":=GetNextSalesLineNo(SalesHeader);
        /*
        //Indsæt Projektnr. på fakturalinje
        IF "pProjektnr." <> '' THEN
        BEGIN
          IF "pProjektnr." <> "GlProjektNr." THEN
          BEGIN
            SalesLine.INSERT(TRUE);
            SalesLine.VALIDATE(Type, SalesLine.Type::" ");
            SalesLine.Description := "pProjektnr.";
            SalesLine.MODIFY(TRUE);
            SalesLine."Line No." += 10000;
            "GlProjektNr." := "pProjektnr."
          END;
        END;
        */
        //Information pr. mødeID
        if GlMødeID_loc <> pMødeID then begin
            //Indsæt Ordredato på fakturalinje
            if pOrderdate <> 0D then begin
                SalesLine.Insert(true);
                SalesLine.Validate(Type, SalesLine.Type::" ");
                SalesLine.Description:=Format(pOrderdate);
                if "pProjektnr." <> '' then SalesLine.Description:=SalesLine.Description + ', ' + "pProjektnr.";
                SalesLine.Modify(true);
                SalesLine."Line No."+=10000;
            end;
            //Indsæt Betalingsnote fakturalinje
            if pBetalingsnote <> '' then begin
                SalesLine.Insert(true);
                SalesLine.Validate(Type, SalesLine.Type::" ");
                SalesLine.Description:=pBetalingsnote;
                SalesLine.Modify(true);
                SalesLine."Line No."+=10000;
            end;
            GlMødeID_loc:=pMødeID;
        end;
        SalesLine.SuspendStatusCheck(true);
        //IMT SalesLine.Set_SkipMessages(TRUE);
        SalesLine.Insert(true);
        SalesLine.Validate(Type, SalesLine.Type::Item);
        SalesLine.Validate("No.", pItemNo);
        //IMT IF SalesLine."Replenishment Policy (TRIMIT)" <> SalesLine."Replenishment Policy (TRIMIT)"::Inventory THEN
        //IMT   SalesLine.VALIDATE("Replenishment Policy (TRIMIT)", SalesLine."Replenishment Policy (TRIMIT)"::Inventory);
        SalesLine.Validate(Quantity, pQuantity);
        if pUseAmount and (pQuantity <> 0)then begin
            if pVatPct <> 0 then pAmount:=pAmount / pQuantity;
            if pItemNo <> 'G176010' then pAmount:=ROUND(pAmount / (1 + pVatPct / 100), 0.00001);
            SalesLine.Validate("Unit Price", pAmount / pQuantity);
        end;
        SalesLine.Modify(true);
        //Bemærkninger
        if Remarks_loc <> '' then begin
            SalesLine."Line No."+=10000;
            SalesLine.Insert(true);
            SalesLine.Validate(Type, SalesLine.Type::" ");
            SalesLine.Description:=Remarks_loc;
            SalesLine.Modify(true);
        end;
    end;
    procedure GetNextSalesLineNo(SalesHeader: Record "Sales Header"): Integer var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.Reset;
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        if not SalesLine.Find('+')then exit(10000)
        else
            exit(SalesLine."Line No." + 10000);
    end;
    procedure GetDebFromSateRel(CustomerNo_par: Code[20])Customer_return: Code[20]var
        Customer_loc: Record Customer;
    begin
        Customer_loc.Reset;
        if Customer_loc.Get(CustomerNo_par)then Customer_return:=Customer_loc."No."
        else
            Customer_return:='';
    end;
    procedure GetItemFromNAV(ItemNo: Code[20])ItemNoReturn: Code[20]var
        Item_Loc: Record Item;
    begin
        ItemNoReturn:='';
        Item_Loc.Reset;
        if Item_Loc.Get(ItemNo)then ItemNoReturn:=Item_Loc."No.";
    end;
    procedure ANSItoASCII(C_Text: Text[250])N_TEXT: Text[250]begin
        begin
            // Converts from ANSI to ASCII
            exit(ConvertStr(C_Text, '–¹•µ°Î', 'Æ¥Åæøå'));
        end;
    end;
    procedure ASCIItoANSI(C_Text: Text[250])N_Text: Text[250]begin
        begin
            // Converts from ASCII to ANSI
            exit(ConvertStr(C_Text, '€ƒ‚„‰Š‹Œ‘’“”•˜™š›œž³¾ÀÁÂÈÛþ ¡£ŸŽ¦ãõˆµÞ·ÌÊËÖ¥Ðàáâ–éêë', 'ÇüéâäàåçêëèïîìÄÅÉæÆôöòûùÿÖÜø£¥ƒáíóúñÑªº¿…†‡­®¯´¸¹ÃÊßËÌÒÓÔ'));
        end;
    end;
    local procedure UpdateEfakNote()
    var
        SalesHeaderLocal: Record "Sales Header";
        SalesLineLocal: Record "Sales Line";
        i: Integer;
        NoteLocal: Text;
    begin
        //>>DST001
        for i:=1 to 2 do begin
            if i = 1 then SalesHeaderLocal.SetRange(SalesHeaderLocal."No.", FirstInvoice, LastInvoice)
            else
                SalesHeaderLocal.SetRange(SalesHeaderLocal."No.", FirstCreMemo, LastCreMemo);
            if SalesHeaderLocal.FindSet then repeat Clear(NoteLocal);
                    SalesLineLocal.SetRange(SalesLineLocal."Document Type", SalesHeaderLocal."Document Type");
                    SalesLineLocal.SetRange(SalesLineLocal."Document No.", SalesHeaderLocal."No.");
                    SalesLineLocal.SetRange(SalesLineLocal.Type, 0);
                    SalesLineLocal.SetFilter(SalesLineLocal.Description, '<>%1', '');
                    if SalesLineLocal.FindSet then repeat if NoteLocal <> '' then NoteLocal:=NoteLocal + ', ' + SalesLineLocal.Description
                            else
                                NoteLocal:=SalesLineLocal.Description;
                        until SalesLineLocal.Next = 0;
                    SalesHeaderLocal."E-fak Note":=CopyStr(NoteLocal, 1, 100);
                    SalesHeaderLocal.Modify;
                until SalesHeaderLocal.Next = 0;
        end;
    //<<DST001
    end;
}
