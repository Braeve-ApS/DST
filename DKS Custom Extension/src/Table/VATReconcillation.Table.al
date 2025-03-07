Table 70015 "VAT Reconcillation"
{
    fields
    {
        field(1; "Account No."; Code[20])
        {
            Caption = 'Konto nr.';
            Editable = false;
            TableRelation = "G/L Account";
        }
        field(2; Name; Text[80])
        {
            Caption = 'Navn';
            Editable = false;
        }
        field(5; "VAT Business Posting Group"; Code[10])
        {
            Caption = 'Moms Virksomheds. bogf. gruppe';
            Editable = false;
        }
        field(6; "VAT Product Posting Group"; Code[10])
        {
            Caption = 'Moms Produktbogf. gruppe';
            Editable = false;
        }
        field(7; "VAT pct. acc. to setup"; Decimal)
        {
            Caption = 'Momspct. jf. opsætning';
            Editable = false;
        }
        field(10; "Net Change"; Decimal)
        {
            Caption = 'Bevægelse';
            Editable = false;
        }
        field(15; "Theoretical calculated VAT"; Decimal)
        {
            Caption = 'Teoretisk beregnet moms';
            Editable = false;
        }
        field(20; "Actual Sales VAT"; Decimal)
        {
            Caption = 'Faktisk salgsmoms';
            Editable = false;
        }
        field(21; "Actual Purchase VAT"; Decimal)
        {
            Caption = 'Faktisk købsmoms';
            Editable = false;
        }
        field(25; "Calculated VAT Pct."; Decimal)
        {
            Caption = 'Beregnet momsprocent (gns.)';
            Editable = false;
        }
        field(30; "Variance in LCY"; Decimal)
        {
            Caption = 'Difference (RV)';
            Editable = false;
        }
        field(100; Type; Option)
        {
            OptionMembers = Reconcile, Total, Accounts;
        }
        field(101; EntryNo; Integer)
        {
        }
        field(200; DateFilterUsed; Text[30])
        {
        }
        field(201; IsBold; Boolean)
        {
        }
    }
    keys
    {
        key(Key1; Type, "Account No.", EntryNo)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
