tableextension 50004 "cor Sales Invoice Header" extends "Sales Invoice Header"
{
    fields
    {
        field(50000; "E-fak Note"; Text[100]) //Field  "cor E-fak Note"
        {
            Caption = 'E-fak Note';
        }
        field(51000; "Tilh. BS-Opkrævning"; Code[9]) // BS - Angiver evt. tilh¢rende BS-Opkrævning)
        {
            Caption = 'Tilh. BS-Opkrævning';
            TableRelation = "BS-Opkrævningshoved"."Opkrævningsnr.";
        }
    }
}
