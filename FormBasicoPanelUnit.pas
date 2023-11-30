unit FormBasicoPanelUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FormBasicoUnit, ExtCtrls, JvDBGrid, dbGrids, wiseUnit;

type
  TFormBasicoPanelForm = class(TFormBasicoForm)
    MainPanel: TPanel;
    BottomPanel: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormBasicoPanelForm: TFormBasicoPanelForm;

implementation

//uses globalUnit;

{$R *.dfm}

procedure TFormBasicoPanelForm.FormCreate(Sender: TObject);
var pos, tamanho, i, j : Integer;
    coluna : String;
    fg_mudar : Boolean;
    posicao_registro, posicao_grid, qtd_mudanca : Integer;
begin
  inherited;
  // Restaura tamanho de colunas da grid
  qtd_mudanca := 0;
  for i := 0 to Pred( ComponentCount ) do
  begin
    if ( ( ( Components[i] is TDBGrid ) or ( Components[i] is TJvDBGrid ) ) and ( Components[i].Tag = 99 ) ) then
    begin
      if ( dgcolumnresize in ( Components[i] as TDBGrid ).Options ) then
      begin
        fg_mudar := true;
        while ( fg_mudar ) and ( qtd_mudanca <= 15 ) do
        begin
          fg_mudar := false;
          for j := 0 to Pred( ( components[i] as TDBGrid ).Columns.Count) do
          begin
            coluna := getNomeForm + '\' + IncludeTrailingPathDelimiter(( Components[i] as TDBGrid ).Name)+ ( Components[i] as TDBGrid ).Columns[j].DisplayName;
            pos := LerReg(coluna,'posicao', -1 );
            if pos >= 0 then
              ( components[i] as TDBGrid ).Columns[j].Index := pos;
          end;

          for j := 0 to Pred( ( components[i] as TDBGrid ).Columns.Count) do
          begin
            coluna := getNomeForm + '\' +IncludeTrailingPathDelimiter(( Components[i] as TDBGrid ).Name)+ ( Components[i] as TDBGrid ).Columns[j].DisplayName;
            posicao_grid     := j;
            posicao_registro := LerReg(coluna,'posicao', -1 );
            if posicao_registro <> -1 then
            begin
              if posicao_registro <> posicao_grid then
                fg_mudar := true;
            end;
          end;
          inc( qtd_mudanca );
        end;

        for j := Pred(( components[i] as TDBGrid ).Columns.Count) downto 0 do
        begin
          coluna := getNomeForm + '\'+IncludeTrailingPathDelimiter(( Components[i] as TDBGrid ).Name)+ ( Components[i] as TDBGrid ).Columns[j].DisplayName;
          tamanho := LerReg(coluna,'width', -1 );
          if tamanho >= 0 then
            ( components[i] as TDBGrid ).Columns[j].Width := tamanho;
        end;
      end;
    end;
  end;

end;

procedure TFormBasicoPanelForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  pos, tamanho, i, j : integer;
  coluna : String;
begin
  inherited;
  for i := 0 to Pred( ComponentCount ) do
  begin
    if ( ( ( Components[i] is TDBGrid ) or ( Components[i] is TJvDBGrid ) ) and ( Components[i].Tag = 99 ) ) then
    begin
      if ( dgcolumnresize in ( Components[i] as TDBGrid ).Options ) then
      begin
        for j := 0 to Pred( ( Components[i] as TDBGrid ).Columns.Count ) do
        begin
          coluna := getNomeForm + '\' +IncludeTrailingPathDelimiter(( Components[i] as TDBGrid ).Name)+ ( Components[i] as TDBGrid ).Columns[j].DisplayName;
          pos := ( Components[i] as TDBGrid ).Columns[j].Index;
          tamanho := ( Components[i] as TDBGrid ).Columns[j].Width;
          GravaReg( coluna,'width', tamanho );
          GravaReg( coluna,'posicao', pos );
        end;
      end;
    end;
  end;

end;


end.
