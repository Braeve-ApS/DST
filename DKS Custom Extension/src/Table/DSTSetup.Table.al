Table 50002 "DST Setup"
{
    // <PROINFO>
    //   PI-PDF
    // PI001/071114/Jim : New field
    // PI003/060115/Jim : Field "Show delayed receipts as" added
    // PI004/140316/Jim : New Field
    // PI005/010416/OBL : Field "Show VAT Claus" added
    // PI006/800816/Jim : Field Consignor Installation ID
    Caption = 'DST Setup';

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }
        field(110; "G/L Account for total Turnover"; Code[10])
        {
            Caption = 'G/L Account for total Turnover';
            Description = 'KPI';
            TableRelation = "G/L Account"."No.";
        }
        field(120; "No. of weeks in Currency Chart"; Integer)
        {
            Caption = 'No. of weeks in Currency Chart';
            Description = 'KPI';
        }
        field(121; "Horizon (days) Order Intake ch"; Integer)
        {
            Caption = 'Horizon (days) Order Intake chart';
            Description = 'KPI';
        }
        field(122; "Specify Order Intake per sales"; Boolean)
        {
            Caption = 'Specify Order Intake per salesperson';
            Description = 'KPI';
        }
        field(123; "Show Delayed shipments as"; Option)
        {
            Caption = 'Show orderintake as';
            Description = 'KPI';
            OptionCaption = 'Quantity,Amount (RV)';
            OptionMembers = Quantity, "Amount (RV)";
        }
        field(124; "Show Delayed Receipts as"; Option)
        {
            Caption = 'Show delayed receipts as';
            Description = 'KPI';
            OptionCaption = 'Quantity,Amount (RV)';
            OptionMembers = Quantity, "Amount (RV)";
        }
        field(130; "G/L Account for GM"; Code[10])
        {
            Caption = 'G/L Account for GM';
            Description = 'KPI';
            TableRelation = "G/L Account"."No.";
        }
        field(131; "G/L Account for GM II"; Code[10])
        {
            Caption = 'G/L Account for GM II';
            Description = 'KPI';
            TableRelation = "G/L Account"."No.";
        }
        field(132; "G/L Account for EBIT"; Code[10])
        {
            Caption = 'G/L Account for EBIT';
            Description = 'KPI';
            TableRelation = "G/L Account"."No.";
        }
        field(133; "G/L Account for Equity"; Code[10])
        {
            Caption = 'G/L Account for Equity';
            Description = 'KPI';
            TableRelation = "G/L Account"."No.";
        }
        field(134; "G/L Account for total Assets"; Code[10])
        {
            Caption = 'G/L Account for total Assets';
            Description = 'KPI';
            TableRelation = "G/L Account"."No.";
        }
        field(135; "G/L Account for Current Assets"; Code[10])
        {
            Caption = 'G/L Account for Current Assets';
            Description = 'KPI';
            TableRelation = "G/L Account"."No.";
        }
        field(136; "G/L Acc. for Shorttermed debts"; Code[10])
        {
            Caption = 'G/L Acc. for Shorttermed debts';
            Description = 'KPI';
            TableRelation = "G/L Account"."No.";
        }
        field(137; "G/L Acc. for total Liabilities"; Code[10])
        {
            Caption = 'G/L Acc. for total Liabilities';
            Description = 'KPI';
            TableRelation = "G/L Account"."No.";
        }
        field(138; "G/L Acc. for Net Result"; Code[10])
        {
            Caption = 'G/L Acc. for Net Result';
            Description = 'KPI';
            TableRelation = "G/L Account"."No.";
        }
        field(139; "G/L Acc. for total Stock"; Code[10])
        {
            Caption = 'G/L Acc. for total Stock';
            Description = 'KPI';
            TableRelation = "G/L Account"."No.";
        }
        field(140; "G/L Acc. for Result before tax"; Code[10])
        {
            Caption = 'G/L Acc. for Result before tax';
            Description = 'KPI,PI004';
            TableRelation = "G/L Account"."No.";
        }
        field(150; "Header Logo"; Blob)
        {
            Caption = 'Header Logo';
            Description = 'PI-Doc';
            SubType = Bitmap;
        }
        field(151; "Footer Logo"; Blob)
        {
            Caption = 'Footer Logo';
            Description = 'PI-Doc';
            SubType = Bitmap;
        }
        field(152; "Footer Text 1"; Text[50])
        {
            Caption = 'Footer Text 1';
            Description = 'PI-Doc';
        }
        field(153; "Footer Text 2"; Text[50])
        {
            Caption = 'Footer Text 2';
            Description = 'PI-Doc';
        }
        field(154; "Footer Text 3"; Text[50])
        {
            Caption = 'Footer Text 3';
            Description = 'PI-Doc';
        }
        field(155; ShowVATSpecification; Boolean)
        {
            Caption = 'Show VAT Specification';
            Description = 'PI-Doc';
        }
        field(156; ShowBankInformation; Boolean)
        {
            Caption = 'Show Bank Information';
            Description = 'PI-Doc';
        }
        field(157; FIK; Option)
        {
            Caption = 'FIK';
            Description = 'PI-Doc';
            OptionMembers = " ", NAV, PM;
        }
        field(158; "Show Vat Clause"; Boolean)
        {
            Caption = 'Show Vat Clause';
            Description = 'PI-Doc';
        }
        field(50000; "Use Department as VAT Bus. pos"; Boolean)
        {
            Caption = 'Use Department as VAT Bus. post. grp.';
            Description = 'DST';
        }
        field(50010; "Path for G/L Budget Entries Im"; Text[100])
        {
            ExtendedDatatype = URL;
        }
    }
    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
