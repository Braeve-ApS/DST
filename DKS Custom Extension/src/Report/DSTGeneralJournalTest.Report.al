Report 50010 "DST_General Journal - Test"
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/DST_General Journal - Test.rdlc';
    Caption = 'General Journal - Test';

    dataset
    {
        dataitem("Gen. Journal Batch"; "Gen. Journal Batch")
        {
            DataItemTableView = sorting("Journal Template Name", Name);

            column(ReportForNavId_3502;3502)
            {
            }
            column(JnlTmplName_GenJnlBatch; "Gen. Journal Batch"."Journal Template Name")
            {
            }
            column(Name_GenJnlBatch; "Gen. Journal Batch".Name)
            {
            }
            column(CompanyName; COMPANYNAME)
            {
            }
            column(GeneralJnlTestCaption; GeneralJnlTestCap)
            {
            }
            dataitem("Integer"; "Integer")
            {
                DataItemTableView = sorting(Number)where(Number=const(1));
                PrintOnlyIfDetail = true;

                column(ReportForNavId_5444;5444)
                {
                }
                column(JnlTemplateName_GenJnlBatch; "Gen. Journal Batch"."Journal Template Name")
                {
                }
                column(JnlName_GenJnlBatch; "Gen. Journal Batch".Name)
                {
                }
                column(GenJnlLineFilter; GenJnlLineFilter)
                {
                }
                column(GenJnlLineFilterTableCaption; "Gen. Journal Line".TableCaption + ': ' + GenJnlLineFilter)
                {
                }
                column(Number_Integer; Integer.Number)
                {
                }
                column(PageNoCaption; PageNoCap)
                {
                }
                column(JnlTmplNameCaption_GenJnlBatch; "Gen. Journal Batch".FieldCaption("Journal Template Name"))
                {
                }
                column(JournalBatchCaption; JnlBatchNameCap)
                {
                }
                column(PostingDateCaption; PostingDateCap)
                {
                }
                column(DocumentTypeCaption; DocumentTypeCap)
                {
                }
                column(DocNoCaption_GenJnlLine; "Gen. Journal Line".FieldCaption("Document No."))
                {
                }
                column(AccountTypeCaption; AccountTypeCap)
                {
                }
                column(AccNoCaption_GenJnlLine; "Gen. Journal Line".FieldCaption("Account No."))
                {
                }
                column(AccNameCaption; AccNameCap)
                {
                }
                column(DescCaption_GenJnlLine; "Gen. Journal Line".FieldCaption(Description))
                {
                }
                column(PostingTypeCaption; GenPostingTypeCap)
                {
                }
                column(GenBusPostGroupCaption; GenBusPostingGroupCap)
                {
                }
                column(GenProdPostGroupCaption; GenProdPostingGroupCap)
                {
                }
                column(AmountCaption_GenJnlLine; "Gen. Journal Line".FieldCaption(Amount))
                {
                }
                column(BalAccNoCaption_GenJnlLine; "Gen. Journal Line".FieldCaption("Bal. Account No."))
                {
                }
                column(BalLCYCaption_GenJnlLine; "Gen. Journal Line".FieldCaption("Balance (LCY)"))
                {
                }
                dataitem("Gen. Journal Line"; "Gen. Journal Line")
                {
                    DataItemLink = "Journal Template Name"=field("Journal Template Name"), "Journal Batch Name"=field(Name);
                    DataItemLinkReference = "Gen. Journal Batch";
                    DataItemTableView = sorting("Journal Template Name", "Journal Batch Name", "Line No.");
                    RequestFilterFields = "Posting Date";

                    column(ReportForNavId_7024;7024)
                    {
                    }
                    column(PostingDate_GenJnlLine; Format("Gen. Journal Line"."Posting Date"))
                    {
                    }
                    column(DocType_GenJnlLine; "Gen. Journal Line"."Document Type")
                    {
                    }
                    column(DocNo_GenJnlLine; "Gen. Journal Line"."Document No.")
                    {
                    }
                    column(AccountType_GenJnlLine; "Gen. Journal Line"."Account Type")
                    {
                    }
                    column(AccountNo_GenJnlLine; "Gen. Journal Line"."Account No.")
                    {
                    }
                    column(AccName; AccName)
                    {
                    }
                    column(Description_GenJnlLine; "Gen. Journal Line".Description)
                    {
                    }
                    column(GenPostType_GenJnlLine; "Gen. Journal Line"."Gen. Posting Type")
                    {
                    }
                    column(GenBusPosGroup_GenJnlLine; "Gen. Journal Line"."Gen. Bus. Posting Group")
                    {
                    }
                    column(GenProdPostGroup_GenJnlLine; "Gen. Journal Line"."Gen. Prod. Posting Group")
                    {
                    }
                    column(Amount_GenJnlLine; "Gen. Journal Line".Amount)
                    {
                    }
                    column(CurrencyCode_GenJnlLine; "Gen. Journal Line"."Currency Code")
                    {
                    }
                    column(BalAccNo_GenJnlLine; "Gen. Journal Line"."Bal. Account No.")
                    {
                    }
                    column(BalanceLCY_GenJnlLine; "Gen. Journal Line"."Balance (LCY)")
                    {
                    }
                    column(AmountLCY; AmountLCY)
                    {
                    }
                    column(BalanceLCY; BalanceLCY)
                    {
                    }
                    column(AmountLCY_GenJnlLine; "Gen. Journal Line"."Amount (LCY)")
                    {
                    }
                    column(JnlTmplName_GenJnlLine; "Gen. Journal Line"."Journal Template Name")
                    {
                    }
                    column(JnlBatchName_GenJnlLine; "Gen. Journal Line"."Journal Batch Name")
                    {
                    }
                    column(LineNo_GenJnlLine; "Gen. Journal Line"."Line No.")
                    {
                    }
                    column(TotalLCYCaption; AmountLCYCap)
                    {
                    }
                    dataitem(DimensionLoop; "Integer")
                    {
                        DataItemTableView = sorting(Number)where(Number=filter(1..));

                        column(ReportForNavId_9775;9775)
                        {
                        }
                        column(DimText; DimText)
                        {
                        }
                        column(Number_DimensionLoop; DimensionLoop.Number)
                        {
                        }
                        column(DimensionsCaption; DimensionsCap)
                        {
                        }
                        trigger OnAfterGetRecord()
                        begin
                            if DimensionLoop.Number = 1 then begin
                                if not DimSetEntry.FindSet then CurrReport.Break;
                            end
                            else if not Continue then CurrReport.Break;
                            DimText:=GetDimensionText(DimSetEntry);
                        end;
                        trigger OnPreDataItem()
                        begin
                            if not ShowDim then CurrReport.Break;
                            DimSetEntry.Reset;
                            DimSetEntry.SetRange("Dimension Set ID", "Gen. Journal Line"."Dimension Set ID")end;
                    }
                    dataitem("Gen. Jnl. Allocation"; "Gen. Jnl. Allocation")
                    {
                        DataItemLink = "Journal Template Name"=field("Journal Template Name"), "Journal Batch Name"=field("Journal Batch Name"), "Journal Line No."=field("Line No.");
                        DataItemTableView = sorting("Journal Template Name", "Journal Batch Name", "Journal Line No.", "Line No.");

                        column(ReportForNavId_100;100)
                        {
                        }
                        column(AccountNo_GenJnlAllocation; "Gen. Jnl. Allocation"."Account No.")
                        {
                        }
                        column(AccountName_GenJnlAllocation; "Gen. Jnl. Allocation"."Account Name")
                        {
                        }
                        column(AllocationQuantity_GenJnlAllocation; "Gen. Jnl. Allocation"."Allocation Quantity")
                        {
                        }
                        column(AllocationPct_GenJnlAllocation; "Gen. Jnl. Allocation"."Allocation %")
                        {
                        }
                        column(Amount_GenJnlAllocation; "Gen. Jnl. Allocation".Amount)
                        {
                        }
                        column(JournalLineNo_GenJnlAllocation; "Gen. Jnl. Allocation"."Journal Line No.")
                        {
                        }
                        column(LineNo_GenJnlAllocation; "Gen. Jnl. Allocation"."Line No.")
                        {
                        }
                        column(JournalBatchName_GenJnlAllocation; "Gen. Jnl. Allocation"."Journal Batch Name")
                        {
                        }
                        column(AccountNoCaption_GenJnlAllocation; "Gen. Jnl. Allocation".FieldCaption("Gen. Jnl. Allocation"."Account No."))
                        {
                        }
                        column(AccountNameCaption_GenJnlAllocation; "Gen. Jnl. Allocation".FieldCaption("Gen. Jnl. Allocation"."Account Name"))
                        {
                        }
                        column(AllocationQuantityCaption_GenJnlAllocation; "Gen. Jnl. Allocation".FieldCaption("Gen. Jnl. Allocation"."Allocation Quantity"))
                        {
                        }
                        column(AllocationPctCaption_GenJnlAllocation; "Gen. Jnl. Allocation".FieldCaption("Gen. Jnl. Allocation"."Allocation %"))
                        {
                        }
                        column(AmountCaption_GenJnlAllocation; "Gen. Jnl. Allocation".FieldCaption("Gen. Jnl. Allocation".Amount))
                        {
                        }
                        column(Recurring_GenJnlTemplate; GenJnlTemplate.Recurring)
                        {
                        }
                        dataitem(DimensionLoopAllocations; "Integer")
                        {
                            DataItemTableView = sorting(Number)where(Number=filter(1..));

                            column(ReportForNavId_114;114)
                            {
                            }
                            column(AllocationDimText; AllocationDimText)
                            {
                            }
                            column(Number_DimensionLoopAllocations; DimensionLoopAllocations.Number)
                            {
                            }
                            column(DimensionAllocationsCaption; DimensionAllocationsCap)
                            {
                            }
                            trigger OnAfterGetRecord()
                            begin
                                if DimensionLoopAllocations.Number = 1 then begin
                                    if not DimSetEntry.FindFirst then CurrReport.Break;
                                end
                                else if not Continue then CurrReport.Break;
                                AllocationDimText:=GetDimensionText(DimSetEntry);
                            end;
                            trigger OnPreDataItem()
                            begin
                                if not ShowDim then CurrReport.Break;
                                DimSetEntry.Reset;
                                DimSetEntry.SetRange("Dimension Set ID", "Gen. Jnl. Allocation"."Dimension Set ID")end;
                        }
                    }
                    dataitem(ErrorLoop; "Integer")
                    {
                        DataItemTableView = sorting(Number);

                        column(ReportForNavId_1162;1162)
                        {
                        }
                        column(ErrorTextNumber; ErrorText[ErrorLoop.Number])
                        {
                        }
                        column(WarningCaption; WarningCap)
                        {
                        }
                        trigger OnPostDataItem()
                        begin
                            ErrorCounter:=0;
                        end;
                        trigger OnPreDataItem()
                        begin
                            ErrorLoop.SetRange(ErrorLoop.Number, 1, ErrorCounter);
                        end;
                    }
                    dataitem(DKSLoop; "Integer")
                    {
                        DataItemTableView = sorting(Number);

                        column(ReportForNavId_1000000005;1000000005)
                        {
                        }
                        column(DKS_DimensionEnforcement_1; DKS_DimensionEnforcement[1])
                        {
                        }
                        column(DKS_DimensionEnforcement_2; DKS_DimensionEnforcement[2])
                        {
                        }
                        column(DKS_DimensionEnforcement_3; DKS_DimensionEnforcement[3])
                        {
                        }
                        column(DKS_DimensionEnforcement_4; DKS_DimensionEnforcement[4])
                        {
                        }
                        column(DKS_DimensionEnforcement_5; DKS_DimensionEnforcement[5])
                        {
                        }
                        trigger OnPostDataItem()
                        begin
                        //ErrorCounter := 0;
                        end;
                        trigger OnPreDataItem()
                        begin
                            DKSLoop.SetRange(DKSLoop.Number, 1, 1);
                        end;
                    }
                    trigger OnAfterGetRecord()
                    var
                        PaymentTerms: Record "Payment Terms";
                        DimMgt: Codeunit DimensionManagement;
                        TableID: array[10]of Integer;
                        No: array[10]of Code[20];
                    begin
                        //->DST
                        Clear(DKS_DimensionEnforcement);
                        Clear(i);
                        DimensionSetEntry.SetRange(DimensionSetEntry."Dimension Set ID", "Gen. Journal Line"."Dimension Set ID");
                        if DimensionSetEntry.FindSet then repeat if DimensionEnforcement.Get(DimensionSetEntry."Dimension Code", DimensionSetEntry."Dimension Value Code")then begin
                                    if DimensionEnforcement."Forces Dimension" <> '' then begin
                                        DimensionSetEntry2.CopyFilters(DimensionSetEntry);
                                        DimensionSetEntry2.SetRange(DimensionSetEntry2."Dimension Code", DimensionEnforcement."Forces Dimension");
                                        DimensionSetEntry2.SetFilter(DimensionSetEntry2."Dimension Value Code", '<>%1', '');
                                        if not DimensionSetEntry2.FindFirst then begin
                                            i+=1;
                                            DKS_DimensionEnforcement[i]:=StrSubstNo('Linjen har %1 %2, og SKAL derfor også have en %3!', DimensionSetEntry."Dimension Code", DimensionSetEntry."Dimension Value Code", DimensionEnforcement."Forces Dimension");
                                        end;
                                    end;
                                end;
                            until(DimensionSetEntry.Next = 0) or (i = 5);
                        //<-DST
                        if "Gen. Journal Line"."Currency Code" = '' then "Gen. Journal Line"."Amount (LCY)":="Gen. Journal Line".Amount;
                        "Gen. Journal Line".UpdateLineBalance;
                        AccName:='';
                        BalAccName:='';
                        if not "Gen. Journal Line".EmptyLine then begin
                            MakeRecurringTexts("Gen. Journal Line");
                            AmountError:=false;
                            if("Gen. Journal Line"."Account No." = '') and ("Gen. Journal Line"."Bal. Account No." = '')then AddError(StrSubstNo(Text001, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Account No."), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Bal. Account No.")))
                            else if("Gen. Journal Line"."Account Type" <> "Gen. Journal Line"."account type"::"Fixed Asset") and ("Gen. Journal Line"."Bal. Account Type" <> "Gen. Journal Line"."bal. account type"::"Fixed Asset")then TestFixedAssetFields("Gen. Journal Line");
                            CheckICDocument;
                            if "Gen. Journal Line"."Account No." <> '' then case "Gen. Journal Line"."Account Type" of "Gen. Journal Line"."account type"::"G/L Account": begin
                                    if("Gen. Journal Line"."Gen. Bus. Posting Group" <> '') or ("Gen. Journal Line"."Gen. Prod. Posting Group" <> '') or ("Gen. Journal Line"."VAT Bus. Posting Group" <> '') or ("Gen. Journal Line"."VAT Prod. Posting Group" <> '')then begin
                                        if "Gen. Journal Line"."Gen. Posting Type".AsInteger() = 0 then AddError(StrSubstNo(Text002, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Gen. Posting Type")));
                                    end;
                                    if("Gen. Journal Line"."Gen. Posting Type" <> "Gen. Journal Line"."gen. posting type"::" ") and ("Gen. Journal Line"."VAT Posting" = "Gen. Journal Line"."vat posting"::"Automatic VAT Entry")then begin
                                        if "Gen. Journal Line"."VAT Amount" + "Gen. Journal Line"."VAT Base Amount" <> "Gen. Journal Line".Amount then AddError(StrSubstNo(Text003, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."VAT Amount"), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."VAT Base Amount"), "Gen. Journal Line".FieldCaption("Gen. Journal Line".Amount)));
                                        if "Gen. Journal Line"."Currency Code" <> '' then if "Gen. Journal Line"."VAT Amount (LCY)" + "Gen. Journal Line"."VAT Base Amount (LCY)" <> "Gen. Journal Line"."Amount (LCY)" then AddError(StrSubstNo(Text003, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."VAT Amount (LCY)"), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."VAT Base Amount (LCY)"), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Amount (LCY)")));
                                    end;
                                    TestJobFields("Gen. Journal Line");
                                end;
                                "Gen. Journal Line"."account type"::Customer, "Gen. Journal Line"."account type"::Vendor: begin
                                    if "Gen. Journal Line"."Gen. Posting Type".AsInteger() <> 0 then AddError(StrSubstNo(Text004, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Gen. Posting Type"), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Account Type"), "Gen. Journal Line"."Account Type"));
                                    if("Gen. Journal Line"."Gen. Bus. Posting Group" <> '') or ("Gen. Journal Line"."Gen. Prod. Posting Group" <> '') or ("Gen. Journal Line"."VAT Bus. Posting Group" <> '') or ("Gen. Journal Line"."VAT Prod. Posting Group" <> '')then AddError(StrSubstNo(Text005, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Gen. Bus. Posting Group"), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Gen. Prod. Posting Group"), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."VAT Bus. Posting Group"), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."VAT Prod. Posting Group"), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Account Type"), "Gen. Journal Line"."Account Type"));
                                    if "Gen. Journal Line"."Document Type".AsInteger() <> 0 then begin
                                        if "Gen. Journal Line"."Account Type" = "Gen. Journal Line"."account type"::Customer then case "Gen. Journal Line"."Document Type" of "Gen. Journal Line"."document type"::"Credit Memo": WarningIfPositiveAmt("Gen. Journal Line");
                                            "Gen. Journal Line"."document type"::Payment: if("Gen. Journal Line"."Applies-to Doc. Type" = "Gen. Journal Line"."applies-to doc. type"::"Credit Memo") and ("Gen. Journal Line"."Applies-to Doc. No." <> '')then WarningIfNegativeAmt("Gen. Journal Line")
                                                else
                                                    WarningIfPositiveAmt("Gen. Journal Line");
                                            "Gen. Journal Line"."document type"::Refund: WarningIfNegativeAmt("Gen. Journal Line");
                                            else
                                                WarningIfNegativeAmt("Gen. Journal Line");
                                            end
                                        else
                                            case "Gen. Journal Line"."Document Type" of "Gen. Journal Line"."document type"::"Credit Memo": WarningIfNegativeAmt("Gen. Journal Line");
                                            "Gen. Journal Line"."document type"::Payment: if("Gen. Journal Line"."Applies-to Doc. Type" = "Gen. Journal Line"."applies-to doc. type"::"Credit Memo") and ("Gen. Journal Line"."Applies-to Doc. No." <> '')then WarningIfPositiveAmt("Gen. Journal Line")
                                                else
                                                    WarningIfNegativeAmt("Gen. Journal Line");
                                            "Gen. Journal Line"."document type"::Refund: WarningIfPositiveAmt("Gen. Journal Line");
                                            else
                                                WarningIfPositiveAmt("Gen. Journal Line");
                                            end end;
                                    if "Gen. Journal Line".Amount * "Gen. Journal Line"."Sales/Purch. (LCY)" < 0 then AddError(StrSubstNo(Text008, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Sales/Purch. (LCY)"), "Gen. Journal Line".FieldCaption("Gen. Journal Line".Amount)));
                                    if "Gen. Journal Line"."Job No." <> '' then AddError(StrSubstNo(Text009, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Job No.")));
                                end;
                                "Gen. Journal Line"."account type"::"Bank Account": begin
                                    if "Gen. Journal Line"."Gen. Posting Type".AsInteger() <> 0 then AddError(StrSubstNo(Text004, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Gen. Posting Type"), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Account Type"), "Gen. Journal Line"."Account Type"));
                                    if("Gen. Journal Line"."Gen. Bus. Posting Group" <> '') or ("Gen. Journal Line"."Gen. Prod. Posting Group" <> '') or ("Gen. Journal Line"."VAT Bus. Posting Group" <> '') or ("Gen. Journal Line"."VAT Prod. Posting Group" <> '')then AddError(StrSubstNo(Text005, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Gen. Bus. Posting Group"), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Gen. Prod. Posting Group"), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."VAT Bus. Posting Group"), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."VAT Prod. Posting Group"), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Account Type"), "Gen. Journal Line"."Account Type"));
                                    if "Gen. Journal Line"."Job No." <> '' then AddError(StrSubstNo(Text009, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Job No.")));
                                    if("Gen. Journal Line".Amount < 0) and ("Gen. Journal Line"."Bank Payment Type" = "Gen. Journal Line"."bank payment type"::"Computer Check")then if not "Gen. Journal Line"."Check Printed" then AddError(StrSubstNo(Text010, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Check Printed")));
                                end;
                                "Gen. Journal Line"."account type"::"Fixed Asset": TestFixedAsset("Gen. Journal Line");
                                end;
                            if "Gen. Journal Line"."Bal. Account No." <> '' then case "Gen. Journal Line"."Bal. Account Type" of "Gen. Journal Line"."bal. account type"::"G/L Account": begin
                                    if("Gen. Journal Line"."Bal. Gen. Bus. Posting Group" <> '') or ("Gen. Journal Line"."Bal. Gen. Prod. Posting Group" <> '') or ("Gen. Journal Line"."Bal. VAT Bus. Posting Group" <> '') or ("Gen. Journal Line"."Bal. VAT Prod. Posting Group" <> '')then begin
                                        if "Gen. Journal Line"."Bal. Gen. Posting Type".AsInteger() = 0 then AddError(StrSubstNo(Text002, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Bal. Gen. Posting Type")));
                                    end;
                                    if("Gen. Journal Line"."Bal. Gen. Posting Type" <> "Gen. Journal Line"."bal. gen. posting type"::" ") and ("Gen. Journal Line"."VAT Posting" = "Gen. Journal Line"."vat posting"::"Automatic VAT Entry")then begin
                                        if "Gen. Journal Line"."Bal. VAT Amount" + "Gen. Journal Line"."Bal. VAT Base Amount" <> -"Gen. Journal Line".Amount then AddError(StrSubstNo(Text011, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Bal. VAT Amount"), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Bal. VAT Base Amount"), "Gen. Journal Line".FieldCaption("Gen. Journal Line".Amount)));
                                        if "Gen. Journal Line"."Currency Code" <> '' then if "Gen. Journal Line"."Bal. VAT Amount (LCY)" + "Gen. Journal Line"."Bal. VAT Base Amount (LCY)" <> -"Gen. Journal Line"."Amount (LCY)" then AddError(StrSubstNo(Text011, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Bal. VAT Amount (LCY)"), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Bal. VAT Base Amount (LCY)"), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Amount (LCY)")));
                                    end;
                                end;
                                "Gen. Journal Line"."bal. account type"::Customer, "Gen. Journal Line"."bal. account type"::Vendor: begin
                                    if "Gen. Journal Line"."Bal. Gen. Posting Type".AsInteger() <> 0 then AddError(StrSubstNo(Text004, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Bal. Gen. Posting Type"), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Bal. Account Type"), "Gen. Journal Line"."Bal. Account Type"));
                                    if("Gen. Journal Line"."Bal. Gen. Bus. Posting Group" <> '') or ("Gen. Journal Line"."Bal. Gen. Prod. Posting Group" <> '') or ("Gen. Journal Line"."Bal. VAT Bus. Posting Group" <> '') or ("Gen. Journal Line"."Bal. VAT Prod. Posting Group" <> '')then AddError(StrSubstNo(Text005, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Bal. Gen. Bus. Posting Group"), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Bal. Gen. Prod. Posting Group"), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Bal. VAT Bus. Posting Group"), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Bal. VAT Prod. Posting Group"), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Bal. Account Type"), "Gen. Journal Line"."Bal. Account Type"));
                                    if "Gen. Journal Line"."Document Type".AsInteger() <> 0 then begin
                                        if("Gen. Journal Line"."Bal. Account Type" = "Gen. Journal Line"."bal. account type"::Customer) = ("Gen. Journal Line"."Document Type" in["Gen. Journal Line"."document type"::Payment, "Gen. Journal Line"."document type"::"Credit Memo"])then WarningIfNegativeAmt("Gen. Journal Line")
                                        else
                                            WarningIfPositiveAmt("Gen. Journal Line")end;
                                    if "Gen. Journal Line".Amount * "Gen. Journal Line"."Sales/Purch. (LCY)" > 0 then AddError(StrSubstNo(Text012, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Sales/Purch. (LCY)"), "Gen. Journal Line".FieldCaption("Gen. Journal Line".Amount)));
                                    if "Gen. Journal Line"."Job No." <> '' then AddError(StrSubstNo(Text009, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Job No.")));
                                end;
                                "Gen. Journal Line"."bal. account type"::"Bank Account": begin
                                    if "Gen. Journal Line"."Bal. Gen. Posting Type".AsInteger() <> 0 then AddError(StrSubstNo(Text004, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Bal. Gen. Posting Type"), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Bal. Account Type"), "Gen. Journal Line"."Bal. Account Type"));
                                    if("Gen. Journal Line"."Bal. Gen. Bus. Posting Group" <> '') or ("Gen. Journal Line"."Bal. Gen. Prod. Posting Group" <> '') or ("Gen. Journal Line"."Bal. VAT Bus. Posting Group" <> '') or ("Gen. Journal Line"."Bal. VAT Prod. Posting Group" <> '')then AddError(StrSubstNo(Text005, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Bal. Gen. Bus. Posting Group"), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Bal. Gen. Prod. Posting Group"), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Bal. VAT Bus. Posting Group"), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Bal. VAT Prod. Posting Group"), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Bal. Account Type"), "Gen. Journal Line"."Bal. Account Type"));
                                    if "Gen. Journal Line"."Job No." <> '' then AddError(StrSubstNo(Text009, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Job No.")));
                                    if("Gen. Journal Line".Amount > 0) and ("Gen. Journal Line"."Bank Payment Type" = "Gen. Journal Line"."bank payment type"::"Computer Check")then if not "Gen. Journal Line"."Check Printed" then AddError(StrSubstNo(Text010, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Check Printed")));
                                end;
                                "Gen. Journal Line"."bal. account type"::"Fixed Asset": TestFixedAsset("Gen. Journal Line");
                                end;
                            if("Gen. Journal Line"."Account No." <> '') and not "Gen. Journal Line"."System-Created Entry" and ("Gen. Journal Line".Amount = 0) and not GenJnlTemplate.Recurring and not "Gen. Journal Line"."Allow Zero-Amount Posting" and ("Gen. Journal Line"."Account Type" <> "Gen. Journal Line"."account type"::"Fixed Asset")then WarningIfZeroAmt("Gen. Journal Line");
                            CheckRecurringLine("Gen. Journal Line");
                            CheckAllocations("Gen. Journal Line");
                            if "Gen. Journal Line"."Posting Date" = 0D then AddError(StrSubstNo(Text002, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Posting Date")))
                            else
                            begin
                                if "Gen. Journal Line"."Posting Date" <> NormalDate("Gen. Journal Line"."Posting Date")then if("Gen. Journal Line"."Account Type" <> "Gen. Journal Line"."account type"::"G/L Account") or ("Gen. Journal Line"."Bal. Account Type" <> "Gen. Journal Line"."bal. account type"::"G/L Account")then AddError(StrSubstNo(Text013, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Posting Date")));
                                if(AllowPostingFrom = 0D) and (AllowPostingTo = 0D)then begin
                                    if UserId <> '' then if UserSetup.Get(UserId)then begin
                                            AllowPostingFrom:=UserSetup."Allow Posting From";
                                            AllowPostingTo:=UserSetup."Allow Posting To";
                                        end;
                                    if(AllowPostingFrom = 0D) and (AllowPostingTo = 0D)then begin
                                        AllowPostingFrom:=GLSetup."Allow Posting From";
                                        AllowPostingTo:=GLSetup."Allow Posting To";
                                    end;
                                    if AllowPostingTo = 0D then AllowPostingTo:=99991231D;
                                end;
                                if("Gen. Journal Line"."Posting Date" < AllowPostingFrom) or ("Gen. Journal Line"."Posting Date" > AllowPostingTo)then AddError(StrSubstNo(Text014, Format("Gen. Journal Line"."Posting Date")));
                                if "Gen. Journal Batch"."No. Series" <> '' then begin
                                    if NoSeries."Date Order" and ("Gen. Journal Line"."Posting Date" < LastEntrdDate)then AddError(Text015);
                                    LastEntrdDate:="Gen. Journal Line"."Posting Date";
                                end;
                            end;
                            if "Gen. Journal Line"."Document Date" <> 0D then if("Gen. Journal Line"."Document Date" <> NormalDate("Gen. Journal Line"."Document Date")) and (("Gen. Journal Line"."Account Type" <> "Gen. Journal Line"."account type"::"G/L Account") or ("Gen. Journal Line"."Bal. Account Type" <> "Gen. Journal Line"."bal. account type"::"G/L Account"))then AddError(StrSubstNo(Text013, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Document Date")));
                            if "Gen. Journal Line"."Document No." = '' then AddError(StrSubstNo(Text002, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Document No.")))
                            else if "Gen. Journal Batch"."No. Series" <> '' then begin
                                    if(LastEntrdDocNo <> '') and ("Gen. Journal Line"."Document No." <> LastEntrdDocNo) and ("Gen. Journal Line"."Document No." <> IncStr(LastEntrdDocNo))then AddError(Text016);
                                    LastEntrdDocNo:="Gen. Journal Line"."Document No.";
                                end;
                            if("Gen. Journal Line"."Account Type" in["Gen. Journal Line"."account type"::Customer, "Gen. Journal Line"."account type"::Vendor, "Gen. Journal Line"."account type"::"Fixed Asset"]) and ("Gen. Journal Line"."Bal. Account Type" in["Gen. Journal Line"."bal. account type"::Customer, "Gen. Journal Line"."bal. account type"::Vendor, "Gen. Journal Line"."bal. account type"::"Fixed Asset"])then AddError(StrSubstNo(Text017, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Account Type"), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Bal. Account Type")));
                            if "Gen. Journal Line".Amount * "Gen. Journal Line"."Amount (LCY)" < 0 then AddError(StrSubstNo(Text008, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Amount (LCY)"), "Gen. Journal Line".FieldCaption("Gen. Journal Line".Amount)));
                            if("Gen. Journal Line"."Account Type" = "Gen. Journal Line"."account type"::"G/L Account") and ("Gen. Journal Line"."Bal. Account Type" = "Gen. Journal Line"."bal. account type"::"G/L Account")then if "Gen. Journal Line"."Applies-to Doc. No." <> '' then AddError(StrSubstNo(Text009, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Applies-to Doc. No.")));
                            if(("Gen. Journal Line"."Account Type" = "Gen. Journal Line"."account type"::"G/L Account") and ("Gen. Journal Line"."Bal. Account Type" = "Gen. Journal Line"."bal. account type"::"G/L Account")) or ("Gen. Journal Line"."Document Type" <> "Gen. Journal Line"."document type"::Invoice)then if PaymentTerms.Get("Gen. Journal Line"."Payment Terms Code")then begin
                                    if("Gen. Journal Line"."Document Type" = "Gen. Journal Line"."document type"::"Credit Memo") and (not PaymentTerms."Calc. Pmt. Disc. on Cr. Memos")then begin
                                        if "Gen. Journal Line"."Pmt. Discount Date" <> 0D then AddError(StrSubstNo(Text009, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Pmt. Discount Date")));
                                        if "Gen. Journal Line"."Payment Discount %" <> 0 then AddError(StrSubstNo(Text018, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Payment Discount %")));
                                    end;
                                end
                                else
                                begin
                                    if "Gen. Journal Line"."Pmt. Discount Date" <> 0D then AddError(StrSubstNo(Text009, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Pmt. Discount Date")));
                                    if "Gen. Journal Line"."Payment Discount %" <> 0 then AddError(StrSubstNo(Text018, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Payment Discount %")));
                                end;
                            if(("Gen. Journal Line"."Account Type" = "Gen. Journal Line"."account type"::"G/L Account") and ("Gen. Journal Line"."Bal. Account Type" = "Gen. Journal Line"."bal. account type"::"G/L Account")) or ("Gen. Journal Line"."Applies-to Doc. No." <> '')then if "Gen. Journal Line"."Applies-to ID" <> '' then AddError(StrSubstNo(Text009, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Applies-to ID")));
                            if("Gen. Journal Line"."Account Type" <> "Gen. Journal Line"."account type"::"Bank Account") and ("Gen. Journal Line"."Bal. Account Type" <> "Gen. Journal Line"."bal. account type"::"Bank Account")then if GenJnlLine2."Bank Payment Type".AsInteger() > 0 then AddError(StrSubstNo(Text009, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Bank Payment Type")));
                            if("Gen. Journal Line"."Account No." <> '') and ("Gen. Journal Line"."Bal. Account No." <> '')then begin
                                PurchPostingType:=false;
                                SalesPostingType:=false;
                            end;
                            if "Gen. Journal Line"."Account No." <> '' then case "Gen. Journal Line"."Account Type" of "Gen. Journal Line"."account type"::"G/L Account": CheckGLAcc("Gen. Journal Line", AccName);
                                "Gen. Journal Line"."account type"::Customer: CheckCust("Gen. Journal Line", AccName);
                                "Gen. Journal Line"."account type"::Vendor: CheckVend("Gen. Journal Line", AccName);
                                "Gen. Journal Line"."account type"::"Bank Account": CheckBankAcc("Gen. Journal Line", AccName);
                                "Gen. Journal Line"."account type"::"Fixed Asset": CheckFixedAsset("Gen. Journal Line", AccName);
                                "Gen. Journal Line"."account type"::"IC Partner": CheckICPartner("Gen. Journal Line", AccName);
                                end;
                            if "Gen. Journal Line"."Bal. Account No." <> '' then begin
                                ExchAccGLJnlLine.Run("Gen. Journal Line");
                                case "Gen. Journal Line"."Account Type" of "Gen. Journal Line"."account type"::"G/L Account": CheckGLAcc("Gen. Journal Line", BalAccName);
                                "Gen. Journal Line"."account type"::Customer: CheckCust("Gen. Journal Line", BalAccName);
                                "Gen. Journal Line"."account type"::Vendor: CheckVend("Gen. Journal Line", BalAccName);
                                "Gen. Journal Line"."account type"::"Bank Account": CheckBankAcc("Gen. Journal Line", BalAccName);
                                "Gen. Journal Line"."account type"::"Fixed Asset": CheckFixedAsset("Gen. Journal Line", BalAccName);
                                "Gen. Journal Line"."account type"::"IC Partner": CheckICPartner("Gen. Journal Line", AccName);
                                end;
                                ExchAccGLJnlLine.Run("Gen. Journal Line");
                            end;
                            if not DimMgt.CheckDimIDComb("Gen. Journal Line"."Dimension Set ID")then AddError(DimMgt.GetDimCombErr);
                            TableID[1]:=DimMgt.TypeToTableID1("Gen. Journal Line"."Account Type".AsInteger());
                            No[1]:="Gen. Journal Line"."Account No.";
                            TableID[2]:=DimMgt.TypeToTableID1("Gen. Journal Line"."Bal. Account Type".AsInteger());
                            No[2]:="Gen. Journal Line"."Bal. Account No.";
                            TableID[3]:=Database::Job;
                            No[3]:="Gen. Journal Line"."Job No.";
                            TableID[4]:=Database::"Salesperson/Purchaser";
                            No[4]:="Gen. Journal Line"."Salespers./Purch. Code";
                            TableID[5]:=Database::Campaign;
                            No[5]:="Gen. Journal Line"."Campaign No.";
                            if not DimMgt.CheckDimValuePosting(TableID, No, "Gen. Journal Line"."Dimension Set ID")then AddError(DimMgt.GetDimValuePostingErr);
                        end;
                        CheckBalance;
                        AmountLCY+="Gen. Journal Line"."Amount (LCY)";
                        BalanceLCY+="Gen. Journal Line"."Balance (LCY)";
                    end;
                    trigger OnPreDataItem()
                    begin
                        "Gen. Journal Line".Copyfilter("Gen. Journal Line"."Journal Batch Name", "Gen. Journal Batch".Name);
                        GenJnlLineFilter:="Gen. Journal Line".GetFilters;
                        GenJnlTemplate.Get("Gen. Journal Batch"."Journal Template Name");
                        if GenJnlTemplate.Recurring then begin
                            if "Gen. Journal Line".GetFilter("Gen. Journal Line"."Posting Date") <> '' then AddError(StrSubstNo(Text000, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Posting Date")));
                            "Gen. Journal Line".SetRange("Gen. Journal Line"."Posting Date", 0D, WorkDate);
                            if "Gen. Journal Line".GetFilter("Gen. Journal Line"."Expiration Date") <> '' then AddError(StrSubstNo(Text000, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Expiration Date")));
                            "Gen. Journal Line".SetFilter("Gen. Journal Line"."Expiration Date", '%1 | %2..', 0D, WorkDate);
                        end;
                        if "Gen. Journal Batch"."No. Series" <> '' then begin
                            NoSeries.Get("Gen. Journal Batch"."No. Series");
                            LastEntrdDocNo:='';
                            LastEntrdDate:=0D;
                        end;
                        CurrentCustomerVendors:=0;
                        VATEntryCreated:=false;
                        GenJnlLine2.Reset;
                        GenJnlLine2.CopyFilters("Gen. Journal Line");
                        GLAccNetChange.DeleteAll;
                        CurrReport.CreateTotals("Gen. Journal Line"."Amount (LCY)", "Gen. Journal Line"."Balance (LCY)");
                    end;
                }
                dataitem(ReconcileLoop; "Integer")
                {
                    DataItemTableView = sorting(Number);

                    column(ReportForNavId_5127;5127)
                    {
                    }
                    column(GLAccNetChangeNo; GLAccNetChange."No.")
                    {
                    }
                    column(GLAccNetChangeName; GLAccNetChange.Name)
                    {
                    }
                    column(GLAccNetChangeNetChangeJnl; GLAccNetChange."Net Change in Jnl.")
                    {
                    }
                    column(GLAccNetChangeBalafterPost; GLAccNetChange."Balance after Posting")
                    {
                    }
                    column(ReconciliationCaption; ReconciliationCap)
                    {
                    }
                    column(NoCaption; NoCap)
                    {
                    }
                    column(NameCaption; NameCap)
                    {
                    }
                    column(NetChangeinJnlCaption; NetChangeinJnlCap)
                    {
                    }
                    column(BalafterPostingCaption; BalafterPostingCap)
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if ReconcileLoop.Number = 1 then GLAccNetChange.Find('-')
                        else
                            GLAccNetChange.Next;
                    end;
                    trigger OnPostDataItem()
                    begin
                        GLAccNetChange.DeleteAll;
                    end;
                    trigger OnPreDataItem()
                    begin
                        ReconcileLoop.SetRange(ReconcileLoop.Number, 1, GLAccNetChange.Count);
                    end;
                }
            }
            trigger OnPreDataItem()
            begin
                GLSetup.Get;
                SalesSetup.Get;
                PurchSetup.Get;
                AmountLCY:=0;
                BalanceLCY:=0;
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

                    field(ShowDim; ShowDim)
                    {
                        ApplicationArea = Basic;
                        Caption = 'Show Dimensions';
                    }
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
    var Text000: label '%1 cannot be filtered when you post recurring journals.';
    Text001: label '%1 or %2 must be specified.';
    Text002: label '%1 must be specified.';
    Text003: label '%1 + %2 must be %3.';
    Text004: label '%1 must be " " when %2 is %3.';
    Text005: label '%1, %2, %3 or %4 must not be completed when %5 is %6.';
    Text006: label '%1 must be negative.';
    Text007: label '%1 must be positive.';
    Text008: label '%1 must have the same sign as %2.';
    Text009: label '%1 cannot be specified.';
    Text010: label '%1 must be Yes.';
    Text011: label '%1 + %2 must be -%3.';
    Text012: label '%1 must have a different sign than %2.';
    Text013: label '%1 must only be a closing date for G/L entries.';
    Text014: label '%1 is not within your allowed range of posting dates.';
    Text015: label 'The lines are not listed according to Posting Date because they were not entered in that order.';
    Text016: label 'There is a gap in the number series.';
    Text017: label '%1 or %2 must be G/L Account or Bank Account.';
    Text018: label '%1 must be 0.';
    Text019: label '%1 cannot be specified when using recurring journals.';
    Text020: label '%1 must not be %2 when %3 = %4.';
    Text021: label 'Allocations can only be used with recurring journals.';
    Text022: label 'Specify %1 in the %2 allocation lines.';
    Text023: label '<Month Text>';
    Text024: label '%1 %2 posted on %3, must be separated by an empty line.', Comment = '%1 - document type, %2 - document number, %3 - posting date';
    Text025: label '%1 %2 is out of balance by %3.';
    Text026: label 'The reversing entries for %1 %2 are out of balance by %3.';
    Text027: label 'As of %1, the lines are out of balance by %2.';
    Text028: label 'As of %1, the reversing entries are out of balance by %2.';
    Text029: label 'The total of the lines is out of balance by %1.';
    Text030: label 'The total of the reversing entries is out of balance by %1.';
    Text031: label '%1 %2 does not exist.';
    Text032: label '%1 must be %2 for %3 %4.';
    Text036: label '%1 %2 %3 does not exist.';
    Text037: label '%1 must be %2.';
    Text038: label 'The currency %1 cannot be found. Check the currency table.';
    Text039: label 'Sales %1 %2 already exists.';
    Text040: label 'Purchase %1 %2 already exists.';
    Text041: label '%1 must be entered.';
    Text042: label '%1 must not be filled when %2 is different in %3 and %4.';
    Text043: label '%1 %2 must not have %3 = %4.';
    Text044: label '%1 must not be specified in fixed asset journal lines.';
    Text045: label '%1 must be specified in fixed asset journal lines.';
    Text046: label '%1 must be different than %2.';
    Text047: label '%1 and %2 must not both be %3.';
    Text049: label '%1 must not be specified when %2 = %3.';
    Text050: label 'must not be specified together with %1 = %2.';
    Text051: label '%1 must be identical to %2.';
    Text052: label '%1 cannot be a closing date.';
    Text053: label '%1 is not within your range of allowed posting dates.';
    Text054: label 'Insurance integration is not activated for %1 %2.';
    Text055: label 'must not be specified when %1 is specified.';
    Text056: label 'When G/L integration is not activated, %1 must not be posted in the general journal.';
    Text057: label 'When G/L integration is not activated, %1 must not be specified in the general journal.';
    Text058: label '%1 must not be specified.';
    Text059: label 'The combination of Customer and Gen. Posting Type Purchase is not allowed.';
    Text060: label 'The combination of Vendor and Gen. Posting Type Sales is not allowed.';
    Text061: label 'The Balance and Reversing Balance recurring methods can be used only with Allocations.';
    Text062: label '%1 must not be 0.';
    GLSetup: Record "General Ledger Setup";
    SalesSetup: Record "Sales & Receivables Setup";
    PurchSetup: Record "Purchases & Payables Setup";
    UserSetup: Record "User Setup";
    AccountingPeriod: Record "Accounting Period";
    GLAcc: Record "G/L Account";
    Currency: Record Currency;
    Cust: Record Customer;
    Vend: Record Vendor;
    BankAccPostingGr: Record "Bank Account Posting Group";
    BankAcc: Record "Bank Account";
    GenJnlTemplate: Record "Gen. Journal Template";
    GenJnlLine2: Record "Gen. Journal Line";
    TempGenJnlLine: Record "Gen. Journal Line" temporary;
    GenJnlAlloc: Record "Gen. Jnl. Allocation";
    OldCustLedgEntry: Record "Cust. Ledger Entry";
    OldVendLedgEntry: Record "Vendor Ledger Entry";
    VATPostingSetup: Record "VAT Posting Setup";
    NoSeries: Record "No. Series";
    FA: Record "Fixed Asset";
    ICPartner: Record "IC Partner";
    DeprBook: Record "Depreciation Book";
    FADeprBook: Record "FA Depreciation Book";
    FASetup: Record "FA Setup";
    GLAccNetChange: Record "G/L Account Net Change" temporary;
    DimSetEntry: Record "Dimension Set Entry";
    ExchAccGLJnlLine: Codeunit "Exchange Acc. G/L Journal Line";
    GenJnlLineFilter: Text;
    AllowPostingFrom: Date;
    AllowPostingTo: Date;
    AllowFAPostingFrom: Date;
    AllowFAPostingTo: Date;
    LastDate: Date;
    lastdoctype: Enum "Gen. Journal Document Type";
    //LastDocType: Option Document,Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder;
    LastDocNo: Code[20];
    LastEntrdDocNo: Code[20];
    LastEntrdDate: Date;
    BalanceLCY: Decimal;
    AmountLCY: Decimal;
    DocBalance: Decimal;
    DocBalanceReverse: Decimal;
    DateBalance: Decimal;
    DateBalanceReverse: Decimal;
    TotalBalance: Decimal;
    TotalBalanceReverse: Decimal;
    AccName: Text[50];
    LastLineNo: Integer;
    GLDocNo: Code[20];
    Day: Integer;
    Week: Integer;
    Month: Integer;
    MonthText: Text[30];
    AmountError: Boolean;
    ErrorCounter: Integer;
    ErrorText: array[50]of Text[250];
    TempErrorText: Text[250];
    BalAccName: Text[50];
    CurrentCustomerVendors: Integer;
    VATEntryCreated: Boolean;
    CustPosting: Boolean;
    VendPosting: Boolean;
    SalesPostingType: Boolean;
    PurchPostingType: Boolean;
    DimText: Text[75];
    AllocationDimText: Text[75];
    ShowDim: Boolean;
    Continue: Boolean;
    Text063: label 'Document,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund';
    Text064: label '%1 %2 is already used in line %3 (%4 %5).';
    Text065: label '%1 must not be blocked with type %2 when %3 is %4.';
    CurrentICPartner: Code[20];
    Text066: label 'You cannot enter G/L Account or Bank Account in both %1 and %2.';
    Text067: label '%1 %2 is linked to %3 %4.';
    Text069: label '%1 must not be specified when %2 is %3.';
    Text070: label '%1 must not be specified when the document is not an intercompany transaction.';
    Text071: label '%1 %2 does not exist.';
    Text072: label '%1 must not be %2 for %3 %4.';
    Text073: label '%1 %2 already exists.';
    GeneralJnlTestCap: label 'General Journal - Test';
    PageNoCap: label 'Page';
    JnlBatchNameCap: label 'Journal Batch';
    PostingDateCap: label 'Posting Date';
    DocumentTypeCap: label 'Document Type';
    AccountTypeCap: label 'Account Type';
    AccNameCap: label 'Name';
    GenPostingTypeCap: label 'Gen. Posting Type';
    GenBusPostingGroupCap: label 'Gen. Bus. Posting Group';
    GenProdPostingGroupCap: label 'Gen. Prod. Posting Group';
    AmountLCYCap: label 'Total (LCY)';
    DimensionsCap: label 'Dimensions';
    WarningCap: label 'Warning!';
    ReconciliationCap: label 'Reconciliation';
    NoCap: label 'No.';
    NameCap: label 'Name';
    NetChangeinJnlCap: label 'Net Change in Jnl.';
    BalafterPostingCap: label 'Balance after Posting';
    DimensionAllocationsCap: label 'Allocation Dimensions';
    "--DKS--": Integer;
    DKS_DimensionEnforcement: array[5]of Text[100];
    DimensionSetEntry: Record "Dimension Set Entry";
    DimensionSetEntry2: Record "Dimension Set Entry";
    DimensionEnforcement: Record "DKS Dimension enforcement";
    i: Integer;
    local procedure CheckRecurringLine(GenJnlLine2: Record "Gen. Journal Line")
    begin
        if GenJnlTemplate.Recurring then begin
            if GenJnlLine2."Recurring Method".AsInteger() = 0 then AddError(StrSubstNo(Text002, GenJnlLine2.FieldCaption(GenJnlLine2."Recurring Method")));
            if Format(GenJnlLine2."Recurring Frequency") = '' then AddError(StrSubstNo(Text002, GenJnlLine2.FieldCaption(GenJnlLine2."Recurring Frequency")));
            if GenJnlLine2."Bal. Account No." <> '' then AddError(StrSubstNo(Text019, GenJnlLine2.FieldCaption(GenJnlLine2."Bal. Account No.")));
            case GenJnlLine2."Recurring Method" of GenJnlLine2."recurring method"::"V  Variable", GenJnlLine2."recurring method"::"RV Reversing Variable", GenJnlLine2."recurring method"::"F  Fixed", GenJnlLine2."recurring method"::"RF Reversing Fixed": WarningIfZeroAmt("Gen. Journal Line");
            GenJnlLine2."recurring method"::"B  Balance", GenJnlLine2."recurring method"::"RB Reversing Balance": WarningIfNonZeroAmt("Gen. Journal Line");
            end;
            if GenJnlLine2."Recurring Method".AsInteger() > GenJnlLine2."recurring method"::"V  Variable".AsInteger()then begin
                if GenJnlLine2."Account Type" = GenJnlLine2."account type"::"Fixed Asset" then AddError(StrSubstNo(Text020, GenJnlLine2.FieldCaption(GenJnlLine2."Recurring Method"), GenJnlLine2."Recurring Method", GenJnlLine2.FieldCaption(GenJnlLine2."Account Type"), GenJnlLine2."Account Type"));
                if GenJnlLine2."Bal. Account Type" = GenJnlLine2."bal. account type"::"Fixed Asset" then AddError(StrSubstNo(Text020, GenJnlLine2.FieldCaption(GenJnlLine2."Recurring Method"), GenJnlLine2."Recurring Method", GenJnlLine2.FieldCaption(GenJnlLine2."Bal. Account Type"), GenJnlLine2."Bal. Account Type"));
            end;
        end
        else
        begin
            if GenJnlLine2."Recurring Method".AsInteger() <> 0 then AddError(StrSubstNo(Text009, GenJnlLine2.FieldCaption(GenJnlLine2."Recurring Method")));
            if Format(GenJnlLine2."Recurring Frequency") <> '' then AddError(StrSubstNo(Text009, GenJnlLine2.FieldCaption(GenJnlLine2."Recurring Frequency")));
        end;
    end;
    local procedure CheckAllocations(GenJnlLine2: Record "Gen. Journal Line")
    begin
        begin
            if GenJnlLine2."Recurring Method" in[GenJnlLine2."recurring method"::"B  Balance", GenJnlLine2."recurring method"::"RB Reversing Balance"]then begin
                GenJnlAlloc.Reset;
                GenJnlAlloc.SetRange("Journal Template Name", GenJnlLine2."Journal Template Name");
                GenJnlAlloc.SetRange("Journal Batch Name", GenJnlLine2."Journal Batch Name");
                GenJnlAlloc.SetRange("Journal Line No.", GenJnlLine2."Line No.");
                if not GenJnlAlloc.FindFirst then AddError(Text061);
            end;
            GenJnlAlloc.Reset;
            GenJnlAlloc.SetRange("Journal Template Name", GenJnlLine2."Journal Template Name");
            GenJnlAlloc.SetRange("Journal Batch Name", GenJnlLine2."Journal Batch Name");
            GenJnlAlloc.SetRange("Journal Line No.", GenJnlLine2."Line No.");
            GenJnlAlloc.SetFilter(Amount, '<>0');
            if GenJnlAlloc.FindFirst then if not GenJnlTemplate.Recurring then AddError(Text021)
                else
                begin
                    GenJnlAlloc.SetRange("Account No.", '');
                    if GenJnlAlloc.FindFirst then AddError(StrSubstNo(Text022, GenJnlAlloc.FieldCaption("Account No."), GenJnlAlloc.Count));
                end;
        end;
    end;
    local procedure MakeRecurringTexts(var GenJnlLine2: Record "Gen. Journal Line")
    begin
        begin
            GLDocNo:=GenJnlLine2."Document No.";
            if(GenJnlLine2."Posting Date" <> 0D) and (GenJnlLine2."Account No." <> '') and (GenJnlLine2."Recurring Method".AsInteger() <> 0)then begin
                Day:=Date2dmy(GenJnlLine2."Posting Date", 1);
                Week:=Date2dwy(GenJnlLine2."Posting Date", 2);
                Month:=Date2dmy(GenJnlLine2."Posting Date", 2);
                MonthText:=Format(GenJnlLine2."Posting Date", 0, Text023);
                AccountingPeriod.SetRange("Starting Date", 0D, GenJnlLine2."Posting Date");
                if not AccountingPeriod.FindLast then AccountingPeriod.Name:='';
                GenJnlLine2."Document No.":=DelChr(PadStr(StrSubstNo(GenJnlLine2."Document No.", Day, Week, Month, MonthText, AccountingPeriod.Name), MaxStrLen(GenJnlLine2."Document No.")), '>');
                GenJnlLine2.Description:=DelChr(PadStr(StrSubstNo(GenJnlLine2.Description, Day, Week, Month, MonthText, AccountingPeriod.Name), MaxStrLen(GenJnlLine2.Description)), '>');
            end;
        end;
    end;
    local procedure CheckBalance()
    var
        GenJnlLine: Record "Gen. Journal Line";
        NextGenJnlLine: Record "Gen. Journal Line";
    begin
        GenJnlLine:="Gen. Journal Line";
        LastLineNo:="Gen. Journal Line"."Line No.";
        NextGenJnlLine:="Gen. Journal Line";
        if NextGenJnlLine.Next = 0 then;
        MakeRecurringTexts(NextGenJnlLine);
        if not GenJnlLine.EmptyLine then begin
            DocBalance:=DocBalance + GenJnlLine."Balance (LCY)";
            DateBalance:=DateBalance + GenJnlLine."Balance (LCY)";
            TotalBalance:=TotalBalance + GenJnlLine."Balance (LCY)";
            if GenJnlLine."Recurring Method".AsInteger() >= GenJnlLine."recurring method"::"RF Reversing Fixed".AsInteger()then begin
                DocBalanceReverse:=DocBalanceReverse + GenJnlLine."Balance (LCY)";
                DateBalanceReverse:=DateBalanceReverse + GenJnlLine."Balance (LCY)";
                TotalBalanceReverse:=TotalBalanceReverse + GenJnlLine."Balance (LCY)";
            end;
            LastDocType:=GenJnlLine."Document Type";
            LastDocNo:=GenJnlLine."Document No.";
            LastDate:=GenJnlLine."Posting Date";
            if TotalBalance = 0 then begin
                CurrentCustomerVendors:=0;
                VATEntryCreated:=false;
            end;
            if GenJnlTemplate."Force Doc. Balance" then begin
                VATEntryCreated:=VATEntryCreated or ((GenJnlLine."Account Type" = GenJnlLine."account type"::"G/L Account") and (GenJnlLine."Account No." <> '') and (GenJnlLine."Gen. Posting Type" in[GenJnlLine."gen. posting type"::Purchase, GenJnlLine."gen. posting type"::Sale])) or ((GenJnlLine."Bal. Account Type" = GenJnlLine."bal. account type"::"G/L Account") and (GenJnlLine."Bal. Account No." <> '') and (GenJnlLine."Bal. Gen. Posting Type" in[GenJnlLine."bal. gen. posting type"::Purchase, GenJnlLine."bal. gen. posting type"::Sale]));
                if((GenJnlLine."Account Type" in[GenJnlLine."account type"::Customer, GenJnlLine."account type"::Vendor]) and (GenJnlLine."Account No." <> '')) or ((GenJnlLine."Bal. Account Type" in[GenJnlLine."bal. account type"::Customer, GenJnlLine."bal. account type"::Vendor]) and (GenJnlLine."Bal. Account No." <> ''))then CurrentCustomerVendors:=CurrentCustomerVendors + 1;
                if(CurrentCustomerVendors > 1) and VATEntryCreated then AddError(StrSubstNo(Text024, GenJnlLine."Document Type", GenJnlLine."Document No.", GenJnlLine."Posting Date"));
            end;
        end;
        begin
            if(LastDate <> 0D) and (LastDocNo <> '') and ((NextGenJnlLine."Posting Date" <> LastDate) or (NextGenJnlLine."Document Type" <> LastDocType) or (NextGenJnlLine."Document No." <> LastDocNo) or (NextGenJnlLine."Line No." = LastLineNo))then begin
                if GenJnlTemplate."Force Doc. Balance" then begin
                    case true of DocBalance <> 0: AddError(StrSubstNo(Text025, SelectStr(LastDocType.AsInteger() + 1, Text063), LastDocNo, DocBalance));
                    DocBalanceReverse <> 0: AddError(StrSubstNo(Text026, SelectStr(LastDocType.AsInteger() + 1, Text063), LastDocNo, DocBalanceReverse));
                    end;
                    DocBalance:=0;
                    DocBalanceReverse:=0;
                end;
                if(NextGenJnlLine."Posting Date" <> LastDate) or (NextGenJnlLine."Document Type" <> LastDocType) or (NextGenJnlLine."Document No." <> LastDocNo)then begin
                    CurrentCustomerVendors:=0;
                    VATEntryCreated:=false;
                    CustPosting:=false;
                    VendPosting:=false;
                    SalesPostingType:=false;
                    PurchPostingType:=false;
                end;
            end;
            if(LastDate <> 0D) and ((NextGenJnlLine."Posting Date" <> LastDate) or (NextGenJnlLine."Line No." = LastLineNo))then begin
                case true of DateBalance <> 0: AddError(StrSubstNo(Text027, LastDate, DateBalance));
                DateBalanceReverse <> 0: AddError(StrSubstNo(Text028, LastDate, DateBalanceReverse));
                end;
                DocBalance:=0;
                DocBalanceReverse:=0;
                DateBalance:=0;
                DateBalanceReverse:=0;
            end;
            if NextGenJnlLine."Line No." = LastLineNo then begin
                case true of TotalBalance <> 0: AddError(StrSubstNo(Text029, TotalBalance));
                TotalBalanceReverse <> 0: AddError(StrSubstNo(Text030, TotalBalanceReverse));
                end;
                DocBalance:=0;
                DocBalanceReverse:=0;
                DateBalance:=0;
                DateBalanceReverse:=0;
                TotalBalance:=0;
                TotalBalanceReverse:=0;
                LastDate:=0D;
                LastDocType:=lastdoctype::" ";
                LastDocNo:='';
            end;
        end;
    end;
    local procedure AddError(Text: Text[250])
    begin
        ErrorCounter:=ErrorCounter + 1;
        ErrorText[ErrorCounter]:=Text;
    end;
    local procedure ReconcileGLAccNo(GLAccNo: Code[20]; ReconcileAmount: Decimal)
    begin
        if not GLAccNetChange.Get(GLAccNo)then begin
            GLAcc.Get(GLAccNo);
            GLAcc.CalcFields("Balance at Date");
            GLAccNetChange.Init;
            GLAccNetChange."No.":=GLAcc."No.";
            GLAccNetChange.Name:=GLAcc.Name;
            GLAccNetChange."Balance after Posting":=GLAcc."Balance at Date";
            GLAccNetChange.Insert;
        end;
        GLAccNetChange."Net Change in Jnl.":=GLAccNetChange."Net Change in Jnl." + ReconcileAmount;
        GLAccNetChange."Balance after Posting":=GLAccNetChange."Balance after Posting" + ReconcileAmount;
        GLAccNetChange.Modify;
    end;
    local procedure CheckGLAcc(var GenJnlLine: Record "Gen. Journal Line"; var AccName: Text[50])
    begin
        if not GLAcc.Get(GenJnlLine."Account No.")then AddError(StrSubstNo(Text031, GLAcc.TableCaption, GenJnlLine."Account No."))
        else
        begin
            AccName:=GLAcc.Name;
            if GLAcc.Blocked then AddError(StrSubstNo(Text032, GLAcc.FieldCaption(Blocked), false, GLAcc.TableCaption, GenJnlLine."Account No."));
            if GLAcc."Account Type" <> GLAcc."account type"::Posting then begin
                GLAcc."Account Type":=GLAcc."account type"::Posting;
                AddError(StrSubstNo(Text032, GLAcc.FieldCaption("Account Type"), GLAcc."Account Type", GLAcc.TableCaption, GenJnlLine."Account No."));
            end;
            if not GenJnlLine."System-Created Entry" then if GenJnlLine."Posting Date" = NormalDate(GenJnlLine."Posting Date")then if not GLAcc."Direct Posting" then AddError(StrSubstNo(Text032, GLAcc.FieldCaption("Direct Posting"), true, GLAcc.TableCaption, GenJnlLine."Account No."));
            if GenJnlLine."Gen. Posting Type".AsInteger() > 0 then begin
                case GenJnlLine."Gen. Posting Type" of GenJnlLine."gen. posting type"::Sale: SalesPostingType:=true;
                GenJnlLine."gen. posting type"::Purchase: PurchPostingType:=true;
                end;
                TestPostingType;
                if not VATPostingSetup.Get(GenJnlLine."VAT Bus. Posting Group", GenJnlLine."VAT Prod. Posting Group")then AddError(StrSubstNo(Text036, VATPostingSetup.TableCaption, GenJnlLine."VAT Bus. Posting Group", GenJnlLine."VAT Prod. Posting Group"))
                else if GenJnlLine."VAT Calculation Type" <> VATPostingSetup."VAT Calculation Type" then AddError(StrSubstNo(Text037, GenJnlLine.FieldCaption(GenJnlLine."VAT Calculation Type"), VATPostingSetup."VAT Calculation Type"))end;
            if GLAcc."Reconciliation Account" then ReconcileGLAccNo(GenJnlLine."Account No.", ROUND(GenJnlLine."Amount (LCY)" / (1 + GenJnlLine."VAT %" / 100)));
        end;
    end;
    local procedure CheckCust(var GenJnlLine: Record "Gen. Journal Line"; var AccName: Text[50])
    begin
        if not Cust.Get(GenJnlLine."Account No.")then AddError(StrSubstNo(Text031, Cust.TableCaption, GenJnlLine."Account No."))
        else
        begin
            AccName:=Cust.Name;
            if((Cust.Blocked = Cust.Blocked::All) or ((Cust.Blocked = Cust.Blocked::Invoice) and (GenJnlLine."Document Type" in[GenJnlLine."document type"::Invoice, GenJnlLine."document type"::" "])))then AddError(StrSubstNo(Text065, GenJnlLine."Account Type", Cust.Blocked, GenJnlLine.FieldCaption(GenJnlLine."Document Type"), GenJnlLine."Document Type"));
            if GenJnlLine."Currency Code" <> '' then if not Currency.Get(GenJnlLine."Currency Code")then AddError(StrSubstNo(Text038, GenJnlLine."Currency Code"));
            if(Cust."IC Partner Code" <> '') and (GenJnlTemplate.Type = GenJnlTemplate.Type::Intercompany)then if ICPartner.Get(Cust."IC Partner Code")then begin
                    if ICPartner.Blocked then AddError(StrSubstNo('%1 %2', StrSubstNo(Text067, Cust.TableCaption, GenJnlLine."Account No.", ICPartner.TableCaption, GenJnlLine."IC Partner Code"), StrSubstNo(Text032, ICPartner.FieldCaption(Blocked), false, ICPartner.TableCaption, Cust."IC Partner Code")));
                end
                else
                    AddError(StrSubstNo('%1 %2', StrSubstNo(Text067, Cust.TableCaption, GenJnlLine."Account No.", ICPartner.TableCaption, Cust."IC Partner Code"), StrSubstNo(Text031, ICPartner.TableCaption, Cust."IC Partner Code")));
            CustPosting:=true;
            TestPostingType;
            if GenJnlLine."Recurring Method".AsInteger() = 0 then if GenJnlLine."Document Type" in[GenJnlLine."document type"::Invoice, GenJnlLine."document type"::"Credit Memo", GenJnlLine."document type"::"Finance Charge Memo", GenJnlLine."document type"::Reminder]then begin
                    OldCustLedgEntry.Reset;
                    OldCustLedgEntry.SetCurrentkey("Document No.");
                    OldCustLedgEntry.SetRange("Document Type", GenJnlLine."Document Type");
                    OldCustLedgEntry.SetRange("Document No.", GenJnlLine."Document No.");
                    if OldCustLedgEntry.FindFirst then AddError(StrSubstNo(Text039, GenJnlLine."Document Type", GenJnlLine."Document No."));
                    if SalesSetup."Ext. Doc. No. Mandatory" or (GenJnlLine."External Document No." <> '')then begin
                        if GenJnlLine."External Document No." = '' then AddError(StrSubstNo(Text041, GenJnlLine.FieldCaption(GenJnlLine."External Document No.")));
                        OldCustLedgEntry.Reset;
                        OldCustLedgEntry.SetCurrentkey("External Document No.");
                        OldCustLedgEntry.SetRange("Document Type", GenJnlLine."Document Type");
                        OldCustLedgEntry.SetRange("Customer No.", GenJnlLine."Account No.");
                        OldCustLedgEntry.SetRange("External Document No.", GenJnlLine."External Document No.");
                        if OldCustLedgEntry.FindFirst then AddError(StrSubstNo(Text039, GenJnlLine."Document Type", GenJnlLine."External Document No."));
                        CheckAgainstPrevLines("Gen. Journal Line");
                    end;
                end;
        end;
    end;
    local procedure CheckVend(var GenJnlLine: Record "Gen. Journal Line"; var AccName: Text[50])
    begin
        if not Vend.Get(GenJnlLine."Account No.")then AddError(StrSubstNo(Text031, Vend.TableCaption, GenJnlLine."Account No."))
        else
        begin
            AccName:=Vend.Name;
            if((Vend.Blocked = Vend.Blocked::All) or ((Vend.Blocked = Vend.Blocked::Payment) and (GenJnlLine."Document Type" = GenJnlLine."document type"::Payment)))then AddError(StrSubstNo(Text065, GenJnlLine."Account Type", Vend.Blocked, GenJnlLine.FieldCaption(GenJnlLine."Document Type"), GenJnlLine."Document Type"));
            if GenJnlLine."Currency Code" <> '' then if not Currency.Get(GenJnlLine."Currency Code")then AddError(StrSubstNo(Text038, GenJnlLine."Currency Code"));
            if(Vend."IC Partner Code" <> '') and (GenJnlTemplate.Type = GenJnlTemplate.Type::Intercompany)then if ICPartner.Get(Vend."IC Partner Code")then begin
                    if ICPartner.Blocked then AddError(StrSubstNo('%1 %2', StrSubstNo(Text067, Vend.TableCaption, GenJnlLine."Account No.", ICPartner.TableCaption, Vend."IC Partner Code"), StrSubstNo(Text032, ICPartner.FieldCaption(Blocked), false, ICPartner.TableCaption, Vend."IC Partner Code")));
                end
                else
                    AddError(StrSubstNo('%1 %2', StrSubstNo(Text067, Vend.TableCaption, GenJnlLine."Account No.", ICPartner.TableCaption, GenJnlLine."IC Partner Code"), StrSubstNo(Text031, ICPartner.TableCaption, Vend."IC Partner Code")));
            VendPosting:=true;
            TestPostingType;
            if GenJnlLine."Recurring Method".AsInteger() = 0 then if GenJnlLine."Document Type" in[GenJnlLine."document type"::Invoice, GenJnlLine."document type"::"Credit Memo", GenJnlLine."document type"::"Finance Charge Memo", GenJnlLine."document type"::Reminder]then begin
                    OldVendLedgEntry.Reset;
                    OldVendLedgEntry.SetCurrentkey("Document No.");
                    OldVendLedgEntry.SetRange("Document Type", GenJnlLine."Document Type");
                    OldVendLedgEntry.SetRange("Document No.", GenJnlLine."Document No.");
                    if OldVendLedgEntry.FindFirst then AddError(StrSubstNo(Text040, GenJnlLine."Document Type", GenJnlLine."Document No."));
                    if PurchSetup."Ext. Doc. No. Mandatory" or (GenJnlLine."External Document No." <> '')then begin
                        if GenJnlLine."External Document No." = '' then AddError(StrSubstNo(Text041, GenJnlLine.FieldCaption(GenJnlLine."External Document No.")));
                        OldVendLedgEntry.Reset;
                        OldVendLedgEntry.SetCurrentkey("External Document No.");
                        OldVendLedgEntry.SetRange("Document Type", GenJnlLine."Document Type");
                        OldVendLedgEntry.SetRange("Vendor No.", GenJnlLine."Account No.");
                        OldVendLedgEntry.SetRange("External Document No.", GenJnlLine."External Document No.");
                        if OldVendLedgEntry.FindFirst then AddError(StrSubstNo(Text040, GenJnlLine."Document Type", GenJnlLine."External Document No."));
                        CheckAgainstPrevLines("Gen. Journal Line");
                    end;
                end;
        end;
    end;
    local procedure CheckBankAcc(var GenJnlLine: Record "Gen. Journal Line"; var AccName: Text[50])
    begin
        if not BankAcc.Get(GenJnlLine."Account No.")then AddError(StrSubstNo(Text031, BankAcc.TableCaption, GenJnlLine."Account No."))
        else
        begin
            AccName:=BankAcc.Name;
            if BankAcc.Blocked then AddError(StrSubstNo(Text032, BankAcc.FieldCaption(Blocked), false, BankAcc.TableCaption, GenJnlLine."Account No."));
            if(GenJnlLine."Currency Code" <> BankAcc."Currency Code") and (BankAcc."Currency Code" <> '')then AddError(StrSubstNo(Text037, GenJnlLine.FieldCaption(GenJnlLine."Currency Code"), BankAcc."Currency Code"));
            if GenJnlLine."Currency Code" <> '' then if not Currency.Get(GenJnlLine."Currency Code")then AddError(StrSubstNo(Text038, GenJnlLine."Currency Code"));
            if GenJnlLine."Bank Payment Type".AsInteger() <> 0 then if(GenJnlLine."Bank Payment Type" = GenJnlLine."bank payment type"::"Computer Check") and (GenJnlLine.Amount < 0)then if BankAcc."Currency Code" <> GenJnlLine."Currency Code" then AddError(StrSubstNo(Text042, GenJnlLine.FieldCaption(GenJnlLine."Bank Payment Type"), GenJnlLine.FieldCaption(GenJnlLine."Currency Code"), GenJnlLine.TableCaption, BankAcc.TableCaption));
            if BankAccPostingGr.Get(BankAcc."Bank Acc. Posting Group")then if BankAccPostingGr."G/L Account No." <> '' then ReconcileGLAccNo(BankAccPostingGr."G/L Account No.", ROUND(GenJnlLine."Amount (LCY)" / (1 + GenJnlLine."VAT %" / 100)));
        end;
    end;
    local procedure CheckFixedAsset(var GenJnlLine: Record "Gen. Journal Line"; var AccName: Text[50])
    begin
        if not FA.Get(GenJnlLine."Account No.")then AddError(StrSubstNo(Text031, FA.TableCaption, GenJnlLine."Account No."))
        else
        begin
            AccName:=FA.Description;
            if FA.Blocked then AddError(StrSubstNo(Text032, FA.FieldCaption(Blocked), false, FA.TableCaption, GenJnlLine."Account No."));
            if FA.Inactive then AddError(StrSubstNo(Text032, FA.FieldCaption(Inactive), false, FA.TableCaption, GenJnlLine."Account No."));
            if FA."Budgeted Asset" then AddError(StrSubstNo(Text043, FA.TableCaption, GenJnlLine."Account No.", FA.FieldCaption("Budgeted Asset"), true));
            if DeprBook.Get(GenJnlLine."Depreciation Book Code")then CheckFAIntegration(GenJnlLine)
            else
                AddError(StrSubstNo(Text031, DeprBook.TableCaption, GenJnlLine."Depreciation Book Code"));
            if not FADeprBook.Get(FA."No.", GenJnlLine."Depreciation Book Code")then AddError(StrSubstNo(Text036, FADeprBook.TableCaption, FA."No.", GenJnlLine."Depreciation Book Code"));
        end;
    end;
    local procedure CheckICPartner(var GenJnlLine: Record "Gen. Journal Line"; var AccName: Text[50])
    begin
        if not ICPartner.Get(GenJnlLine."Account No.")then AddError(StrSubstNo(Text031, ICPartner.TableCaption, GenJnlLine."Account No."))
        else
        begin
            AccName:=ICPartner.Name;
            if ICPartner.Blocked then AddError(StrSubstNo(Text032, ICPartner.FieldCaption(Blocked), false, ICPartner.TableCaption, GenJnlLine."Account No."));
        end;
    end;
    local procedure TestFixedAsset(var GenJnlLine: Record "Gen. Journal Line")
    begin
        begin
            if GenJnlLine."Job No." <> '' then AddError(StrSubstNo(Text044, GenJnlLine.FieldCaption(GenJnlLine."Job No.")));
            if GenJnlLine."FA Posting Type" = GenJnlLine."fa posting type"::" " then AddError(StrSubstNo(Text045, GenJnlLine.FieldCaption(GenJnlLine."FA Posting Type")));
            if GenJnlLine."Depreciation Book Code" = '' then AddError(StrSubstNo(Text045, GenJnlLine.FieldCaption(GenJnlLine."Depreciation Book Code")));
            if GenJnlLine."Depreciation Book Code" = GenJnlLine."Duplicate in Depreciation Book" then AddError(StrSubstNo(Text046, GenJnlLine.FieldCaption(GenJnlLine."Depreciation Book Code"), GenJnlLine.FieldCaption(GenJnlLine."Duplicate in Depreciation Book")));
            CheckFADocNo(GenJnlLine);
            if GenJnlLine."Account Type" = GenJnlLine."Bal. Account Type" then AddError(StrSubstNo(Text047, GenJnlLine.FieldCaption(GenJnlLine."Account Type"), GenJnlLine.FieldCaption(GenJnlLine."Bal. Account Type"), GenJnlLine."Account Type"));
            if GenJnlLine."Account Type" = GenJnlLine."account type"::"Fixed Asset" then if GenJnlLine."FA Posting Type" in[GenJnlLine."fa posting type"::"Acquisition Cost", GenJnlLine."fa posting type"::Disposal, GenJnlLine."fa posting type"::Maintenance]then begin
                    if(GenJnlLine."Gen. Bus. Posting Group" <> '') or (GenJnlLine."Gen. Prod. Posting Group" <> '')then if GenJnlLine."Gen. Posting Type" = GenJnlLine."gen. posting type"::" " then AddError(StrSubstNo(Text002, GenJnlLine.FieldCaption(GenJnlLine."Gen. Posting Type")));
                end
                else
                begin
                    if GenJnlLine."Gen. Posting Type" <> GenJnlLine."gen. posting type"::" " then AddError(StrSubstNo(Text049, GenJnlLine.FieldCaption(GenJnlLine."Gen. Posting Type"), GenJnlLine.FieldCaption(GenJnlLine."FA Posting Type"), GenJnlLine."FA Posting Type"));
                    if GenJnlLine."Gen. Bus. Posting Group" <> '' then AddError(StrSubstNo(Text049, GenJnlLine.FieldCaption(GenJnlLine."Gen. Bus. Posting Group"), GenJnlLine.FieldCaption(GenJnlLine."FA Posting Type"), GenJnlLine."FA Posting Type"));
                    if GenJnlLine."Gen. Prod. Posting Group" <> '' then AddError(StrSubstNo(Text049, GenJnlLine.FieldCaption(GenJnlLine."Gen. Prod. Posting Group"), GenJnlLine.FieldCaption(GenJnlLine."FA Posting Type"), GenJnlLine."FA Posting Type"));
                end;
            if GenJnlLine."Bal. Account Type" = GenJnlLine."bal. account type"::"Fixed Asset" then if GenJnlLine."FA Posting Type" in[GenJnlLine."fa posting type"::"Acquisition Cost", GenJnlLine."fa posting type"::Disposal, GenJnlLine."fa posting type"::Maintenance]then begin
                    if(GenJnlLine."Bal. Gen. Bus. Posting Group" <> '') or (GenJnlLine."Bal. Gen. Prod. Posting Group" <> '')then if GenJnlLine."Bal. Gen. Posting Type" = GenJnlLine."bal. gen. posting type"::" " then AddError(StrSubstNo(Text002, GenJnlLine.FieldCaption(GenJnlLine."Bal. Gen. Posting Type")));
                end
                else
                begin
                    if GenJnlLine."Bal. Gen. Posting Type" <> GenJnlLine."bal. gen. posting type"::" " then AddError(StrSubstNo(Text049, GenJnlLine.FieldCaption(GenJnlLine."Bal. Gen. Posting Type"), GenJnlLine.FieldCaption(GenJnlLine."FA Posting Type"), GenJnlLine."FA Posting Type"));
                    if GenJnlLine."Bal. Gen. Bus. Posting Group" <> '' then AddError(StrSubstNo(Text049, GenJnlLine.FieldCaption(GenJnlLine."Bal. Gen. Bus. Posting Group"), GenJnlLine.FieldCaption(GenJnlLine."FA Posting Type"), GenJnlLine."FA Posting Type"));
                    if GenJnlLine."Bal. Gen. Prod. Posting Group" <> '' then AddError(StrSubstNo(Text049, GenJnlLine.FieldCaption(GenJnlLine."Bal. Gen. Prod. Posting Group"), GenJnlLine.FieldCaption(GenJnlLine."FA Posting Type"), GenJnlLine."FA Posting Type"));
                end;
            TempErrorText:='%1 ' + StrSubstNo(Text050, GenJnlLine.FieldCaption(GenJnlLine."FA Posting Type"), GenJnlLine."FA Posting Type");
            if GenJnlLine."FA Posting Type" <> GenJnlLine."fa posting type"::"Acquisition Cost" then begin
                if GenJnlLine."Depr. Acquisition Cost" then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption(GenJnlLine."Depr. Acquisition Cost")));
                if GenJnlLine."Salvage Value" <> 0 then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption(GenJnlLine."Salvage Value")));
                if GenJnlLine."FA Posting Type" <> GenJnlLine."fa posting type"::Maintenance then if GenJnlLine.Quantity <> 0 then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption(GenJnlLine.Quantity)));
                if GenJnlLine."Insurance No." <> '' then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption(GenJnlLine."Insurance No.")));
            end;
            if(GenJnlLine."FA Posting Type" = GenJnlLine."fa posting type"::Maintenance) and GenJnlLine."Depr. until FA Posting Date" then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption(GenJnlLine."Depr. until FA Posting Date")));
            if(GenJnlLine."FA Posting Type" <> GenJnlLine."fa posting type"::Maintenance) and (GenJnlLine."Maintenance Code" <> '')then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption(GenJnlLine."Maintenance Code")));
            if(GenJnlLine."FA Posting Type" <> GenJnlLine."fa posting type"::Depreciation) and (GenJnlLine."FA Posting Type" <> GenJnlLine."fa posting type"::"Custom 1") and (GenJnlLine."No. of Depreciation Days" <> 0)then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption(GenJnlLine."No. of Depreciation Days")));
            if(GenJnlLine."FA Posting Type" = GenJnlLine."fa posting type"::Disposal) and GenJnlLine."FA Reclassification Entry" then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption(GenJnlLine."FA Reclassification Entry")));
            if(GenJnlLine."FA Posting Type" = GenJnlLine."fa posting type"::Disposal) and (GenJnlLine."Budgeted FA No." <> '')then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption(GenJnlLine."Budgeted FA No.")));
            if GenJnlLine."FA Posting Date" = 0D then GenJnlLine."FA Posting Date":=GenJnlLine."Posting Date";
            if DeprBook.Get(GenJnlLine."Depreciation Book Code")then if DeprBook."Use Same FA+G/L Posting Dates" and (GenJnlLine."Posting Date" <> GenJnlLine."FA Posting Date")then AddError(StrSubstNo(Text051, GenJnlLine.FieldCaption(GenJnlLine."Posting Date"), GenJnlLine.FieldCaption(GenJnlLine."FA Posting Date")));
            if GenJnlLine."FA Posting Date" <> 0D then begin
                if GenJnlLine."FA Posting Date" <> NormalDate(GenJnlLine."FA Posting Date")then AddError(StrSubstNo(Text052, GenJnlLine.FieldCaption(GenJnlLine."FA Posting Date")));
                if not(GenJnlLine."FA Posting Date" in[00020101D .. 99981231D])then AddError(StrSubstNo(Text053, GenJnlLine.FieldCaption(GenJnlLine."FA Posting Date")));
                if(AllowFAPostingFrom = 0D) and (AllowFAPostingTo = 0D)then begin
                    if UserId <> '' then if UserSetup.Get(UserId)then begin
                            AllowFAPostingFrom:=UserSetup."Allow FA Posting From";
                            AllowFAPostingTo:=UserSetup."Allow FA Posting To";
                        end;
                    if(AllowFAPostingFrom = 0D) and (AllowFAPostingTo = 0D)then begin
                        FASetup.Get;
                        AllowFAPostingFrom:=FASetup."Allow FA Posting From";
                        AllowFAPostingTo:=FASetup."Allow FA Posting To";
                    end;
                    if AllowFAPostingTo = 0D then AllowFAPostingTo:=99981231D;
                end;
                if(GenJnlLine."FA Posting Date" < AllowFAPostingFrom) or (GenJnlLine."FA Posting Date" > AllowFAPostingTo)then AddError(StrSubstNo(Text053, GenJnlLine.FieldCaption(GenJnlLine."FA Posting Date")));
            end;
            FASetup.Get;
            if(GenJnlLine."FA Posting Type" = GenJnlLine."fa posting type"::"Acquisition Cost") and (GenJnlLine."Insurance No." <> '') and (GenJnlLine."Depreciation Book Code" <> FASetup."Insurance Depr. Book")then AddError(StrSubstNo(Text054, GenJnlLine.FieldCaption(GenJnlLine."Depreciation Book Code"), GenJnlLine."Depreciation Book Code"));
            if GenJnlLine."FA Error Entry No." > 0 then begin
                TempErrorText:='%1 ' + StrSubstNo(Text055, GenJnlLine.FieldCaption(GenJnlLine."FA Error Entry No."));
                if GenJnlLine."Depr. until FA Posting Date" then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption(GenJnlLine."Depr. until FA Posting Date")));
                if GenJnlLine."Depr. Acquisition Cost" then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption(GenJnlLine."Depr. Acquisition Cost")));
                if GenJnlLine."Duplicate in Depreciation Book" <> '' then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption(GenJnlLine."Duplicate in Depreciation Book")));
                if GenJnlLine."Use Duplication List" then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption(GenJnlLine."Use Duplication List")));
                if GenJnlLine."Salvage Value" <> 0 then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption(GenJnlLine."Salvage Value")));
                if GenJnlLine."Insurance No." <> '' then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption(GenJnlLine."Insurance No.")));
                if GenJnlLine."Budgeted FA No." <> '' then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption(GenJnlLine."Budgeted FA No.")));
                if GenJnlLine."Recurring Method".AsInteger() > 0 then AddError(StrSubstNo(TempErrorText, GenJnlLine.FieldCaption(GenJnlLine."Recurring Method")));
                if GenJnlLine."FA Posting Type" = GenJnlLine."fa posting type"::Maintenance then AddError(StrSubstNo(TempErrorText, GenJnlLine."FA Posting Type"));
            end;
        end;
    end;
    local procedure CheckFAIntegration(var GenJnlLine: Record "Gen. Journal Line")
    var
        GLIntegration: Boolean;
    begin
        begin
            if GenJnlLine."FA Posting Type" = GenJnlLine."fa posting type"::" " then exit;
            case GenJnlLine."FA Posting Type" of GenJnlLine."fa posting type"::"Acquisition Cost": GLIntegration:=DeprBook."G/L Integration - Acq. Cost";
            GenJnlLine."fa posting type"::Depreciation: GLIntegration:=DeprBook."G/L Integration - Depreciation";
            GenJnlLine."fa posting type"::"Write-Down": GLIntegration:=DeprBook."G/L Integration - Write-Down";
            GenJnlLine."fa posting type"::Appreciation: GLIntegration:=DeprBook."G/L Integration - Appreciation";
            GenJnlLine."fa posting type"::"Custom 1": GLIntegration:=DeprBook."G/L Integration - Custom 1";
            GenJnlLine."fa posting type"::"Custom 2": GLIntegration:=DeprBook."G/L Integration - Custom 2";
            GenJnlLine."fa posting type"::Disposal: GLIntegration:=DeprBook."G/L Integration - Disposal";
            GenJnlLine."fa posting type"::Maintenance: GLIntegration:=DeprBook."G/L Integration - Maintenance";
            end;
            if not GLIntegration then AddError(StrSubstNo(Text056, GenJnlLine."FA Posting Type"));
            if not DeprBook."G/L Integration - Depreciation" then begin
                if GenJnlLine."Depr. until FA Posting Date" then AddError(StrSubstNo(Text057, GenJnlLine.FieldCaption(GenJnlLine."Depr. until FA Posting Date")));
                if GenJnlLine."Depr. Acquisition Cost" then AddError(StrSubstNo(Text057, GenJnlLine.FieldCaption(GenJnlLine."Depr. Acquisition Cost")));
            end;
        end;
    end;
    local procedure TestFixedAssetFields(var GenJnlLine: Record "Gen. Journal Line")
    begin
        begin
            if GenJnlLine."FA Posting Type" <> GenJnlLine."fa posting type"::" " then AddError(StrSubstNo(Text058, GenJnlLine.FieldCaption(GenJnlLine."FA Posting Type")));
            if GenJnlLine."Depreciation Book Code" <> '' then AddError(StrSubstNo(Text058, GenJnlLine.FieldCaption(GenJnlLine."Depreciation Book Code")));
        end;
    end;
    procedure TestPostingType()
    begin
        case true of CustPosting and PurchPostingType: AddError(Text059);
        VendPosting and SalesPostingType: AddError(Text060);
        end;
    end;
    local procedure WarningIfNegativeAmt(GenJnlLine: Record "Gen. Journal Line")
    begin
        if(GenJnlLine.Amount < 0) and not AmountError then begin
            AmountError:=true;
            AddError(StrSubstNo(Text007, GenJnlLine.FieldCaption(Amount)));
        end;
    end;
    local procedure WarningIfPositiveAmt(GenJnlLine: Record "Gen. Journal Line")
    begin
        if(GenJnlLine.Amount > 0) and not AmountError then begin
            AmountError:=true;
            AddError(StrSubstNo(Text006, GenJnlLine.FieldCaption(Amount)));
        end;
    end;
    local procedure WarningIfZeroAmt(GenJnlLine: Record "Gen. Journal Line")
    begin
        if(GenJnlLine.Amount = 0) and not AmountError then begin
            AmountError:=true;
            AddError(StrSubstNo(Text002, GenJnlLine.FieldCaption(Amount)));
        end;
    end;
    local procedure WarningIfNonZeroAmt(GenJnlLine: Record "Gen. Journal Line")
    begin
        if(GenJnlLine.Amount <> 0) and not AmountError then begin
            AmountError:=true;
            AddError(StrSubstNo(Text062, GenJnlLine.FieldCaption(Amount)));
        end;
    end;
    local procedure CheckAgainstPrevLines(GenJnlLine: Record "Gen. Journal Line")
    var
        i: Integer;
        AccType: Integer;
        AccNo: Code[20];
        ErrorFound: Boolean;
    begin
        if(GenJnlLine."External Document No." = '') or not(GenJnlLine."Account Type" in[GenJnlLine."account type"::Customer, GenJnlLine."account type"::Vendor]) and not(GenJnlLine."Bal. Account Type" in[GenJnlLine."bal. account type"::Customer, GenJnlLine."bal. account type"::Vendor])then exit;
        if GenJnlLine."Account Type" in[GenJnlLine."account type"::Customer, GenJnlLine."account type"::Vendor]then begin
            AccType:=GenJnlLine."Account Type".AsInteger();
            AccNo:=GenJnlLine."Account No.";
        end
        else
        begin
            AccType:=GenJnlLine."Bal. Account Type".AsInteger();
            AccNo:=GenJnlLine."Bal. Account No.";
        end;
        TempGenJnlLine.Reset;
        TempGenJnlLine.SetRange("External Document No.", GenJnlLine."External Document No.");
        while(i < 2) and not ErrorFound do begin
            i:=i + 1;
            if i = 1 then begin
                TempGenJnlLine.SetRange("Account Type", AccType);
                TempGenJnlLine.SetRange("Account No.", AccNo);
                TempGenJnlLine.SetRange("Bal. Account Type");
                TempGenJnlLine.SetRange("Bal. Account No.");
            end
            else
            begin
                TempGenJnlLine.SetRange("Account Type");
                TempGenJnlLine.SetRange("Account No.");
                TempGenJnlLine.SetRange("Bal. Account Type", AccType);
                TempGenJnlLine.SetRange("Bal. Account No.", AccNo);
            end;
            if TempGenJnlLine.FindFirst then begin
                ErrorFound:=true;
                AddError(StrSubstNo(Text064, GenJnlLine.FieldCaption("External Document No."), GenJnlLine."External Document No.", TempGenJnlLine."Line No.", GenJnlLine.FieldCaption("Document No."), TempGenJnlLine."Document No."));
            end;
        end;
        TempGenJnlLine.Reset;
        TempGenJnlLine:=GenJnlLine;
        TempGenJnlLine.Insert;
    end;
    local procedure CheckICDocument()
    var
        GenJnlLine4: Record "Gen. Journal Line";
        "IC G/L Account": Record "IC G/L Account";
    begin
        if GenJnlTemplate.Type = GenJnlTemplate.Type::Intercompany then begin
            if("Gen. Journal Line"."Posting Date" <> LastDate) or ("Gen. Journal Line"."Document Type" <> LastDocType) or ("Gen. Journal Line"."Document No." <> LastDocNo)then begin
                GenJnlLine4.SetCurrentkey("Journal Template Name", "Journal Batch Name", "Posting Date", "Document No.");
                GenJnlLine4.SetRange("Journal Template Name", "Gen. Journal Line"."Journal Template Name");
                GenJnlLine4.SetRange("Journal Batch Name", "Gen. Journal Line"."Journal Batch Name");
                GenJnlLine4.SetRange("Posting Date", "Gen. Journal Line"."Posting Date");
                GenJnlLine4.SetRange("Document No.", "Gen. Journal Line"."Document No.");
                GenJnlLine4.SetFilter("IC Partner Code", '<>%1', '');
                if GenJnlLine4.FindFirst then CurrentICPartner:=GenJnlLine4."IC Partner Code"
                else
                    CurrentICPartner:='';
            end;
            if(CurrentICPartner <> '') and ("Gen. Journal Line"."IC Direction" = "Gen. Journal Line"."ic direction"::Outgoing)then begin
                if("Gen. Journal Line"."Account Type" in["Gen. Journal Line"."account type"::"G/L Account", "Gen. Journal Line"."account type"::"Bank Account"]) and ("Gen. Journal Line"."Bal. Account Type" in["Gen. Journal Line"."bal. account type"::"G/L Account", "Gen. Journal Line"."account type"::"Bank Account"]) and ("Gen. Journal Line"."Account No." <> '') and ("Gen. Journal Line"."Bal. Account No." <> '')then begin
                    AddError(StrSubstNo(Text066, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Account No."), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."Bal. Account No.")));
                end
                else
                begin
                    if(("Gen. Journal Line"."Account Type" in["Gen. Journal Line"."account type"::"G/L Account", "Gen. Journal Line"."account type"::"Bank Account"]) and ("Gen. Journal Line"."Account No." <> '')) xor (("Gen. Journal Line"."Bal. Account Type" in["Gen. Journal Line"."bal. account type"::"G/L Account", "Gen. Journal Line"."account type"::"Bank Account"]) and ("Gen. Journal Line"."Bal. Account No." <> ''))then begin
                        if "Gen. Journal Line"."IC Account No." = '' then AddError(StrSubstNo(Text002, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."IC Account No.")))
                        else
                        begin
                            if "IC G/L Account".Get("Gen. Journal Line"."IC Account No.")then if "IC G/L Account".Blocked then AddError(StrSubstNo(Text032, "IC G/L Account".FieldCaption(Blocked), false, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."IC Account No."), "Gen. Journal Line"."IC Account No."));
                        end;
                    end
                    else if "Gen. Journal Line"."IC Account No." <> '' then AddError(StrSubstNo(Text009, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."IC Account No.")));
                end;
            end
            else if "Gen. Journal Line"."IC Account No." <> '' then begin
                    if "Gen. Journal Line"."IC Direction" = "Gen. Journal Line"."ic direction"::Incoming then AddError(StrSubstNo(Text069, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."IC Account No."), "Gen. Journal Line".FieldCaption("Gen. Journal Line"."IC Direction"), Format("Gen. Journal Line"."IC Direction")));
                    if CurrentICPartner = '' then AddError(StrSubstNo(Text070, "Gen. Journal Line".FieldCaption("Gen. Journal Line"."IC Account No.")));
                end;
        end;
    end;
    local procedure TestJobFields(var GenJnlLine: Record "Gen. Journal Line")
    var
        Job: Record Job;
        JT: Record "Job Task";
    begin
        begin
            if(GenJnlLine."Job No." = '') or (GenJnlLine."Account Type" <> GenJnlLine."account type"::"G/L Account")then exit;
            if not Job.Get(GenJnlLine."Job No.")then AddError(StrSubstNo(Text071, Job.TableCaption, GenJnlLine."Job No."))
            else if Job.Blocked <> Job.Blocked::" " then AddError(StrSubstNo(Text072, Job.FieldCaption(Blocked), Job.Blocked, Job.TableCaption, GenJnlLine."Job No."));
            if GenJnlLine."Job Task No." = '' then AddError(StrSubstNo(Text002, GenJnlLine.FieldCaption(GenJnlLine."Job Task No.")))
            else if not JT.Get(GenJnlLine."Job No.", GenJnlLine."Job Task No.")then AddError(StrSubstNo(Text071, JT.TableCaption, GenJnlLine."Job Task No."))end;
    end;
    local procedure CheckFADocNo(GenJnlLine: Record "Gen. Journal Line")
    var
        DeprBook: Record "Depreciation Book";
        FAJnlLine: Record "FA Journal Line";
        OldFALedgEntry: Record "FA Ledger Entry";
        OldMaintenanceLedgEntry: Record "Maintenance Ledger Entry";
        FANo: Code[20];
    begin
        begin
            if GenJnlLine."Account Type" = GenJnlLine."account type"::"Fixed Asset" then FANo:=GenJnlLine."Account No.";
            if GenJnlLine."Bal. Account Type" = GenJnlLine."bal. account type"::"Fixed Asset" then FANo:=GenJnlLine."Bal. Account No.";
            if(FANo = '') or (GenJnlLine."FA Posting Type" = GenJnlLine."fa posting type"::" ") or (GenJnlLine."Depreciation Book Code" = '') or (GenJnlLine."Document No." = '')then exit;
            if not DeprBook.Get(GenJnlLine."Depreciation Book Code")then exit;
            if DeprBook."Allow Identical Document No." then exit;
            FAJnlLine."FA Posting Type":=Enum::"Gen. Journal Line FA Posting Type".FromInteger(GenJnlLine."FA Posting Type".AsInteger() - 1);
            if GenJnlLine."FA Posting Type" <> GenJnlLine."fa posting type"::Maintenance then begin
                OldFALedgEntry.SetCurrentkey("FA No.", "Depreciation Book Code", "FA Posting Category", "FA Posting Type", "Document No.");
                OldFALedgEntry.SetRange("FA No.", FANo);
                OldFALedgEntry.SetRange("Depreciation Book Code", GenJnlLine."Depreciation Book Code");
                OldFALedgEntry.SetRange("FA Posting Category", OldFALedgEntry."fa posting category"::" ");
                OldFALedgEntry.SetRange("FA Posting Type", FAJnlLine.ConvertToLedgEntry(FAJnlLine));
                OldFALedgEntry.SetRange("Document No.", GenJnlLine."Document No.");
                if OldFALedgEntry.FindFirst then AddError(StrSubstNo(Text073, GenJnlLine.FieldCaption(GenJnlLine."Document No."), GenJnlLine."Document No."));
            end
            else
            begin
                OldMaintenanceLedgEntry.SetCurrentkey("FA No.", "Depreciation Book Code", "Document No.");
                OldMaintenanceLedgEntry.SetRange("FA No.", FANo);
                OldMaintenanceLedgEntry.SetRange("Depreciation Book Code", GenJnlLine."Depreciation Book Code");
                OldMaintenanceLedgEntry.SetRange("Document No.", GenJnlLine."Document No.");
                if OldMaintenanceLedgEntry.FindFirst then AddError(StrSubstNo(Text073, GenJnlLine.FieldCaption(GenJnlLine."Document No."), GenJnlLine."Document No."));
            end;
        end;
    end;
    procedure InitializeRequest(NewShowDim: Boolean)
    begin
        ShowDim:=NewShowDim;
    end;
    local procedure GetDimensionText(var DimensionSetEntry: Record "Dimension Set Entry"): Text[75]var
        DimensionText: Text[75];
        Separator: Code[10];
        DimValue: Text[45];
    begin
        Separator:='';
        DimValue:='';
        Continue:=false;
        repeat DimValue:=StrSubstNo('%1 - %2', DimensionSetEntry."Dimension Code", DimensionSetEntry."Dimension Value Code");
            if MaxStrLen(DimensionText) < StrLen(DimensionText + Separator + DimValue)then begin
                Continue:=true;
                exit(DimensionText);
            end;
            DimensionText:=DimensionText + Separator + DimValue;
            Separator:='; ';
        until DimSetEntry.Next = 0;
        exit(DimensionText);
    end;
}
