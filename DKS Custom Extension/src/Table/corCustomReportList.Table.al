table 50000 "cor Custom Report List"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; Name; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(3; ReportID; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }
}
