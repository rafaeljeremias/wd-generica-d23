unit ConsultaSimplesGenericaUnit;

interface

uses SysUtils, Types, Classes, Variants, Provider, DBClient, DB, SqlExpr,
     StdCtrls, Controls, Grids, DBGrids, ExtCtrls, Buttons,Forms,
     StrUtils, Windows, Messages, Registry, Graphics,
     ImgList, ListaCondicaoUnit, dialogs, WiseUnit,
     FMTBcd, Menus;
type
  TConsultaSimplesGenericaForm = class(TForm)
    Grid: TDBGrid;
    ValorEdit: TEdit;
    ValorLabel: TLabel;
    NovoButton: TBitBtn;
    AlteraButton: TBitBtn;
    ExcluiButton: TBitBtn;
    SairButton: TBitBtn;
    ConsultaButton: TSpeedButton;
    DSQy: TDataSource;
    Panel: TPanel;
    RetornaButton: TBitBtn;
    IBQy: TSQLQuery;
    CDSQy: TClientDataSet;
    DSProvider: TDataSetProvider;
    FiltroCDS: TClientDataSet;
    FiltroCDScd_condicao: TIntegerField;
    FiltroCDSds_condicao: TStringField;
    FiltroCDSe_ou: TStringField;
    FiltroCDSds_clausula: TStringField;
    FiltroCDSds_mostra: TStringField;
    FiltroDS: TDataSource;
    MainMenuConsulta: TMainMenu;
    PesquisarMainMenu: TMenuItem;
    OpcoesMainMenu: TMenuItem;
    OperacaoMainMenu: TMenuItem;
    OrdenarMainMenu: TMenuItem;
    FiltroMenu: TMenuItem;
    ImprimirMenu: TMenuItem;
    IniciarConsultaAbertaMenu: TMenuItem;
    N1: TMenuItem;
    salvarTextoMenu: TMenuItem;
    CDSColunas: TClientDataSet;
    CDSColunasDS_CAMPO: TStringField;
    CDSColunasNR_INDICE: TIntegerField;
    CDSColunasNR_TAMANHO: TIntegerField;
    procedure ConsultaButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SairButtonClick(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure ValorEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RetornaButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NovoButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FiltroCDSAfterInsert(DataSet: TDataSet);
    procedure FiltroCDSBeforeInsert(DataSet: TDataSet);
    procedure FiltroCDSCalcFields(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FiltroMenuClick(Sender: TObject);
    procedure ImprimirMenuClick(Sender: TObject);
    procedure IniciarConsultaAbertaMenuClick(Sender: TObject);
    procedure salvarTextoMenuClick(Sender: TObject);
  private
    Lista, ListaOrdem, ListaCondicao, ListaCondicaoFixa, LWhere, LOrder: TStringList;
    AbreQuery : Boolean;
    Chave : String;
    o,c   : integer;
    defaultCampo, defaulFiltro, defaultOrdem, defaultBusca : integer;
    defaultInverter, defaultAbre, defaultSalvaTexto : boolean;
    usuario_logado :integer;
    menu_associado : String;
    PesquisaMenu: TMenuItem;
    OperacaoMenu: TMenuItem;
    OrdemMenu: TMenuItem;

    procedure dummyPesquisaMenuClick(Sender: TObject);
    procedure dummyOrdemADMenuClick(Sender: TObject);

    function getCampoIndex:integer;
    function getOrdemSelecionado:String;
    function getOrdemIndex:Integer;
    function getOperacao:String;
    function isConsultaParcial:Boolean;
    function isOrdemInvertida:Boolean;
  public
    SQLQuery, OrderByFixa  : string;
    Retornou, fg_mensagem_empty, fg_avancar_foco : Boolean;
    InserirFiltro : Boolean;

    function MontaSQL: String;
    function getCampoSelecionado:String;
    function MontaCondicao(Campo, Valor, Tipo: String;Operador:String = '='): String;

    procedure setDatasetAberto;
    procedure SetaCampos;
    procedure SetSubConsulta(modo: boolean);
    procedure AddWhere(Condicao: String);
    procedure AddOrder(Campo: String);
    procedure ClearWhere;
    procedure ClearOrder;
    procedure ClearSQL;
    procedure AddSelecao;
    procedure AddOrdem(Texto, Campos: String; Default : Boolean = False);
    procedure AddCondicao(condicao: String; fixa: boolean = false);
    procedure ClearCondicao;
    procedure SetDefault(defaultCampo: integer = -1; defaultFiltro: integer = -1;
          defaultOrdem: integer = -1; defaultBusca: integer = -1; defaultInverter: boolean = False; defaultAbre: boolean = False; defaultSalvaTexto : boolean = false);
    procedure SetPermissao(cd_usuario: integer; menu : String; menuBloqueiaOuLibera : Char = 'B' );
    procedure Atualizar_CamposOrdem;
  end;

var
  ConsultaSimplesGenericaForm: TConsultaSimplesGenericaForm;

implementation

uses ConsultaGenericaImpressao;

{$R *.dfm}

procedure TConsultaSimplesGenericaForm.ClearCondicao;
begin
  ListaCondicao.clear;
end;

procedure TConsultaSimplesGenericaForm.AddCondicao(condicao :String; fixa: boolean = false);
begin
  if fixa then
    ListaCondicaoFixa.Add(condicao)
  else
    ListaCondicao.Add(Condicao);
end;

procedure TConsultaSimplesGenericaForm.AddOrdem(Texto, Campos :String; Default : Boolean = False);
begin
  ListaOrdem.Add(Campos);
{  with ConfiguraConsultaForm do
  begin
    OrdemComboBox.Items.Add(Texto);
    if (o <> 0) and (o = Pred(OrdemComboBox.Items.Count)) then
      OrdemComboBox.ItemIndex := Pred(ListaOrdem.Count);
    if Default then
    begin
      OrdemComboBox.Tag := Pred(ListaOrdem.Count);
      OrdemComboBox.ItemIndex := Pred(ListaOrdem.Count);
    end;
  end;}
end;

function TConsultaSimplesGenericaForm.MontaCondicao(Campo,Valor,Tipo: String; Operador:String = '=') : String;
var
  Condicao:String;
begin
  if (Trim(Campo) <> '') and (Trim(Tipo) <> '') and (Trim(Valor) <> '') then
  begin
    if Tipo = 'String' then
    begin
      if Operador = '=' then
        Operador := ' like ';
      Condicao := 'upper(' + Campo + ')' + Operador + QuotedStr(Valor);
    end;
    if Tipo = 'Integer' then
    begin
      msgInformaAbort(StrToIntDef(Valor,-1)=-1,QuotedStr(Valor)+' nao é um número inteiro válido');
      Condicao := Campo + Operador + Valor;
    end;
  end
  else
    Condicao := '';
  Result := Condicao;
end;

procedure TConsultaSimplesGenericaForm.AddSelecao;
var
  s :string;
  i : integer;
begin
  AddOrder(getOrdemSelecionado);

  // Verifica se existe algum valor para pesquisa
  if Length(Trim(ValorEdit.Text)) > 0 then
  begin
    //////////////////////////////////////////////// se for campo do tipo string
    if Separa(getCampoSelecionado, '#',2) = 'String' then
    begin
      s := '';
      // verifica se a pesquisa deve ser feita parcial ou exata
      if IsConsultaParcial then
      begin
        s := QuotedStr('%' + ValorEdit.Text + '%');
        AddWhere('upper('+Separa(getCampoSelecionado, '#',1) + ') like ' + UpperCase(s));
      end
      else
      begin
        s := QuotedStr(ValorEdit.Text);
        AddWhere('upper('+Separa(getCampoSelecionado, '#',1) + ') = ' + UpperCase(s));
      end
    end;
    //////////////////////////////////////////////// se for campo do tipo integer
    if Separa(getCampoSelecionado, '#',2) = 'Integer' then
    begin
      msgInformaAbort(StrToInt64Def(ValorEdit.text,-1)=-1,QuotedStr(ValorEdit.Text)+' não é um número inteiro válido',ValorEdit);
      AddWhere(Separa(getCampoSelecionado, '#',1) + getOperacao + ValorEdit.Text);
    end;
    //////////////////////////////////////////////// se for campo do tipo float
    if Separa(getCampoSelecionado, '#',2) = 'Float' then
    begin
      msgInformaAbort(StrToFloatDef(ValorEdit.text,-1)=-1, QuotedStr(ValorEdit.Text) +' é um conteúdo inválido para o tipo de campo selecionado!',ValorEdit);
      AddWhere(Separa(getCampoSelecionado, '#',1) + getOperacao + AnsiReplaceStr(ValorEdit.Text,',','.'));
    end;
    //////////////////////////////////////////////// se for campo do tipo datetime
    if Separa(getCampoSelecionado, '#',2) = 'DateTime' then
      try
        AddWhere(Separa(getCampoSelecionado, '#',1) + getOperacao + QuotedStr(FormatDateTime('mm/dd/yyyy hh:nn:ss', StrToDateTime(ValorEdit.Text))));
      except
        showmessage(QuotedStr(ValorEdit.Text)+' não é uma data/hora válida. Exemplo: (25/12/2003 12:20:39)');
      end;
    //////////////////////////////////////////////// se for campo do tipo time
    if Separa(getCampoSelecionado, '#',2) = 'Time' then
      try
        AddWhere(Separa(getCampoSelecionado, '#',1) + getOperacao + QuotedStr(FormatDateTime('hh:nn:ss', StrToDateTime(ValorEdit.Text))));
      except
        showmessage(QuotedStr(ValorEdit.Text)+' não é uma hora válida. Exemplo: (12:20:39)');
      end;
    //////////////////////////////////////////////// se for campo do tipo date
    if Separa(getCampoSelecionado, '#',2) = 'Date' then
      try
        AddWhere(Separa(getCampoSelecionado, '#',1) + getOperacao + QuotedStr(FormatDateTime('mm/dd/yyyy', StrToDateTime(ValorEdit.Text))));
      except
        showmessage(QuotedStr(ValorEdit.Text)+' não é uma data válida. Exemplo: (25/12/2003)');
      end;
  end;
  for i:= 0 to pred(ListaCondicao.Count) do
    AddWhere(ListaCondicao[i]);
  for i:= 0 to pred(ListaCondicaoFixa.Count) do
    AddWhere(ListaCondicaoFixa[i]);
end;

procedure TConsultaSimplesGenericaForm.ClearSQL;
begin
  ClearOrder;
  ClearWhere;
end;

procedure TConsultaSimplesGenericaForm.ClearOrder;
begin
  LOrder.Clear
end;

procedure TConsultaSimplesGenericaForm.ClearWhere;
begin
  LWhere.Clear
end;

procedure TConsultaSimplesGenericaForm.AddWhere(Condicao : String);
begin
  LWhere.Add(Condicao);
end;


procedure TConsultaSimplesGenericaForm.AddOrder(Campo: String);
begin
  LOrder.Add(Campo);
end;

function TConsultaSimplesGenericaForm.MontaSQL : String;
var
  SQL, SQLWhere, Where, Group, aux : String;
  i, pos_group : integer;
begin
  //verificar se o where tem posicao definida /*#where*/
  if Pos( '/*#WHERE*/', AnsiUpperCase( SQLQuery ) ) > 0 then
  begin
    SQL := SQLQuery;
  end
  else
  begin
    //procurar ultimo group by
    if Pos( 'GROUP', AnsiUpperCase( SQLQuery ) ) > 0 then
    begin
      pos_group := Pos( 'GROUP', AnsiUpperCase( SQLQuery ) );
      while Pos( 'GROUP', AnsiUpperCase( copy(SQLQuery, pos_group + 5, length(sqlquery)-1))) > 0 do
      begin
        pos_group := Pos( 'GROUP', AnsiUpperCase( copy(SQLQuery, pos_group + 5, length(SQLQuery)-1)));
      end;

      SQL := Copy( SQLQuery, 1, pos_group - 1 );
      group := Copy( SQLQuery, pos_group, length(sqlquery) );
    end
    else
      SQL := SQLQuery;
  end;

  SQLWhere := '';
  where := ' where ';
  if AnsiContainsText(SQL, 'where') then
    where := ' and ';
  for i:= 0 to Pred(LWhere.Count) do
  begin
    SQLWhere := SQLWhere + Where + LWhere[i];
    Where := ' and ';
  end;


  FiltroCDS.First;
  if not Filtrocds.IsEmpty then
    SQLWhere := SQLWhere + Where + '(';
  While not FiltroCDS.Eof do
  begin
    if FiltroCDScd_condicao.AsInteger = FiltroCDS.Aggregates[1].Value then
      SQLWhere := SQLWhere + FiltroCDSds_condicao.AsString
    else
      SQLWhere := SQLWhere + FiltroCDSds_clausula.AsString;
    FiltroCDS.Next;
  end;
  if not FiltroCDS.IsEmpty then
    SQLWhere := SQLWhere + ')';

  if Pos( '/*#WHERE*/', AnsiUpperCase( SQLQuery ) ) > 0 then
  begin
    SQL := AnsiReplaceStr(SQL,'/*#where*/', SQLWhere);
    SQL := AnsiReplaceStr(SQL,'/*#WHERE*/', SQLWhere);
  end
  else
  begin
    SQL := SQL + SQLWhere + Group;
  end;

  if OrdenarMainMenu.Visible then
  begin
    SQL := SQL + ' order by ';
    for i:=0 to Pred(LOrder.Count) do
    begin
      aux := LOrder[i];
      if IsOrdemInvertida then
        aux := AnsiReplaceStr(aux,',',' desc,');
      SQL := SQL + aux;
      if IsOrdemInvertida then
        SQL := SQL + ' desc';
      if i <> Pred(LOrder.Count) then
        SQL := SQL + ', ';
    end;
  end
  else
  if OrderByFixa <> '' then
    SQL := SQL + ifThen(pos('ORDER BY', UpperCase(OrderByFixa)) > 0, '', ' ORDER BY') +' '+ OrderByFixa;
  
  Result := SQL;
end;

procedure TConsultaSimplesGenericaForm.SetaCampos;
var
  i     : integer;
  Campo : String;
begin
  // Limpa Menu
  PesquisarMainMenu.Clear;
  //ConfiguraConsultaForm.OrdemComboBox.Items.Clear;
  // Cria e Limpa StringList
  Lista := TStringList.Create;
  Lista.Clear;
  ListaOrdem.Clear;
  // Percorre os campos da query
  for i := 0 to Pred(CDSQy.FieldCount) do
    if CDSQy.Fields[i].Visible then
    begin
      // Adiciona os Labels dos campos no Menu
      PesquisaMenu := TMenuItem.Create(PesquisarMainMenu);
      PesquisaMenu.RadioItem := True;
      PesquisaMenu.Caption := CDSQy.Fields[i].DisplayLabel;
      PesquisaMenu.Tag := Lista.Count;
      PesquisaMenu.Name := CDSQy.Fields[i].FieldName+'CMenu';
      PesquisaMenu.OnClick := dummyPesquisaMenuClick;
      if Lista.Count = 0  then
        PesquisaMenu.ShortCut := ShortCut(vk_f5,[]);
      if Lista.Count = 1  then
        PesquisaMenu.ShortCut := ShortCut(vk_f6,[]);
      PesquisarMainMenu.Add(PesquisaMenu);

      OrdemMenu := TMenuItem.Create(OrdenarMainMenu);
      OrdemMenu.GroupIndex := 1;
      OrdemMenu.RadioItem := True;
      OrdemMenu.Caption := CDSQy.Fields[i].DisplayLabel;
      OrdemMenu.Tag := Lista.Count;
      OrdemMenu.Name := CDSQy.Fields[i].FieldName+'OMenu';
      OrdemMenu.OnClick := dummyOrdemADMenuClick;
      OrdenarMainMenu.Add(OrdemMenu);


      if CDSQy.Fields[i].Origin = '' then
        Campo := CDSQy.Fields[i].FieldName
      else
        Campo := CDSQy.Fields[i].Origin;
      // Adiciona na string list de ordem
      ListaOrdem.Add(Campo);
      // Adiciona na string list o nome do campo e o tipo no seguinte formato: campo#tipo
      if CDSQy.Fields[i].DataType = ftString   then
        Lista.Add(Campo + '#' + 'String');
      if CDSQy.Fields[i].DataType in [ ftInteger, ftSmallint, ftLargeInt ]  then
        Lista.Add(Campo + '#' + 'Integer');
      if CDSQy.Fields[i].DataType in [ftFloat, ftFMTBcd, ftBCD] then
        Lista.Add(Campo + '#' + 'Float');
      if CDSQy.Fields[i].DataType in [ftDateTime, ftTimeStamp] then
        Lista.Add(Campo + '#' + 'DateTime');
      if CDSQy.Fields[i].DataType = ftTime then
        Lista.Add(Campo + '#' + 'Time');
      if CDSQy.Fields[i].DataType = ftDate then
        Lista.Add(Campo + '#' + 'Date');
    end;

  OrdemMenu := TMenuItem.Create(OrdenarMainMenu);
  OrdemMenu.Caption := '-';
  OrdemMenu.Tag := 1000;
  OrdemMenu.Name := 'SeparadorOrdemMenu';
  OrdenarMainMenu.Add(OrdemMenu);

  OrdemMenu := TMenuItem.Create(OrdenarMainMenu);
  OrdemMenu.GroupIndex := 2;
  OrdemMenu.RadioItem := True;
  OrdemMenu.Checked := True;
  OrdemMenu.Caption := 'Ascendente';
  OrdemMenu.Tag := 1001;
  OrdemMenu.Name := 'AscMenu';
  OrdemMenu.OnClick := dummyOrdemADMenuClick;
  OrdenarMainMenu.Add(OrdemMenu);

  OrdemMenu := TMenuItem.Create(OrdenarMainMenu);
  OrdemMenu.GroupIndex := 2;
  OrdemMenu.RadioItem := True;
  OrdemMenu.Caption := 'Descendente';
  OrdemMenu.Tag := 1002;
  OrdemMenu.Name := 'DescMenu';
  OrdemMenu.OnClick := dummyOrdemADMenuClick;
  OrdenarMainMenu.Add(OrdemMenu);
end;

procedure TConsultaSimplesGenericaForm.setDatasetAberto;
begin
  IniciarConsultaAbertaMenu.Visible := False;
  IniciarConsultaAbertaMenu.Checked := True; 
end;

procedure TConsultaSimplesGenericaForm.SetSubConsulta(modo : boolean);
begin
  AbreQuery := not modo;
  RetornaButton.Visible := modo;
end;

procedure TConsultaSimplesGenericaForm.ConsultaButtonClick(Sender: TObject);
begin
  ConsultaButton.Enabled := False;
  try
    // remover o bug da pesquisa ao clicar no botão sem sair do componente atual, não atualiza o valor informado
    if fg_avancar_foco and (Sender = ConsultaButton) and (self.Visible) then
    begin
      Perform(WM_NEXTDLGCTL, 0, 0);
      Perform(WM_NEXTDLGCTL, 1, 0);
    end;

    if not (FindComponent('Campo1Edit') <> nil) then
      ClearSQL;

    AddSelecao;
    IBQy.SQL.Clear;
    IBQy.SQL.Add(MontaSQL);
    if (IniciarConsultaAbertaMenu.Checked) or (Sender = ConsultaButton) then
    begin
      CDSQy.Close;
      CDSQy.Open;
      if ( CDSQy.IsEmpty )and fg_mensagem_empty then
        msgInformacao('Nada Encontrado com esses Parâmetros');
    end;
  finally
    ConsultaButton.Enabled := True;
  end;
end;

procedure TConsultaSimplesGenericaForm.dummyOrdemADMenuClick(Sender: TObject);
begin
  TMenuItem(Sender).Checked := true;
end;

procedure TConsultaSimplesGenericaForm.dummyPesquisaMenuClick(Sender: TObject);
begin
  // Procedure genérica para seleção do campo
  ValorLabel.Caption := ( sender as TMenuItem ).Caption;
  TMenuItem(Sender).Checked := true;
  OperacaoMainMenu.Clear;
  if Separa(getCampoSelecionado, '#',2) = 'String' then
  begin
    OperacaoMenu := TMenuItem.Create(OperacaoMainMenu);
    OperacaoMenu.GroupIndex := 1;
    OperacaoMenu.RadioItem := True;
    OperacaoMenu.Checked := True;
    OperacaoMenu.Caption := 'Parcial';
    OperacaoMenu.Tag := 1;
    OperacaoMenu.Name := 'OperacaoParcialMenu';
    OperacaoMenu.OnClick := dummyOrdemADMenuClick;
    OperacaoMainMenu.Add(OperacaoMenu);

    OperacaoMenu := TMenuItem.Create(OperacaoMainMenu);
    OperacaoMenu.GroupIndex := 1;
    OperacaoMenu.RadioItem := True;
    OperacaoMenu.Caption := 'Exata';
    OperacaoMenu.Tag := 2;
    OperacaoMenu.Name := 'OperacaoExataMenu';
    OperacaoMenu.OnClick := dummyOrdemADMenuClick;
    OperacaoMainMenu.Add(OperacaoMenu);
  end
  else
  begin
    OperacaoMenu := TMenuItem.Create(OperacaoMainMenu);
    OperacaoMenu.GroupIndex := 1;
    OperacaoMenu.RadioItem := True;
    OperacaoMenu.Checked := True;
    OperacaoMenu.Caption := '(=) Igual';
    OperacaoMenu.Tag := 2;
    OperacaoMenu.Name := 'OperacaoIgualMenu';
    OperacaoMenu.OnClick := dummyOrdemADMenuClick;
    OperacaoMainMenu.Add(OperacaoMenu);
    OperacaoMenu := TMenuItem.Create(OperacaoMainMenu);

    OperacaoMenu.GroupIndex := 1;
    OperacaoMenu.RadioItem := True;
    OperacaoMenu.Caption := '(>) Maior';
    OperacaoMenu.Tag := 2;
    OperacaoMenu.Name := 'OperacaoMaiorMenu';
    OperacaoMenu.OnClick := dummyOrdemADMenuClick;
    OperacaoMainMenu.Add(OperacaoMenu);

    OperacaoMenu := TMenuItem.Create(OperacaoMainMenu);
    OperacaoMenu.GroupIndex := 1;
    OperacaoMenu.RadioItem := True;
    OperacaoMenu.Caption := '(>=) Maior ou Igual';
    OperacaoMenu.Tag := 2;
    OperacaoMenu.Name := 'OperacaoMaiorIgualMenu';
    OperacaoMenu.OnClick := dummyOrdemADMenuClick;
    OperacaoMainMenu.Add(OperacaoMenu);

    OperacaoMenu := TMenuItem.Create(OperacaoMainMenu);
    OperacaoMenu.GroupIndex := 1;
    OperacaoMenu.RadioItem := True;
    OperacaoMenu.Caption := '(<) Menor';
    OperacaoMenu.Tag := 2;
    OperacaoMenu.Name := 'OperacaoMenorMenu';
    OperacaoMenu.OnClick := dummyOrdemADMenuClick;
    OperacaoMainMenu.Add(OperacaoMenu);

    OperacaoMenu := TMenuItem.Create(OperacaoMainMenu);
    OperacaoMenu.GroupIndex := 1;
    OperacaoMenu.RadioItem := True;
    OperacaoMenu.Caption := '(<=) Menor ou Igual';
    OperacaoMenu.Tag := 2;
    OperacaoMenu.Name := 'OperacaoMenorIgualMenu';
    OperacaoMenu.OnClick := dummyOrdemADMenuClick;
    OperacaoMainMenu.Add(OperacaoMenu);

    OperacaoMenu := TMenuItem.Create(OperacaoMainMenu);
    OperacaoMenu.GroupIndex := 1;
    OperacaoMenu.RadioItem := True;
    OperacaoMenu.Caption := '(<>) Diferente';
    OperacaoMenu.Tag := 2;
    OperacaoMenu.Name := 'OperacaoExataMenu';
    OperacaoMenu.OnClick := dummyOrdemADMenuClick;
    OperacaoMainMenu.Add(OperacaoMenu);
  end;
end;

procedure TConsultaSimplesGenericaForm.FormClose(Sender: TObject; var Action: TCloseAction);
var
  I : Integer;

begin
  // manda uma mensagem para atualizar a lista de janelas abertas
  if Application.MainForm <> nil then
  begin
    for I := 0 to Screen.FormCount - 1 do
      if Screen.Forms[I] = Self then Break;
        SendMessage(Application.MainForm.Handle, WM_USER + 1, I, 0);
  end;
        
  if AbreQuery then
    Action := caFree;
end;


procedure TConsultaSimplesGenericaForm.SairButtonClick(Sender: TObject);
begin
  close;
end;

procedure TConsultaSimplesGenericaForm.GridDblClick(Sender: TObject);
begin
  if AbreQuery then
  begin
    if (AlteraButton.Visible) and (AlteraButton.Enabled) then
      AlteraButton.Click
  end
  else
    RetornaButton.Click;
end;

procedure TConsultaSimplesGenericaForm.ValorEditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = Vk_Return) then
  begin
    ConsultaButton.Click;
    Key := 0;
  end;
end;

procedure TConsultaSimplesGenericaForm.RetornaButtonClick(Sender: TObject);
begin
  if not CDSQy.IsEmpty then Retornou := True;
  close;
end;

procedure TConsultaSimplesGenericaForm.FormShow(Sender: TObject);

begin
  // Armazena SQL que foi colcado na query para concatenar opcoes depois
  SQLQuery := IBQy.SQL.Text;
  ConsultaButton.OnClick(Self);
end;

function TConsultaSimplesGenericaForm.getCampoIndex: integer;
var
  I : integer;
begin
  Result := PesquisarMainMenu.Items[0].tag;
  for I := 0 to PesquisarMainMenu.Count - 1 do
     if PesquisarMainMenu.Items[i].Checked then
        Result := PesquisarMainMenu.Items[i].tag;
end;

function TConsultaSimplesGenericaForm.getCampoSelecionado: String;
begin
  Result := Lista[getCampoIndex];
end;

function TConsultaSimplesGenericaForm.getOperacao: String;
var
  I : integer;
begin
  for I := 0 to OperacaoMainMenu.Count - 1 do
     if OperacaoMainMenu.Items[i].Checked then
        Result := AnsiReplaceStr(AnsiReplaceStr(Separa(OperacaoMainMenu.Items[i].Caption,' ',1),'(',''),')','');
end;

function TConsultaSimplesGenericaForm.getOrdemIndex: Integer;
var
  I : integer;
begin
  Result := OrdenarMainMenu.Items[0].tag;
  for I := 0 to OrdenarMainMenu.Count - 1 do
     if (OrdenarMainMenu.Items[i].Checked)and(OrdenarMainMenu.Items[i].Tag < 1000) then
        Result := OrdenarMainMenu.Items[i].tag;
end;

function TConsultaSimplesGenericaForm.getOrdemSelecionado: String;
begin
  Result := ListaOrdem[getOrdemIndex];
end;

procedure TConsultaSimplesGenericaForm.SetDefault(defaultCampo: integer = -1; defaultFiltro: integer = -1;
          defaultOrdem: integer = -1; defaultBusca: integer = -1; defaultInverter: boolean = False; defaultAbre: boolean = False; defaultSalvaTexto : boolean = false );
begin
  self.defaultCampo := defaultCampo;
  self.defaulFiltro := defaultFiltro;
  self.defaultOrdem := defaultOrdem;
  self.defaultBusca := defaultBusca;
  self.defaultInverter := defaultInverter;
  self.defaultAbre := defaultAbre;
  IniciarConsultaAbertaMenu.Checked := defaultAbre;
  salvarTextoMenu.Checked := defaultSalvaTexto;
end;

procedure TConsultaSimplesGenericaForm.FormCreate(Sender: TObject);
var
  i : integer;

begin
  fg_avancar_foco := True;
  fg_mensagem_empty := True;
  usuario_logado := 0;
  menu_associado := '';
  OrderByFixa := '';

  defaultCampo := -1;
  defaulFiltro := -1;
  defaultOrdem := -1;
  defaultBusca := -1;
  defaultInverter := False;
  defaultAbre := False;

  InserirFiltro := False;

  o := 0;
  c := 0;

  Chave := IncludeTrailingPathDelimiter(ExtractFileName(Application.ExeName)) +  self.Name;

  IniciarConsultaAbertaMenu.Checked := LerReg(chave,'aberta',defaultAbre);
  salvarTextoMenu.Checked := LerReg(chave,'salvaTexto',defaultSalvaTexto);
  if salvarTextoMenu.Checked then
    ValorEdit.Text := LerReg(chave,'Texto','');


  //  Seta flag
  AbreQuery := True;
  // Se retornou valor para outro cadastro
  Retornou := False;

  LWhere := TStringList.Create;
  LOrder := TStringList.Create;
  ListaOrdem := TStringList.Create;
  ListaCondicao := TStringList.Create;
  ListaCondicaoFixa := TStringList.Create;

  // Chama o metodo que preenche o Menu e amazena os campos na string list
  SetaCampos;

  if LerReg(chave,'width',-1)= -1 then
    self.Position := poDesktopCenter
  else
    self.Position := poDesigned;
  self.Width := LerReg(chave,'width',self.Width);
  self.Height := LerReg(chave,'height',self.Height);
  self.Top := LerReg(chave,'top',self.Top);
  self.Left := LerReg(chave,'left',self.left);

  if self.Left < Screen.DesktopLeft then
    self.Left := Screen.DesktopLeft;
  if self.Width > Screen.DesktopWidth then
    self.Width := Screen.DesktopWidth;
  if self.Top < Screen.DesktopTop then
    self.Top := Screen.DesktopTop;
  if self.Height > Screen.DesktopHeight then
    self.Height := Screen.DesktopHeight;


  if LerReg(chave,'campo',0) <= Pred(PesquisarMainMenu.Count) then
  begin
    c := LerReg(chave,'campo',0);
    for I := 0 to PesquisarMainMenu.Count - 1 do
       if PesquisarMainMenu.Items[i].Tag = c then
          PesquisarMainMenu.Items[i].Checked := True;
    ValorLabel.Caption := PesquisarMainMenu.Items[c].Caption;
    dummyPesquisaMenuClick(PesquisarMainMenu.Items[c]);
  end;
  if LerReg(chave,'ordem',0) <= Pred(OrdenarMainMenu.Count) then
  begin
    o := LerReg(chave,'ordem',0);
    for I := 0 to OrdenarMainMenu.Count - 1 do
       if OrdenarMainMenu.Items[i].Tag = o then
          OrdenarMainMenu.Items[i].Checked := True;
  end;

  OrdenarMainMenu.Items[OrdenarMainMenu.Count-1].Checked := LerReg(chave,'inverte',False);

  if (Grid.Tag <> 99)and(dgcolumnresize in Grid.Options) then
  begin
    CDSColunas.CreateDataSet;
    CDSColunas.MergeChangeLog;
    CDSColunas.LogChanges := False;

    for i:= 0 to Pred(Grid.Columns.Count) do
    begin
      CDSColunas.Insert;
      CDSColunasNR_INDICE.AsInteger := LerReg(IncludeTrailingPathDelimiter(chave) + IncludeTrailingPathDelimiter(grid.Name) + grid.Columns[i].DisplayName, 'index', grid.Columns[i].Index);
      CDSColunasDS_CAMPO.AsString := grid.Columns[i].DisplayName;
      CDSColunasNR_TAMANHO.AsInteger := LerReg(IncludeTrailingPathDelimiter(chave) + IncludeTrailingPathDelimiter(grid.Name) + grid.Columns[i].DisplayName, 'width', grid.Columns[i].Width);
      CDSColunas.Post;
    end;

    CDSColunas.First;
    while not CDSColunas.Eof do
    begin
      i := -1;
      repeat
        i := i + 1;
      until grid.Columns[i].DisplayName = CDSColunasDS_CAMPO.AsString;

      grid.Columns[i].Width := CDSColunasNR_TAMANHO.AsInteger;
      grid.Columns[i].Index := CDSColunasNR_INDICE.AsInteger;

      CDSColunas.Next;
    end;
  end;
end;

procedure TConsultaSimplesGenericaForm.NovoButtonClick(Sender: TObject);
begin
  if ((Sender = AlteraButton)or(Sender = ExcluiButton))and(CDSQy.IsEmpty) then
  begin
    msgAlerta('Nenhum registro selecionado');
    abort;
  end;
end;

procedure TConsultaSimplesGenericaForm.FormDestroy(Sender: TObject);
begin
  LWhere.Free;
  LOrder.Free;
  ListaOrdem.Free;
  ListaCondicao.Free;
  ListaCondicaoFixa.Free;
end;

procedure TConsultaSimplesGenericaForm.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
var
  i : integer;
begin
  // Libera String List
  Lista.Free;
  // Grava no Registro as Posicoes
  GravaReg(chave,'campo',getCampoIndex);
  GravaReg(chave,'ordem',getOrdemIndex);
  GravaReg(chave,'inverte',isOrdemInvertida);
  GravaReg(chave,'aberta',IniciarConsultaAbertaMenu.Checked);
  GravaReg(chave,'salvaTexto',salvarTextoMenu.Checked);
  GravaReg(chave,'texto',ValorEdit.Text);

  if self.WindowState = wsnormal then
  begin
    GravaReg(chave,'width',self.Width);
    GravaReg(chave,'height',self.Height);
    GravaReg(chave,'top',self.Top);
    GravaReg(chave,'left',self.Left);
  end;
  if (Grid.Tag <> 99)and(dgcolumnresize in Grid.Options) then
    for i:= 0 to Pred(Grid.Columns.Count) do
    begin
      GravaReg(IncludeTrailingPathDelimiter(chave)+IncludeTrailingPathDelimiter(grid.Name)+
               grid.Columns[i].DisplayName,'width',grid.Columns[i].Width);
      GravaReg(IncludeTrailingPathDelimiter(chave)+IncludeTrailingPathDelimiter(grid.Name)+
               grid.Columns[i].DisplayName,'index',grid.Columns[i].Index);
    end;
end;

procedure TConsultaSimplesGenericaForm.GridKeyDown(Sender: TObject;  var Key: Word; Shift: TShiftState);
begin
  if (Key = Vk_Return) then
    if AbreQuery then
    begin
      if (AlteraButton.Visible) and (AlteraButton.Enabled) then
        AlteraButton.Click
    end
    else
      RetornaButton.Click;
end;

procedure TConsultaSimplesGenericaForm.ImprimirMenuClick(Sender: TObject);
begin
  if (not CDSQy.Active) or (CDSQy.IsEmpty) then
    msgAlerta('Consulte as informações que você deseja para poder imprimi-las!')
  else
  begin
    consultaGenericaImpressaoForm := TconsultaGenericaImpressaoForm.Create(Self);
    consultaGenericaImpressaoForm.ShowModal;
    consultaGenericaImpressaoForm.Free;
  end;
end;

procedure TConsultaSimplesGenericaForm.IniciarConsultaAbertaMenuClick(
  Sender: TObject);
begin
  IniciarConsultaAbertaMenu.Checked := not IniciarConsultaAbertaMenu.Checked;
end;

procedure TConsultaSimplesGenericaForm.FiltroCDSAfterInsert(
  DataSet: TDataSet);
begin
  if VarIsNull(FiltroCDS.Aggregates[1].Value) then
    FiltroCDScd_condicao.AsInteger := 1
  else
    FiltroCDScd_condicao.AsInteger := FiltroCDS.Aggregates[1].Value + 1;
  FiltroCDSe_ou.AsString := 'E';
end;

procedure TConsultaSimplesGenericaForm.FiltroCDSBeforeInsert(
  DataSet: TDataSet);
begin
  if not InserirFiltro then
    abort;
end;

procedure TConsultaSimplesGenericaForm.FiltroCDSCalcFields(
  DataSet: TDataSet);
begin
  if FiltroCDSe_ou.AsString = 'OU' then
    FiltroCDSds_clausula.AsString := FiltroCDSds_condicao.AsString + ' or '
  else
    FiltroCDSds_clausula.AsString := FiltroCDSds_condicao.AsString + ' and '
end;

procedure TConsultaSimplesGenericaForm.FiltroMenuClick(Sender: TObject);
begin
   try
    ListaCondicaoForm := TListaCondicaoForm.Create(self);
    ListaCondicaoForm.ShowModal;
  finally
    ListaCondicaoForm.Free;
  end;
  FiltroMenu.Checked := not FiltroCDS.IsEmpty;
end;

function TConsultaSimplesGenericaForm.isConsultaParcial: Boolean;
begin
  Result := OperacaoMainMenu.Items[0].Checked;
end;

function TConsultaSimplesGenericaForm.isOrdemInvertida: Boolean;
begin
  Result := OrdenarMainMenu.Items[OrdenarMainMenu.Count-1].Checked
end;

procedure TConsultaSimplesGenericaForm.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
{  if (Key = Vk_F3) then
    if (ActiveControl = ValorEdit)or (ActiveControl = Grid)  then
      ConfiguraButtonClick(Self);}

    if Key = VK_ESCAPE then
      SairButtonClick(SairButton);
end;

procedure TConsultaSimplesGenericaForm.SetPermissao(cd_usuario: integer;
  menu: String; menuBloqueiaOuLibera : Char );
var
  DS : TSQLDataSet;
  sqlMenu : String;

begin
  self.usuario_logado := cd_usuario;
  self.menu_associado := menu;
  // verificar se o usuario tem permissao nesse cadastro
  if (trim(menu_associado) <> '')and(cd_usuario <> 1) then
  begin
    sqlMenu :=  'select cast(sum(conta) as integer) as conta from '+
                '( '+
                'select cast(count(*) as integer) as conta '+
                '               from tb_usuario u '+
                '               inner join tb_usuario_menu um on(u.cd_usuario = um.cd_usuario) '+
                'where u.cd_usuario='+intToStr(usuario_logado)+' and um.nm_menu = '+QuotedStr(menu_associado)+
                ' union all '+
                'select cast(count(*) as integer) as conta '+
                '   from tb_usuario_role ur '+
                '   inner join tb_role_menu rm on (rm.cd_role = ur.cd_role) '+
                '   where ur.cd_usuario='+intToStr(usuario_logado)+' and rm.nm_menu = '+QuotedStr(menu_associado)+
                ' ) ';
    IBQy.SQLConnection.Execute(sqlMenu,nil,@DS);
    try
      if (Ds.FieldByName('conta').AsInteger > 0) then
      begin
        if menuBloqueiaOuLibera = 'B' then
        begin
          NovoButton.Enabled := False;
          AlteraButton.Enabled := False;
          ExcluiButton.Enabled := False;
        end
        else
        begin
          NovoButton.Enabled := True;
          AlteraButton.Enabled := True;
          ExcluiButton.Enabled := True;
        end;
      end;
      if (Ds.FieldByName('conta').AsInteger = 0) and (  menuBloqueiaOuLibera = 'L' )  then
      begin
        NovoButton.Enabled := False;
        AlteraButton.Enabled := False;
        ExcluiButton.Enabled := False;
      end

    finally
      DS.Free;
    end;
  end;
end;

procedure TConsultaSimplesGenericaForm.salvarTextoMenuClick(
  Sender: TObject);
begin
  salvarTextoMenu.Checked := not salvarTextoMenu.Checked;
end;

procedure TConsultaSimplesGenericaForm.Atualizar_CamposOrdem;
var
  a : integer;
  campo : String;

begin
  ListaOrdem.Clear;

  for a := 0 to Pred(CDSQy.FieldCount) do
  begin
    if CDSQy.Fields[a].Visible then
    begin
      if CDSQy.Fields[a].Origin = '' then
        Campo := CDSQy.Fields[a].FieldName
      else
        Campo := CDSQy.Fields[a].Origin;

      ListaOrdem.Add(Campo);
    end;
  end;
end;

end.
