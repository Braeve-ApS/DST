Report 50001 "Skatteindberetning 8+12"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", Description;

            column(ReportForNavId_1000000000;1000000000)
            {
            }
            dataitem("Item Ledger Entry"; "Item Ledger Entry")
            {
                DataItemLink = "Item No."=field("No.");
                DataItemTableView = sorting("Item No.");
                RequestFilterFields = "Posting Date";

                column(ReportForNavId_1000000001;1000000001)
                {
                }
                trigger OnAfterGetRecord()
                var
                    "Cust. Ledger Entry": Record "Cust. Ledger Entry";
                begin
                    "Item Ledger Entry".CalcFields("Item Ledger Entry"."Sales Amount (Actual)");
                    AMTTotal:=0;
                    if Customer.Get("Item Ledger Entry"."Source No.")then begin
                        if not lCustomerTemp.Get(Customer."No.")then begin
                            Customer.TestField("Social Security No.");
                            lCustomerTemp.Init;
                            lCustomerTemp:=Customer;
                            lCustomerTemp.Insert;
                        end;
                        Clear("Cust. Ledger Entry");
                        "Cust. Ledger Entry".SetCurrentkey("Customer No.");
                        "Cust. Ledger Entry".SetRange("Customer No.", Customer."No.");
                        "Cust. Ledger Entry".SetRange("Posting Date", "Item Ledger Entry"."Posting Date");
                        "Cust. Ledger Entry".SetRange("Document No.", "Item Ledger Entry"."Document No.");
                        "Cust. Ledger Entry".SetRange(Open, false);
                        if "Cust. Ledger Entry".Find('-')then begin
                            if 'ã 8' = CopyStr(Item.Description, 1, 3)then begin
                                lCustomerTemp."Credit Limit (LCY)"+="Item Ledger Entry"."Sales Amount (Actual)";
                                lCustomerTemp.Modify;
                            end;
                            if 'ã 12' = CopyStr(Item.Description, 1, 4)then begin
                                lCustomerTemp."Budgeted Amount"+="Item Ledger Entry"."Sales Amount (Actual)";
                                lCustomerTemp.Modify;
                            end;
                            //  AMTTotal := Item Ledger Entry"."Sales Amount (Actual)";
                            gYear:=Format(Date2dwy("Cust. Ledger Entry"."Posting Date", 3));
                        end;
                    end;
                    SalesAmount+="Item Ledger Entry"."Sales Amount (Actual)";
                end;
                trigger OnPostDataItem()
                begin
                    Paragraf812.Init;
                    Paragraf812.Type:=Paragraf812.Type::Item;
                    Paragraf812.Nummer:=Item."No.";
                    Paragraf812.Navn:=Item.Description;
                    Paragraf812.Salesamount:=SalesAmount;
                    Paragraf812."Date Filter":=DateFilterTxt;
                    Paragraf812.Insert;
                end;
                trigger OnPreDataItem()
                begin
                    "Item Ledger Entry".SetRange("Source Type", "Item Ledger Entry"."source type"::Customer);
                end;
            }
            trigger OnAfterGetRecord()
            begin
                Clear(SalesAmount);
            end;
            trigger OnPostDataItem()
            begin
                if lCustomerTemp.FindFirst then repeat Paragraf812.Init;
                        Paragraf812.Type:=Paragraf812.Type::Customer;
                        Paragraf812.Nummer:=lCustomerTemp."No.";
                        Paragraf812.Navn:=lCustomerTemp.Name;
                        Paragraf812."Cpr-Nr":=lCustomerTemp."Social Security No.";
                        Paragraf812."Paragraf 8":=lCustomerTemp."Credit Limit (LCY)";
                        Paragraf812."Paragraf 12":=lCustomerTemp."Budgeted Amount";
                        Paragraf812."Date Filter":=DateFilterTxt;
                        Paragraf812.Insert;
                    until lCustomerTemp.Next = 0;
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
    trigger OnPreReport()
    begin
        Paragraf812.DeleteAll;
        DateFilterTxt:="Item Ledger Entry".GetFilter("Item Ledger Entry"."Posting Date");
    end;
    var lCustomerTemp: Record Customer temporary;
    Customer: Record Customer;
    AMT8: Decimal;
    AMT12: Decimal;
    AMTTotal: Decimal;
    Filename: Text[250];
    gFile: File;
    gYear: Text[4];
    SalesAmount: Decimal;
    Paragraf812: Record "Paragraf 8+12 indberetning";
    DateFilterTxt: Text;
}
