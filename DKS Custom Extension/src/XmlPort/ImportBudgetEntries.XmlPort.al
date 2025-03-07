XmlPort 50003 "Import Budget Entries"
{
    Direction = Import;
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
    textelement(Root)
    {
    tableelement("G/L Budget Entry Import Buffer";
    "G/L Budget Entry Import Buffer")
    {
    XmlName = 'Budget';

    fieldelement(a;
    "G/L Budget Entry Import Buffer"."Budget Name")
    {
    }
    fieldelement(b;
    "G/L Budget Entry Import Buffer"."G/L Account No.")
    {
    }
    fieldelement(c;
    "G/L Budget Entry Import Buffer".Date)
    {
    }
    fieldelement(d;
    "G/L Budget Entry Import Buffer"."Global Dimension 1 Code")
    {
    }
    fieldelement(e;
    "G/L Budget Entry Import Buffer"."Global Dimension 2 Code")
    {
    }
    fieldelement(f;
    "G/L Budget Entry Import Buffer".Amount)
    {
    }
    fieldelement(g;
    "G/L Budget Entry Import Buffer".Description)
    {
    }
    trigger OnBeforeInsertRecord()
    begin
        i+=1;
        "G/L Budget Entry Import Buffer"."Entry No.":=i;
    end;
    }
    }
    }
    requestpage
    {
        layout
        {
        }
        actions
        {
        }
    }
    trigger OnPreXmlPort()
    begin
        "G/L Budget Entry Import Buffer".DeleteAll;
    end;
    var i: Integer;
}
