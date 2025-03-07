XmlPort 50001 "Import Pronestor"
{
    Direction = Import;
    FieldSeparator = ';';
    Format = VariableText;
    TextEncoding = WINDOWS;

    schema
    {
    textelement(Root)
    {
    tableelement("Pronestor indlæsning";
    "Pronestor indlæsning")
    {
    XmlName = 'Pron';
    SourceTableView = sorting(EntryNo);

    textelement(debitornavn)
    {
    XmlName = 'a';
    }
    textelement(betalingsnote)
    {
    XmlName = 'b';
    }
    fieldelement(c;
    "Pronestor indlæsning".Varenummer)
    {
    }
    fieldelement(d;
    "Pronestor indlæsning".Antal)
    {
    }
    fieldelement(e;
    "Pronestor indlæsning".Debitornummer)
    {
    }
    fieldelement(f;
    "Pronestor indlæsning"."Pris incl. moms")
    {
    }
    fieldelement(g;
    "Pronestor indlæsning"."Mødetype (intern/ekstern)")
    {
    }
    fieldelement(h;
    "Pronestor indlæsning"."Møde ID")
    {
    }
    textelement(bemaerkninger)
    {
    XmlName = 'i';
    }
    fieldelement(j;
    "Pronestor indlæsning"."Bestiller/Projekt nr.")
    {
    }
    fieldelement(k;
    "Pronestor indlæsning".OrdredatoDT)
    {
    }
    trigger OnBeforeInsertRecord()
    begin
        i+=1;
        "Pronestor indlæsning".EntryNo:=i;
        "Pronestor indlæsning"."Debitor navn":=CopyStr(Debitornavn, 1, 30);
        "Pronestor indlæsning".Betalingsnote:=CopyStr(BetalingsNote, 1, 30);
        "Pronestor indlæsning".Bemærkninger:=CopyStr(Bemaerkninger, 1, 30);
        "Pronestor indlæsning".Ordredato:=Dt2Date("Pronestor indlæsning".OrdredatoDT);
        "Pronestor indlæsning"."Bogf.dato":="Posting date";
        //Kontrol:
        if not Customer.Get("Pronestor indlæsning".Debitornummer)then Clear("Pronestor indlæsning".Debitornummer);
        if not Item.Get("Pronestor indlæsning".Varenummer)then Clear("Pronestor indlæsning".Varenummer);
    end;
    }
    }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                field("Posting date"; "Posting date")
                {
                    ApplicationArea = Basic;
                    Caption = 'Bogf. dato:';
                }
            }
        }
        actions
        {
        }
    }
    trigger OnPostXmlPort()
    begin
        Message(txt001, currXMLport.Filename);
    end;
    trigger OnPreXmlPort()
    begin
        if "Posting date" = 0D then Error('Bogf. dato SKAL angives!');
        "Pronestor indlæsning".DeleteAll;
    end;
    var i: Integer;
    "Posting date": Date;
    Customer: Record Customer;
    Item: Record Item;
    txt001: label 'Filen %1 er indlæst!';
}
