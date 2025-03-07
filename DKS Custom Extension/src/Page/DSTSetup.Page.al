Page 50006 "DST Setup"
{
    // <PROINFO>
    //   PI-PDF
    // PI001/22-08-14/Jim : Action: Link to Bank Account Info
    // PI002/28-08-14/Jim : Mail Setup filters on Action
    // PI003/101114/Jim : Action Mail Header changed from Card to List
    // PI004/131114/Jim : Field Use SMTP removed (moved to Mail header)
    // PI005/060115/Jim : Fiel Show delayed receipts as" added
    // PI006/140316/Jim : Field "G/L Acc. for Result before tax" added
    // PI007/010416/OBL : Field "Show VAT Claus" added
    // PI008/080816/Jim : Field Consignor ID
    Caption = 'DST Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "DST Setup";

    layout
    {
        area(content)
        {
            group("Moms og bogføring")
            {
                field("Use Department as VAT Bus. pos"; Rec."Use Department as VAT Bus. pos")
                {
                    ApplicationArea = Basic;
                }
                field("Path for G/L Budget Entries Im"; Rec."Path for G/L Budget Entries Im")
                {
                    ApplicationArea = Basic;
                }
            }
            grid(KPI)
            {
                field("No. of weeks in Currency Chart"; Rec."No. of weeks in Currency Chart")
                {
                    ApplicationArea = Basic;
                }
                field("Horizon (days) Order Intake ch"; Rec."Horizon (days) Order Intake ch")
                {
                    ApplicationArea = Basic;
                }
                field("Specify Order Intake per sales"; Rec."Specify Order Intake per sales")
                {
                    ApplicationArea = Basic;
                }
                field("Show Delayed shipments as"; Rec."Show Delayed shipments as")
                {
                    ApplicationArea = Basic;
                }
                field("Show Delayed Receipts as"; Rec."Show Delayed Receipts as")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account for total Turnover"; Rec."G/L Account for total Turnover")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account for GM"; Rec."G/L Account for GM")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account for GM II"; Rec."G/L Account for GM II")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account for EBIT"; Rec."G/L Account for EBIT")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Acc. for Result before tax"; Rec."G/L Acc. for Result before tax")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Acc. for Net Result"; Rec."G/L Acc. for Net Result")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Acc. for total Stock"; Rec."G/L Acc. for total Stock")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account for Current Assets"; Rec."G/L Account for Current Assets")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account for total Assets"; Rec."G/L Account for total Assets")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Account for Equity"; Rec."G/L Account for Equity")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Acc. for Shorttermed debts"; Rec."G/L Acc. for Shorttermed debts")
                {
                    ApplicationArea = Basic;
                }
                field("G/L Acc. for total Liabilities"; Rec."G/L Acc. for total Liabilities")
                {
                    ApplicationArea = Basic;
                }
            }
            group(Documents)
            {
                Caption = 'Documents';

                group(Control1000000043)
                {
                    //The GridLayout property is only supported on controls of type Grid
                    //GridLayout = Rows;
                    field("Header Logo"; Rec."Header Logo")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Footer Logo"; Rec."Footer Logo")
                    {
                        ApplicationArea = Basic;
                    }
                }
                group(Control1000000040)
                {
                    field("Footer Text 1"; Rec."Footer Text 1")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Footer Text 2"; Rec."Footer Text 2")
                    {
                        ApplicationArea = Basic;
                    }
                    field("Footer Text 3"; Rec."Footer Text 3")
                    {
                        ApplicationArea = Basic;
                    }
                    field(ShowVATSpecification; Rec.ShowVATSpecification)
                    {
                        ApplicationArea = Basic;
                    }
                    field(ShowBankInformation; Rec.ShowBankInformation)
                    {
                        ApplicationArea = Basic;
                    }
                    field("Show Vat Clause"; Rec."Show Vat Clause")
                    {
                        ApplicationArea = Basic;
                    }
                    field(FIK; Rec.FIK)
                    {
                        ApplicationArea = Basic;
                    }
                }
            }
        }
    }
    actions
    {
        area(navigation)
        {
        /* action("Bank Info Setup")
            {
                ApplicationArea = Basic;
                Caption = 'Bank Info Setup';
                Image = BankContact;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = Page UnknownPage70007;
            }
            */
        }
    }
    trigger OnOpenPage()
    begin
        Rec.Reset;
        if not Rec.Get then begin
            Rec.Init;
            Rec.Insert;
        end;
    end;
    var ShowPdfControls: Boolean;
    ShowReportControls: Boolean;
}
