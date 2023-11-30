unit winPrintUnit;

interface

function trocaImpressoraPadrao(pNomeNovaImpressora: string):boolean;

implementation

uses Winspool, Printers, sysUtils, windows;

function trocaImpressoraPadrao(pNomeNovaImpressora: string):boolean;
var
  W2KSDP: function(pszPrinter: PChar): Boolean; stdcall;
  H: THandle;
  Size, Dummy: Cardinal;
  PI: PPrinterInfo2;
begin
  Result:= False;
  try
    if pNomeNovaImpressora <> '' then
    begin
      if ( Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion >= 5) then
      begin
        @W2KSDP := GetProcAddress(GetModuleHandle(winspl), 'SetDefaultPrinterA');

        if (@W2KSDP <> nil)and(W2KSDP(PChar(pNomeNovaImpressora))) then
          Result:= true
        else
          RaiseLastOSError;
      end
      else
      begin
        if OpenPrinter(PChar(pNomeNovaImpressora), H, nil) then
        try
          Winspool.GetPrinter(H, 2, nil, 0, @Size);

          if GetLastError <> ERROR_INSUFFICIENT_BUFFER then
            RaiseLastOSError;

          GetMem(PI, Size) ;
          try
            if Winspool.GetPrinter(H, 2, PI, Size, @Dummy) then
            begin
              PI^.Attributes := PI^.Attributes or PRINTER_ATTRIBUTE_DEFAULT;
              if Winspool.SetPrinter(H, 2, PI, PRINTER_CONTROL_SET_STATUS) then
                Result:= True
              else
                RaiseLastOSError;
            end
            else
              RaiseLastOSError;
          finally
            FreeMem(PI) ;
          end;
        finally
          ClosePrinter(H) ;
        end
        else
          RaiseLastOSError;
      end;
    end;
  except
    raise;
  end;
end;

end.
