unit Classe.Helper;

interface

Uses StdCtrls, SysUtils;

type
  TEditHelper = class helper for TEdit
    function IsEmpty: boolean;
  end;

implementation

{ TEditHelper }

function TEditHelper.IsEmpty: boolean;
begin
  result := Trim(Self.Text) = EmptyStr;
end;

end.
