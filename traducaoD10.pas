unit traducaoD10;

interface

uses Windows, Consts, dbconsts;

  procedure SetResourceString(AResString: PResStringRec; ANewValue: PChar);

implementation

procedure SetResourceString(AResString: PResStringRec; ANewValue: PChar);
var
  POldProtect: DWORD;
begin
  VirtualProtect(AResString, SizeOf(AResString^), PAGE_EXECUTE_READWRITE, @POldProtect);
  AResString^.Identifier := Integer(ANewValue);
  VirtualProtect(AResString, SizeOf(AResString^), POldProtect, @POldProtect);
end;

initialization
  // consts
  SetResourceString(@SOpenFileTitle,'Abrir');
  SetResourceString(@SMsgDlgWarning,'Aviso');
  SetResourceString(@SMsgDlgError,'Erro');
  SetResourceString(@SMsgDlgInformation,'Informa��o');
  SetResourceString(@SMsgDlgConfirm,'Confirma��o');
  SetResourceString(@SMsgDlgYes,'&Sim');
  SetResourceString(@SMsgDlgNo,'&N�o');
  SetResourceString(@SMsgDlgOK,'OK');
  SetResourceString(@SMsgDlgCancel,'Cancelar');
  SetResourceString(@SMsgDlgHelp,'&Ajuda');
  SetResourceString(@SMsgDlgHelpNone,'Ajuda n�o dispon�vel');
  SetResourceString(@SMsgDlgHelpHelp,'Ajuda');
  SetResourceString(@SMsgDlgAbort,'&Abortar');
  SetResourceString(@SMsgDlgRetry,'&Tentar novamente');
  SetResourceString(@SMsgDlgIgnore,'&Ignorar');
  SetResourceString(@SMsgDlgAll,'&Tudo');
  SetResourceString(@SMsgDlgNoToAll,'N�o para Todos');
  SetResourceString(@SMsgDlgYesToAll,'Sim para Todos');
  SetResourceString(@SMsgDlgClose,'&Fechar');

  // dbconsts
  SetResourceString(@SInvalidFieldSize,'Tamanho do campo inv�lido');
  SetResourceString(@SInvalidFieldKind,'Tipo de dado inv�lido');
  SetResourceString(@SParameterNotFound,'Par�metro ''%s'' n�o encontrado');
  SetResourceString(@SDataSetClosed,'N�o � poss�vel realizar esta oper��o sobre um dataset fechado');
  SetResourceString(@SDataSetEmpty,'N�o � poss�vel realizar esta oper��o sobre um dataset vazio');
  SetResourceString(@SInvalidSqlTimeStamp,'Valores de Data/Hota inv�lidos no SQL');
  SetResourceString(@SDeleteRecordQuestion,'Apagar o registro?');
  SetResourceString(@SDeleteMultipleRecordsQuestion,'Apagar todos os registros selecionados?');

  SetResourceString(@SFieldValueError,'Valor inv�lido para o campo ''%s''');
  SetResourceString(@SFieldRequired,'Campo ''%s'' deve ter um valor');
  SetResourceString(@SFieldReadOnly,'Campo ''%s'' n�o pode ser alterado');
  SetResourceString(@SNotEditing,'Dataset n�o est� em modo de edi��o ou inser��o');
  SetResourceString(@SDataSetEmpty,'Opera��o inv�lida em um dataset fechado');
  SetResourceString(@SDataSetReadOnly,'Dataset aberto somente para leitura n�o pode ser modificado');
  SetResourceString(@SRecordChanged, 'Registro n�o encontrado ou alterado por outro usu�rio');
  SetResourceString(@SBcdOverflow, 'Valor Excedido');
  SetResourceString(@SCouldNotParseTimeStamp, 'Data/Hora inv�lida');
  SetResourceString(@SInvalidSqlTimeStamp, 'Data/Hora inv�lida');
  SetResourceString(@SDeleteRecordQuestion, 'Excluir registro ?');
end.
