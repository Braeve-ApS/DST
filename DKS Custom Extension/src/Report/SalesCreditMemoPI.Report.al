Report 50021 "Sales - Credit Memo PI"
{
    // PI001/160414/Jim : 2013 R2 Rollup 6
    // 13-04-2015 OBL PI003  Fields addded and layout updated. German captions addded.
    // 03-11-2015 OBL PI004 New function InitHeaderValues. Dataset and laout changed
    // 01-04-2016 OBL PI005 ShowVATClause added
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Sales - Credit Memo PI.rdlc';
    Caption = 'Sales - Credit Memo';
    Permissions = TableData "Sales Shipment Buffer"=rimd;

    dataset
    {
        dataitem("Sales Cr.Memo Header"; "Sales Cr.Memo Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Credit Memo';

            column(ReportForNavId_8098;8098)
            {
            }
            column(No_SalesCrMemoHeader; "Sales Cr.Memo Header"."No.")
            {
            }
            column(VATAmtLineVATCptn; VATAmtLineVATCptnLbl)
            {
            }
            column(VATAmtLineVATBaseCptn; VATAmtLineVATBaseCptnLbl)
            {
            }
            column(VATAmtLineVATAmtCptn; VATAmtLineVATAmtCptnLbl)
            {
            }
            column(VATAmtLineVATIdentifierCptn; VATAmtLineVATIdentifierCptnLbl)
            {
            }
            column(TotalCptn; TotalCptnLbl)
            {
            }
            column(SalesCrMemoLineDiscCaption; SalesCrMemoLineDiscCaptionLbl)
            {
            }
            column(EDOCLine; EdocCMDLine)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = sorting(Number);

                column(ReportForNavId_5701;5701)
                {
                }
                dataitem(PageLoop; "Integer")
                {
                    DataItemTableView = sorting(Number)where(Number=const(1));

                    column(ReportForNavId_6455;6455)
                    {
                    }
                    column(HeaderLogo; DstSetup."Header Logo")
                    {
                    }
                    column(FooterLogo; DstSetup."Footer Logo")
                    {
                    }
                    column(FooterText1; FooterText1)
                    {
                    }
                    column(FooterText2; FooterText2)
                    {
                    }
                    column(FooterText3; FooterText3)
                    {
                    }
                    column(ShowVATSpecification; ShowVATSpecification)
                    {
                    }
                    column(ShowBankInformation; ShowBankInformation)
                    {
                    }
                    column(ShowVATClause; ShowVATClause)
                    {
                    }
                    column(CaptionLeft1; CaptionLeft[1])
                    {
                    }
                    column(CaptionLeft2; CaptionLeft[2])
                    {
                    }
                    column(CaptionLeft3; CaptionLeft[3])
                    {
                    }
                    column(CaptionLeft4; CaptionLeft[4])
                    {
                    }
                    column(CaptionLeft5; CaptionLeft[5])
                    {
                    }
                    column(CaptionLeft6; CaptionLeft[6])
                    {
                    }
                    column(CaptionLeft7; CaptionLeft[7])
                    {
                    }
                    column(CaptionLeft8; CaptionLeft[8])
                    {
                    }
                    column(CaptionLeft9; CaptionLeft[9])
                    {
                    }
                    column(CaptionLeft10; CaptionLeft[10])
                    {
                    }
                    column(ValueLeft1; ValueLeft[1])
                    {
                    }
                    column(ValueLeft2; ValueLeft[2])
                    {
                    }
                    column(ValueLeft3; ValueLeft[3])
                    {
                    }
                    column(ValueLeft4; ValueLeft[4])
                    {
                    }
                    column(ValueLeft5; ValueLeft[5])
                    {
                    }
                    column(ValueLeft6; ValueLeft[6])
                    {
                    }
                    column(ValueLeft7; ValueLeft[7])
                    {
                    }
                    column(ValueLeft8; ValueLeft[8])
                    {
                    }
                    column(ValueLeft9; ValueLeft[9])
                    {
                    }
                    column(ValueLeft10; ValueLeft[10])
                    {
                    }
                    column(CaptionRight1; CaptionRight[1])
                    {
                    }
                    column(CaptionRight2; CaptionRight[2])
                    {
                    }
                    column(CaptionRight3; CaptionRight[3])
                    {
                    }
                    column(CaptionRight4; CaptionRight[4])
                    {
                    }
                    column(CaptionRight5; CaptionRight[5])
                    {
                    }
                    column(CaptionRight6; CaptionRight[6])
                    {
                    }
                    column(CaptionRight7; CaptionRight[7])
                    {
                    }
                    column(CaptionRight8; CaptionRight[8])
                    {
                    }
                    column(CaptionRight9; CaptionRight[9])
                    {
                    }
                    column(CaptionRight10; CaptionRight[10])
                    {
                    }
                    column(ValueRight1; ValueRight[1])
                    {
                    }
                    column(ValueRight2; ValueRight[2])
                    {
                    }
                    column(ValueRight3; ValueRight[3])
                    {
                    }
                    column(ValueRight4; ValueRight[4])
                    {
                    }
                    column(ValueRight5; ValueRight[5])
                    {
                    }
                    column(ValueRight6; ValueRight[6])
                    {
                    }
                    column(ValueRight7; ValueRight[7])
                    {
                    }
                    column(ValueRight8; ValueRight[8])
                    {
                    }
                    column(ValueRight9; ValueRight[9])
                    {
                    }
                    column(ValueRight10; ValueRight[10])
                    {
                    }
                    column(CustAddr1; CustAddr[1])
                    {
                    }
                    column(CompanyAddr1; CompanyAddr[1])
                    {
                    }
                    column(CustAddr2; CustAddr[2])
                    {
                    }
                    column(CompanyAddr2; CompanyAddr[2])
                    {
                    }
                    column(CustAddr3; CustAddr[3])
                    {
                    }
                    column(CompanyAddr3; CompanyAddr[3])
                    {
                    }
                    column(CustAddr4; CustAddr[4])
                    {
                    }
                    column(CompanyAddr4; CompanyAddr[4])
                    {
                    }
                    column(CustAddr5; CustAddr[5])
                    {
                    }
                    column(CustAddr6; CustAddr[6])
                    {
                    }
                    column(CustAddr7; CustAddr[7])
                    {
                    }
                    column(CustAddr8; CustAddr[8])
                    {
                    }
                    column(CompanyAddr5; CompanyAddr[5])
                    {
                    }
                    column(CompanyAddr6; CompanyAddr[6])
                    {
                    }
                    column(DocCptnCopyTxt; StrSubstNo(DocumentCaption, CopyText))
                    {
                    }
                    column(PageCaption; PageCaptionCap)
                    {
                    }
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(BilltoCustNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Bill-to Customer No.")
                    {
                    }
                    column(PriceInclVAT_SalesCrMemoHeader; "Sales Cr.Memo Header"."Prices Including VAT")
                    {
                    }
                    column(VATBaseDiscPrc_SalesCrMemoLine; "Sales Cr.Memo Header"."VAT Base Discount %")
                    {
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = sorting(Number)where(Number=filter(1..));

                        column(ReportForNavId_7574;7574)
                        {
                        }
                        column(DimText; DimText)
                        {
                        }
                        column(DimensionLoop1Num; DimensionLoop1.Number)
                        {
                        }
                        column(HeaderDimCptn; HeaderDimCptnLbl)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            if DimensionLoop1.Number = 1 then begin
                                if not DimSetEntry1.FindSet then CurrReport.Break;
                            end
                            else if not Continue then CurrReport.Break;
                            Clear(DimText);
                            Continue:=false;
                            repeat OldDimText:=DimText;
                                if DimText = '' then DimText:=StrSubstNo('%1 %2', DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code")
                                else
                                    DimText:=StrSubstNo('%1, %2 %3', DimText, DimSetEntry1."Dimension Code", DimSetEntry1."Dimension Value Code");
                                if StrLen(DimText) > MaxStrLen(OldDimText)then begin
                                    DimText:=OldDimText;
                                    Continue:=true;
                                    exit;
                                end;
                            until DimSetEntry1.Next = 0;
                        end;
                        trigger OnPreDataItem()
                        begin
                            if not ShowInternalInfo then CurrReport.Break;
                        end;
                    }
                    dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
                    {
                        DataItemLink = "Document No."=field("No.");
                        DataItemLinkReference = "Sales Cr.Memo Header";
                        DataItemTableView = sorting("Document No.", "Line No.");

                        column(ReportForNavId_3364;3364)
                        {
                        }
                        column(AccCode_SalesCrMemoLine; "Sales Cr.Memo Line"."OIOUBL-Account Code")
                        {
                        }
                        column(SalesCrMemoHdrAccCode; "Sales Cr.Memo Header"."OIOUBL-Account Code")
                        {
                        }
                        column(LineAmt_SalesCrMemoLine; "Sales Cr.Memo Line"."Line Amount")
                        {
                        AutoFormatExpression = GetCurrencyCode;
                        AutoFormatType = 1;
                        }
                        column(Desc_SalesCrMemoLine; "Sales Cr.Memo Line".Description)
                        {
                        }
                        column(No_SalesCrMemoLine; "Sales Cr.Memo Line"."No.")
                        {
                        }
                        column(Qty_SalesCrMemoLine; "Sales Cr.Memo Line".Quantity)
                        {
                        }
                        column(UOM_SalesCrMemoLine; "Sales Cr.Memo Line"."Unit of Measure")
                        {
                        }
                        column(UnitPrice_SalesCrMemoLine; "Sales Cr.Memo Line"."Unit Price")
                        {
                        AutoFormatExpression = GetCurrencyCode;
                        AutoFormatType = 2;
                        }
                        column(Disc_SalesCrMemoLine; "Sales Cr.Memo Line"."Line Discount %")
                        {
                        }
                        column(VATIdentif_SalesCrMemoLine; "Sales Cr.Memo Line"."VAT Identifier")
                        {
                        }
                        column(PostedReceiptDate; Format(PostedReceiptDate))
                        {
                        }
                        column(Type_SalesCrMemoLine; Format("Sales Cr.Memo Line".Type))
                        {
                        }
                        column(NNCTotalLineAmt; NNC_TotalLineAmount)
                        {
                        }
                        column(NNCTotalAmtInclVat; NNC_TotalAmountInclVat)
                        {
                        }
                        column(NNCTotalInvDiscAmt_SalesCrMemoLine; NNC_TotalInvDiscAmount)
                        {
                        }
                        column(NNCTotalAmt; NNC_TotalAmount)
                        {
                        }
                        column(AccCodeCaption; StrSubstNo('%1 %2', AccCodeCaption, "Sales Cr.Memo Line"."OIOUBL-Account Code"))
                        {
                        }
                        column(InvDiscAmt_SalesCrMemoLine;-"Sales Cr.Memo Line"."Inv. Discount Amount")
                        {
                        AutoFormatExpression = GetCurrencyCode;
                        AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(Amt_SalesCrMemoLine; "Sales Cr.Memo Line".Amount)
                        {
                        AutoFormatExpression = GetCurrencyCode;
                        AutoFormatType = 1;
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(AmtIncluVAT_SalesCrMemoLine; "Sales Cr.Memo Line"."Amount Including VAT")
                        {
                        AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                        AutoFormatType = 1;
                        }
                        column(SumOfAmtInclVATAmtAndAmt_SalesCrMemoLine; "Sales Cr.Memo Line"."Amount Including VAT" - "Sales Cr.Memo Line".Amount)
                        {
                        AutoFormatExpression = "Sales Cr.Memo Line".GetCurrencyCode;
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtTxt; VATAmountLine.VATAmountText)
                        {
                        }
                        column(LineAmtInvDiscAmt_SalesCrMemoLine;-("Sales Cr.Memo Line"."Line Amount" - "Sales Cr.Memo Line"."Inv. Discount Amount" - "Sales Cr.Memo Line"."Amount Including VAT"))
                        {
                        AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(DocNo_SalesCrMemoLine; "Sales Cr.Memo Line"."Document No.")
                        {
                        }
                        column(LineNo_SalesCrMemoLine; "Sales Cr.Memo Line"."Line No.")
                        {
                        }
                        column(UnitPriceCptn; UnitPriceCptnLbl)
                        {
                        }
                        column(AmountCptn; AmountCptnLbl)
                        {
                        }
                        column(PostedReceiptDateCptn; PostedReceiptDateCptnLbl)
                        {
                        }
                        column(InvDiscAmt_SalesCrMemoLineCptn; InvDiscAmt_SalesCrMemoLineCptnLbl)
                        {
                        }
                        column(SubtotalCptn; SubtotalCptnLbl)
                        {
                        }
                        column(Desc_SalesCrMemoLineCaption; Desc_SalesCrMemoLineCaption)
                        {
                        }
                        column(No_SalesCrMemoLineCaption; No_SalesCrMemoLineCaption)
                        {
                        }
                        column(Qty_SalesCrMemoLineCaption; Qty_SalesCrMemoLineCaption)
                        {
                        }
                        column(UOM_SalesCrMemoLineCaption; UOM_SalesCrMemoLineCaption)
                        {
                        }
                        column(VATIdentif_SalesCrMemoLineCaption; VATIdentif_SalesCrMemoLineCaption)
                        {
                        }
                        column(LineAmtCaption; VATAmtLineLineAmtCptnLbl)
                        {
                        }
                        dataitem("Sales Shipment Buffer"; "Integer")
                        {
                            DataItemTableView = sorting(Number);

                            column(ReportForNavId_1484;1484)
                            {
                            }
                            column(PostingDtFormatted_SalesShipmentBuffer; Format(SalesShipmentBuffer."Posting Date"))
                            {
                            }
                            column(Qty_SalesShipmentBuffer; SalesShipmentBuffer.Quantity)
                            {
                            DecimalPlaces = 0: 5;
                            }
                            column(ReturnRcptCaption; ReturnRcptCaptionLbl)
                            {
                            }
                            trigger OnAfterGetRecord()
                            begin
                                if "Sales Shipment Buffer".Number = 1 then SalesShipmentBuffer.Find('-')
                                else
                                    SalesShipmentBuffer.Next;
                            end;
                            trigger OnPreDataItem()
                            begin
                                "Sales Shipment Buffer".SetRange("Sales Shipment Buffer".Number, 1, SalesShipmentBuffer.Count);
                            end;
                        }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = sorting(Number)where(Number=filter(1..));

                            column(ReportForNavId_3591;3591)
                            {
                            }
                            column(DimText_DimensionLoop2; DimText)
                            {
                            }
                            column(LineDimCptn; LineDimCptnLbl)
                            {
                            }
                            trigger OnAfterGetRecord()
                            begin
                                if DimensionLoop2.Number = 1 then begin
                                    if not DimSetEntry2.Find('-')then CurrReport.Break;
                                end
                                else if not Continue then CurrReport.Break;
                                Clear(DimText);
                                Continue:=false;
                                repeat OldDimText:=DimText;
                                    if DimText = '' then DimText:=StrSubstNo('%1 %2', DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code")
                                    else
                                        DimText:=StrSubstNo('%1, %2 %3', DimText, DimSetEntry2."Dimension Code", DimSetEntry2."Dimension Value Code");
                                    if StrLen(DimText) > MaxStrLen(OldDimText)then begin
                                        DimText:=OldDimText;
                                        Continue:=true;
                                        exit;
                                    end;
                                until DimSetEntry2.Next = 0;
                            end;
                            trigger OnPreDataItem()
                            begin
                                if not ShowInternalInfo then CurrReport.Break;
                                DimSetEntry2.SetRange("Dimension Set ID", "Sales Cr.Memo Line"."Dimension Set ID");
                            end;
                        }
                        trigger OnAfterGetRecord()
                        begin
                            NNC_TotalLineAmount+="Sales Cr.Memo Line"."Line Amount";
                            NNC_TotalAmountInclVat+="Sales Cr.Memo Line"."Amount Including VAT";
                            NNC_TotalInvDiscAmount+="Sales Cr.Memo Line"."Inv. Discount Amount";
                            NNC_TotalAmount+="Sales Cr.Memo Line".Amount;
                            SalesShipmentBuffer.DeleteAll;
                            PostedReceiptDate:=0D;
                            if "Sales Cr.Memo Line".Quantity <> 0 then PostedReceiptDate:=FindPostedShipmentDate;
                            if("Sales Cr.Memo Line".Type = "Sales Cr.Memo Line".Type::"G/L Account") and (not ShowInternalInfo)then "Sales Cr.Memo Line"."No.":='';
                            VATAmountLine.Init;
                            VATAmountLine."VAT Identifier":="Sales Cr.Memo Line"."VAT Identifier";
                            VATAmountLine."VAT Calculation Type":="Sales Cr.Memo Line"."VAT Calculation Type";
                            VATAmountLine."Tax Group Code":="Sales Cr.Memo Line"."Tax Group Code";
                            VATAmountLine."VAT %":="Sales Cr.Memo Line"."VAT %";
                            VATAmountLine."VAT Base":="Sales Cr.Memo Line".Amount;
                            VATAmountLine."Amount Including VAT":="Sales Cr.Memo Line"."Amount Including VAT";
                            VATAmountLine."Line Amount":="Sales Cr.Memo Line"."Line Amount";
                            if "Sales Cr.Memo Line"."Allow Invoice Disc." then VATAmountLine."Inv. Disc. Base Amount":="Sales Cr.Memo Line"."Line Amount";
                            VATAmountLine."Invoice Discount Amount":="Sales Cr.Memo Line"."Inv. Discount Amount";
                            VATAmountLine."VAT Clause Code":="Sales Cr.Memo Line"."VAT Clause Code";
                            VATAmountLine.InsertLine;
                        end;
                        trigger OnPreDataItem()
                        begin
                            VATAmountLine.DeleteAll;
                            SalesShipmentBuffer.Reset;
                            SalesShipmentBuffer.DeleteAll;
                            FirstValueEntryNo:=0;
                            MoreLines:="Sales Cr.Memo Line".Find('+');
                            while MoreLines and ("Sales Cr.Memo Line".Description = '') and ("Sales Cr.Memo Line"."No." = '') and ("Sales Cr.Memo Line".Quantity = 0) and ("Sales Cr.Memo Line".Amount = 0)do MoreLines:="Sales Cr.Memo Line".Next(-1) <> 0;
                            if not MoreLines then CurrReport.Break;
                            "Sales Cr.Memo Line".SetRange("Sales Cr.Memo Line"."Line No.", 0, "Sales Cr.Memo Line"."Line No.");
                            CurrReport.CreateTotals("Sales Cr.Memo Line".Amount, "Sales Cr.Memo Line"."Amount Including VAT", "Sales Cr.Memo Line"."Inv. Discount Amount");
                        end;
                    }
                    dataitem(VATCounter; "Integer")
                    {
                        DataItemTableView = sorting(Number);

                        column(ReportForNavId_6558;6558)
                        {
                        }
                        column(VATAmtLineVATBase; VATAmountLine."VAT Base")
                        {
                        AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                        AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; VATAmountLine."Line Amount")
                        {
                        AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                        AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineInvoiceDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                        AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineVAT; VATAmountLine."VAT %")
                        {
                        DecimalPlaces = 0: 5;
                        }
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmtSpecificationCptn; VATAmtSpecificationCptnLbl)
                        {
                        }
                        column(VATAmtLineInvDiscBaseAmtCptn; VATAmtLineInvDiscBaseAmtCptnLbl)
                        {
                        }
                        column(VATAmtLineLineAmtCptn; VATAmtLineLineAmtCptnLbl)
                        {
                        }
                        column(VATAmtLineInvoiceDiscAmtCptn; VATAmtLineInvoiceDiscAmtCptnLbl)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(VATCounter.Number);
                        end;
                        trigger OnPreDataItem()
                        begin
                            //>>PI001
                            //IF VATAmountLine.GetTotalVATAmount = 0 THEN
                            //  CurrReport.BREAK;
                            //<<
                            VATCounter.SetRange(VATCounter.Number, 1, VATAmountLine.Count);
                            CurrReport.CreateTotals(VATAmountLine."Line Amount", VATAmountLine."Inv. Disc. Base Amount", VATAmountLine."Invoice Discount Amount", VATAmountLine."VAT Base", VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VATClauseEntryCounter; "Integer")
                    {
                        DataItemTableView = sorting(Number);

                        column(ReportForNavId_250;250)
                        {
                        }
                        column(VATClauseVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATClauseCode; VATAmountLine."VAT Clause Code")
                        {
                        }
                        column(VATClauseDescription; VATClause.Description)
                        {
                        }
                        column(VATClauseDescription2; VATClause."Description 2")
                        {
                        }
                        column(VATClauseAmount; VATAmountLine."VAT Amount")
                        {
                        AutoFormatExpression = "Sales Cr.Memo Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATClausesCaption; VATClausesCap)
                        {
                        }
                        column(VATClauseVATIdentifierCaption; VATAmtLineVATIdentifierCptnLbl)
                        {
                        }
                        column(VATClauseVATAmtCaption; VATAmtLineVATAmtCptnLbl)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(VATClauseEntryCounter.Number);
                            if not VATClause.Get(VATAmountLine."VAT Clause Code")then CurrReport.Skip;
                            VATClause.TranslateDescription("Sales Cr.Memo Header"."Language Code");
                        end;
                        trigger OnPreDataItem()
                        begin
                            Clear(VATClause);
                            VATClauseEntryCounter.SetRange(VATClauseEntryCounter.Number, 1, VATAmountLine.Count);
                            CurrReport.CreateTotals(VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VATCounterLCY; "Integer")
                    {
                        DataItemTableView = sorting(Number);

                        column(ReportForNavId_2038;2038)
                        {
                        }
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                        AutoFormatType = 1;
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineVATPercent; VATAmountLine."VAT %")
                        {
                        DecimalPlaces = 0: 5;
                        }
                        column(VATAmtLineVATIdentifierCptn_VATCounterLCY; VATAmtLineVATIdentifierCptnLbl)
                        {
                        }
                        column(VATIdentifier_VATCounterLCY; VATAmountLine."VAT Identifier")
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(VATCounterLCY.Number);
                            VALVATBaseLCY:=VATAmountLine.GetBaseLCY("Sales Cr.Memo Header"."Posting Date", "Sales Cr.Memo Header"."Currency Code", "Sales Cr.Memo Header"."Currency Factor");
                            VALVATAmountLCY:=VATAmountLine.GetAmountLCY("Sales Cr.Memo Header"."Posting Date", "Sales Cr.Memo Header"."Currency Code", "Sales Cr.Memo Header"."Currency Factor");
                        end;
                        trigger OnPreDataItem()
                        begin
                            if(not GLSetup."Print VAT specification in LCY") or ("Sales Cr.Memo Header"."Currency Code" = '') //>>PI001
                            //OR
                            //  (VATAmountLine.GetTotalVATAmount = 0)
                            //<<
                            then CurrReport.Break;
                            VATCounterLCY.SetRange(VATCounterLCY.Number, 1, VATAmountLine.Count);
                            CurrReport.CreateTotals(VALVATBaseLCY, VALVATAmountLCY);
                            if GLSetup."LCY Code" = '' then VALSpecLCYHeader:=Text008 + Text009
                            else
                                VALSpecLCYHeader:=Text008 + Format(GLSetup."LCY Code");
                            CurrExchRate.FindCurrency("Sales Cr.Memo Header"."Posting Date", "Sales Cr.Memo Header"."Currency Code", 1);
                            CalculatedExchRate:=ROUND(1 / "Sales Cr.Memo Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
                            VALExchRate:=StrSubstNo(Text010, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = sorting(Number)where(Number=const(1));

                        column(ReportForNavId_3476;3476)
                        {
                        }
                    }
                    dataitem(Total2; "Integer")
                    {
                        DataItemTableView = sorting(Number)where(Number=const(1));

                        column(ReportForNavId_3363;3363)
                        {
                        }
                        column(SelltoCustNo_SalesCrMemoHeader; "Sales Cr.Memo Header"."Sell-to Customer No.")
                        {
                        }
                        column(ShipToAddr1; ShipToAddr[1])
                        {
                        }
                        column(ShipToAddr2; ShipToAddr[2])
                        {
                        }
                        column(ShipToAddr3; ShipToAddr[3])
                        {
                        }
                        column(ShipToAddr4; ShipToAddr[4])
                        {
                        }
                        column(ShipToAddr5; ShipToAddr[5])
                        {
                        }
                        column(ShipToAddr6; ShipToAddr[6])
                        {
                        }
                        column(ShipToAddr7; ShipToAddr[7])
                        {
                        }
                        column(ShipToAddr8; ShipToAddr[8])
                        {
                        }
                        column(ShiptoAddressCptn; ShiptoAddressCptnLbl)
                        {
                        }
                        column(SelltoCustNo_SalesCrMemoHeaderCaption; SelltoCustNoCaption)
                        {
                        }
                        trigger OnPreDataItem()
                        begin
                            if not ShowShippingAddr then CurrReport.Break;
                        end;
                    }
                }
                trigger OnAfterGetRecord()
                begin
                    if CopyLoop.Number > 1 then begin
                        CopyText:=Text004;
                        OutputNo+=1;
                    end;
                    NNC_TotalLineAmount:=0;
                    NNC_TotalAmountInclVat:=0;
                    NNC_TotalInvDiscAmount:=0;
                    NNC_TotalAmount:=0;
                end;
                trigger OnPostDataItem()
                begin
                    if not CurrReport.Preview then SalesCrMemoCountPrinted.Run("Sales Cr.Memo Header");
                end;
                trigger OnPreDataItem()
                begin
                    NoOfLoops:=Abs(NoOfCopies) + 1;
                    CopyText:='';
                    CopyLoop.SetRange(CopyLoop.Number, 1, NoOfLoops);
                    OutputNo:=1;
                end;
            }
            trigger OnAfterGetRecord()
            var
                LanguageCu_loc: Codeunit Language;
            begin
                if "Sales Cr.Memo Header"."Language Code" = '' then "Sales Cr.Memo Header"."Language Code":='DAN';
                CurrReport.Language:=LanguageCu_loc.GetLanguageId("Sales Cr.Memo Header"."Language Code");
                CompanyInfo.Get;
                if RespCenter.Get("Sales Cr.Memo Header"."Responsibility Center")then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No.":=RespCenter."Phone No.";
                    CompanyInfo."Fax No.":=RespCenter."Fax No.";
                end
                else
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                DimSetEntry1.SetRange("Dimension Set ID", "Sales Cr.Memo Header"."Dimension Set ID");
                if "Sales Cr.Memo Header"."Currency Code" = '' then begin
                    GLSetup.TestField("LCY Code");
                    TotalText:=StrSubstNo(Text001, GLSetup."LCY Code");
                    TotalInclVATText:=StrSubstNo(Text002, GLSetup."LCY Code");
                    TotalExclVATText:=StrSubstNo(Text007, GLSetup."LCY Code");
                end
                else
                begin
                    TotalText:=StrSubstNo(Text001, "Sales Cr.Memo Header"."Currency Code");
                    TotalInclVATText:=StrSubstNo(Text002, "Sales Cr.Memo Header"."Currency Code");
                    TotalExclVATText:=StrSubstNo(Text007, "Sales Cr.Memo Header"."Currency Code");
                end;
                FormatAddr.SalesCrMemoBillTo(CustAddr, "Sales Cr.Memo Header");
                Cust.Get("Sales Cr.Memo Header"."Bill-to Customer No.");
                FormatAddr.SalesCrMemoShipTo(ShipToAddr, CustAddr, "Sales Cr.Memo Header");
                ShowShippingAddr:="Sales Cr.Memo Header"."Sell-to Customer No." <> "Sales Cr.Memo Header"."Bill-to Customer No.";
                for i:=1 to ArrayLen(ShipToAddr)do if ShipToAddr[i] <> CustAddr[i]then ShowShippingAddr:=true;
                if LogInteraction then if not CurrReport.Preview then if "Sales Cr.Memo Header"."Bill-to Contact No." <> '' then SegManagement.LogDocument(6, "Sales Cr.Memo Header"."No.", 0, 0, Database::Contact, "Sales Cr.Memo Header"."Bill-to Contact No.", "Sales Cr.Memo Header"."Salesperson Code", "Sales Cr.Memo Header"."Campaign No.", "Sales Cr.Memo Header"."Posting Description", '')
                        else
                            SegManagement.LogDocument(6, "Sales Cr.Memo Header"."No.", 0, 0, Database::Customer, "Sales Cr.Memo Header"."Sell-to Customer No.", "Sales Cr.Memo Header"."Salesperson Code", "Sales Cr.Memo Header"."Campaign No.", "Sales Cr.Memo Header"."Posting Description", '');
                //>>PI002
                CompanyInfo."Bank Name":=BankInfoInDocuments.GetBankName("Sales Cr.Memo Header"."Currency Code", "Sales Cr.Memo Header"."Bill-to Country/Region Code");
                CompanyInfo."Bank Branch No.":=BankInfoInDocuments.GetbankBranch("Sales Cr.Memo Header"."Currency Code", "Sales Cr.Memo Header"."Bill-to Country/Region Code");
                CompanyInfo."Bank Account No.":=BankInfoInDocuments.GetBankAccount("Sales Cr.Memo Header"."Currency Code", "Sales Cr.Memo Header"."Bill-to Country/Region Code");
                CompanyInfo.Iban:=BankInfoInDocuments.GetIBAN("Sales Cr.Memo Header"."Currency Code", "Sales Cr.Memo Header"."Bill-to Country/Region Code");
                CompanyInfo."SWIFT Code":=BankInfoInDocuments.GetSwift("Sales Cr.Memo Header"."Currency Code", "Sales Cr.Memo Header"."Bill-to Country/Region Code");
                //<<PI002
                //>>EDOC
                InitEDOC;
                //<<EDOC
                //>>PI004
                InitHeaderValues;
            //<<PI004
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

                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = Basic;
                        Caption = 'No. of Copies';
                    }
                    field(ShowInternalInfo; ShowInternalInfo)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show Internal Information';
                    }
                    field(LogInteraction; LogInteraction)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Log Interaction';
                        Enabled = LogInteractionEnable;
                    }
                }
            }
        }
        actions
        {
        }
        trigger OnInit()
        begin
            LogInteractionEnable:=true;
        end;
        trigger OnOpenPage()
        begin
            LogInteraction:=SegManagement.FindInteractionTemplateCode(enum::"Interaction Log Entry Document Type".FromInteger(6)) <> '';
            LogInteractionEnable:=LogInteraction;
        end;
    }
    labels
    {
    IBANCaption='IBAN';
    }
    trigger OnInitReport()
    var
    begin
        GLSetup.Get;
        SalesSetup.Get;
        /*  if not DstSetup.IsEmpty then begin
             DstSetup.Get;
             DstSetup.CalcFields("Header Logo", "Footer Logo");
             TempBlob."Header Logo" := DstSetup."Header Logo";
             TempBlob."Footer Logo" := DstSetup."Footer Logo";
             FooterText1 := DstSetup."Footer Text 1";
             FooterText2 := DstSetup."Footer Text 2";
             FooterText3 := DstSetup."Footer Text 3";
             ShowVATSpecification := DstSetup.ShowVATSpecification;
             ShowBankInformation := DstSetup.ShowBankInformation;
             ShowVATClause := DstSetup."Show Vat Clause";
         end else begin
             CompanyInfo.CalcFields(Picture);
             TempBlob."Header Logo" := CompanyInfo.Picture;
             ShowVATSpecification := true;
             ShowBankInformation := true;
             ShowVATClause := true;
         end;
         TempBlob.Insert();
         TempBlob.CalcFields("Header Logo", "Footer Logo");
     end; */
        if not DstSetup.IsEmpty then begin
            DstSetup.Get;
            //DstSetup.CalcFields("Header Logo", "Footer Logo");
            FooterText1:=DstSetup."Footer Text 1";
            FooterText2:=DstSetup."Footer Text 2";
            FooterText3:=DstSetup."Footer Text 3";
            ShowVATSpecification:=DstSetup.ShowVATSpecification;
            ShowBankInformation:=DstSetup.ShowBankInformation;
            ShowVATClause:=DstSetup."Show Vat Clause";
        end
        else
        begin
            CompanyInfo.CalcFields(Picture);
            DstSetup."Header Logo":=CompanyInfo.Picture;
            ShowVATSpecification:=true;
            ShowBankInformation:=true;
            ShowVATClause:=true;
        end;
        //TempBlob.Insert();
        DstSetup.CalcFields("Header Logo", "Footer Logo");
    end;
    trigger OnPreReport()
    begin
        if not CurrReport.UseRequestPage then InitLogInteraction;
    end;
    var Text000: label 'Salesperson';
    Text001: label 'Total %1';
    Text002: label 'Total %1 Incl. VAT';
    Text003: label '(Applies to %1 %2)';
    Text004: label 'COPY';
    Text005: label 'Credit Memo %1';
    PageCaptionCap: label 'Page %1 of %2';
    Text007: label 'Total %1 Excl. VAT';
    DstSetup: Record "DST Setup";
    TempBlob: Record "DST Setup";
    GLSetup: Record "General Ledger Setup";
    SalesSetup: Record "Sales & Receivables Setup";
    SalesPurchPerson: Record "Salesperson/Purchaser";
    CompanyInfo: Record "Company Information";
    VATAmountLine: Record "VAT Amount Line" temporary;
    VATClause: Record "VAT Clause";
    DimSetEntry1: Record "Dimension Set Entry";
    DimSetEntry2: Record "Dimension Set Entry";
    SalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
    CurrExchRate: Record "Currency Exchange Rate";
    SalesCrMemoCountPrinted: Codeunit "Sales Cr. Memo-Printed";
    FormatAddr: Codeunit "Format Address";
    SegManagement: Codeunit SegManagement;
    RespCenter: Record "Responsibility Center";
    CustAddr: array[8]of Text[100];
    ShipToAddr: array[8]of Text[100];
    CompanyAddr: array[8]of Text[100];
    TotalText: Text[50];
    TotalExclVATText: Text[50];
    TotalInclVATText: Text[50];
    MoreLines: Boolean;
    NoOfCopies: Integer;
    NoOfLoops: Integer;
    CopyText: Text[30];
    ShowShippingAddr: Boolean;
    i: Integer;
    DimText: Text[120];
    OldDimText: Text[75];
    ShowInternalInfo: Boolean;
    Continue: Boolean;
    LogInteraction: Boolean;
    FirstValueEntryNo: Integer;
    PostedReceiptDate: Date;
    NextEntryNo: Integer;
    VALVATBaseLCY: Decimal;
    VALVATAmountLCY: Decimal;
    Text008: label 'VAT Amount Specification in ';
    Text009: label 'Local Currency';
    Text010: label 'Exchange rate: %1/%2';
    VALSpecLCYHeader: Text[80];
    VALExchRate: Text[50];
    CalculatedExchRate: Decimal;
    Text011: label 'Prepmt. Credit Memo %1';
    OutputNo: Integer;
    NNC_TotalLineAmount: Decimal;
    NNC_TotalAmountInclVat: Decimal;
    NNC_TotalInvDiscAmount: Decimal;
    NNC_TotalAmount: Decimal;
    Cust: Record Customer;
    LogInteractionEnable: Boolean;
    CompanyInfoPhoneNoCptnLbl: label 'Phone No.';
    CompanyInfoVATRegNoCptnLbl: label 'VAT Reg. No.';
    CompanyInfoGiroNoCptnLbl: label 'Giro No.';
    CompanyInfoBankNameCptnLbl: label 'Bank';
    CompanyInfoBankAccNoCptnLbl: label 'Account No.';
    No1_SalesCrMemoHeaderCptnLbl: label 'Credit Memo No.';
    SalesCrMemoHeaderPostDtCptnLbl: label 'Date';
    CompanyInfoHomePageCaptionLbl: label 'Home Page';
    CompanyINfoEmailCaptionLbl: label 'E-Mail';
    SWIFTCodeCaptionLbl: label 'BIC/SWIFT';
    HeaderDimCptnLbl: label 'Header Dimensions';
    UnitPriceCptnLbl: label 'Unit Price';
    AmountCptnLbl: label 'Amount';
    PostedReceiptDateCptnLbl: label 'Posted Return Receipt Date';
    InvDiscAmt_SalesCrMemoLineCptnLbl: label 'Invoice Discount Amount';
    SubtotalCptnLbl: label 'Subtotal';
    LineAmtInvDiscAmt_SalesCrMemoLineCptnLbl: label 'Payment Discount on VAT';
    VATClausesCap: label 'VAT Clause';
    ReturnRcptCaptionLbl: label 'Return Receipt';
    LineDimCptnLbl: label 'Line Dimensions';
    VATAmtSpecificationCptnLbl: label 'VAT Amount Specification';
    VATAmtLineInvDiscBaseAmtCptnLbl: label 'Invoice Discount Base Amount';
    VATAmtLineLineAmtCptnLbl: label 'Line Amount';
    VATAmtLineInvoiceDiscAmtCptnLbl: label 'Invoice Discount Amount';
    ShiptoAddressCptnLbl: label 'Ship-to Address';
    VATAmtLineVATCptnLbl: label 'VAT %';
    VATAmtLineVATBaseCptnLbl: label 'VAT Base';
    VATAmtLineVATAmtCptnLbl: label 'VAT Amount';
    VATAmtLineVATIdentifierCptnLbl: label 'VAT Identifier';
    TotalCptnLbl: label 'Total';
    SalesCrMemoLineDiscCaptionLbl: label 'Discount %';
    VATAmountLineInvDiscBaseAmountCptnLbl: label 'Inv. Disc. Base Amount';
    FooterText1: Text;
    FooterText2: Text;
    FooterText3: Text;
    ShowVATSpecification: Boolean;
    ShowBankInformation: Boolean;
    ShowVATClause: Boolean;
    EdocIniFileName: Text;
    EdocCMDLine: Text;
    PdfName: label 'Credit Meno %1';
    BankInfoInDocuments: Record "Bank Information documents";
    ExtDocNoCaption: label 'Your Order';
    SelltoContactCaption: label 'Sell-to Contact';
    CaptionLeft: array[10]of Text;
    ValueLeft: array[10]of Text;
    CaptionRight: array[10]of Text;
    ValueRight: array[10]of Text;
    BilltoCustNo_Caption: label 'Bill-to Customer No.';
    CustomerVATRegNoCaption: label 'Customer VAT Registration No.';
    SelltoCustNoCaption: label 'Sell-to Customer No.';
    AccCodeCaption: label 'Account Code';
    Desc_SalesCrMemoLineCaption: label 'Description';
    No_SalesCrMemoLineCaption: label 'No.';
    Qty_SalesCrMemoLineCaption: label 'Quantity';
    UOM_SalesCrMemoLineCaption: label 'Unit of Measure';
    VATIdentif_SalesCrMemoLineCaption: label 'VAT Identifier';
    procedure InitLogInteraction()
    begin
        LogInteraction:=SegManagement.FindInteractionTemplateCode(enum::"Interaction Log Entry Document Type".FromInteger(6)) <> '';
    end;
    procedure FindPostedShipmentDate(): Date var
        ReturnReceiptHeader: Record "Return Receipt Header";
        SalesShipmentBuffer2: Record "Sales Shipment Buffer" temporary;
    begin
        NextEntryNo:=1;
        if "Sales Cr.Memo Line"."Return Receipt No." <> '' then if ReturnReceiptHeader.Get("Sales Cr.Memo Line"."Return Receipt No.")then exit(ReturnReceiptHeader."Posting Date");
        if "Sales Cr.Memo Header"."Return Order No." = '' then exit("Sales Cr.Memo Header"."Posting Date");
        case "Sales Cr.Memo Line".Type of "Sales Cr.Memo Line".Type::Item: GenerateBufferFromValueEntry("Sales Cr.Memo Line");
        "Sales Cr.Memo Line".Type::"G/L Account", "Sales Cr.Memo Line".Type::Resource, "Sales Cr.Memo Line".Type::"Charge (Item)", "Sales Cr.Memo Line".Type::"Fixed Asset": GenerateBufferFromShipment("Sales Cr.Memo Line");
        "Sales Cr.Memo Line".Type::" ": exit(0D);
        end;
        SalesShipmentBuffer.Reset;
        SalesShipmentBuffer.SetRange("Document No.", "Sales Cr.Memo Line"."Document No.");
        SalesShipmentBuffer.SetRange("Line No.", "Sales Cr.Memo Line"."Line No.");
        if SalesShipmentBuffer.Find('-')then begin
            SalesShipmentBuffer2:=SalesShipmentBuffer;
            if SalesShipmentBuffer.Next = 0 then begin
                SalesShipmentBuffer.Get(SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No.");
                SalesShipmentBuffer.Delete;
                exit(SalesShipmentBuffer2."Posting Date");
            end;
            SalesShipmentBuffer.CalcSums(Quantity);
            if SalesShipmentBuffer.Quantity <> "Sales Cr.Memo Line".Quantity then begin
                SalesShipmentBuffer.DeleteAll;
                exit("Sales Cr.Memo Header"."Posting Date");
            end;
        end
        else
            exit("Sales Cr.Memo Header"."Posting Date");
    end;
    procedure GenerateBufferFromValueEntry(SalesCrMemoLine2: Record "Sales Cr.Memo Line")
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity:=SalesCrMemoLine2."Quantity (Base)";
        ValueEntry.SetCurrentkey("Document No.");
        ValueEntry.SetRange("Document No.", SalesCrMemoLine2."Document No.");
        ValueEntry.SetRange("Posting Date", "Sales Cr.Memo Header"."Posting Date");
        ValueEntry.SetRange("Item Charge No.", '');
        ValueEntry.SetFilter("Entry No.", '%1..', FirstValueEntryNo);
        if ValueEntry.Find('-')then repeat if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.")then begin
                    if SalesCrMemoLine2."Qty. per Unit of Measure" <> 0 then Quantity:=ValueEntry."Invoiced Quantity" / SalesCrMemoLine2."Qty. per Unit of Measure"
                    else
                        Quantity:=ValueEntry."Invoiced Quantity";
                    AddBufferEntry(SalesCrMemoLine2, -Quantity, ItemLedgerEntry."Posting Date");
                    TotalQuantity:=TotalQuantity - ValueEntry."Invoiced Quantity";
                end;
                FirstValueEntryNo:=ValueEntry."Entry No." + 1;
            until(ValueEntry.Next = 0) or (TotalQuantity = 0);
    end;
    procedure GenerateBufferFromShipment(SalesCrMemoLine: Record "Sales Cr.Memo Line")
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        SalesCrMemoLine2: Record "Sales Cr.Memo Line";
        ReturnReceiptHeader: Record "Return Receipt Header";
        ReturnReceiptLine: Record "Return Receipt Line";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity:=0;
        SalesCrMemoHeader.SetCurrentkey("Return Order No.");
        SalesCrMemoHeader.SetFilter("No.", '..%1', "Sales Cr.Memo Header"."No.");
        SalesCrMemoHeader.SetRange("Return Order No.", "Sales Cr.Memo Header"."Return Order No.");
        if SalesCrMemoHeader.Find('-')then repeat SalesCrMemoLine2.SetRange("Document No.", SalesCrMemoHeader."No.");
                SalesCrMemoLine2.SetRange("Line No.", SalesCrMemoLine."Line No.");
                SalesCrMemoLine2.SetRange(Type, SalesCrMemoLine.Type);
                SalesCrMemoLine2.SetRange("No.", SalesCrMemoLine."No.");
                SalesCrMemoLine2.SetRange("Unit of Measure Code", SalesCrMemoLine."Unit of Measure Code");
                if SalesCrMemoLine2.Find('-')then repeat TotalQuantity:=TotalQuantity + SalesCrMemoLine2.Quantity;
                    until SalesCrMemoLine2.Next = 0;
            until SalesCrMemoHeader.Next = 0;
        ReturnReceiptLine.SetCurrentkey("Return Order No.", "Return Order Line No.");
        ReturnReceiptLine.SetRange("Return Order No.", "Sales Cr.Memo Header"."Return Order No.");
        ReturnReceiptLine.SetRange("Return Order Line No.", SalesCrMemoLine."Line No.");
        ReturnReceiptLine.SetRange("Line No.", SalesCrMemoLine."Line No.");
        ReturnReceiptLine.SetRange(Type, SalesCrMemoLine.Type);
        ReturnReceiptLine.SetRange("No.", SalesCrMemoLine."No.");
        ReturnReceiptLine.SetRange("Unit of Measure Code", SalesCrMemoLine."Unit of Measure Code");
        ReturnReceiptLine.SetFilter(Quantity, '<>%1', 0);
        if ReturnReceiptLine.Find('-')then repeat if "Sales Cr.Memo Header"."Get Return Receipt Used" then CorrectShipment(ReturnReceiptLine);
                if Abs(ReturnReceiptLine.Quantity) <= Abs(TotalQuantity - SalesCrMemoLine.Quantity)then TotalQuantity:=TotalQuantity - ReturnReceiptLine.Quantity
                else
                begin
                    if Abs(ReturnReceiptLine.Quantity) > Abs(TotalQuantity)then ReturnReceiptLine.Quantity:=TotalQuantity;
                    Quantity:=ReturnReceiptLine.Quantity - (TotalQuantity - SalesCrMemoLine.Quantity);
                    SalesCrMemoLine.Quantity:=SalesCrMemoLine.Quantity - Quantity;
                    TotalQuantity:=TotalQuantity - ReturnReceiptLine.Quantity;
                    if ReturnReceiptHeader.Get(ReturnReceiptLine."Document No.")then AddBufferEntry(SalesCrMemoLine, -Quantity, ReturnReceiptHeader."Posting Date");
                end;
            until(ReturnReceiptLine.Next = 0) or (TotalQuantity = 0);
    end;
    procedure CorrectShipment(var ReturnReceiptLine: Record "Return Receipt Line")
    var
        SalesCrMemoLine: Record "Sales Cr.Memo Line";
    begin
        SalesCrMemoLine.SetCurrentkey("Return Receipt No.", "Return Receipt Line No.");
        SalesCrMemoLine.SetRange("Return Receipt No.", ReturnReceiptLine."Document No.");
        SalesCrMemoLine.SetRange("Return Receipt Line No.", ReturnReceiptLine."Line No.");
        if SalesCrMemoLine.Find('-')then repeat ReturnReceiptLine.Quantity:=ReturnReceiptLine.Quantity - SalesCrMemoLine.Quantity;
            until SalesCrMemoLine.Next = 0;
    end;
    procedure AddBufferEntry(SalesCrMemoLine: Record "Sales Cr.Memo Line"; QtyOnShipment: Decimal; PostingDate: Date)
    begin
        SalesShipmentBuffer.SetRange("Document No.", SalesCrMemoLine."Document No.");
        SalesShipmentBuffer.SetRange("Line No.", SalesCrMemoLine."Line No.");
        SalesShipmentBuffer.SetRange("Posting Date", PostingDate);
        if SalesShipmentBuffer.Find('-')then begin
            SalesShipmentBuffer.Quantity:=SalesShipmentBuffer.Quantity - QtyOnShipment;
            SalesShipmentBuffer.Modify;
            exit;
        end;
        begin
            SalesShipmentBuffer.Init;
            SalesShipmentBuffer."Document No.":=SalesCrMemoLine."Document No.";
            SalesShipmentBuffer."Line No.":=SalesCrMemoLine."Line No.";
            SalesShipmentBuffer."Entry No.":=NextEntryNo;
            SalesShipmentBuffer.Type:=SalesCrMemoLine.Type;
            SalesShipmentBuffer."No.":=SalesCrMemoLine."No.";
            SalesShipmentBuffer.Quantity:=-QtyOnShipment;
            SalesShipmentBuffer."Posting Date":=PostingDate;
            SalesShipmentBuffer.Insert;
            NextEntryNo:=NextEntryNo + 1 end;
    end;
    local procedure DocumentCaption(): Text[250]begin
        if "Sales Cr.Memo Header"."Prepayment Credit Memo" then exit(Text011);
        exit(Text005);
    end;
    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean)
    begin
        NoOfCopies:=NewNoOfCopies;
        ShowInternalInfo:=NewShowInternalInfo;
        LogInteraction:=NewLogInteraction;
    end;
    procedure InitEDOC()
    var
        TxtLine: Text;
        Text50000: label 'Invoice_%1';
        InStr: InStream;
    begin
    //EDOC
    // EdocIniFileName := 'C:\Program Files\Microsoft Dynamics NAV\71\Service\EDOCINI.TXT';  //
    // if not UploadIntoStream(EdocIniFileName, InStr) then
    //     exit;
    // EdocCMDLine += '%%DestFile:' + StrSubstNo(PdfName, "Sales Cr.Memo Header"."No.") + '%%';
    // while Instr.ReadText(TxtLine) <> 0 do begin
    //     if TxtLine[1] = '1' then begin
    //         TxtLine := CopyStr(TxtLine, 3);
    //         if StrPos(TxtLine, '//') <> 0 then
    //             TxtLine := DelStr(TxtLine, StrPos(TxtLine, '//'));
    //         TxtLine := DelChr(TxtLine, '=', '"');
    //         TxtLine := ConvertStr(TxtLine, ',', ':');
    //         TxtLine := DelChr(TxtLine, '=', ' ');
    //         if StrPos(TxtLine, 'EmailEnable:True') <> 0 then begin
    //             EdocCMDLine += '%%EmailTo:' + Cust."E-Mail" + '%%';
    //             EdocCMDLine += '%%EmailSubject:' + StrSubstNo(PdfName, "Sales Cr.Memo Header"."No.") + '%%';
    //         end;
    //         EdocCMDLine += '%%' + TxtLine + '%%';
    //     end;
    // end;
    end;
    local procedure InitHeaderValues()
    begin
        Clear(CaptionLeft);
        Clear(ValueLeft);
        Clear(CaptionRight);
        Clear(ValueRight);
        if "Sales Cr.Memo Header"."Bill-to Customer No." <> '' then begin
            CaptionLeft[1]:=BilltoCustNo_Caption;
            ValueLeft[1]:="Sales Cr.Memo Header"."Bill-to Customer No.";
        end;
        if "Sales Cr.Memo Header"."VAT Registration No." <> '' then begin
            CaptionLeft[2]:=CustomerVATRegNoCaption;
            ValueLeft[2]:="Sales Cr.Memo Header"."VAT Registration No.";
        end;
        if "Sales Cr.Memo Header"."No." <> '' then begin
            CaptionLeft[3]:=No1_SalesCrMemoHeaderCptnLbl;
            ValueLeft[3]:="Sales Cr.Memo Header"."No.";
        end;
        if "Sales Cr.Memo Header"."Return Order No." <> '' then begin
            CaptionLeft[4]:="Sales Cr.Memo Header".FieldCaption("Return Order No.");
            ValueLeft[4]:="Sales Cr.Memo Header"."Return Order No.";
        end;
        if "Sales Cr.Memo Header"."Posting Date" <> 0D then begin
            CaptionLeft[5]:=SalesCrMemoHeaderPostDtCptnLbl;
            ValueLeft[5]:=Format("Sales Cr.Memo Header"."Posting Date", 0, 7);
        end;
        if "Sales Cr.Memo Header"."External Document No." <> '' then begin
            CaptionLeft[6]:=ExtDocNoCaption;
            ValueLeft[6]:="Sales Cr.Memo Header"."External Document No.";
        end;
        if "Sales Cr.Memo Header"."Sell-to Contact" <> '' then begin
            CaptionLeft[7]:=SelltoContactCaption;
            ValueLeft[7]:="Sales Cr.Memo Header"."Sell-to Contact";
        end;
        if CompanyInfo."Phone No." <> '' then begin
            CaptionRight[1]:=CompanyInfoPhoneNoCptnLbl;
            ValueRight[1]:=CompanyInfo."Phone No.";
        end;
        if CompanyInfo."Home Page" <> '' then begin
            CaptionRight[2]:=CompanyInfoHomePageCaptionLbl;
            ValueRight[2]:=CompanyInfo."Home Page";
        end;
        if CompanyInfo."E-Mail" <> '' then begin
            CaptionRight[3]:=CompanyINfoEmailCaptionLbl;
            ValueRight[3]:=CompanyInfo."E-Mail";
        end;
        if CompanyInfo."VAT Registration No." <> '' then begin
            CaptionRight[4]:=CompanyInfoVATRegNoCptnLbl;
            ValueRight[4]:=CompanyInfo."VAT Registration No.";
        end;
        if "Sales Cr.Memo Header"."Salesperson Code" <> '' then begin
            if SalesPurchPerson.Get("Sales Cr.Memo Header"."Salesperson Code")then begin
                CaptionRight[5]:=Text000;
                ValueRight[5]:=SalesPurchPerson.Name;
            end;
        end;
        if ShowBankInformation then begin
            if CompanyInfo."Bank Name" <> '' then begin
                CaptionRight[6]:=CompanyInfoBankNameCptnLbl;
                ValueRight[6]:=CompanyInfo."Bank Name";
            end;
            if CompanyInfo.Iban <> '' then begin
                CaptionRight[7]:='IBAN';
                ValueRight[7]:=CompanyInfo.Iban;
            end;
            if CompanyInfo."SWIFT Code" <> '' then begin
                CaptionRight[8]:=SWIFTCodeCaptionLbl;
                ValueRight[8]:=CompanyInfo."SWIFT Code";
            end;
            if(CompanyInfo."Bank Branch No." <> '') and (CompanyInfo."Bank Account No." <> '')then begin
                CaptionRight[9]:=CompanyInfoBankAccNoCptnLbl;
                ValueRight[9]:=StrSubstNo('%1-%2', CompanyInfo."Bank Branch No.", CompanyInfo."Bank Account No.");
            end;
        end;
        CompressArray(CaptionLeft);
        CompressArray(ValueLeft);
        CompressArray(CaptionRight);
        CompressArray(ValueRight);
    end;
}
