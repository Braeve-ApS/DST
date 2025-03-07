Table 60000 "Buffer for reporting totals"
{
    fields
    {
        field(1; "Account No"; Code[10])
        {
        }
        field(11; Kol1; Decimal)
        {
        }
        field(12; Kol2; Decimal)
        {
        }
        field(13; Kol3; Decimal)
        {
        }
        field(14; Kol4; Decimal)
        {
        }
        field(15; Kol5; Decimal)
        {
        }
        field(16; Kol6; Decimal)
        {
        }
        field(17; Kol7; Decimal)
        {
        }
        field(18; Kol8; Decimal)
        {
        }
        field(19; Kol9; Decimal)
        {
        }
        field(20; Kol10; Decimal)
        {
        }
        field(21; Kol11; Decimal)
        {
        }
        field(22; Kol12; Decimal)
        {
        }
        field(23; Kol13; Decimal)
        {
        }
        field(24; Kol14; Decimal)
        {
        }
        field(25; Kol15; Decimal)
        {
        }
    }
    keys
    {
        key(Key1; "Account No")
        {
            Clustered = true;
            SumIndexFields = Kol1, Kol2, Kol3, Kol4, Kol5, Kol6, Kol7, Kol8, Kol9, Kol10, Kol11, Kol12, Kol13, Kol14, Kol15;
        }
    }
    fieldgroups
    {
    }
}
