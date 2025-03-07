Page 50007 "Bank information documents"
{
    // <PROINFO>
    PageType = List;
    SourceTable = "Bank Information documents";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Basic;
                }
                field("Country Code"; Rec."Country Code")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Account"; Rec."Bank Account")
                {
                    ApplicationArea = Basic;
                }
                field("Bank Name"; Rec."Bank Name")
                {
                    ApplicationArea = Basic;
                }
                field("Print FIK on invoice"; Rec."Print FIK on invoice")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Test)
            {
                ApplicationArea = Basic;
                Caption = 'Test';
                Image = CarryOutActionMessage;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    Name: Text[50];
                    Account: Text[73];
                    Iban: Text[50];
                    Swift: Code[20];
                begin
                    Name:=Rec.GetBankName(Rec."Currency Code", Rec."Country Code");
                    Account:=Rec.GetbankBranch(Rec."Currency Code", Rec."Country Code") + ' - ' + Rec.GetBankAccount(Rec."Currency Code", Rec."Country Code");
                    Iban:=Rec.GetIBAN(Rec."Currency Code", Rec."Country Code");
                    Swift:=Rec.GetSwift(Rec."Currency Code", Rec."Country Code");
                    Message(Testtxt, Name, Account, Iban, Swift, Rec."Print FIK on invoice");
                end;
            }
        }
    }
    var Testtxt: label 'Bank: %1\Account: %2\IBAN: %3\Swift: %4\FIK info: %5';
}
