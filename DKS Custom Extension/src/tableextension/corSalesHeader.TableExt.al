tableextension 50002 "cor Sales Header" extends "Sales Header"
{
    fields
    {
        field(50000; "E-fak Note"; Text[100]) //Field  "cor E-fak Note"
        {
            Caption = 'E-fak Note';
        }
        field(51000; "Tilh. BS-Opkrævning"; Code[9])
        {
            Caption = 'Tilh. BS-Opkrævning';
            ObsoleteState = Pending;
            ObsoleteReason = 'Replaced by standard BC Subscription Billing. Will be removed in a future version.';
        }
    }
}
