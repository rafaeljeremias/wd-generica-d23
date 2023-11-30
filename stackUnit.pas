unit StackUnit;

interface

type
  TPrvok = string;
  TStack = class
    st:array of TPrvok;
    constructor Create;
    procedure push(const p:TPrvok);
    procedure pop(var p:TPrvok);
    function top:TPrvok;
    function empty:boolean;
  end;

implementation

uses
  Dialogs;

procedure chyba(const s:string);
begin
  ShowMessage(s); halt;
end;

constructor TStack.Create;
begin
  st:=nil;
end;

procedure TStack.push(const p:TPrvok);
begin
  SetLength(st,Length(st)+1); st[High(st)]:=p;
end;

procedure TStack.pop(var p:TPrvok);
begin
  if empty then chyba('Pilha Vazia');
  p:=st[High(st)]; SetLength(st,Length(st)-1);
end;

function TStack.top:TPrvok;
begin
  if empty then chyba('Pilha Vazia');
  Result:=st[High(st)];
end;

function TStack.empty:boolean;
begin
  Result:=Length(st)=0;   // alebo Result:=st=nil;
end;

end.

