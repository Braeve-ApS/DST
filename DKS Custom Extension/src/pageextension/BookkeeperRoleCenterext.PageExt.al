pageextension 50012 "Bookkeeper Role Center ext." extends "Bookkeeper Role Center"
{
    actions
    {
        addlast(sections)
        {
            group(DST)
            {
                Caption = 'DST';

                group(pages)
                {
                    Caption = 'Sider';

                    action("KMD Brugere")
                    {
                        Caption = 'KMD Brugere';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "KMD Brugere";
                    }
                    action("KMD Kladde")
                    {
                        Caption = 'KMD Kladde';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "KMD Kladde";
                    }
                    action("DST Kontoplan")
                    {
                        Caption = 'DST Kontoplan';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "DST Chart of Accounts Report";
                    }
                    action("DST Finansposter Rapportering")
                    {
                        Caption = 'DST Finansposter Rapportering';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page 50041;
                    }
                    action("DST Kontorækkefølge Momsrapporter")
                    {
                        Caption = 'DST Kontorækkefølge Momsrapporter';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "DST Kontorækkefølge momspappor";
                    }
                    action("DKS Tvungne Dimensioner")
                    {
                        Caption = 'DKS Tvungne Dimensioner';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Tvungne dimensioner";
                    }
                    action("Pronestor Indlæsning")
                    {
                        Caption = 'Pronestor Indlæsning';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Pronestor Indlæsning";
                    }
                    action("BS Opkrævningsoversigt")
                    {
                        Caption = 'BS Opkrævningsoversigt';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page 51028;
                    }
                    action("BS Opkrævning")
                    {
                        Caption = 'BS Opkrævning';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page 50043;
                    }
                    action("DST Opsætning")
                    {
                        Caption = 'DST Opsætning';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "DST Setup";
                    }
                    action("BankInformationer på Dokumenter")
                    {
                        Caption = 'BankInformationer på Dokumenter';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Bank information documents";
                    }
                    action("Paragraf 18+12")
                    {
                        Caption = 'Paragraf 18+12';
                        ApplicationArea = Basic, Suite;
                        RunObject = Page "Paragraf 8+12 oversigt";
                    }
                }
                group(reports)
                {
                    Caption = 'Rapporter';

                    action("DST Balance")
                    {
                        Caption = 'DST Balance';
                        ApplicationArea = Basic, Suite;
                        RunObject = Report 50015;
                    }
                    action("DST Kontospecifikationer")
                    {
                        Caption = 'DST Kontospecifikationer';
                        ApplicationArea = Basic, Suite;
                        RunObject = Report 50005;
                    }
                    action("DST Real og forventet Excel")
                    {
                        Caption = 'DST Real og forventet Excel';
                        ApplicationArea = Basic, Suite;
                        RunObject = Report 50017;
                    }
                    action("DST Real og Forventet MOMS XL")
                    {
                        Caption = 'DST Real og Forventet MOMS XL';
                        ApplicationArea = Basic, Suite;
                        RunObject = Report 50018;
                    }
                    action("DKS Børnehusene - MOMS")
                    {
                        Caption = 'DKS Børnehusene - MOMS';
                        ApplicationArea = Basic, Suite;
                        RunObject = Report 50059;
                    }
                    action("Vedligehold GDPR")
                    {
                        Caption = 'Vedligehold GDPR';
                        ApplicationArea = Basic, Suite;
                        RunObject = Report 50060;
                    }
                    action("BS Dan opkrævninger")
                    {
                        Caption = 'BS Dan opkrævninger';
                        ApplicationArea = Basic, Suite;
                        RunObject = Report 51000;
                    }
                }
                group(Codeunits)
                {
                    Caption = 'Kørsler';

                    action("Run VAT Reconcillation")
                    {
                        Caption = 'Run VAT Reconcillation';
                        ApplicationArea = Basic, Suite;
                        RunObject = Codeunit 50001;
                    }
                    action("Bogfør opkrævninger")
                    {
                        Caption = 'Bogfør opkrævninger';
                        ApplicationArea = Basic, Suite;
                        RunObject = Codeunit 51030;
                    }
                    group(XMLPorts)
                    {
                        Caption = 'XML Porte';

                        action("Import KMD Løn")
                        {
                            Caption = 'Import KMD Løn';
                            ApplicationArea = Basic, Suite;
                            RunObject = XMLport 50001;
                        }
                    }
                }
            }
        }
        addafter(RecurringGeneralJournals)
        {
            action(Report)
            {
                ApplicationArea = All;
                Caption = 'DST Reports';
                RunObject = Page "cor Show Custom Reports";
            }
        }
    }
}
