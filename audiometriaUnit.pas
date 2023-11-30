unit audiometriaUnit;


interface

uses
  SysUtils, Variants, Classes, Graphics, ExtCtrls, Types;

procedure desenhaGridOrelhaDireita( imagem : TImage; cor : boolean = true; fundoColorido : boolean = true );
procedure desenhaGridOrelhaEsquerda( imagem : TImage; cor : boolean = true; fundoColorido : boolean = true  );
procedure desenhaOssea( o0_25, o0_5, o1, o2, o3, o4 : Variant; mascaraO0_25, mascaraO0_5, mascaraO1, mascaraO2, mascaraO3, mascaraO4 : String; orelha : Char; cor : TColor; imagem : TImage );
procedure desenhaAerea( a0_25, a0_5, a1, a2, a3, a4, a6, a8 : Variant; mascaraA0_25, mascaraA0_5, mascaraA1, mascaraA2, mascaraA3, mascaraA4, mascaraA6, mascaraA8 : String; orelha : Char; cor : TColor; imagem : TImage );

implementation

//const auzente = 285;

procedure desenhaPontoAereaMascarada(x,y: integer; orelha: Char; cor: TColor ; imagem : TImage);
var w : integer;
    c, b : TColor;
begin
  w := imagem.canvas.pen.Width;
  c := imagem.canvas.Pen.Color;
  b := imagem.canvas.Brush.Color;
  imagem.canvas.Brush.Color := clWhite;
  imagem.canvas.Pen.Width := 2;
  if orelha = 'D' then
  begin
    y := y + 9;
    imagem.canvas.Pen.Color := clWhite;
    imagem.canvas.Ellipse( x, y - 7, x + 10, y + 2 );
    imagem.canvas.Pen.Color := cor;
    imagem.canvas.MoveTo( x, y );
    imagem.canvas.LineTo( x + 10, y );
    imagem.canvas.LineTo( x + 5, y - 10 );
    imagem.canvas.LineTo( x, y );
  end
  else
  begin
    x := x - 11;
    y := y + 1;
    imagem.canvas.Pen.Color := clWhite;
    //imagem.canvas.Ellipse( x, y, x + 10, y + 8 );
    imagem.canvas.Pen.Color := cor;
    imagem.canvas.Rectangle(x,y,x+10,y+10);
    {imagem.canvas.MoveTo( x, y );
    imagem.canvas.LineTo( x + 10, y );
    imagem.canvas.LineTo( x + 5, y + 10 );
    imagem.canvas.LineTo( x, y );}
  end;
  imagem.canvas.pen.Width   := w;
  imagem.canvas.Pen.Color   := c;
  imagem.canvas.Brush.Color := b;
end;




procedure desenhaLinha(x1, y1, x2, y2 : Integer; orelha: Char; cor: TColor; imagem : TImage);
var w : integer;
    c : TColor;
    ajusteX, ajusteY : Integer;
begin
  w := imagem.canvas.pen.Width;
  c := imagem.canvas.Pen.Color;
  imagem.canvas.Pen.Color := cor;

  if orelha = 'E' then
  begin
    imagem.canvas.Pen.Width := 1;
    imagem.canvas.Pen.Style := psDot;
    ajusteX := -3;
    ajusteY := 1;
  end
  else
  begin
    ajusteX := 2;
    ajusteY := 0;
    imagem.canvas.Pen.Width := 2;
  end;
  imagem.canvas.MoveTo( x1 + ajusteX, y1 + 5 - ajusteY );
  imagem.canvas.LineTo( x2 + ajusteX, y2 + 5 - ajusteY );
  if orelha = 'E' then
  begin
    imagem.canvas.MoveTo( x1 + ajusteX + 1, y1 + 5 - ajusteY );
    imagem.canvas.LineTo( x2 + ajusteX + 1, y2 + 5 - ajusteY );
    imagem.canvas.MoveTo( x1 + ajusteX, y1 + 6 - ajusteY );
    imagem.canvas.LineTo( x2 + ajusteX, y2 + 6 - ajusteY );
  end;
  imagem.canvas.pen.Width   := w;
  imagem.canvas.Pen.Color   := c;
end;

procedure desenhaPontoAerea(x, y: integer; orelha : Char; cor : TColor; imagem : TImage );
var w : integer;
    c : TColor;
begin
  w := imagem.canvas.pen.Width;
  c := imagem.canvas.Pen.Color;
  imagem.canvas.Pen.Width := 2;
  imagem.canvas.Pen.Color := cor;

  if orelha = 'D' then
  begin
    imagem.canvas.Ellipse( x, y, x + 10, y + 10 );
  end
  else
  begin
    x := x - 5;
    y := y + 4;
    imagem.canvas.MoveTo( x, y );
    imagem.canvas.LineTo( x - 5, y - 5 );
    imagem.canvas.LineTo( x + 5, y + 5);
    imagem.canvas.MoveTo( x, y );
    imagem.canvas.LineTo( x - 5, y + 5 );
    imagem.canvas.LineTo( x + 5 ,y - 5 );
  end;
  imagem.canvas.pen.Width := w;
  imagem.canvas.Pen.Color := c;
end;

function PosicaoY( valor : integer): integer;
Var ajusteY, y : Integer;
begin
  y := 0;
  result := 0;
  ajusteY := 19;

  Case valor of
    -10 : result := y  + ajusteY;
     -5 : result := 10 + y + ajusteY;
      0 : result := 20 + y + ajusteY;
      5 : result := 31 + y + ajusteY;
     10 : result := 42 + y + ajusteY;
     15 : result := 52 + y + ajusteY;
     20 : result := 62 + y + ajusteY;
     25 : result := 73 + y + ajusteY;
     30 : result := 83 + y + ajusteY;
     35 : result := 94 + y + ajusteY;
     40 : result := 104 + y + ajusteY;
     45 : result := 114 + y + ajusteY;
     50 : result := 125 + y + ajusteY;
     55 : result := 136 + y + ajusteY;
     60 : result := 147 + y + ajusteY;
     65 : result := 157 + y + ajusteY;
     70 : result := 168 + y + ajusteY;
     75 : result := 178 + y + ajusteY;
     80 : result := 189 + y + ajusteY;
     85 : result := 199 + y + ajusteY;
     90 : result := 210 + y + ajusteY;
     95 : result := 221 + y + ajusteY;
     100 : result := 231 + y + ajusteY;
     105 : result := 242 + y + ajusteY;
     110 : result := 252 + y + ajusteY;
     115 : result := 263 + y + ajusteY;
     120 : result := 273 + y + ajusteY;
  end;

end;

procedure desenhaPontoOssea(x, y: integer; orelha: Char; cor : TColor; imagem : TImage );
var w : integer;
    c : TColor;
begin
  w := imagem.canvas.pen.Width;
  c := imagem.canvas.Pen.Color;
  imagem.canvas.Pen.Color := cor;
  imagem.canvas.Pen.Width := 2;
  if orelha = 'D' then
  begin
    imagem.canvas.MoveTo( x - 2, y + 5 );
    imagem.canvas.LineTo( x + 5, y - 5 );
    imagem.canvas.MoveTo( x - 2, y + 5 );
    imagem.canvas.LineTo( x + 5, y + 15 );
  end
  else
  begin
    imagem.canvas.MoveTo( x + 2, y + 5 );
    imagem.canvas.LineTo( x - 5, y - 5 );
    imagem.canvas.MoveTo( x + 2, y + 5 );
    imagem.canvas.LineTo( x - 5, y + 15 );
  end;
  imagem.canvas.pen.Width := w;
  imagem.canvas.Pen.Color := c;
end;

procedure desenhaPontoOsseaMascarada( x, y: integer; orelha : Char; cor : TColor; imagem : TImage );
var w : integer;
    c : TColor;
begin
  w := imagem.canvas.pen.Width;
  c := imagem.canvas.Pen.Color;
  imagem.canvas.Pen.Color := cor;
  imagem.canvas.Pen.Width := 2;
  if orelha = 'D' then
  begin
    imagem.canvas.MoveTo( x - 2, y + 5);
    imagem.canvas.LineTo( x - 2, y  );
    imagem.canvas.LineTo( x + 5, y - 1 );
    imagem.canvas.MoveTo( x - 2, y + 5);
    imagem.canvas.LineTo( x - 2, y + 10 );
    imagem.canvas.LineTo( x + 5, y + 10 );
  end
  else
  begin
    imagem.canvas.MoveTo( x + 2, y + 5);
    imagem.canvas.LineTo( x + 2, y  );
    imagem.canvas.LineTo( x - 5, y - 1 );
    imagem.canvas.MoveTo( x + 2, y + 5);
    imagem.canvas.LineTo( x + 2, y + 10 );
    imagem.canvas.LineTo( x - 5, y + 10 );
  end;

  imagem.canvas.pen.Width := w;
  imagem.canvas.Pen.Color := c;
end;

procedure desenhaGridOrelhaDireita( imagem : TImage; cor : boolean = true ; fundoColorido : boolean = true );
var
  i, j, x, y : Integer;
begin

  x := 0;
  y := 0;

  With imagem.Canvas Do
  begin
    Pen.Color := clBlack;
    Pen.Width := 1;
    Pen.Style := psSolid;
    brush.Color := clWhite;
    FillRect(Rect( x, y, x + 325, y + 320 ) );
    Rectangle( x, y, x + 325, y + 320 );

    if fundoColorido then
      brush.Color := clAqua
    else
      brush.Color := clWhite;
    FillRect(Rect(x+20,y+23,x+310, y+96));

    if fundoColorido then
      brush.Color := clLime
    else
      brush.Color := clWhite;
    FillRect(Rect(x+20,y+96,x+310, y+128));

    if fundoColorido then
      brush.Color := clYellow
    else
      brush.Color := clWhite;
    FillRect(Rect(x+20,y+128,x+310, y+170));

    if fundoColorido then
      brush.Color := 5220351
    else
      brush.Color := clWhite;
    FillRect(Rect(x+20,y+170,x+310, y+212));

    if fundoColorido then
      brush.Color := 15658734
    else
      brush.Color := clWhite;
    FillRect(Rect(x+20,y+212,x+310, y+297));

    brush.Color := clWhite;
    i := y + 23;
    Pen.Color := clBlack;
    Pen.Width := 1;
    Repeat
      if i = y + 44 then
      begin
        pen.Width := 2;
        Pen.Color := clBlack;
      end
      else
      begin
        pen.Width := 1;
        Pen.Color := clGray;
      end;
      MoveTo( x + 20, i );
      LineTo( x + 310, i );
      i := i + 21;
    Until i >= y + 297;
    i := y + 33;
    Pen.Color := clGray;
    Pen.Width := 1;
    Pen.Style := psDot;
    Repeat
      MoveTo( x + 20, i );
      LineTo( x + 310, i );
      i := i + 21;
    Until i >= y + 297;
    Pen.Style := psSolid;
    MoveTo( x + 20, y + 23 );
    LineTo( x + 20, y + 297 );

    if cor then
      Font.Color := clRed
    else
      Font.Color := clBlack;

    Font.Size  := 12;
    Font.Style := [ fsBold ];
    TextOut( x + 100, y + 3, 'Orelha Direita' );
    Font.Color := clBlack;
    Font.Size  := 8;
    Font.Style := [];
    j := -10;
    i := y + 17;
    Repeat
      TextOut( x + 2, i, IntToStr( j ) ); //numeros de Y
      j := j + 10;
      i := i + 21;
    Until j >= 115;
    MoveTo( x + 70, y + 23 );
    LineTo( x + 70, y + 297 );
    Pen.Color := clBlack;
    Pen.Width := 2;
    MoveTo( x + 120, y + 23 );
    LineTo( x + 120, y + 297 );
    Pen.Color := clGray;
    Pen.Width := 1;
    MoveTo( x + 170, y + 23 );
    LineTo( x + 170, y + 297 );
    MoveTo( x + 205, y + 23 );
    LineTo( x + 205, y + 297 );
    MoveTo( x + 240, y + 23 );
    LineTo( x + 240, y + 297 );
    MoveTo( x + 275, y + 23 );
    LineTo( x + 275, y + 297 );
    MoveTo( x + 310, y + 23 );
    LineTo( x + 310, y + 297 );

    TextOut( x + 10,  y + 304, '250' );
    TextOut( x + 55,  y + 304, '500' );
    TextOut( x + 110, y + 304, '1000' );
    TextOut( x + 160, y + 304, '2000' );
    TextOut( x + 195, y + 304, '3000' );
    TextOut( x + 230, y + 304, '4000' );
    TextOut( x + 265, y + 304, '6000' );
    TextOut( x + 295, y + 304, '8000' );
  end;


end;

procedure desenhaGridOrelhaEsquerda( imagem : TImage; cor : boolean = true ; fundoColorido : boolean = true );
var
  x, y, i, j : Integer;
begin

  x := 0;
  y := 0;

  With imagem.Canvas Do
  begin
    Pen.Color := clBlack;
    Pen.Width := 1;
    Pen.Style := psSolid;
    brush.Color := clWhite;
    FillRect(Rect( x, y, x + 325, y + 320 ) );
    Rectangle( x, y, x + 325, y + 320 );

    if fundoColorido then
      brush.Color := clAqua
    else
      brush.Color := clWhite;

    FillRect(Rect(x+20,y+23,x+310, y+96));

    if fundoColorido then
      brush.Color := clLime
    else
      brush.Color := clWhite;
    FillRect(Rect(x+20,y+96,x+310, y+128));

    if fundoColorido then
      brush.Color := clYellow
    else
      brush.Color := clWhite;
    FillRect(Rect(x+20,y+128,x+310, y+170));

    if fundoColorido then
      brush.Color := 5220351
    else
      brush.Color := clWhite;
    FillRect(Rect(x+20,y+170,x+310, y+212));

    if fundoColorido then
      brush.Color := 15658734
    else
      brush.Color := clWhite;
    FillRect(Rect(x+20,y+212,x+310, y+297));

    brush.Color := clWhite;

    i := y + 23;
    Pen.Color := clBlack;
    Pen.Width := 1;
    Repeat
      if i = y + 44 then
      begin
        pen.Width := 2;
        Pen.Color := clBlack;
      end
      else
      begin
        pen.Width := 1;
        Pen.Color := clGray;
      end;
      MoveTo( x + 20, i );
      LineTo( x + 310, i );
      i := i + 21;
    Until i >= y + 297;
    i := y + 33;
    Pen.Color := clGray;
    Pen.Width := 1;
    Pen.Style := psDot;
    Repeat
      MoveTo( x + 20, i );
      LineTo( x + 310, i );
      i := i + 21;
    Until i >= y + 297;
    Pen.Style := psSolid;
    MoveTo( x + 20, y + 23 );
    LineTo( x + 20, y + 297 );

    if cor then
      Font.Color := clBlue
    else
      Font.Color := clBlack;
    Font.Size  := 12;
    Font.Style := [ fsBold ];
    TextOut( x + 100, y + 3, 'Orelha Esquerda' );
    Font.Color := clBlack;
    Font.Size  := 8;
    Font.Style := [];
    j := -10;
    i := y + 17;
    Repeat
      TextOut( x + 2, i, IntToStr( j ) );
      j := j + 10;
      i := i + 21;
    Until j >= 115;
    MoveTo( x + 70, y + 23 );
    LineTo( x + 70, y + 297 );
    Pen.Width := 2;
    pen.Color := clBlack;
    MoveTo( x + 120, y + 23 );
    LineTo( x + 120, y + 297 );
    Pen.Width := 1;
    pen.Color := clGray;
    MoveTo( x + 170, y + 23 );
    LineTo( x + 170, y + 297 );
    MoveTo( x + 205, y + 23 );
    LineTo( x + 205, y + 297 );
    MoveTo( x + 240, y + 23 );
    LineTo( x + 240, y + 297 );
    MoveTo( x + 275, y + 23 );
    LineTo( x + 275, y + 297 );
    MoveTo( x + 310, y + 23 );
    LineTo( x + 310, y + 297 );

    TextOut( x + 10,  y + 304, '250' );
    TextOut( x + 55,  y + 304, '500' );
    TextOut( x + 110, y + 304, '1000' );
    TextOut( x + 160, y + 304, '2000' );
    TextOut( x + 195, y + 304, '3000' );
    TextOut( x + 230, y + 304, '4000' );
    TextOut( x + 265, y + 304, '6000' );
    TextOut( x + 295, y + 304, '8000' );
  end;

end;


procedure desenhaSeta(x, py : integer; cor : TColor; imagem : TImage; orelha, tipo :Char; mascarada : boolean );
var w, y : integer;
    c : TColor;
    ajuste : integer;
begin
  if tipo = 'O' then
    ajuste := -5
  else
    ajuste := 0;
  if tipo = 'A' then
  begin
    if mascarada then
      desenhaPontoAereaMascarada( x, py + ajuste, orelha, cor, imagem )
    else
      desenhaPontoAerea( x, py + ajuste, orelha, cor, imagem );
  end
  else
  begin
    if mascarada then
      desenhaPontoOsseaMascarada( x, py, orelha, cor, imagem )
    else
      desenhaPontoOssea( x, py + ajuste, orelha, cor, imagem );
  end;
  y := 10;
  w := imagem.canvas.pen.Width;
  c := imagem.canvas.Pen.Color;
  if orelha = 'D' then
    x := x + 5
  else
    x := x - 5;
  imagem.canvas.Pen.Color := cor;
  imagem.canvas.Pen.Width := 2;

  if (tipo = 'A')and(orelha='E')and(not mascarada) then
  begin
    imagem.canvas.MoveTo( x, y + py -5 );
    imagem.canvas.LineTo( x, y + py);
  end;

  imagem.canvas.MoveTo( x, y + py );
  imagem.canvas.LineTo( x, y + py+10 );
  imagem.canvas.LineTo( x - 6, y + py+5 );
  imagem.canvas.MoveTo( x, y + py+10 );
  imagem.canvas.LineTo( x + 5, y + py+5 );

  imagem.canvas.pen.Width := w;
  imagem.canvas.Pen.Color := c;
end;

procedure desenhaOssea(o0_25, o0_5, o1, o2, o3, o4 : Variant; mascaraO0_25, mascaraO0_5, mascaraO1, mascaraO2, mascaraO3, mascaraO4: String; orelha : Char; cor : TColor; imagem : TImage );
Var
  x, posicao250, posicao500, posicao1000, posicao2000, posicao3000, posicao4000 : Integer;
  ajusteX : Integer;
begin
  x := 0;

  if orelha = 'D' then
    ajusteX := 15
  else
    ajusteX := 25;

  posicao250  := x       + ajusteX;
  posicao500  := x +  50 + ajusteX;
  posicao1000 := x + 100 + ajusteX;
  posicao2000 := x + 150 + ajusteX;
  posicao3000 := x + 185 + ajusteX;
  posicao4000 := x + 220 + ajusteX;

  if orelha = 'D' then
  begin
    if not VarIsNull( o0_25 ) then
    begin
      if o0_25 < 245 then
      begin
        if mascarao0_25 = 'S' then
          desenhaPontoOsseaMascarada( posicao250, PosicaoY( o0_25 ), 'D', cor, imagem )
        else
          desenhaPontoOssea( posicao250, PosicaoY( o0_25 ), 'D', cor, imagem );
      end
      else
      begin
        desenhaSeta( posicao250, PosicaoY( o0_25 - 255 ), cor, imagem, 'D', 'O', mascarao0_25 = 'S' );
      end
    end;
    if not VarIsNull( o0_5 ) then
    begin
      if o0_5 < 245 then
      begin
        if mascarao0_5 = 'S' then
          desenhaPontoOsseaMascarada( posicao500, PosicaoY( o0_5 ), 'D', cor, imagem )
        else
          desenhaPontoOssea( posicao500, PosicaoY( o0_5 ), 'D', cor, imagem );
      end
      else
      begin
        desenhaSeta( posicao500, PosicaoY( o0_5 - 255 ), cor, imagem, 'D' , 'O', mascarao0_5 = 'S');
      end
    end;
    if not VarIsNull( o1 ) then
    begin
      if o1 < 245 then
      begin
        if mascaraO1 = 'S' then
          desenhaPontoOsseaMascarada( posicao1000, PosicaoY( o1 ), 'D', cor, imagem )
        else
          desenhaPontoOssea( posicao1000, PosicaoY( o1 ), 'D', cor, imagem );
      end
      else
      begin
        desenhaSeta( posicao1000, PosicaoY( o1 - 255 ), cor, imagem, 'D', 'O', mascaraO1 = 'S' );
      end
    end;
    if not VarIsNull( o2 ) then
    begin
      if o2 < 245 then
      begin
        if mascaraO2 = 'S' then
          desenhaPontoOsseaMascarada( posicao2000, PosicaoY( o2 ), 'D', cor, imagem )
        else
          desenhaPontoOssea( posicao2000, PosicaoY( o2 ), 'D', cor , imagem );
      end
      else
      begin
        desenhaSeta( posicao2000, PosicaoY( o2 - 255 ), cor, imagem, 'D' , 'O', mascaraO2 = 'S');
      end
    end;
    if not VarIsNull( o3 ) then
    begin
      if o3 < 245 then
      begin
      if mascaraO3 = 'S' then
        desenhaPontoOsseaMascarada( posicao3000, PosicaoY( o3 ), 'D', cor, imagem )
      else
        desenhaPontoOssea( posicao3000, PosicaoY( o3 ), 'D', cor, imagem );
      end
      else
      begin
        desenhaSeta( posicao3000, PosicaoY( o3- 255 ), cor, imagem, 'D' , 'O', mascaraO3 = 'S');
      end
    end;

    if not VarIsNull( o4 ) then
    begin
      if o4 < 245 then
      begin
        if mascaraO4 = 'S' then
          desenhaPontoOsseaMascarada( posicao4000, PosicaoY( o4 ), 'D', cor, imagem )
        else
          desenhaPontoOssea( posicao4000, PosicaoY( o4 ), 'D', cor, imagem );
      end
      else
      begin
        desenhaSeta( posicao4000, PosicaoY( o4 - 255 ), cor, imagem, 'D' , 'O', mascaraO4 = 'S');
      end
    end;
  end
  else
  begin
    if not VarIsNull( o0_25 ) then
    begin
      if o0_25 < 245 then
      begin
        if mascarao0_25 = 'S' then
          desenhaPontoOsseaMascarada( posicao250, PosicaoY( o0_25 ), 'E', cor, imagem )
        else
          desenhaPontoOssea( posicao250, PosicaoY( o0_25 ), 'E', cor, imagem );
      end
      else
      begin
        desenhaSeta( posicao250, PosicaoY( o0_25 - 255 ), cor, imagem, 'E' , 'O', mascarao0_25 = 'S');
      end
    end;

    if not VarIsNull( o0_5 ) then
    begin
      if o0_5 < 245 then
      begin
        if mascarao0_5 = 'S' then
          desenhaPontoOsseaMascarada( posicao500, PosicaoY( o0_5 ), 'E', cor, imagem )
        else
          desenhaPontoOssea( posicao500, PosicaoY( o0_5 ), 'E', cor, imagem );
      end
      else
      begin
        desenhaSeta( posicao500, PosicaoY( o0_5 - 255 ), cor, imagem, 'E' , 'O', mascarao0_5 = 'S');
      end
    end;
    if not VarIsNull( o1 ) then
    begin
      if o1 < 245 then
      begin
        if mascaraO1 = 'S' then
          desenhaPontoOsseaMascarada( posicao1000, PosicaoY( o1 ), 'E', cor, imagem )
        else
          desenhaPontoOssea( posicao1000, PosicaoY( o1 ), 'E', cor, imagem );
      end
      else
      begin
        desenhaSeta( posicao1000, PosicaoY( o1 - 255 ), cor, imagem, 'E' , 'O', mascaraO1 = 'S');
      end
    end;
    if not VarIsNull( o2 ) then
    begin
      if o2 < 245 then
      begin
        if mascaraO2 = 'S' then
          desenhaPontoOsseaMascarada( posicao2000, PosicaoY( o2 ), 'E', cor, imagem )
        else
          desenhaPontoOssea( posicao2000, PosicaoY( o2 ), 'E', cor, imagem );
      end
      else
      begin
        desenhaSeta( posicao2000, PosicaoY( o2 - 255 ), cor, imagem, 'E' , 'O', mascaraO2 = 'S');
      end
    end;
    if not VarIsNull( o3 ) then
    begin
      if o3 < 245 then
      begin
      if mascaraO3 = 'S' then
        desenhaPontoOsseaMascarada( posicao3000, PosicaoY( o3 ), 'E', cor, imagem )
      else
        desenhaPontoOssea( posicao3000, PosicaoY( o3 ), 'E', cor, imagem );
      end
      else
      begin
        desenhaSeta( posicao3000, PosicaoY( o3 - 255 ), cor, imagem, 'E' , 'O', mascaraO3 = 'S');
      end
    end;
    if not VarIsNull( o4 ) then
    begin
      if o4 < 245 then
      begin
        if mascaraO4 = 'S' then
          desenhaPontoOsseaMascarada( posicao4000, PosicaoY( o4 ), 'E', cor, imagem )
        else
          desenhaPontoOssea( posicao4000, PosicaoY( o4 ), 'E', cor, imagem );
      end
      else
      begin
        desenhaSeta( posicao4000, PosicaoY( o4 - 255 ), cor, imagem, 'E' , 'O', mascaraO4 = 'S');
      end
    end;
  end;
end;


procedure desenhaAerea(a0_25, a0_5, a1, a2, a3, a4, a6, a8: Variant; mascaraA0_25, mascaraA0_5, mascaraA1, mascaraA2, mascaraA3, mascaraA4, mascaraA6, mascaraA8: String; orelha: Char; cor: TColor; imagem : TImage);
Var
  posicao250, posicao500, posicao1000, posicao2000, posicao3000, posicao4000, posicao6000, posicao8000 : Integer;
  ajusteX, contador : Integer;
  valor, posicaoX : array[1..8] of Variant;
  x, x1, x2, ajusteX2 : Integer;
begin
  x := 0;

  if orelha = 'D' then
    ajusteX := 15
  else
    ajusteX := 25;

  posicao250  := x       + ajusteX;
  posicao500  := x +  50 + ajusteX;
  posicao1000 := x + 100 + ajusteX;
  posicao2000 := x + 150 + ajusteX;
  posicao3000 := x + 185 + ajusteX;
  posicao4000 := x + 220 + ajusteX;
  posicao6000 := x + 255 + ajusteX;
  posicao8000 := x + 290 + ajusteX;

  valor[1] := a0_25;
  valor[2] := a0_5;
  valor[3] := a1;
  valor[4] := a2;
  valor[5] := a3;
  valor[6] := a4;
  valor[7] := a6;
  valor[8] := a8;

  posicaoX[1] := posicao250;
  posicaoX[2] := posicao500;
  posicaoX[3] := posicao1000;
  posicaoX[4] := posicao2000;
  posicaoX[5] := posicao3000;
  posicaoX[6] := posicao4000;
  posicaoX[7] := posicao6000;
  posicaoX[8] := posicao8000;


  contador := 1;

  x1 := 999;
  ajusteX2 := 0;
  Repeat
    if not VarIsNull( valor[contador] ) then
    begin
      if valor[contador] < 245 then
      begin
        if x1 = 999 then
        begin
          x1 := valor[contador];
          ajusteX2 := posicaoX[contador];
        end
        else
        begin
          x2 := valor[contador];
          if orelha = 'D' then
            desenhaLinha( ajusteX2, PosicaoY( x1 ), posicaoX[contador], PosicaoY( x2 ), orelha, cor, imagem )
          else
            desenhaLinha( ajusteX2, PosicaoY( x1 ), posicaoX[contador], PosicaoY( x2 ), orelha, cor, imagem );
          x1 := x2;
          ajusteX2 := posicaoX[contador];
        end;
      end
      else
        x1 := 999
    end
    else
    begin
      x1 := 999;
    end;
    Inc(contador);
  Until contador = 9;


  if orelha = 'D' then
  begin
    if not VarIsNull( a0_25 ) then
    begin
      if a0_25 < 245 then
      begin
        if mascaraA0_25 = 'S' then
          desenhaPontoAereaMascarada( posicao250, PosicaoY( a0_25 ), 'D', cor, imagem )
        else
          desenhaPontoAerea( posicao250, PosicaoY( a0_25 ), 'D', cor, imagem );
      end
      else
      begin
        desenhaSeta( posicao250, PosicaoY( a0_25 - 255 ), cor, imagem, 'D', 'A', mascaraA0_25 = 'S');
      end
    end;
    if not VarIsNull( a0_5 ) then
    begin
      if a0_5 < 245 then
      begin
        if mascaraA0_5 = 'S' then
          desenhaPontoAereaMascarada( posicao500, PosicaoY( a0_5 ), 'D', cor, imagem )
        else
          desenhaPontoAerea( posicao500, PosicaoY( a0_5 ), 'D', cor, imagem );
      end
      else
      begin
        desenhaSeta( posicao500, PosicaoY( a0_5 - 255 ), cor, imagem, 'D', 'A', mascaraA0_25 = 'S');
      end
    end;
    if not VarIsNull( a1 ) then
    begin
      if a1 < 245 then
      begin
        if mascaraA1 = 'S' then
          desenhaPontoAereaMascarada( posicao1000, PosicaoY( a1 ), 'D', cor, imagem )
        else
          desenhaPontoAerea( posicao1000, PosicaoY( a1 ), 'D', cor, imagem );
      end
      else
      begin
        desenhaSeta( posicao1000, PosicaoY( a1 - 255 ), cor, imagem, 'D', 'A', mascaraA1 = 'S');
      end
    end;
    if not VarIsNull( a2 ) then
    begin
      if a2 < 245 then
      begin
        if mascaraA2 = 'S' then
          desenhaPontoAereaMascarada( posicao2000, PosicaoY( a2 ), 'D', cor, imagem )
        else
          desenhaPontoAerea( posicao2000, PosicaoY( a2 ), 'D', cor, imagem );
      end
      else
      begin
        desenhaSeta( posicao2000, PosicaoY( a2 - 255 ), cor, imagem, 'D', 'A', mascaraA2 = 'S');
      end
    end;
    if not VarIsNull( a3 ) then
    begin
      if a3 < 245 then
      begin
      if mascaraA3 = 'S' then
        desenhaPontoAereaMascarada( posicao3000, PosicaoY( a3 ), 'D', cor, imagem )
      else
        desenhaPontoAerea( posicao3000, PosicaoY( a3 ), 'D', cor, imagem );
      end
      else
      begin
        desenhaSeta( posicao3000, PosicaoY( a3 - 255 ), cor, imagem, 'D', 'A', mascaraA3 = 'S');
      end
    end;
    if not VarIsNull( a4 ) then
    begin
      if a4 < 245 then
      begin
        if mascaraA4 = 'S' then
          desenhaPontoAereaMascarada( posicao4000, PosicaoY( a4 ), 'D', cor, imagem )
        else
          desenhaPontoAerea( posicao4000, PosicaoY( a4 ), 'D', cor, imagem );
      end
      else
      begin
        desenhaSeta( posicao4000, PosicaoY( a4 - 255 ), cor, imagem, 'D', 'A', mascaraA4 = 'S');
      end
    end;
    if not VarIsNull( a6 ) then
    begin
      if a6 < 245 then
      begin
        if mascaraA6 = 'S' then
          desenhaPontoAereaMascarada( posicao6000, PosicaoY( a6 ), 'D', cor, imagem )
        else
          desenhaPontoAerea( posicao6000, PosicaoY( a6 ), 'D', cor , imagem);
      end
      else
      begin
        desenhaSeta( posicao6000, PosicaoY( a6 - 255 ), cor, imagem, 'D', 'A', mascaraA6 = 'S');
      end
    end;
    if not VarIsNull( a8 ) then
    begin
      if a8 < 245 then
      begin
        if mascaraA8 = 'S' then
          desenhaPontoAereaMascarada( posicao8000, PosicaoY( a8 ), 'D', cor, imagem )
        else
          desenhaPontoAerea( posicao8000, PosicaoY( a8 ), 'D', cor, imagem );
      end
      else
      begin
        desenhaSeta( posicao8000, PosicaoY( a8 - 255 ), cor, imagem, 'D', 'A', mascaraA8 = 'S');
      end
    end;
  end
  else
  begin
    if not VarIsNull( a0_25 ) then
    begin
      if a0_25 < 245 then
      begin
        if mascaraA0_25 = 'S' then
          desenhaPontoAereaMascarada( posicao250, PosicaoY( a0_25 ), 'E', cor, imagem )
        else
          desenhaPontoAerea( posicao250, PosicaoY( a0_25 ), 'E', cor, imagem );
      end
      else
      begin
        desenhaSeta( posicao250, PosicaoY( a0_25 - 255 ), cor, imagem, 'E', 'A', mascaraA0_25 = 'S');
      end
    end;
    if not VarIsNull( a0_5 ) then
    begin
      if a0_5 < 245 then
      begin
        if mascaraA0_5 = 'S' then
          desenhaPontoAereaMascarada( posicao500, PosicaoY( a0_5 ), 'E', cor, imagem )
        else
          desenhaPontoAerea( posicao500, PosicaoY( a0_5 ), 'E', cor, imagem );
      end
      else
      begin
        desenhaSeta( posicao500, PosicaoY( a0_5 - 255 ), cor, imagem, 'E', 'A', mascaraA0_5 = 'S');
      end
    end;
    if not VarIsNull( a1 ) then
    begin
      if a1 < 245 then
      begin
        if mascaraA1 = 'S' then
          desenhaPontoAereaMascarada( posicao1000, PosicaoY( a1 ), 'E', cor, imagem )
        else
          desenhaPontoAerea( posicao1000, PosicaoY( a1 ), 'E', cor, imagem );
      end
      else
      begin
        desenhaSeta( posicao1000, PosicaoY( a1 - 255 ), cor, imagem, 'E', 'A', mascaraA1 = 'S');
      end
    end;
    if not VarIsNull( a2 ) then
    begin
      if a2 < 245 then
      begin
        if mascaraA2 = 'S' then
          desenhaPontoAereaMascarada( posicao2000, PosicaoY( a2 ), 'E', cor, imagem )
        else
          desenhaPontoAerea( posicao2000, PosicaoY( a2 ), 'E', cor, imagem );
      end
      else
      begin
        desenhaSeta( posicao2000, PosicaoY( a2 - 255 ), cor, imagem, 'E', 'A', mascaraA2 = 'S');
      end
    end;
    if not VarIsNull( a3 ) then
    begin
      if a3 < 245 then
      begin
      if mascaraA3 = 'S' then
        desenhaPontoAereaMascarada( posicao3000, PosicaoY( a3 ), 'E', cor, imagem )
      else
        desenhaPontoAerea( posicao3000, PosicaoY( a3 ), 'E', cor, imagem );
      end
      else
      begin
        desenhaSeta( posicao3000, PosicaoY( a3 - 255 ), cor, imagem, 'E', 'A', mascaraA3 = 'S');
      end
    end;
    if not VarIsNull( a4 ) then
    begin
      if a4 < 245 then
      begin
        if mascaraA4 = 'S' then
          desenhaPontoAereaMascarada( posicao4000, PosicaoY( a4 ), 'E', cor, imagem )
        else
          desenhaPontoAerea( posicao4000, PosicaoY( a4 ), 'E', cor, imagem );
      end
      else
      begin
        desenhaSeta( posicao4000, PosicaoY( a4 - 255 ), cor, imagem, 'E', 'A', mascaraA4 = 'S');
      end
    end;
    if not VarIsNull( a6 ) then
    begin
      if a6 < 245 then
      begin
        if mascaraA6 = 'S' then
          desenhaPontoAereaMascarada( posicao6000, PosicaoY( a6 ), 'E', cor, imagem )
        else
          desenhaPontoAerea( posicao6000, PosicaoY( a6 ), 'E', cor, imagem );
      end
      else
      begin
        desenhaSeta( posicao6000, PosicaoY( a6 - 255 ), cor, imagem, 'E', 'A', mascaraA6 = 'S');
      end
    end;
    if not VarIsNull( a8 ) then
    begin
      if a8 < 245 then
      begin
        if mascaraA8 = 'S' then
          desenhaPontoAereaMascarada( posicao8000, PosicaoY( a8 ), 'E', cor, imagem )
        else
          desenhaPontoAerea( posicao8000, PosicaoY( a8 ), 'E', cor, imagem);
      end
      else
      begin
        desenhaSeta( posicao8000, PosicaoY( a8 - 255 ), cor, imagem, 'E', 'A', mascaraA8 = 'S');
      end
    end;
  end;

end;

end.
