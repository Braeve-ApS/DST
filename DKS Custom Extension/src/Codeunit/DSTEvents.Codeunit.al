codeunit 50000 "DST Events"
{
    // //DST Events
    // DKS001/220217/Jim : Perform Dimension Check when salesposting
    // DKS002/095017/Jim : Auto set new articles to Type::Service
    // DST003/120617/Jim : When importing from Ibistic PM tables are not created
    // DST004/200617/Jim : Set Payment Channel before E-invoicing
    // DST005/301017/Jim : Set Payment Method on Credit memos
    // BS/001/050918/Jim : Warning when changin "Use Department as VAT Bus Posting Gr."
    // COR/001/191222/Jim : Warning if Cust Name/Address exceeds 35 Char (PBS).
    // COR/002/080223/Jim : For PBS - CPR to CVR field for persons
    // COR/003/220123/Jim : Make sure GlobalDim is validated (does not happen through DocCap)
    // COR/MIN 250124     : DC invoice/credit - take first line and insert on posting descrip in headeer
    trigger OnRun()
    begin
    end;

    var
        CU51004: Codeunit "DKS Check Tvungen Dimension";
        DSTSetup: Record "DST Setup";

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterModifyEvent', '', false, false)]
    local procedure T18OnAfterModify(var Rec: Record Customer; var xRec: Record Customer; RunTrigger: Boolean)
    var
        HelpText: Text;
    begin
        if not GuiAllowed() then exit;
        if StrLen(Rec.Name) > 35 then HelpText := 'NAVN';
        if StrLen(Rec."Name 2") > 35 then HelpText += '  NAVN 2';
        if StrLen(Rec.Address) > 35 then HelpText += '  ADRESSE';
        if StrLen(Rec."Address 2") > 35 then HelpText += '  ADRESSE 2';
        if HelpText <> '' then Message('OBS! Felterne %1\' + 'er længere end 35 karakterer.\' + 'Hvis debitor skal opkræves via PBS er max-længden 35 karakterer!', HelpText);
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterDeleteEvent', '', false, false)]
    local procedure T18OnDeleteLast(var Rec: Record Customer; RunTrigger: Boolean)
    var
        "BS-Aftale": Record "BS-Betalingsaftale";
    begin
        //Copied From T18 On Delete in NAV 4.0
        // >> BetalingsService 1.03 >>
        "BS-Aftale".Reset();
        "BS-Aftale".SetRange("Debitornr.", Rec."No.");
        while "BS-Aftale".Find('-') do begin
            "BS-Aftale".Delete(true);
        end;
        // << BetalingsService <<
    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'Social Security No.', false, false)]
    local procedure T18_SocialSecurityNo_OnAfterValidate(var Rec: Record Customer; var xRec: Record Customer; CurrFieldNo: Integer)
    var
        HelpTxt: Text;
    begin
        //COR/002>>
        if Rec."Social Security No." = '' then begin
            if Rec."VAT Registration No." = DelChr(xRec."Social Security No.", '=', '-') then Clear(Rec."VAT Registration No.");
        end;
        if Rec."VAT Registration No." <> '' then exit;
        HelpTxt := DelChr(Rec."Social Security No.", '=', '-');
        if (StrLen(HelpTxt) <> 0) and (StrLen(HelpTxt) <> 10) then Error('CPR-nummer er ikke gyldigt!');
        Rec."VAT Registration No." := HelpTxt;
        //COR/002<<
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterInsertEvent', '', false, false)]
    local procedure T27OnInsertLast(var Rec: Record Item; RunTrigger: Boolean)
    begin
        //DKS002
        Rec.Type := Rec.Type::Service;
        //DKS002
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Bill-to Customer No.', false, false)]
    local procedure T36BillToCustOnValidatelast(var Rec: Record "Sales Header"; var xRec: Record "Sales Header"; CurrFieldNo: Integer)
    var
        Cust: Record Customer;
    begin
        //>>DST005 - NAV doesn't set Payment Method on Credit Memos
        Cust.Get(Rec."Bill-to Customer No.");
        if Rec."Payment Method Code" = '' then Rec."Payment Method Code" := Cust."Payment Method Code";
        //<<DST005
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure T39OnAfterInsert(var Rec: Record "Purchase Line"; RunTrigger: Boolean)
    begin
        //COR/003>>
        //Purpose: Doc Cap does not validate Global Dim 1. Result: We don't get correct VAT Bus Post Gr.
        if Rec.IsTemporary then exit;
        if Rec."Shortcut Dimension 1 Code" = Rec."VAT Bus. Posting Group" then exit;
        if Rec."Shortcut Dimension 1 Code" = '' then exit;
        Rec.Validate(Rec."Shortcut Dimension 1 Code");
        //COR/003
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterModifyEvent', '', false, false)]
    local procedure T39OnAfterModify(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; RunTrigger: Boolean)
    begin
        //COR/003>>
        //Purpose: Doc Cap does not validate Global Dim 1. Result: We don't get correct VAT Bus Post Gr.
        //IF Rec."Shortcut Dimension 1 Code" = Rec."VAT Bus. Posting Group" THEN
        //  EXIT;
        //Rec.VALIDATE(Rec."Shortcut Dimension 1 Code");
        //COR/003<<
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'Shortcut Dimension 1 Code', false, false)]
    local procedure T39GlobalDim1OnValidate(var Rec: Record "Purchase Line"; var xRec: Record "Purchase Line"; CurrFieldNo: Integer)
    begin
        //Set VAT Bus Posting Group
        if not DSTSetup.Get() then exit;
        if not DSTSetup."Use Department as VAT Bus. pos" then exit;
        if Rec."No." <> '' then
            if Rec."VAT Prod. Posting Group" <> '' then
                Rec.Validate(Rec."VAT Bus. Posting Group", Rec."Shortcut Dimension 1 Code")
            else begin
                if Rec."VAT Bus. Posting Group" <> '' then
                    Rec.Validate(Rec."VAT Bus. Posting Group", Rec."Shortcut Dimension 1 Code")
                else
                    Rec.Validate(Rec."VAT Bus. Posting Group", '');
            end;
    end;
    /* IBISTIC - NOT IN USE
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure T81OnInsertLast(var Rec: Record "Gen. Journal Line"; RunTrigger: Boolean)
    var
        PurchPaymentInformation: Record UnknownRecord6016828;
        PurchPayInfoCU: Codeunit UnknownCodeunit6016807;
        xRec: Record "Gen. Journal Line";
        VendPmtInfo: Record UnknownRecord6016826;
        PaymentSetup: Record UnknownRecord6016800;
    begin
        //DST003
        The name 'PurchPaymentInformation' does not exist in the current context.
         if Rec."Journal Template Name" = 'K¥B' then begin
             if PurchPaymentInformation.Get(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.", Rec."Document Type", Rec."Document No.") then
                 exit;
             PurchPayInfoCU."InsertModifyPurchPmtInfo-Jnl"(Rec, xRec);
             PurchPayInfoCU.CreateCustomerIDPurchJnl(Rec, false);
             // <PM>
             if (Rec."Document Type" in [
               Rec."document type"::Invoice,
               Rec."document type"::Reminder,
               Rec."document type"::"Finance Charge Memo"]) and
               (Rec."Account Type" = Rec."account type"::Vendor)
             then
                 if PaymentSetup.Get then
                     if PaymentSetup."Check before Post. Purch Doc." then
                         if VendPmtInfo.Get(Rec."Account No.") then
                             PurchPayInfoCU.ValidatePaymentIDPurchJnl(Rec, false);
             // </PM>
         end;
         

        //DST003
    end;
*/
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterValidateEvent', 'Account No.', false, false)]
    local procedure T81AccountNoOnAfterValidate(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line"; CurrFieldNo: Integer)
    begin
        //Assure VAR calculation du to Separtments
        if not DSTSetup.Get() then exit;
        if not DSTSetup."Use Department as VAT Bus. pos" then exit;
        if Rec."Account Type" = Rec."account type"::"G/L Account" then if Rec."Shortcut Dimension 1 Code" <> '' then if Rec."VAT Prod. Posting Group" <> '' then Rec.Validate(Rec."VAT Bus. Posting Group", Rec."Shortcut Dimension 1 Code");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterValidateEvent', 'Bal. Account No.', false, false)]
    local procedure T81BalanceAccountNoOnAfterValidate(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line"; CurrFieldNo: Integer)
    begin
        //Assure VAR calculation du to Separtments
        if not DSTSetup.Get() then exit;
        if not DSTSetup."Use Department as VAT Bus. pos" then exit;
        if Rec."Bal. Account Type" = Rec."bal. account type"::"G/L Account" then if Rec."Shortcut Dimension 1 Code" <> '' then if Rec."Bal. VAT Prod. Posting Group" <> '' then Rec.Validate(Rec."Bal. VAT Bus. Posting Group", Rec."Shortcut Dimension 1 Code");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterValidateEvent', 'Shortcut Dimension 1 Code', false, false)]
    local procedure T81GlobalDim1OnValidateLast(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line"; CurrFieldNo: Integer)
    begin
        //Set VAT Bus Posting Group
        if not DSTSetup.Get() then exit;
        if not DSTSetup."Use Department as VAT Bus. pos" then exit;
        if Rec."Account Type" = Rec."account type"::"G/L Account" then
            if Rec."Account No." <> '' then
                if Rec."VAT Prod. Posting Group" <> '' then
                    Rec.Validate(Rec."VAT Bus. Posting Group", Rec."Shortcut Dimension 1 Code")
                else begin
                    if Rec."VAT Bus. Posting Group" <> '' then
                        Rec.Validate(Rec."VAT Bus. Posting Group", Rec."Shortcut Dimension 1 Code")
                    else
                        Rec.Validate(Rec."VAT Bus. Posting Group", '');
                end;
        if Rec."Bal. Account Type" = Rec."bal. account type"::"G/L Account" then
            if Rec."Bal. Account No." <> '' then
                if Rec."Bal. VAT Prod. Posting Group" <> '' then
                    Rec.Validate(Rec."Bal. VAT Bus. Posting Group", Rec."Shortcut Dimension 1 Code")
                else begin
                    if Rec."Bal. VAT Bus. Posting Group" <> '' then
                        Rec.Validate(Rec."Bal. VAT Bus. Posting Group", Rec."Shortcut Dimension 1 Code")
                    else
                        Rec.Validate(Rec."Bal. VAT Bus. Posting Group", '');
                end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"DST Setup", 'OnBeforeValidateEvent', 'Use Department as VAT Bus. pos', false, false)]
    local procedure T50002UseDepAsVatOnBeforeValidate(var Rec: Record "DST Setup"; var xRec: Record "DST Setup"; CurrFieldNo: Integer)
    var
        Text50002_1: Label 'WARNING!\Your are about to change the prerequisites for correct VAT calculations!\Continue Y/N?';
        Text50002_2: Label 'Aborted!';
    begin
        //BS/001
        if not Confirm(Text50002_1, false) then Error(Text50002_2);
        //BS/001
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', false, false)]
    local procedure CU80OnBeforeSalesPost(var SalesHeader: Record "Sales Header")
    begin
        //DST005
        SalesHeader."Posting Description" := SalesHeader."Bill-to Name";
        //DST005
        //>>DKS001
        CU51004.PerformCheck(36, SalesHeader."No.", 0, '', '', SalesHeader."Document Type".AsInteger());
        //<<DKS001
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostPurchaseDoc', '', false, false)]
    local procedure CU90OnBeforePostDocument(var PurchaseHeader: Record "Purchase Header")
    var
        PurchaseLine_loc: Record "Purchase Line";
    begin
        //>>DKS001
        CU51004.PerformCheck(38, PurchaseHeader."No.", 0, '', '', PurchaseHeader."Document Type".AsInteger());
        //<<DKS001
        //>> COR/MIN 250124
        //DC invoice/credit - take first line and insert on posting descrip in headeer
        if PurchaseHeader."Document Type" in [PurchaseHeader."document type"::Invoice, PurchaseHeader."document type"::"Credit Memo"] then begin
            PurchaseLine_loc.SetRange("Document Type", PurchaseHeader."Document Type");
            PurchaseLine_loc.SetRange("Document No.", PurchaseHeader."No.");
            //PurchaseLine_loc.SETRANGE(Type,PurchaseLine_loc.Type::"G/L Account");
            PurchaseLine_loc.SetFilter(Type, '<>%1', PurchaseLine_loc.Type::" "); //alt andet end blank
            if PurchaseLine_loc.FindFirst() then if PurchaseLine_loc."No." <> '' then if PurchaseLine_loc.Description <> '' then PurchaseHeader."Posting Description" := PurchaseLine_loc.Description;
        end;
        //<< COR/MIN 250124
    end;

    [EventSubscriber(Objecttype::Codeunit, 6085706, 'OnAfterModifyPurchLineCreatePurchLine', '', false, false)]
    local procedure C6085706_OnAfterModifyPurchLineCreatePurchLine(Document: Record "CDC Document"; var PurchLine: Record "Purchase Line")
    begin
        //COR/003>>
        //Purpose: Doc Cap does not validate Global Dim 1. Result: We don't get correct VAT Bus Post Gr.
        //IF PurchLine.ISTEMPORARY THEN
        //  EXIT;
        if PurchLine."Shortcut Dimension 1 Code" = PurchLine."VAT Bus. Posting Group" then exit;
        if PurchLine."Shortcut Dimension 1 Code" = '' then exit;
        //PurchLine.VALIDATE(PurchLine."Shortcut Dimension 1 Code");
        PurchLine.Validate(PurchLine."VAT Bus. Posting Group", PurchLine."Shortcut Dimension 1 Code");
        PurchLine.Modify();
        //COR/003
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterModifyEvent', '', false, false)]
    LOCAL procedure T38OnAfterModify(var Rec: Record 38; var xRec: Record 38; RunTrigger: Boolean);
    begin
        //>> COR/MIN 190324
        if Rec."Document Type" in [Rec."Document Type"::Invoice, Rec."Document Type"::"Credit Memo"] then
            if (xRec."Posting Date" <> 0D) then
                if (Rec."Posting Date" <> 0D) then
                    if (xRec."Posting Date") <> (Rec."Posting Date") then
                        if (xRec."Due Date" <> 0D) then
                            if (Rec."Due Date" <> xRec."Due Date") then begin
                                Rec."Due Date" := xRec."Due Date";
                                Rec.Modify();
                            end;
        //<< COR/MIN 190324
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterValidateEvent', 'Shortcut Dimension 1 Code', false, false)]
    LOCAL procedure T38_ShortCutDim1_OnAfterValidate(var Rec: Record 38; var xRec: Record 38; CurrFieldNo: Integer);
    var
        PurchaseLine_Loc: Record 39;
    begin
        if not DSTSetup.Get() then exit;
        if not DSTSetup."Use Department as VAT Bus. pos" then exit;
        if Rec."Shortcut Dimension 1 Code" <> xRec."Shortcut Dimension 1 Code" then begin
            PurchaseLine_Loc.SetRange(PurchaseLine_Loc."Document Type", Rec."Document Type");
            PurchaseLine_Loc.SetRange(PurchaseLine_Loc."Document No.", Rec."No.");
            PurchaseLine_Loc.SetFilter(PurchaseLine_Loc."No.", '<>%1', '');
            if PurchaseLine_Loc.FindSet() then
                repeat
                    PurchaseLine_Loc.Validate("VAT Bus. Posting Group", PurchaseLine_Loc."Shortcut Dimension 1 Code");
                    PurchaseLine_Loc.Modify();
                until PurchaseLine_Loc.Next = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterValidateEvent', 'Purchaser Code', false, false)]
    LOCAL procedure T38_PurchaserCode_OnAfterValidate(var Rec: Record 38; var xRec: Record 38; CurrFieldNo: Integer);
    var
        PurchaseLine_Loc: Record 39;
    begin
        if not DSTSetup.Get() then exit;
        if not DSTSetup."Use Department as VAT Bus. pos" then exit;
        if Rec."Purchaser Code" <> xRec."Purchaser Code" then begin
            PurchaseLine_Loc.SetRange(PurchaseLine_Loc."Document Type", Rec."Document Type");
            PurchaseLine_Loc.SetRange(PurchaseLine_Loc."Document No.", Rec."No.");
            PurchaseLine_Loc.SetFilter(PurchaseLine_Loc."No.", '<>%1', '');
            if PurchaseLine_Loc.FindSet() then
                repeat
                    PurchaseLine_Loc.Validate("VAT Bus. Posting Group", PurchaseLine_Loc."Shortcut Dimension 1 Code");
                    PurchaseLine_Loc.Modify();
                until PurchaseLine_Loc.Next = 0;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"OIOUBL-Export Sales Invoice", OnCreateXMLOnAfterInsertInvoiceTypeCode, '', false, false)]
    local procedure "OIOUBL-Export Sales Invoice_OnCreateXMLOnAfterInsertInvoiceTypeCode"(var XMLCurrNode: XmlElement; SalesInvoiceHeader: Record "Sales Invoice Header")
    var
        OIOUBLXMLGenerator: Codeunit "OIOUBL-Common Logic";
        DocNameSpace: Text[250];
        DocNameSpace2: Text[250];
    begin
        OIOUBLXMLGenerator.init(DocNameSpace, DocNameSpace2);
        If SalesInvoiceheader."E-fak Note" <> '' then XMLCurrNode.Add(XmlElement.Create('Note', DocNameSpace, SalesInvoiceheader."E-fak Note"));
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"OIOUBL-Export Sales Cr. Memo", OnCreateXMLOnBeforeInsertAccountingSupplierParty, '', false, false)]
    local procedure "OIOUBL-Export Sales Cr. Memo_OnCreateXMLOnBeforeInsertAccountingSupplierParty"(var XMLCurrNode: XmlElement; SalesCrMemoHeader: Record "Sales Cr.Memo Header")
    var
        OIOUBLXMLGenerator: Codeunit "OIOUBL-Common Logic";
        DocNameSpace: Text[250];
        DocNameSpace2: Text[250];
    begin
        OIOUBLXMLGenerator.init(DocNameSpace, DocNameSpace2);
        if SalesCrMemoHeader."E-fak Note" <> '' then XMLCurrNode.Add(XmlElement.Create('Note', DocNameSpace, SalesCrMemoHeader."E-fak Note"));
    end;
}
