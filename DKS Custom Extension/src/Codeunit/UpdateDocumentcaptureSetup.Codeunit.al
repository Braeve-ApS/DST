codeunit 50003 "Update Document capture Setup"
{
    trigger OnRun()
    begin
        if CDCDocumentCaptureSetup.FindFirst()then begin
            CDCDocumentCaptureSetup."Data Version":=240000;
            CDCDocumentCaptureSetup.Modify();
        end end;
    var CDCDocumentCaptureSetup: Record "CDC Document Capture Setup";
}
