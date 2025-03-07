Report 50020 "Sales - Invoice PI"
{
    // PI001/160414/Jim : 2013 R2 Rollup 6
    // PI002/220814/Jim : Bank Info implemented
    // 13-04-2015 OBL PI003 Fields addded and layout updated. German captions addded.
    // 03-11-2015 OBL PI004 New function InitHeaderValues. Dataset and laout changed
    // 01-04-2016 OBL PI005 ShowVATClause added
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Sales - Invoice PI.rdlc';
    Caption = 'Sales - Invoice';
    Permissions = TableData "Sales Shipment Buffer"=rimd;

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Sell-to Customer No.", "No. Printed";
            RequestFilterHeading = 'Posted Sales Invoice';

            column(ReportForNavId_5581;5581)
            {
            }
            column(No_SalesInvHdr; "Sales Invoice Header"."No.")
            {
            }
            column(InvDiscountAmtCaption; InvDiscountAmtCaptionLbl)
            {
            }
            column(PaymentTermsDescCaption; PaymentTermsDescCaptionLbl)
            {
            }
            column(ShptMethodDescCaption; ShptMethodDescCaptionLbl)
            {
            }
            column(VATPercentageCaption; VATPercentageCaptionLbl)
            {
            }
            column(TotalCaption; TotalCaptionLbl)
            {
            }
            column(VATBaseCaption; VATBaseCaptionLbl)
            {
            }
            column(VATAmtCaption; VATAmtCaptionLbl)
            {
            }
            column(VATIdentifierCaption; VATIdentifierCaptionLbl)
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
                    column(DocumentCaptionCopyText; StrSubstNo(DocumentCaption, CopyText))
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
                    column(OutputNo; OutputNo)
                    {
                    }
                    column(PageCaption; PageCaptionCap)
                    {
                    }
                    column(BilltoCustNo_SalesInvHdr; "Sales Invoice Header"."Bill-to Customer No.")
                    {
                    }
                    column(PricesInclVAT_SalesInvHdr; "Sales Invoice Header"."Prices Including VAT")
                    {
                    }
                    column(DocumentReferenceTxt; DocumentReferenceTxt)
                    {
                    }
                    column(DocumentReference; DocumentReference)
                    {
                    }
                    dataitem(DimensionLoop1; "Integer")
                    {
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = sorting(Number)where(Number=filter(1..));

                        column(ReportForNavId_7574;7574)
                        {
                        }
                        column(DimText; DimText)
                        {
                        }
                        column(DimensionLoop1Number; DimensionLoop1.Number)
                        {
                        }
                        column(HeaderDimCaption; HeaderDimCaptionLbl)
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
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLink = "Document No."=field("No.");
                        DataItemLinkReference = "Sales Invoice Header";
                        DataItemTableView = sorting("Document No.", "Line No.");

                        column(ReportForNavId_1570;1570)
                        {
                        }
                        column(LineAmt_SalesInvLine; "Sales Invoice Line"."Line Amount")
                        {
                        AutoFormatExpression = GetCurrencyCode;
                        AutoFormatType = 1;
                        }
                        column(Desc_SalesInvLine; "Sales Invoice Line".Description)
                        {
                        }
                        column(No_SalesInvLine; "Sales Invoice Line"."No.")
                        {
                        }
                        column(Qty_SalesInvLine; "Sales Invoice Line".Quantity)
                        {
                        }
                        column(UOM_SalesInvLine; "Sales Invoice Line"."Unit of Measure")
                        {
                        }
                        column(UnitPrice_SalesInvLine; "Sales Invoice Line"."Unit Price")
                        {
                        AutoFormatExpression = GetCurrencyCode;
                        AutoFormatType = 2;
                        }
                        column(Discount_SalesInvLine; "Sales Invoice Line"."Line Discount %")
                        {
                        }
                        column(VATIdentifier_SalesInvLine; "Sales Invoice Line"."VAT Identifier")
                        {
                        }
                        column(PostedShipmentDate; Format(PostedShipmentDate))
                        {
                        }
                        column(Type_SalesInvLine; Format("Sales Invoice Line".Type))
                        {
                        }
                        column(InvDiscLineAmt_SalesInvLine;-"Sales Invoice Line"."Inv. Discount Amount")
                        {
                        AutoFormatExpression = GetCurrencyCode;
                        AutoFormatType = 1;
                        }
                        column(TotalSubTotal; TotalSubTotal)
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(TotalInvDiscAmount; TotalInvDiscAmount)
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(TotalText; TotalText)
                        {
                        }
                        column(Amount_SalesInvLine; "Sales Invoice Line".Amount)
                        {
                        AutoFormatExpression = GetCurrencyCode;
                        AutoFormatType = 1;
                        }
                        column(TotalAmount; TotalAmount)
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(Amount_AmtInclVAT; "Sales Invoice Line"."Amount Including VAT" - "Sales Invoice Line".Amount)
                        {
                        AutoFormatExpression = GetCurrencyCode;
                        AutoFormatType = 1;
                        }
                        column(AmtInclVAT_SalesInvLine; "Sales Invoice Line"."Amount Including VAT")
                        {
                        AutoFormatExpression = GetCurrencyCode;
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmtText; VATAmountLine.VATAmountText)
                        {
                        }
                        column(TotalExclVATText; TotalExclVATText)
                        {
                        }
                        column(TotalInclVATText; TotalInclVATText)
                        {
                        }
                        column(TotalAmountInclVAT; TotalAmountInclVAT)
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(TotalAmountVAT; TotalAmountVAT)
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(LineAmtAfterInvDiscAmt;-("Sales Invoice Line"."Line Amount" - "Sales Invoice Line"."Inv. Discount Amount" - "Sales Invoice Line"."Amount Including VAT"))
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATBaseDisc_SalesInvHdr; "Sales Invoice Header"."VAT Base Discount %")
                        {
                        AutoFormatType = 1;
                        }
                        column(TotalPaymentDiscOnVAT; TotalPaymentDiscOnVAT)
                        {
                        AutoFormatType = 1;
                        }
                        column(TotalInclVATText_SalesInvLine; TotalInclVATText)
                        {
                        }
                        column(VATAmtText_SalesInvLine; VATAmountLine.VATAmountText)
                        {
                        }
                        column(DocNo_SalesInvLine; "Sales Invoice Line"."Document No.")
                        {
                        }
                        column(LineNo_SalesInvLine; "Sales Invoice Line"."Line No.")
                        {
                        }
                        column(UnitPriceCaption; UnitPriceCaptionLbl)
                        {
                        }
                        column(SalesInvLineDiscCaption; SalesInvLineDiscCaptionLbl)
                        {
                        }
                        column(AmountCaption; AmountCaptionLbl)
                        {
                        }
                        column(PostedShipmentDateCaption; PostedShipmentDateCaptionLbl)
                        {
                        }
                        column(SubtotalCaption; SubtotalCaptionLbl)
                        {
                        }
                        column(LineAmtAfterInvDiscCptn; LineAmtAfterInvDiscCptnLbl)
                        {
                        }
                        column(Desc_SalesInvLineCaption; Desc_SalesInvLineCaption)
                        {
                        }
                        column(No_SalesInvLineCaption; ItemNoCaption)
                        {
                        }
                        column(Qty_SalesInvLineCaption; Qty_Caption)
                        {
                        }
                        column(UOM_SalesInvLineCaption; UOM_Caption)
                        {
                        }
                        column(VATIdentifier_SalesInvLineCaption; VATIdentifierCaptionLbl)
                        {
                        }
                        dataitem("Sales Shipment Buffer"; "Integer")
                        {
                            DataItemTableView = sorting(Number);

                            column(ReportForNavId_1484;1484)
                            {
                            }
                            column(SalesShptBufferPostDate; Format(SalesShipmentBuffer."Posting Date"))
                            {
                            }
                            column(SalesShptBufferQty; SalesShipmentBuffer.Quantity)
                            {
                            DecimalPlaces = 0: 5;
                            }
                            column(ShipmentCaption; ShipmentCaptionLbl)
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
                                SalesShipmentBuffer.SetRange("Document No.", "Sales Invoice Line"."Document No.");
                                SalesShipmentBuffer.SetRange("Line No.", "Sales Invoice Line"."Line No.");
                                "Sales Shipment Buffer".SetRange("Sales Shipment Buffer".Number, 1, SalesShipmentBuffer.Count);
                            end;
                        }
                        dataitem(DimensionLoop2; "Integer")
                        {
                            DataItemTableView = sorting(Number)where(Number=filter(1..));

                            column(ReportForNavId_3591;3591)
                            {
                            }
                            column(DimText_DimLoop; DimText)
                            {
                            }
                            column(LineDimCaption; LineDimCaptionLbl)
                            {
                            }
                            trigger OnAfterGetRecord()
                            begin
                                if DimensionLoop2.Number = 1 then begin
                                    if not DimSetEntry2.FindSet then CurrReport.Break;
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
                                DimSetEntry2.SetRange("Dimension Set ID", "Sales Invoice Line"."Dimension Set ID");
                            end;
                        }
                        dataitem(AsmLoop; "Integer")
                        {
                            DataItemTableView = sorting(Number);

                            column(ReportForNavId_9462;9462)
                            {
                            }
                            column(TempPostedAsmLineNo; BlanksForIndent + TempPostedAsmLine."No.")
                            {
                            }
                            column(TempPostedAsmLineQuantity; TempPostedAsmLine.Quantity)
                            {
                            DecimalPlaces = 0: 5;
                            }
                            column(TempPostedAsmLineDesc; BlanksForIndent + TempPostedAsmLine.Description)
                            {
                            }
                            column(TempPostAsmLineVartCode; BlanksForIndent + TempPostedAsmLine."Variant Code")
                            {
                            }
                            column(TempPostedAsmLineUOM; GetUOMText(TempPostedAsmLine."Unit of Measure Code"))
                            {
                            }
                            trigger OnAfterGetRecord()
                            var
                                ItemTranslation: Record "Item Translation";
                            begin
                                if AsmLoop.Number = 1 then TempPostedAsmLine.FindSet
                                else
                                    TempPostedAsmLine.Next;
                                //>>PI001
                                if ItemTranslation.Get(TempPostedAsmLine."No.", TempPostedAsmLine."Variant Code", "Sales Invoice Header"."Language Code")then TempPostedAsmLine.Description:=ItemTranslation.Description;
                            //<<
                            end;
                            trigger OnPreDataItem()
                            begin
                                Clear(TempPostedAsmLine);
                                if not DisplayAssemblyInformation then CurrReport.Break;
                                CollectAsmInformation;
                                Clear(TempPostedAsmLine);
                                AsmLoop.SetRange(AsmLoop.Number, 1, TempPostedAsmLine.Count);
                            end;
                        }
                        trigger OnAfterGetRecord()
                        begin
                            if("Sales Invoice Line".Type.Asinteger() <> 0) and ("Sales Invoice Line".Quantity = 0)then CurrReport.Skip;
                            PostedShipmentDate:=0D;
                            if "Sales Invoice Line".Quantity <> 0 then PostedShipmentDate:=FindPostedShipmentDate;
                            if("Sales Invoice Line".Type = "Sales Invoice Line".Type::"G/L Account") and (not ShowInternalInfo)then "Sales Invoice Line"."No.":='';
                            VATAmountLine.Init;
                            VATAmountLine."VAT Identifier":="Sales Invoice Line"."VAT Identifier";
                            VATAmountLine."VAT Calculation Type":="Sales Invoice Line"."VAT Calculation Type";
                            VATAmountLine."Tax Group Code":="Sales Invoice Line"."Tax Group Code";
                            VATAmountLine."VAT %":="Sales Invoice Line"."VAT %";
                            VATAmountLine."VAT Base":="Sales Invoice Line".Amount;
                            VATAmountLine."Amount Including VAT":="Sales Invoice Line"."Amount Including VAT";
                            VATAmountLine."Line Amount":="Sales Invoice Line"."Line Amount";
                            if "Sales Invoice Line"."Allow Invoice Disc." then VATAmountLine."Inv. Disc. Base Amount":="Sales Invoice Line"."Line Amount";
                            VATAmountLine."Invoice Discount Amount":="Sales Invoice Line"."Inv. Discount Amount";
                            VATAmountLine."VAT Clause Code":="Sales Invoice Line"."VAT Clause Code";
                            VATAmountLine.InsertLine;
                            TotalSubTotal+="Sales Invoice Line"."Line Amount";
                            TotalInvDiscAmount-="Sales Invoice Line"."Inv. Discount Amount";
                            TotalAmount+="Sales Invoice Line".Amount;
                            TotalAmountVAT+="Sales Invoice Line"."Amount Including VAT" - "Sales Invoice Line".Amount;
                            TotalAmountInclVAT+="Sales Invoice Line"."Amount Including VAT";
                            TotalPaymentDiscOnVAT+=-("Sales Invoice Line"."Line Amount" - "Sales Invoice Line"."Inv. Discount Amount" - "Sales Invoice Line"."Amount Including VAT");
                        end;
                        trigger OnPreDataItem()
                        begin
                            VATAmountLine.DeleteAll;
                            SalesShipmentBuffer.Reset;
                            SalesShipmentBuffer.DeleteAll;
                            FirstValueEntryNo:=0;
                            MoreLines:="Sales Invoice Line".Find('+');
                            while MoreLines and ("Sales Invoice Line".Description = '') and ("Sales Invoice Line"."No." = '') and ("Sales Invoice Line".Quantity = 0) and ("Sales Invoice Line".Amount = 0)do MoreLines:="Sales Invoice Line".Next(-1) <> 0;
                            if not MoreLines then CurrReport.Break;
                            "Sales Invoice Line".SetRange("Sales Invoice Line"."Line No.", 0, "Sales Invoice Line"."Line No.");
                            CurrReport.CreateTotals("Sales Invoice Line"."Line Amount", "Sales Invoice Line".Amount, "Sales Invoice Line"."Amount Including VAT", "Sales Invoice Line"."Inv. Discount Amount");
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
                        AutoFormatExpression = "Sales Invoice Line".GetCurrencyCode;
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineVATAmt; VATAmountLine."VAT Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineLineAmt; VATAmountLine."Line Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscBaseAmt; VATAmountLine."Inv. Disc. Base Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineInvDiscAmt; VATAmountLine."Invoice Discount Amount")
                        {
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATAmtLineVATPer; VATAmountLine."VAT %")
                        {
                        DecimalPlaces = 0: 5;
                        }
                        column(VATAmtLineVATIdentifier; VATAmountLine."VAT Identifier")
                        {
                        }
                        column(VATAmtSpecificationCptn; VATAmtSpecificationCptnLbl)
                        {
                        }
                        column(InvDiscBaseAmtCaption; InvDiscBaseAmtCaptionLbl)
                        {
                        }
                        column(LineAmtCaption; LineAmtCaptionLbl)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(VATCounter.Number);
                        end;
                        trigger OnPreDataItem()
                        begin
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
                        AutoFormatExpression = "Sales Invoice Header"."Currency Code";
                        AutoFormatType = 1;
                        }
                        column(VATClausesCaption; VATClausesCap)
                        {
                        }
                        column(VATClauseVATIdentifierCaption; VATIdentifierCaptionLbl)
                        {
                        }
                        column(VATClauseVATAmtCaption; VATAmtCaptionLbl)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(VATClauseEntryCounter.Number);
                            if not VATClause.Get(VATAmountLine."VAT Clause Code")then CurrReport.Skip;
                            VATClause.TranslateDescription("Sales Invoice Header"."Language Code");
                        end;
                        trigger OnPreDataItem()
                        begin
                            Clear(VATClause);
                            VATClauseEntryCounter.SetRange(VATClauseEntryCounter.Number, 1, VATAmountLine.Count);
                            CurrReport.CreateTotals(VATAmountLine."VAT Amount");
                        end;
                    }
                    dataitem(VatCounterLCY; "Integer")
                    {
                        DataItemTableView = sorting(Number);

                        column(ReportForNavId_9347;9347)
                        {
                        }
                        column(VALSpecLCYHeader; VALSpecLCYHeader)
                        {
                        }
                        column(VALExchRate; VALExchRate)
                        {
                        }
                        column(VALVATBaseLCY; VALVATBaseLCY)
                        {
                        AutoFormatType = 1;
                        }
                        column(VALVATAmountLCY; VALVATAmountLCY)
                        {
                        AutoFormatType = 1;
                        }
                        column(VATPer_VATCounterLCY; VATAmountLine."VAT %")
                        {
                        DecimalPlaces = 0: 5;
                        }
                        column(VATIdentifier_VATCounterLCY; VATAmountLine."VAT Identifier")
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            VATAmountLine.GetLine(VatCounterLCY.Number);
                            VALVATBaseLCY:=VATAmountLine.GetBaseLCY("Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code", "Sales Invoice Header"."Currency Factor");
                            VALVATAmountLCY:=VATAmountLine.GetAmountLCY("Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code", "Sales Invoice Header"."Currency Factor");
                        end;
                        trigger OnPreDataItem()
                        begin
                            if(not GLSetup."Print VAT specification in LCY") or ("Sales Invoice Header"."Currency Code" = '')then CurrReport.Break;
                            VatCounterLCY.SetRange(VatCounterLCY.Number, 1, VATAmountLine.Count);
                            CurrReport.CreateTotals(VALVATBaseLCY, VALVATAmountLCY);
                            if GLSetup."LCY Code" = '' then VALSpecLCYHeader:=Text007 + Text008
                            else
                                VALSpecLCYHeader:=Text007 + Format(GLSetup."LCY Code");
                            CurrExchRate.FindCurrency("Sales Invoice Header"."Posting Date", "Sales Invoice Header"."Currency Code", 1);
                            CalculatedExchRate:=ROUND(1 / "Sales Invoice Header"."Currency Factor" * CurrExchRate."Exchange Rate Amount", 0.000001);
                            VALExchRate:=StrSubstNo(Text009, CalculatedExchRate, CurrExchRate."Exchange Rate Amount");
                        end;
                    }
                    dataitem(Total; "Integer")
                    {
                        DataItemTableView = sorting(Number)where(Number=const(1));

                        column(ReportForNavId_3476;3476)
                        {
                        }
                        column(SelltoCustNo_SalesInvHdr; "Sales Invoice Header"."Sell-to Customer No.")
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
                        column(ShiptoAddrCaption; ShiptoAddrCaptionLbl)
                        {
                        }
                        column(SelltoCustNo_SalesInvHdrCaption; SelltoCustNoCaption)
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
                        CopyText:=Text003;
                        OutputNo+=1;
                    end;
                    CurrReport.PageNo:=1;
                    TotalSubTotal:=0;
                    TotalInvDiscAmount:=0;
                    TotalAmount:=0;
                    TotalAmountVAT:=0;
                    TotalAmountInclVAT:=0;
                    TotalPaymentDiscOnVAT:=0;
                end;
                trigger OnPostDataItem()
                begin
                    if not CurrReport.Preview then SalesInvCountPrinted.Run("Sales Invoice Header");
                end;
                trigger OnPreDataItem()
                begin
                    NoOfLoops:=Abs(NoOfCopies) + Cust."Invoice Copies" + 1;
                    if NoOfLoops <= 0 then NoOfLoops:=1;
                    CopyText:='';
                    CopyLoop.SetRange(CopyLoop.Number, 1, NoOfLoops);
                    OutputNo:=1;
                end;
            }
            trigger OnAfterGetRecord()
            var
                LanguageCU: Codeunit Language;
            begin
                if "Sales Invoice Header"."Language Code" = '' then "Sales Invoice Header"."Language Code":='DAN';
                CurrReport.Language:=LanguageCU.GetLanguageID("Sales Invoice Header"."Language Code");
                if RespCenter.Get("Sales Invoice Header"."Responsibility Center")then begin
                    FormatAddr.RespCenter(CompanyAddr, RespCenter);
                    CompanyInfo."Phone No.":=RespCenter."Phone No.";
                    CompanyInfo."Fax No.":=RespCenter."Fax No.";
                end
                else
                    FormatAddr.Company(CompanyAddr, CompanyInfo);
                DimSetEntry1.SetRange("Dimension Set ID", "Sales Invoice Header"."Dimension Set ID");
                if "Sales Invoice Header"."Currency Code" = '' then begin
                    GLSetup.TestField("LCY Code");
                    TotalText:=StrSubstNo(Text001, GLSetup."LCY Code");
                    TotalInclVATText:=StrSubstNo(Text002, GLSetup."LCY Code");
                    TotalExclVATText:=StrSubstNo(Text006, GLSetup."LCY Code");
                end
                else
                begin
                    TotalText:=StrSubstNo(Text001, "Sales Invoice Header"."Currency Code");
                    TotalInclVATText:=StrSubstNo(Text002, "Sales Invoice Header"."Currency Code");
                    TotalExclVATText:=StrSubstNo(Text006, "Sales Invoice Header"."Currency Code");
                end;
                FormatAddr.SalesInvBillTo(CustAddr, "Sales Invoice Header");
                if not Cust.Get("Sales Invoice Header"."Bill-to Customer No.")then Clear(Cust);
                FormatAddr.SalesInvShipTo(ShipToAddr, CustAddr, "Sales Invoice Header");
                ShowShippingAddr:="Sales Invoice Header"."Sell-to Customer No." <> "Sales Invoice Header"."Bill-to Customer No.";
                for i:=1 to ArrayLen(ShipToAddr)do if ShipToAddr[i] <> CustAddr[i]then ShowShippingAddr:=true;
                if LogInteraction then if not CurrReport.Preview then begin
                        if "Sales Invoice Header"."Bill-to Contact No." <> '' then SegManagement.LogDocument(4, "Sales Invoice Header"."No.", 0, 0, Database::Contact, "Sales Invoice Header"."Bill-to Contact No.", "Sales Invoice Header"."Salesperson Code", "Sales Invoice Header"."Campaign No.", "Sales Invoice Header"."Posting Description", '')
                        else
                            SegManagement.LogDocument(4, "Sales Invoice Header"."No.", 0, 0, Database::Customer, "Sales Invoice Header"."Bill-to Customer No.", "Sales Invoice Header"."Salesperson Code", "Sales Invoice Header"."Campaign No.", "Sales Invoice Header"."Posting Description", '');
                    end;
                //>>PI002
                CompanyInfo."Bank Name":=BankInfoInDocuments.GetBankName("Sales Invoice Header"."Currency Code", "Sales Invoice Header"."Bill-to Country/Region Code");
                CompanyInfo."Bank Branch No.":=BankInfoInDocuments.GetbankBranch("Sales Invoice Header"."Currency Code", "Sales Invoice Header"."Bill-to Country/Region Code");
                CompanyInfo."Bank Account No.":=BankInfoInDocuments.GetBankAccount("Sales Invoice Header"."Currency Code", "Sales Invoice Header"."Bill-to Country/Region Code");
                CompanyInfo.Iban:=BankInfoInDocuments.GetIBAN("Sales Invoice Header"."Currency Code", "Sales Invoice Header"."Bill-to Country/Region Code");
                CompanyInfo."SWIFT Code":=BankInfoInDocuments.GetSwift("Sales Invoice Header"."Currency Code", "Sales Invoice Header"."Bill-to Country/Region Code");
                //<<PI002
                DocumentReference:='';
                if not DstSetup.IsEmpty then begin
                    case DstSetup.FIK of DstSetup.Fik::" ": DocumentReference:='';
                    DstSetup.Fik::NAV: DocumentReference:=DKSFunctions.GetFIK71String("Sales Invoice Header"."No.");
                    DstSetup.Fik::PM: DocumentReference:="GetFIK-PM";
                    end;
                end
                else
                    DocumentReference:="GetFIK-PM";
                //>>PI002
                if BankInfoInDocuments.FindBankAccount("Sales Invoice Header"."Currency Code", "Sales Invoice Header"."Bill-to Country/Region Code")then if not BankInfoInDocuments.PrintFIK("Sales Invoice Header"."Currency Code", "Sales Invoice Header"."Bill-to Country/Region Code")then Clear(DocumentReference);
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
                    field(DisplayAsmInformation; DisplayAssemblyInformation)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show Assembly Components';
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
            InitLogInteraction;
            LogInteractionEnable:=LogInteraction;
        end;
    }
    labels
    {
    PaymentInfoCaption='Payment Information';
    }
    trigger OnInitReport()
    begin
        GLSetup.Get;
        CompanyInfo.Get;
        SalesSetup.Get;
        CompanyInfo.VerifyAndSetPaymentInfo;
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
    Text003: label 'COPY';
    Text004: label 'Invoice %1';
    PageCaptionCap: label 'Page %1 of %2';
    Text006: label 'Total %1 Excl. VAT';
    DstSetup: Record "DST Setup";
    TempBlob: Codeunit "Temp Blob";
    TempBlob1: Codeunit "Temp Blob";
    GLSetup: Record "General Ledger Setup";
    ShipmentMethod: Record "Shipment Method";
    PaymentTerms: Record "Payment Terms";
    SalesPurchPerson: Record "Salesperson/Purchaser";
    CompanyInfo: Record "Company Information";
    CompanyInfo1: Record "Company Information";
    CompanyInfo2: Record "Company Information";
    CompanyInfo3: Record "Company Information";
    SalesSetup: Record "Sales & Receivables Setup";
    Cust: Record Customer;
    VATAmountLine: Record "VAT Amount Line" temporary;
    DimSetEntry1: Record "Dimension Set Entry";
    DimSetEntry2: Record "Dimension Set Entry";
    RespCenter: Record "Responsibility Center";
    CurrExchRate: Record "Currency Exchange Rate";
    TempPostedAsmLine: Record "Posted Assembly Line" temporary;
    VATClause: Record "VAT Clause";
    SalesInvCountPrinted: Codeunit "Sales Inv.-Printed";
    DKSFunctions: Codeunit DKSFunctions;
    FormatAddr: Codeunit "Format Address";
    SegManagement: Codeunit SegManagement;
    SalesShipmentBuffer: Record "Sales Shipment Buffer" temporary;
    PostedShipmentDate: Date;
    CustAddr: array[8]of Text[50];
    ShipToAddr: array[8]of Text[50];
    CompanyAddr: array[8]of Text[50];
    TotalText: Text[50];
    TotalExclVATText: Text[50];
    TotalInclVATText: Text[50];
    MoreLines: Boolean;
    NoOfCopies: Integer;
    NoOfLoops: Integer;
    CopyText: Text[30];
    ShowShippingAddr: Boolean;
    i: Integer;
    NextEntryNo: Integer;
    FirstValueEntryNo: Integer;
    DimText: Text[120];
    OldDimText: Text[75];
    ShowInternalInfo: Boolean;
    Continue: Boolean;
    LogInteraction: Boolean;
    VALVATBaseLCY: Decimal;
    VALVATAmountLCY: Decimal;
    VALSpecLCYHeader: Text[80];
    Text007: label 'VAT Amount Specification in ';
    Text008: label 'Local Currency';
    VALExchRate: Text[50];
    Text009: label 'Exchange rate: %1/%2';
    CalculatedExchRate: Decimal;
    Text010: label 'Sales - Prepayment Invoice %1';
    OutputNo: Integer;
    TotalSubTotal: Decimal;
    TotalAmount: Decimal;
    TotalAmountInclVAT: Decimal;
    TotalAmountVAT: Decimal;
    TotalInvDiscAmount: Decimal;
    TotalPaymentDiscOnVAT: Decimal;
    CustVatNoText: Text[30];
    LogInteractionEnable: Boolean;
    DisplayAssemblyInformation: Boolean;
    CompanyInfoPhoneNoCaptionLbl: label 'Phone No.';
    CompanyInfoVATRegNoCptnLbl: label 'VAT Registration No.';
    CompanyInfoGiroNoCaptionLbl: label 'Giro No.';
    CompanyInfoBankNameCptnLbl: label 'Bank';
    CompanyInfoBankAccNoCptnLbl: label 'Account No.';
    CompanyInfoIBANCptnLbl: label 'IBAN';
    CompanyInfoSWIFTCptnLbl: label 'BIC/SWIFT';
    SalesInvDueDateCaptionLbl: label 'Due Date';
    InvNoCaptionLbl: label 'Invoice No.';
    SalesInvPostingDateCptnLbl: label 'Date';
    HeaderDimCaptionLbl: label 'Header Dimensions';
    UnitPriceCaptionLbl: label 'Unit Price';
    SalesInvLineDiscCaptionLbl: label 'Discount %';
    AmountCaptionLbl: label 'Amount';
    VATClausesCap: label 'VAT Clause';
    PostedShipmentDateCaptionLbl: label 'Posted Shipment Date';
    SubtotalCaptionLbl: label 'Subtotal';
    LineAmtAfterInvDiscCptnLbl: label 'Payment Discount on VAT';
    ShipmentCaptionLbl: label 'Shipment';
    LineDimCaptionLbl: label 'Line Dimensions';
    VATAmtSpecificationCptnLbl: label 'VAT Amount Specification';
    InvDiscBaseAmtCaptionLbl: label 'Invoice Discount Base Amount';
    LineAmtCaptionLbl: label 'Line Amount';
    ShiptoAddrCaptionLbl: label 'Ship-to Address';
    InvDiscountAmtCaptionLbl: label 'Invoice Discount Amount';
    PaymentTermsDescCaptionLbl: label 'Payment Terms';
    ShptMethodDescCaptionLbl: label 'Shipment Method';
    VATPercentageCaptionLbl: label 'VAT %';
    TotalCaptionLbl: label 'Total';
    VATBaseCaptionLbl: label 'VAT Base';
    VATAmtCaptionLbl: label 'VAT Amount';
    VATIdentifierCaptionLbl: label 'VAT Identifier';
    HomePageCaptionLbl: label 'Home Page';
    EMailCaptionLbl: label 'E-Mail';
    DocumentReferenceCaptionbl: label 'If your bank supports FIK (Danish bank standard), then use the following information:', Comment = 'Translate to "Hvis din bank understøtter FIK (fælles indbetalingkort), så benyt denne information:"';
    DocumentReferenceTxt: Text;
    DocumentReference: Text;
    IBANCaption: Text[80];
    FooterText1: Text;
    FooterText2: Text;
    FooterText3: Text;
    ShowVATSpecification: Boolean;
    ShowBankInformation: Boolean;
    PdfName: label 'Invoice %1';
    ShowVATClause: Boolean;
    EdocIniFileName: Text;
    EdocCMDLine: Text;
    BankInfoInDocuments: Record "Bank Information documents";
    SWIFTCaption: Text[80];
    BilltoCustNo_Caption: label 'Bill-to Customer No.';
    Desc_SalesInvLineCaption: label 'Description';
    Qty_Caption: label 'Quantity';
    UOM_Caption: label 'Unit';
    PricesInclVATCaption: label 'Prices Including VAT';
    ItemNoCaption: label 'No.';
    SelltoCustNoCaption: label 'Sell-to Customer No.';
    ExtDocNoCaption: label 'Your Order';
    SelltoContactCaption: label 'Sell-to Contact';
    CaptionLeft: array[10]of Text;
    ValueLeft: array[10]of Text;
    CaptionRight: array[10]of Text;
    ValueRight: array[10]of Text;
    OrderNoCaptionLbl: label 'Order No.';
    CustomerVATRegNoCaption: label 'Customer VAT Registration No.';
    inStream_: InStream;
    inStream1: InStream;
    outStream1: OutStream;
    procedure InitLogInteraction()
    begin
        LogInteraction:=SegManagement.FindInteractionTemplateCode(enum::"Interaction Log Entry Document Type".FromInteger(4)) <> '';
    end;
    procedure FindPostedShipmentDate(): Date var
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentBuffer2: Record "Sales Shipment Buffer" temporary;
    begin
        NextEntryNo:=1;
        if "Sales Invoice Line"."Shipment No." <> '' then if SalesShipmentHeader.Get("Sales Invoice Line"."Shipment No.")then exit(SalesShipmentHeader."Posting Date");
        if "Sales Invoice Header"."Order No." = '' then exit("Sales Invoice Header"."Posting Date");
        case "Sales Invoice Line".Type of "Sales Invoice Line".Type::Item: GenerateBufferFromValueEntry("Sales Invoice Line");
        "Sales Invoice Line".Type::"G/L Account", "Sales Invoice Line".Type::Resource, "Sales Invoice Line".Type::"Charge (Item)", "Sales Invoice Line".Type::"Fixed Asset": GenerateBufferFromShipment("Sales Invoice Line");
        "Sales Invoice Line".Type::" ": exit(0D);
        end;
        SalesShipmentBuffer.Reset;
        SalesShipmentBuffer.SetRange("Document No.", "Sales Invoice Line"."Document No.");
        SalesShipmentBuffer.SetRange("Line No.", "Sales Invoice Line"."Line No.");
        if SalesShipmentBuffer.Find('-')then begin
            SalesShipmentBuffer2:=SalesShipmentBuffer;
            if SalesShipmentBuffer.Next = 0 then begin
                SalesShipmentBuffer.Get(SalesShipmentBuffer2."Document No.", SalesShipmentBuffer2."Line No.", SalesShipmentBuffer2."Entry No.");
                SalesShipmentBuffer.Delete;
                exit(SalesShipmentBuffer2."Posting Date");
            end;
            SalesShipmentBuffer.CalcSums(Quantity);
            if SalesShipmentBuffer.Quantity <> "Sales Invoice Line".Quantity then begin
                SalesShipmentBuffer.DeleteAll;
                exit("Sales Invoice Header"."Posting Date");
            end;
        end
        else
            exit("Sales Invoice Header"."Posting Date");
    end;
    procedure GenerateBufferFromValueEntry(SalesInvoiceLine2: Record "Sales Invoice Line")
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity:=SalesInvoiceLine2."Quantity (Base)";
        ValueEntry.SetCurrentkey("Document No.");
        ValueEntry.SetRange("Document No.", SalesInvoiceLine2."Document No.");
        ValueEntry.SetRange("Posting Date", "Sales Invoice Header"."Posting Date");
        ValueEntry.SetRange("Item Charge No.", '');
        ValueEntry.SetFilter("Entry No.", '%1..', FirstValueEntryNo);
        if ValueEntry.Find('-')then repeat if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.")then begin
                    if SalesInvoiceLine2."Qty. per Unit of Measure" <> 0 then Quantity:=ValueEntry."Invoiced Quantity" / SalesInvoiceLine2."Qty. per Unit of Measure"
                    else
                        Quantity:=ValueEntry."Invoiced Quantity";
                    AddBufferEntry(SalesInvoiceLine2, -Quantity, ItemLedgerEntry."Posting Date");
                    TotalQuantity:=TotalQuantity + ValueEntry."Invoiced Quantity";
                end;
                FirstValueEntryNo:=ValueEntry."Entry No." + 1;
            until(ValueEntry.Next = 0) or (TotalQuantity = 0);
    end;
    procedure GenerateBufferFromShipment(SalesInvoiceLine: Record "Sales Invoice Line")
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        SalesInvoiceLine2: Record "Sales Invoice Line";
        SalesShipmentHeader: Record "Sales Shipment Header";
        SalesShipmentLine: Record "Sales Shipment Line";
        TotalQuantity: Decimal;
        Quantity: Decimal;
    begin
        TotalQuantity:=0;
        SalesInvoiceHeader.SetCurrentkey("Order No.");
        SalesInvoiceHeader.SetFilter("No.", '..%1', "Sales Invoice Header"."No.");
        SalesInvoiceHeader.SetRange("Order No.", "Sales Invoice Header"."Order No.");
        if SalesInvoiceHeader.Find('-')then repeat SalesInvoiceLine2.SetRange("Document No.", SalesInvoiceHeader."No.");
                SalesInvoiceLine2.SetRange("Line No.", SalesInvoiceLine."Line No.");
                SalesInvoiceLine2.SetRange(Type, SalesInvoiceLine.Type);
                SalesInvoiceLine2.SetRange("No.", SalesInvoiceLine."No.");
                SalesInvoiceLine2.SetRange("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
                if SalesInvoiceLine2.Find('-')then repeat TotalQuantity:=TotalQuantity + SalesInvoiceLine2.Quantity;
                    until SalesInvoiceLine2.Next = 0;
            until SalesInvoiceHeader.Next = 0;
        SalesShipmentLine.SetCurrentkey("Order No.", "Order Line No.");
        SalesShipmentLine.SetRange("Order No.", "Sales Invoice Header"."Order No.");
        SalesShipmentLine.SetRange("Order Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SetRange("Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentLine.SetRange(Type, SalesInvoiceLine.Type);
        SalesShipmentLine.SetRange("No.", SalesInvoiceLine."No.");
        SalesShipmentLine.SetRange("Unit of Measure Code", SalesInvoiceLine."Unit of Measure Code");
        SalesShipmentLine.SetFilter(Quantity, '<>%1', 0);
        if SalesShipmentLine.Find('-')then repeat if "Sales Invoice Header"."Get Shipment Used" then CorrectShipment(SalesShipmentLine);
                if Abs(SalesShipmentLine.Quantity) <= Abs(TotalQuantity - SalesInvoiceLine.Quantity)then TotalQuantity:=TotalQuantity - SalesShipmentLine.Quantity
                else
                begin
                    if Abs(SalesShipmentLine.Quantity) > Abs(TotalQuantity)then SalesShipmentLine.Quantity:=TotalQuantity;
                    Quantity:=SalesShipmentLine.Quantity - (TotalQuantity - SalesInvoiceLine.Quantity);
                    TotalQuantity:=TotalQuantity - SalesShipmentLine.Quantity;
                    SalesInvoiceLine.Quantity:=SalesInvoiceLine.Quantity - Quantity;
                    if SalesShipmentHeader.Get(SalesShipmentLine."Document No.")then AddBufferEntry(SalesInvoiceLine, Quantity, SalesShipmentHeader."Posting Date");
                end;
            until(SalesShipmentLine.Next = 0) or (TotalQuantity = 0);
    end;
    procedure CorrectShipment(var SalesShipmentLine: Record "Sales Shipment Line")
    var
        SalesInvoiceLine: Record "Sales Invoice Line";
    begin
        SalesInvoiceLine.SetCurrentkey("Shipment No.", "Shipment Line No.");
        SalesInvoiceLine.SetRange("Shipment No.", SalesShipmentLine."Document No.");
        SalesInvoiceLine.SetRange("Shipment Line No.", SalesShipmentLine."Line No.");
        if SalesInvoiceLine.Find('-')then repeat SalesShipmentLine.Quantity:=SalesShipmentLine.Quantity - SalesInvoiceLine.Quantity;
            until SalesInvoiceLine.Next = 0;
    end;
    procedure AddBufferEntry(SalesInvoiceLine: Record "Sales Invoice Line"; QtyOnShipment: Decimal; PostingDate: Date)
    begin
        SalesShipmentBuffer.SetRange("Document No.", SalesInvoiceLine."Document No.");
        SalesShipmentBuffer.SetRange("Line No.", SalesInvoiceLine."Line No.");
        SalesShipmentBuffer.SetRange("Posting Date", PostingDate);
        if SalesShipmentBuffer.Find('-')then begin
            SalesShipmentBuffer.Quantity:=SalesShipmentBuffer.Quantity + QtyOnShipment;
            SalesShipmentBuffer.Modify;
            exit;
        end;
        begin
            SalesShipmentBuffer."Document No.":=SalesInvoiceLine."Document No.";
            SalesShipmentBuffer."Line No.":=SalesInvoiceLine."Line No.";
            SalesShipmentBuffer."Entry No.":=NextEntryNo;
            SalesShipmentBuffer.Type:=SalesInvoiceLine.Type;
            SalesShipmentBuffer."No.":=SalesInvoiceLine."No.";
            SalesShipmentBuffer.Quantity:=QtyOnShipment;
            SalesShipmentBuffer."Posting Date":=PostingDate;
            SalesShipmentBuffer.Insert;
            NextEntryNo:=NextEntryNo + 1 end;
    end;
    local procedure DocumentCaption(): Text[250]begin
        if "Sales Invoice Header"."Prepayment Invoice" then exit(Text010);
        exit(Text004);
    end;
    procedure InitializeRequest(NewNoOfCopies: Integer; NewShowInternalInfo: Boolean; NewLogInteraction: Boolean; DisplayAsmInfo: Boolean)
    begin
        NoOfCopies:=NewNoOfCopies;
        ShowInternalInfo:=NewShowInternalInfo;
        LogInteraction:=NewLogInteraction;
        DisplayAssemblyInformation:=DisplayAsmInfo;
    end;
    procedure CollectAsmInformation()
    var
        ValueEntry: Record "Value Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        PostedAsmHeader: Record "Posted Assembly Header";
        PostedAsmLine: Record "Posted Assembly Line";
        SalesShipmentLine: Record "Sales Shipment Line";
    begin
        TempPostedAsmLine.DeleteAll;
        if "Sales Invoice Line".Type <> "Sales Invoice Line".Type::Item then exit;
        begin
            ValueEntry.SetCurrentkey(ValueEntry."Document No.");
            ValueEntry.SetRange(ValueEntry."Document No.", "Sales Invoice Line"."Document No.");
            ValueEntry.SetRange(ValueEntry."Document Type", ValueEntry."document type"::"Sales Invoice");
            ValueEntry.SetRange(ValueEntry."Document Line No.", "Sales Invoice Line"."Line No.");
            //>>PI001
            ValueEntry.SetRange(ValueEntry.Adjustment, false);
            //<<
            if not ValueEntry.FindSet then exit;
        end;
        repeat if ItemLedgerEntry.Get(ValueEntry."Item Ledger Entry No.")then if ItemLedgerEntry."Document Type" = ItemLedgerEntry."document type"::"Sales Shipment" then begin
                    SalesShipmentLine.Get(ItemLedgerEntry."Document No.", ItemLedgerEntry."Document Line No.");
                    if SalesShipmentLine.AsmToShipmentExists(PostedAsmHeader)then begin
                        PostedAsmLine.SetRange("Document No.", PostedAsmHeader."No.");
                        if PostedAsmLine.FindSet then repeat TreatAsmLineBuffer(PostedAsmLine);
                            until PostedAsmLine.Next = 0;
                    end;
                end;
        until ValueEntry.Next = 0;
    end;
    procedure TreatAsmLineBuffer(PostedAsmLine: Record "Posted Assembly Line")
    begin
        Clear(TempPostedAsmLine);
        TempPostedAsmLine.SetRange(Type, PostedAsmLine.Type);
        TempPostedAsmLine.SetRange("No.", PostedAsmLine."No.");
        TempPostedAsmLine.SetRange("Variant Code", PostedAsmLine."Variant Code");
        TempPostedAsmLine.SetRange(Description, PostedAsmLine.Description);
        TempPostedAsmLine.SetRange("Unit of Measure Code", PostedAsmLine."Unit of Measure Code");
        if TempPostedAsmLine.FindFirst then begin
            TempPostedAsmLine.Quantity+=PostedAsmLine.Quantity;
            TempPostedAsmLine.Modify;
        end
        else
        begin
            Clear(TempPostedAsmLine);
            TempPostedAsmLine:=PostedAsmLine;
            TempPostedAsmLine.Insert;
        end;
    end;
    procedure GetUOMText(UOMCode: Code[10]): Text[10]var
        UnitOfMeasure: Record "Unit of Measure";
    begin
        if not UnitOfMeasure.Get(UOMCode)then exit(UOMCode);
        exit(UnitOfMeasure.Description);
    end;
    procedure BlanksForIndent(): Text[10]begin
        exit(PadStr('', 2, ' '));
    end;
    procedure "GetFIK-PM"(): Text var
        CompanyInformation: Record "Company Information";
        LicensePermission: Record "License Permission";
        PaymentID: Code[16];
        PmtIDLength: Integer;
        RecRef: RecordRef;
        CPMPayment365Setup: Record "CPM Payment 365 Setup";
        PaymentMethod_loc: Record "Payment Method";
        CompanyInformation_loc: Record "Company Information";
    begin
        // The name 'Object' does not exist in the current context.
        CompanyInformation_loc.get();
        if CompanyInformation_loc."Giro No." <> '' then begin
            PmtIDLength:=15; // Allways FIK 71.
            if PmtIDLength > 0 then begin
                PaymentID:=PadStr('', PmtIDLength - 2 - StrLen("Sales Invoice Header"."No."), '0') + "Sales Invoice Header"."No." + '0';
                PaymentID:=PaymentID + Modulus10(PaymentID);
            end
            else
                PaymentID:=PadStr('', PmtIDLength, '0');
            exit('+' + Format(71) + '<' + PaymentID + ' +' + CompanyInformation_loc."Giro No.");
        end
        else
            exit('');
    end;
    procedure Modulus10(TestNumber: Code[16]): Code[16]var
        Counter: Integer;
        Accumulator: Integer;
        WeightNo: Integer;
        SumStr: Text[30];
    begin
        WeightNo:=2;
        SumStr:='';
        for Counter:=StrLen(TestNumber)downto 1 do begin
            Evaluate(Accumulator, CopyStr(TestNumber, Counter, 1));
            Accumulator:=Accumulator * WeightNo;
            SumStr:=SumStr + Format(Accumulator);
            if WeightNo = 1 then WeightNo:=2
            else
                WeightNo:=1;
        end;
        Accumulator:=0;
        for Counter:=1 to StrLen(SumStr)do begin
            Evaluate(WeightNo, CopyStr(SumStr, Counter, 1));
            Accumulator:=Accumulator + WeightNo;
        end;
        Accumulator:=10 - (Accumulator MOD 10);
        if Accumulator = 10 then exit('0')
        else
            exit(Format(Accumulator));
    end;
    procedure InitEDOC()
    var
        TxtLine: Text;
        Text50000: label 'Invoice_%1';
        InStr: InStream;
    begin
    //EDOC
    // EdocIniFileName := 'C:\Program Files\Microsoft Dynamics NAV\71\Service\EDOCINI.TXT'; 
    // if not UploadIntoStream(EdocIniFileName, InStr) then
    //     exit;
    // EdocCMDLine += '%%DestFile:' + StrSubstNo(PdfName, "Sales Invoice Header"."No.") + '%%';
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
    //             EdocCMDLine += '%%EmailSubject:' + StrSubstNo(PdfName, "Sales Invoice Header"."No.") + '%%';
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
        if "Sales Invoice Header"."Bill-to Customer No." <> '' then begin
            CaptionLeft[1]:=BilltoCustNo_Caption;
            ValueLeft[1]:="Sales Invoice Header"."Bill-to Customer No.";
        end;
        if "Sales Invoice Header"."VAT Registration No." <> '' then begin
            CaptionLeft[2]:=CustomerVATRegNoCaption;
            ValueLeft[2]:="Sales Invoice Header"."VAT Registration No.";
        end;
        if "Sales Invoice Header"."No." <> '' then begin
            CaptionLeft[3]:=InvNoCaptionLbl;
            ValueLeft[3]:="Sales Invoice Header"."No.";
        end;
        if "Sales Invoice Header"."Order No." <> '' then begin
            CaptionLeft[4]:=OrderNoCaptionLbl;
            ValueLeft[4]:="Sales Invoice Header"."Order No.";
        end;
        if "Sales Invoice Header"."Posting Date" <> 0D then begin
            CaptionLeft[5]:=SalesInvPostingDateCptnLbl;
            ValueLeft[5]:=Format("Sales Invoice Header"."Posting Date", 0, 7);
        end;
        if "Sales Invoice Header"."Due Date" <> 0D then begin
            CaptionLeft[6]:=SalesInvDueDateCaptionLbl;
            ValueLeft[6]:=Format("Sales Invoice Header"."Due Date", 0, 7);
        end;
        if "Sales Invoice Header"."Payment Terms Code" <> '' then begin
            if PaymentTerms.Get("Sales Invoice Header"."Payment Terms Code")then begin
                PaymentTerms.TranslateDescription(PaymentTerms, "Sales Invoice Header"."Language Code");
                CaptionLeft[7]:=PaymentTermsDescCaptionLbl;
                ValueLeft[7]:=PaymentTerms.Description;
            end;
        end;
        if "Sales Invoice Header"."Shipment Method Code" <> '' then begin
            if ShipmentMethod.Get("Sales Invoice Header"."Shipment Method Code")then begin
                ShipmentMethod.TranslateDescription(ShipmentMethod, "Sales Invoice Header"."Language Code");
                CaptionLeft[8]:=ShptMethodDescCaptionLbl;
                ValueLeft[8]:=ShipmentMethod.Description;
            end;
        end;
        if "Sales Invoice Header"."External Document No." <> '' then begin
            CaptionLeft[9]:=ExtDocNoCaption;
            ValueLeft[9]:="Sales Invoice Header"."External Document No.";
        end;
        if "Sales Invoice Header"."Sell-to Contact" <> '' then begin
            CaptionLeft[10]:=SelltoContactCaption;
            ValueLeft[10]:="Sales Invoice Header"."Sell-to Contact";
        end;
        if CompanyInfo."Phone No." <> '' then begin
            CaptionRight[1]:=CompanyInfoPhoneNoCaptionLbl;
            ValueRight[1]:=CompanyInfo."Phone No.";
        end;
        if CompanyInfo."Home Page" <> '' then begin
            CaptionRight[2]:=HomePageCaptionLbl;
            ValueRight[2]:=CompanyInfo."Home Page";
        end;
        if CompanyInfo."E-Mail" <> '' then begin
            CaptionRight[3]:=EMailCaptionLbl;
            ValueRight[3]:=CompanyInfo."E-Mail";
        end;
        if CompanyInfo."VAT Registration No." <> '' then begin
            CaptionRight[4]:=CompanyInfoVATRegNoCptnLbl;
            ValueRight[4]:=CompanyInfo."VAT Registration No.";
        end;
        if "Sales Invoice Header"."Salesperson Code" <> '' then begin
            if SalesPurchPerson.Get("Sales Invoice Header"."Salesperson Code")then begin
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
                CaptionRight[8]:=CompanyInfoSWIFTCptnLbl;
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
