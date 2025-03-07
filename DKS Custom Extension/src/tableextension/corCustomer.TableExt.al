tableextension 50000 "cor Customer" extends "Customer"
{
    fields
    {
        field(50003; "PBS Incl moms"; Boolean) //Field  "cor PBS Incl moms"
        {
            Caption = 'PBS Incl moms';
        }
        field(50010; "Trading Partner (Filter)"; Code[20]) // DST001
        {
            Caption = 'Trading Partner (Filter)';
        }
        field(50100; "Anvender BetalingsService"; Boolean)
        {
            Caption = 'Anvender BetalingsService';
        }
        field(60000; "Social Security No."; Text[30]) //Field  "cor Social Security No."
        {
            Caption = 'Social Security No.';

            trigger OnValidate()
            var
                Text1160030002: Label 'An employee with this Social Security No. already exists.';
                Text1160030021: Label 'Social Security No. %1 is invalid.';
                Weight: Text[10];
                I: Integer;
                Ok: Boolean;
                V: Integer;
                C: Integer;
                Sum: Integer;
                CustomerRec: Record Customer;
                TempSocialSecNo: Text[30];
            begin
                IF "Social Security No." <> '' THEN BEGIN
                    TempSocialSecNo:=INSSTR("Social Security No.", '-', 7);
                    CustomerRec.SETCURRENTKEY("Social Security No.");
                    CustomerRec.SETRANGE("Social Security No.", TempSocialSecNo);
                    CustomerRec.SETFILTER("No.", '<>%1', "No.");
                    IF CustomerRec.FIND('-')THEN MESSAGE(Text1160030002);
                    //>>COR/IMT 060613
                    IF STRLEN("Social Security No.") = 10 THEN BEGIN
                        Weight:='4327654321';
                        FOR I:=1 TO 10 DO BEGIN
                            Ok:=EVALUATE(V, COPYSTR(Weight, I, 1));
                            Ok:=EVALUATE(C, COPYSTR("Social Security No.", I, 1));
                            Sum:=Sum + V * C;
                        END;
                        IF(Ok) AND (Sum MOD 11 = 0)THEN BEGIN
                            "Social Security No.":=INSSTR("Social Security No.", '-', 7);
                        END
                        ELSE
                            MESSAGE(Text1160030021, "Social Security No."); // DKLL3.08.00.00
                    END
                    ELSE IF STRLEN("Social Security No.") <> 8 THEN ERROR('Antallet af cifre i SE Nr. er forkert');
                END;
            end;
        }
    }
}
