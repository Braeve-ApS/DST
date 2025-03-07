Codeunit 51049 "Om BetalingsService"
{
    // // BetalingsService -------------------------------------- >>
    // // ˆ Copyright 1997, 2001 Hands A/S
    Permissions = TableData Customer=rimd,
        TableData "Cust. Ledger Entry"=rimd;

    trigger OnRun()
    begin
        Message('BetalingsService til Navision Financials\' + 'Copyright 1997, 2004 - Columbus IT Partner A/S\\' + 'Columbus IT Partner A/S\' + 'Banemarksvej 50 C, 2605 Br¢ndby\' + 'Tlf.: 7010 0809 - Fax : 7010 0810\\' + 'Web : http://dk.columbusit.com\' + '. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .\\' + 'Kontaktperson hos PBS :\' + 'Service & Aftaler\' + 'Telefon : 44 89 26 50\' + 'Vores PBS Nr. : 01743686\' + '. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .\\' + 'Version BS2.60.05 (DK2.60.G) Build 00\\' + 'Licenshaver :\' + 'Diakonissestiftelsen\' + 'Peter Bangsvej 1\' + '2000 Frederiksberg');
    end;
    var "-- Procentbar --": Integer;
    Window: Dialog;
    Starttidspunkt: Time;
    Overskrift: Text[220];
    "Totalmængde": Integer;
    Counter: Integer;
    ControlledCounter: Integer;
    AntalOpdateringer: Integer;
    Medtagestimat: Boolean;
    "Estimer Aldrig": Boolean;
    SidsteEstimering: Time;
    procedure Open("Beskrivende tekst": Text[220]; "Antal records i alt": Integer)
    var
        "F¢rste linie": Text[250];
    begin
        // Globalisering af parametre
        Starttidspunkt:=Time;
        Totalmængde:="Antal records i alt";
        Overskrift:="Beskrivende tekst";
        // Initiering
        Medtagestimat:=false;
        "Estimer Aldrig":=false;
        Clear(AntalOpdateringer);
        Clear(Counter);
        SidsteEstimering:=000000.001T;
        // Procentbjælken åbnes. I f¢rste omgang kun med en simpel bjælke
        Window.Open(Overskrift + '\\' + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
    end;
    procedure Update()
    var
        "Færdig kl.": Time;
        "Tid tilbage": Time;
    begin
        if ControlledCounter = 0 then Counter:=Counter + 1
        else
        begin
            Counter:=ControlledCounter;
            ControlledCounter:=0;
        end;
        // Hvis der efter 5 sekunder er afviklet mindre end 5% udvides procentbjælken med estimering.
        if not Medtagestimat and not "Estimer Aldrig" then if Time - Starttidspunkt > 5000 then if ROUND(Counter / Totalmængde * 100) < 5 then begin
                    Window.Close;
                    Window.Open(Overskrift + '\\' + '@1@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\\' + 'Igangsat kl. #10#####  Færdig kl.     #12####\' + 'Forbrugt tid #11#####  Resterende tid #13####');
                    Medtagestimat:=true;
                    Window.Update(1, ROUND(Counter / Totalmængde * 10000, 1));
                    Window.Update(10, Starttidspunkt);
                    Window.Update(11, 'Måler !');
                    Window.Update(12, 'Måler !');
                    Window.Update(13, 'Måler !');
                end
                else
                    "Estimer Aldrig":=true;
        // Opdater procentbjælke 1 gang pr. ½ procents afvikling
        if Counter MOD ROUND(Totalmængde / 200, 1, '>') = 0 then begin
            AntalOpdateringer:=AntalOpdateringer + 1;
            Window.Update(1, ROUND(Counter / Totalmængde * 10000, 1));
            if Medtagestimat then // Opdater estimering 1 gang pr 2 procents afvikling eller mindst hver 5. sekund
 if(AntalOpdateringer MOD 4 = 0) or (Time - SidsteEstimering > 5000)then begin
                    Tidsestimat(Starttidspunkt, ROUND(Counter / Totalmængde * 100), "Færdig kl.", "Tid tilbage");
                    Window.Update(11, 000000.001T + (Time - Starttidspunkt));
                    Window.Update(12, "Færdig kl.");
                    Window.Update(13, "Tid tilbage");
                    SidsteEstimering:=Time;
                end;
        end;
    end;
    procedure Close()
    begin
        Window.Close;
    end;
    procedure "Set Counter"(_Counter: Integer)
    begin
        ControlledCounter:=_Counter;
    end;
    local procedure Tidsestimat(Starttid: Time; "Færdig": Decimal; var "Est. sluttidspunkt": Time; var "Est. resttid": Time)
    var
        Forbrugt: Integer;
        Resttid: Integer;
    begin
        if Færdig = 0 then exit;
        Clear("Est. sluttidspunkt");
        Clear("Est. resttid");
        if Starttid < Time then Forbrugt:=Time - Starttid
        else
            Forbrugt:=86400000 - Abs(Time - Starttid); // Hvis midnat passeres. (86400000 = 24T i ms)
        Resttid:=(ROUND(Forbrugt / Færdig) * 100) - Forbrugt;
        "Est. sluttidspunkt":=Time + Resttid;
        "Est. resttid":=000000.001T + Resttid;
    end;
    procedure "-- DIA ---------------"()
    begin
    end;
    procedure "OpdaterK¢kkenBS"()
    var
        Debitor: Record Customer;
        DebitorPost: Record "Cust. Ledger Entry";
        DebOpdateret: Integer;
        DebPostOpdateret: Integer;
    begin
    // if not Confirm('Aktiver BetalingsService for alle K¢kken Debitorer ?',false) then
    //   exit;
    // Debitor.Reset;
    // if Debitor.Find('-') then begin
    //   repeat
    //     if not Debitor."Køkken Undlad BS automatik" then begin
    //       if Debitor."Køkken BS Kunde" then begin
    //         if not Debitor."Anvender BetalingsService" then begin
    //           Debitor."Anvender BetalingsService" := true;
    //           Debitor.Modify;
    //           DebOpdateret += 1;
    //         end;
    //         DebitorPost.Reset;
    //         DebitorPost.SetCurrentkey("Customer No.",Open,Positive,"Due Date","Currency Code");
    //         DebitorPost.SetRange("Customer No.",Debitor."No.");
    //         DebitorPost.SetRange(Open,true);
    //         DebitorPost.SetRange(Positive,true);
    //         DebitorPost.SetRange("Aut. BS-Opkrævning",false);
    //         DebPostOpdateret += DebitorPost.Count;
    //         DebitorPost.ModifyAll("Aut. BS-Opkrævning",true);
    //       end;
    //     end;
    //   until Debitor.Next = 0;
    // end;
    // if (DebOpdateret <> 0) or (DebPostOpdateret <> 0) then
    //   Message('%1 Debitorer og %2 Debitorposter blev opdateret !',DebOpdateret,DebPostOpdateret);
    end;
}
