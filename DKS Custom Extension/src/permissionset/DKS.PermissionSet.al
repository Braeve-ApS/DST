permissionset 50000 DKS
{
    Assignable = true;
    Permissions = tabledata "Bank Information documents" = RIMD,
        tabledata "BS-Betalingsaftale" = RIMD,
        tabledata "BS-Opkrævningshoved" = RIMD,
        tabledata "BS-Opkrævningslinie" = RIMD,
        tabledata "BS-Specifikation" = RIMD,
        tabledata "BS-Specifkationstekst" = RIMD,
        tabledata "BS-Stamoplysninger" = RIMD,
        tabledata "Buffer for reporting totals" = RIMD,
        tabledata "DKS Dimension enforcement" = RIMD,
        tabledata "DKS G/L Account Rapportering" = RIMD,
        tabledata "DKS G/L Entry Rapportering" = RIMD,
        tabledata "DKS Kontorækker momsbalancer" = RIMD,
        tabledata "DST Setup" = RIMD,
        tabledata "G/L Budget Entry Import Buffer" = RIMD,
        tabledata "KMD Bruger" = RIMD,
        tabledata "KMD Kladde" = RIMD,
        tabledata "Paragraf 8+12 indberetning" = RIMD,
        tabledata "Pronestor indlæsning" = RIMD,
        tabledata "VAT Reconcillation" = RIMD,
        tabledata "cor Custom Report List" = RIMD,
        table "Bank Information documents" = X,
        table "BS-Betalingsaftale" = X,
        table "BS-Opkrævningshoved" = X,
        table "BS-Opkrævningslinie" = X,
        table "BS-Specifikation" = X,
        table "BS-Specifkationstekst" = X,
        table "BS-Stamoplysninger" = X,
        table "Buffer for reporting totals" = X,
        table "DKS Dimension enforcement" = X,
        table "DKS G/L Account Rapportering" = X,
        table "DKS G/L Entry Rapportering" = X,
        table "DKS Kontorækker momsbalancer" = X,
        table "DST Setup" = X,
        table "G/L Budget Entry Import Buffer" = X,
        table "KMD Bruger" = X,
        table "KMD Kladde" = X,
        table "Paragraf 8+12 indberetning" = X,
        table "Pronestor indlæsning" = X,
        table "VAT Reconcillation" = X,
        report "BS Dan Opkrævninger" = X,
        report "BS Dan Ref. Opkrævninger" = X,
        report "DKS Børnehusene - MOMS" = X,
        report "DST Real / forventet - MOMS XL" = X,
        report "DST Real og forventet Excel" = X,
        report "DST Trial Balance" = X,
        report "DST_Detail Trial Balance" = X,
        report "DST_General Journal - Test" = X,
        report "Maintain Cust for GDPR" = X,
        report "Pronestor Indlæsning" = X,
        report "Sales - Credit Memo PI" = X,
        report "Sales - Invoice PI" = X,
        report "Skatteindberetning 8+12" = X,
        codeunit "DKS Check Tvungen Dimension" = X,
        codeunit "DKS GL Reporting Functions" = X,
        codeunit "DKS Korr. Dimensionsværdi" = X,
        codeunit "DST Events" = X,
        codeunit "Run Vat Recocillation" = X,
        xmlport "Import Budget Entries" = X,
        xmlport "Import KMD Løn" = X,
        xmlport "Import Pronestor" = X,
        xmlport "Import Budget Entries2" = X,
        page "Bank information documents" = X,
        page "BS Bogf. Opkrævninger" = X,
        page "BS Opkrævning" = X,
        page "BS OpkrævningsLinier" = X,
        page "DST Chart of Accounts Report" = X,
        page "DST Finansposter-rapportering" = X,
        page "DST Setup" = X,
        page "G/L Budget Entry Import" = X,
        page "KMD Brugere" = X,
        page "KMD Kladde" = X,
        page "Paragraf 8+12 kunder" = X,
        page "Paragraf 8+12 oversigt" = X,
        page "Paragraf 8+12 varer" = X,
        page "Pronestor Indlæsning" = X,
        page "Tvungne dimensioner" = X,
        page "VAT Reconcillation" = X,
        tabledata "BS-Indbetalingslinie" = RIMD,
        table "BS-Indbetalingslinie" = X,
        table "cor Custom Report List" = X,
        codeunit "Bogfør Opkrævninger" = X,
        codeunit "cor Insert Custom Reports" = X,
        codeunit DKSFunctions = X,
        codeunit "Update Document capture Setup" = X,
        codeunit "Update Expense Mgt. Setup" = X,
        page "BS Betalingsaftale" = X,
        page "BS Bogf. Opkrævningsoversigt" = X,
        page "BS Bogførte indbetalinger" = X,
        page "BS Opkrævninger" = X,
        page "BS Opkrævningsoversigt" = X,
        page "BS Specifikation" = X,
        page "BS Specifikationstekst" = X,
        page "cor Show Custom Reports" = X,
        page "DST Kontorækkefølge momspappor" = X,
        page "Korr. dimension på finanspost" = X,
        tabledata "BS-Ajourføringslinie" = RIMD,
        tabledata "BS-Betalingsaftalepost" = RIMD,
        tabledata "BS-Transmission" = RIMD,
        tabledata "BS-Transmissionsdata" = RIMD,
        table "BS-Ajourføringslinie" = X,
        table "BS-Betalingsaftalepost" = X,
        table "BS-Transmission" = X,
        table "BS-Transmissionsdata" = X,
        codeunit "Ajourføring - Aftaleophør" = X,
        codeunit "Ajourføring - Automatisk" = X,
        codeunit "Ajourføring - Ny aftale" = X,
        codeunit "Om BetalingsService" = X,
        page "BS Betalingsaftaleposter" = X;
}
