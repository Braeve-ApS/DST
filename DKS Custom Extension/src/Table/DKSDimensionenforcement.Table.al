Table 50018 "DKS Dimension enforcement"
{
    fields
    {
        field(1; "Dimension Code"; Code[20])
        {
            Caption = 'Dimension';
            TableRelation = Dimension.Code;
        }
        field(2; "Dimension Value"; Code[20])
        {
            Caption = 'Værdi';
            TableRelation = "Dimension Value".Code where("Dimension Code"=field("Dimension Code"));
        }
        field(3; "Forces Dimension"; Code[20])
        {
            Caption = 'Kræver dimension udfyldt';
            TableRelation = Dimension.Code;
        }
    }
    keys
    {
        key(Key1; "Dimension Code", "Dimension Value")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
