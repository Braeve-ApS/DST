Report 50060 "Maintain Cust for GDPR"
{
    // COR/001/210420/Jim : Avoid changing brand new customers
    Permissions = TableData "Sales Invoice Header"=rm,
        TableData "Sales Cr.Memo Header"=rm;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            column(ReportForNavId_1160810000;1160810000)
            {
            }
            trigger OnAfterGetRecord()
            begin
                w.Update(1, Customer.Name);
                //COR/001>>
                if IsBrandNew then begin
                    Counter[1]+=1;
                    CurrReport.Skip;
                end;
                //Cor/001<<
                if HasSalesDocs then begin
                    Counter[1]+=1;
                    CurrReport.Skip;
                end;
                if ActiveWithin3Years then begin
                    Counter[1]+=1;
                    CurrReport.Skip;
                end;
                if HasEntriesAtAll then begin
                    GDPRModify(Customer);
                    Counter[2]+=1;
                end
                else
                begin
                    DeleteCust(Customer);
                    Counter[3]+=1;
                end;
                ModifyOldInvoices;
                ModifyOldCreditMemos;
            end;
            trigger OnPostDataItem()
            begin
                w.Close;
                Message('%1 debitorer blev skippet.\' + '%2 debitorer blev modificeret.\' + '%3 debitorer blev slettet!', Counter[1], Counter[2], Counter[3]);
            end;
            trigger OnPreDataItem()
            begin
                w.Open('Nu behandles: #1##########################');
            end;
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
    labels
    {
    }
    var w: Dialog;
    Counter: array[3]of Integer;
    procedure HasEntriesAtAll()HasEntriesAtAll: Boolean var
        CLE: Record "Cust. Ledger Entry";
    begin
        CLE.SetCurrentkey("Customer No.", "Posting Date", "Currency Code");
        CLE.SetRange(CLE."Customer No.", Customer."No.");
        if not CLE.IsEmpty then exit(true);
    end;
    procedure HasSalesDocs()HasSalesDocs: Boolean var
        SalesHeader: Record "Sales Header";
    begin
        SalesHeader.SetRange(SalesHeader."Document Type", 1, 3);
        SalesHeader.SetRange(SalesHeader."Sell-to Customer No.", Customer."No.");
        if not SalesHeader.IsEmpty then exit(true);
    end;
    procedure ActiveWithin3Years()ActiveWithin3Years: Boolean var
        CLE: Record "Cust. Ledger Entry";
    begin
        CLE.SetCurrentkey("Customer No.", "Posting Date", "Currency Code");
        CLE.SetRange(CLE."Customer No.", Customer."No.");
        CLE.SetRange(CLE."Posting Date", CalcDate('<-CY-5Y-1D>', Today), Today);
        if not CLE.IsEmpty then exit(true);
    end;
    procedure DeleteCust(Customer: Record Customer)
    var
        Cust2: Record Customer;
    begin
        Cust2.Get(Customer."No.");
        if Cust2.Delete(true)then;
    end;
    procedure GDPRModify(var Customer: Record Customer)
    begin
        Customer.Name:='GDPR';
        Customer."Search Name":='GDPR';
        Customer."Name 2":='GDPR';
        Customer.City:='GDPR';
        Customer."Phone No.":='GDPR';
        Customer."Post Code":='GDPR';
        Customer."E-Mail":='GDPR';
        Customer.Modify;
    end;
    local procedure ModifyOldInvoices()
    var
        SalesInvoiceHeader: Record "Sales Invoice Header";
        Lastdate: Date;
        i: Integer;
    begin
        SalesInvoiceHeader.SetCurrentkey("Bill-to Customer No.");
        SalesInvoiceHeader.SetRange(SalesInvoiceHeader."Bill-to Customer No.", Customer."No.");
        Lastdate:=CalcDate('<-CY-5Y-1D>', Today);
        SalesInvoiceHeader.SetRange(SalesInvoiceHeader."Posting Date", 20800101D, Lastdate);
        if SalesInvoiceHeader.FindSet then repeat SalesInvoiceHeader."Bill-to Name":='GDPR';
                SalesInvoiceHeader."Bill-to Name 2":='GDPR';
                SalesInvoiceHeader."Bill-to Address":='GDPR';
                SalesInvoiceHeader."Bill-to Address 2":='GDPR';
                SalesInvoiceHeader."Bill-to City":='GDPR';
                SalesInvoiceHeader."Bill-to Contact":='GDPR';
                SalesInvoiceHeader."Bill-to Post Code":='GDPR';
                SalesInvoiceHeader.Modify;
            until SalesInvoiceHeader.Next = 0;
    end;
    local procedure ModifyOldCreditMemos()
    var
        SalesCrMemoHeader: Record "Sales Cr.Memo Header";
        i: Integer;
        Lastdate: Date;
    begin
        SalesCrMemoHeader.SetCurrentkey("Bill-to Customer No.");
        SalesCrMemoHeader.SetRange(SalesCrMemoHeader."Bill-to Customer No.", Customer."No.");
        Lastdate:=CalcDate('<-CY-5Y-1D>', Today);
        SalesCrMemoHeader.SetRange(SalesCrMemoHeader."Posting Date", 20800101D, Lastdate);
        i:=SalesCrMemoHeader.Count;
        if SalesCrMemoHeader.FindSet then repeat SalesCrMemoHeader."Bill-to Name":='GDPR';
                SalesCrMemoHeader."Bill-to Name 2":='GDPR';
                SalesCrMemoHeader."Bill-to Address":='GDPR';
                SalesCrMemoHeader."Bill-to Address 2":='GDPR';
                SalesCrMemoHeader."Bill-to City":='GDPR';
                SalesCrMemoHeader."Bill-to Contact":='GDPR';
                SalesCrMemoHeader."Bill-to Post Code":='GDPR';
                SalesCrMemoHeader.Modify;
            until SalesCrMemoHeader.Next = 0;
    end;
    local procedure IsBrandNew()IsBrandNew: Boolean var
        i: Decimal;
    begin
        //COR/001>>
        i:=Today - Customer."Last Date Modified";
        if i <= 60 then exit(true);
    //COR/001<<
    end;
}
