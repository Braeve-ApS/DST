XmlPort 55096 "Import Budget Entries2"
{
    Direction = Import;
    FieldSeparator = ';';
    Format = VariableText;

    schema
    {
        textelement(Root)
        {
            tableelement("G/L Budget Entry";
            "G/L Budget Entry")
            {
                XmlName = 'GLBudget';

                fieldelement(F1;
                "G/L Budget Entry"."Entry No.")
                {
                }
                fieldelement(F2;
                "G/L Budget Entry"."Budget Name")
                {
                }
                fieldelement(F3;
                "G/L Budget Entry"."G/L Account No.")
                {
                }
                fieldelement(F4;
                "G/L Budget Entry".Date)
                {
                }
                fieldelement(F5;
                "G/L Budget Entry"."Global Dimension 1 Code")
                {
                }
                fieldelement(F6;
                "G/L Budget Entry"."Global Dimension 2 Code")
                {
                }
                fieldelement(F7;
                "G/L Budget Entry".Amount)
                {
                }
                fieldelement(F8;
                "G/L Budget Entry".Description)
                {
                }
                fieldelement(F9;
                "G/L Budget Entry"."Business Unit Code")
                {
                }
                textelement(dummy)
                {
                    XmlName = 'F10';
                }
                fieldelement(F11;
                "G/L Budget Entry"."Budget Dimension 1 Code")
                {
                }
                fieldelement(F12;
                "G/L Budget Entry"."Budget Dimension 2 Code")
                {
                }
                fieldelement(F13;
                "G/L Budget Entry"."Budget Dimension 3 Code")
                {
                }
                fieldelement(F14;
                "G/L Budget Entry"."Budget Dimension 4 Code")
                {
                }
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
}
