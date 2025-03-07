codeunit 50002 DKSFunctions
{
    trigger OnRun()
    begin
    end;
    procedure GetFIK71String(No: Text[20]): Text var
        CompanyInformation: Record "Company Information";
        StringLen: Integer;
        CheckSum: Integer;
        Total: Integer;
        Weight: Text;
        String: Text;
    begin
        StringLen:=15;
        IF STRLEN(No) > (StringLen - 1)THEN EXIT;
        IF DELCHR(No, '=', '0123456789') <> '' THEN EXIT;
        CompanyInformation.GET;
        IF CompanyInformation.BankCreditorNo = '' THEN EXIT;
        String:=PADSTR('', (StringLen - 1 - STRLEN(No)), '0') + No;
        Weight:='12121212121212';
        CreateFIKCheckSum(String, Weight, Total, CheckSum);
        EXIT('+71<' + String + FORMAT(CheckSum) + '+' + CompanyInformation.BankCreditorNo);
    end;
    internal procedure CreateFIKCheckSum(String: Text; Weight: Text; var Total: Integer; var CheckSum: Integer): Integer;
    var
        StringDigit: Integer;
        WeightDigit: Integer;
        ProductDigit: Integer;
    begin
        EVALUATE(StringDigit, COPYSTR(String, 1, 1));
        EVALUATE(WeightDigit, COPYSTR(Weight, 1, 1));
        ProductDigit:=StringDigit * WeightDigit;
        IF ProductDigit >= 10 THEN Total+=1 + (ProductDigit MOD 10)
        ELSE
            Total+=ProductDigit;
        IF STRLEN(String) > 1 THEN BEGIN
            String:=COPYSTR(String, 2, STRLEN(String) - 1);
            Weight:=COPYSTR(Weight, 2, STRLEN(Weight) - 1);
            CreateFIKCheckSum(String, Weight, Total, CheckSum);
        END
        ELSE
        BEGIN
            CheckSum:=10 - (Total MOD 10);
            IF CheckSum = 10 THEN CheckSum:=0;
        END;
        EXIT(CheckSum);
    end;
}
