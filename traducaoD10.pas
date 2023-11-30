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
  SetResourceString(@SMsgDlgInformation,'Informação');
  SetResourceString(@SMsgDlgConfirm,'Confirmação');
  SetResourceString(@SMsgDlgYes,'&Sim');
  SetResourceString(@SMsgDlgNo,'&Não');
  SetResourceString(@SMsgDlgOK,'OK');
  SetResourceString(@SMsgDlgCancel,'Cancelar');
  SetResourceString(@SMsgDlgHelp,'&Ajuda');
  SetResourceString(@SMsgDlgHelpNone,'Ajuda não disponível');
  SetResourceString(@SMsgDlgHelpHelp,'Ajuda');
  SetResourceString(@SMsgDlgAbort,'&Abortar');
  SetResourceString(@SMsgDlgRetry,'&Tentar novamente');
  SetResourceString(@SMsgDlgIgnore,'&Ignorar');
  SetResourceString(@SMsgDlgAll,'&Tudo');
  SetResourceString(@SMsgDlgNoToAll,'Não para Todos');
  SetResourceString(@SMsgDlgYesToAll,'Sim para Todos');
  SetResourceString(@SMsgDlgClose,'&Fechar');

  // dbconsts
  SetResourceString(@SInvalidFieldSize,'Tamanho do campo inválido');
  SetResourceString(@SInvalidFieldKind,'Tipo de dado inválido');
  SetResourceString(@SParameterNotFound,'Parâmetro ''%s'' não encontrado');
  SetResourceString(@SDataSetClosed,'Não é possível realizar esta operção sobre um dataset fechado');
  SetResourceString(@SDataSetEmpty,'Não é possível realizar esta operção sobre um dataset vazio');
  SetResourceString(@SInvalidSqlTimeStamp,'Valores de Data/Hota inválidos no SQL');
  SetResourceString(@SDeleteRecordQuestion,'Apagar o registro?');
  SetResourceString(@SDeleteMultipleRecordsQuestion,'Apagar todos os registros selecionados?');

  SetResourceString(@SFieldValueError,'Valor inválido para o campo ''%s''');
  SetResourceString(@SFieldRequired,'Campo ''%s'' deve ter um valor');
  SetResourceString(@SFieldReadOnly,'Campo ''%s'' não pode ser alterado');
  SetResourceString(@SNotEditing,'Dataset não está em modo de edição ou inserção');
  SetResourceString(@SDataSetEmpty,'Operação inválida em um dataset fechado');
  SetResourceString(@SDataSetReadOnly,'Dataset aberto somente para leitura não pode ser modificado');
  SetResourceString(@SRecordChanged, 'Registro não encontrado ou alterado por outro usuário');
  SetResourceString(@SBcdOverflow, 'Valor Excedido');
  SetResourceString(@SCouldNotParseTimeStamp, 'Data/Hora inválida');
  SetResourceString(@SInvalidSqlTimeStamp, 'Data/Hora inválida');
  SetResourceString(@SDeleteRecordQuestion, 'Excluir registro ?');
end.
