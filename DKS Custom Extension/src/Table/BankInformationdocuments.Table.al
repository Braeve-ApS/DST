Table 50003 "Bank Information documents"
{
    fields
    {
        field(1; "Currency Code"; Code[10])
        {
            Caption = 'Valutakode';
            TableRelation = Currency.Code;
        }
        field(2; "Country Code"; Code[10])
        {
            Caption = 'Landekode';
            TableRelation = "Country/Region".Code;
        }
        field(3; "Bank Account"; Code[20])
        {
            Caption = 'Bankkonto';
            TableRelation = "Bank Account"."No.";
        }
        field(4; "Bank Name"; Text[100])
        {
            CalcFormula = lookup("Bank Account".Name where("No."=field("Bank Account")));
            Caption = 'Bank Navn';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Print FIK on invoice"; Boolean)
        {
            Caption = 'Skriv FIK på faktura?';
        }
    }
    keys
    {
        key(Key1; "Currency Code", "Country Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var BankAccount: Record "Bank Account";
    CompanyInfo: Record "Company Information";
    BankInfo: Record "Bank Information documents";
    procedure GetBankName(CurrencyCode: Code[10]; CountryCode: Code[10])BankName: Text[50]begin
        if FindBankAccount(CurrencyCode, CountryCode)then exit(BankAccount.Name)
        else
            exit(CompanyInfo."Bank Name");
    end;
    procedure GetbankBranch(CurrencyCode: Code[10]; CountryCode: Code[10])BankBranch: Text[20]begin
        if FindBankAccount(CurrencyCode, CountryCode)then exit(BankAccount."Bank Branch No.")
        else
            exit(CompanyInfo."Bank Branch No.");
    end;
    procedure GetBankAccount(CurrencyCode: Code[10]; CountryCode: Code[10])"Bank Account": Text[30]begin
        if FindBankAccount(CurrencyCode, CountryCode)then exit(BankAccount."Bank Account No.")
        else
            exit(CompanyInfo."Bank Account No.");
    end;
    procedure GetIBAN(CurrencyCode: Code[10]; CountryCode: Code[10])Iban: Code[50]begin
        if FindBankAccount(CurrencyCode, CountryCode)then exit(BankAccount.Iban)
        else
            exit(CompanyInfo.Iban);
    end;
    procedure GetSwift(CurrencyCode: Code[10]; CountryCode: Code[10])Swift: Code[20]begin
        if FindBankAccount(CurrencyCode, CountryCode)then exit(BankAccount."SWIFT Code")
        else
            exit(CompanyInfo."SWIFT Code");
    end;
    procedure FindBankAccount(CurrencyCode: Code[10]; CountryCode: Code[10])BankAccountFound: Boolean begin
        CompanyInfo.Get;
        Clear(BankInfo);
        if BankInfo.Get(CurrencyCode, CountryCode)then begin
            BankAccount.Get(BankInfo."Bank Account");
            exit(true);
        end
        else if BankInfo.Get(CurrencyCode, '')then begin
                BankAccount.Get(BankInfo."Bank Account");
                exit(true);
            end
            else if BankInfo.Get('', CountryCode)then begin
                    BankAccount.Get(BankInfo."Bank Account");
                    exit(true);
                end
                else
                    exit(false);
    end;
    procedure PrintFIK(CurrencyCode: Code[10]; CountryCode: Code[10])PrintFIK: Boolean begin
        if not FindBankAccount(CurrencyCode, CountryCode)then exit(false);
        exit(BankInfo."Print FIK on invoice");
    end;
}
