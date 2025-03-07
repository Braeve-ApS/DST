pageextension 50000 "Customer Card Ext" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field("Social Security No."; Rec."Social Security No.")
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
        addlast(Payments)
        {
            field("PBS Incl moms"; Rec."PBS Incl moms")
            {
                visible = true;
                ApplicationArea = all;
            }
        }
        addafter("CPM Bal. Account No.")
        {
            field("Anvender BetalingsService"; Rec."Anvender BetalingsService")
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter(History)
        {
            action(BSBetalingsaftale)
            {
                ApplicationArea = all;
                Caption = 'BS_Opkrævningslinjer';

                trigger OnAction()
                var
                    lBSBetalingsaftaleform: Page "BS Betalingsaftale";
                    lBSBetalingsaftaleRec: Record "BS-Betalingsaftale";
                    lSelected: Integer;
                    Text1001: Label 'Der er ikke oprettet BS-betalingsaftale på debitor.\ \Skal der oprettes en nye BS betalingsaftale?';
                    Text1002: Label 'Debitorgruppe 84';
                begin
                    lBSBetalingsaftaleRec.SETRANGE("Debitornr.", Rec."No.");
                    IF NOT lBSBetalingsaftaleRec.FIND('-')THEN BEGIN
                        IF NOT CONFIRM(Text1001, TRUE)THEN EXIT;
                        lSelected:=DIALOG.STRMENU(Text1002, 2);
                        IF lSelected = 0 THEN EXIT;
                        lBSBetalingsaftaleRec.INIT;
                        lBSBetalingsaftaleRec."Debitornr.":=Rec."No.";
                        CASE lSelected OF 1: lBSBetalingsaftaleRec."Debitorgr.":=84;
                        2: lBSBetalingsaftaleRec."Debitorgr.":=85;
                        3: lBSBetalingsaftaleRec."Debitorgr.":=86;
                        4: lBSBetalingsaftaleRec."Debitorgr.":=87;
                        5: lBSBetalingsaftaleRec."Debitorgr.":=90;
                        END;
                        IF Rec."Social Security No." <> '' THEN lBSBetalingsaftaleRec.VALIDATE("CPR-/CVR-Nr.", DELCHR(Rec."Social Security No.", '=', '-'));
                        lBSBetalingsaftaleRec."PBS Status":=lBSBetalingsaftaleRec."PBS Status"::Inaktiv;
                        lBSBetalingsaftaleRec.INSERT;
                        COMMIT;
                    END;
                    lBSBetalingsaftaleform.SETTABLEVIEW(lBSBetalingsaftaleRec);
                    lBSBetalingsaftaleform.RUNMODAL();
                end;
            }
        }
    }
}
