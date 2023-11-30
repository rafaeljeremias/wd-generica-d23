unit RoundToXReplacement_3c;

(* *****************************************************************************

  This is a suggested replacement for Math.RoundTo and SimpleRoundTo functions.

  Please comments and suggestions to b.p.delphi.language.BASM forum
  and/or Quality Central report #8143.

  Rev. 06/13/2004 by JH to
    (1) replace TRoundToRange with type integer;
    (2) cause exception if abs(Digits) > 27;
    (3) to cause exception if
        abs(ScaledVal) > (high(Int64) - 2)/10^abs(Digits)
    (4) rename to RoundToXReplacement_3c; 
    (5) to build-in the PowersOfTen array; and
    (6) added function MaxRoundableValue(Digits): extended;
  Rev. 06/08/2004 by JH to replace Elbow64 with RoundUp64 and remove
      Math.Round function code example.  Also improved comments and
      renamed RoundToXReplacement_3b.
  Fix. 06/02/2004 by JH to make work with MaxRelErr = 0.  This required
      a major revision in the logic.  Renamed RoundToXReplacement_3.
  Fix. 05/30/2004 by JH to change name from RoundToXReplacement_1 to
      RoundToXReplacement_2.
  Fix. 05/30/2004 by JH to change j from Integer to Int64.
  Fix. 05/12/2004 by JH to reverse of Digits sign, except on DecimalRound.
  Pgm. 05/12/2004 by John Herbster, herb-sci1@sbcglobal.net,
      281-531-4423, 12807 Park Royal, Houston, TX  77077-2249.

***************************************************************************** *)

{ TODO 3 : Needs testing, like done for the DecimalRounding_JH0 routines. }

{ TODO 3 : Need to resolve name and sign convention for # of decimal digits. }
{ Should the number decimal digits for rounding to cents should be -2 or +2? }

interface

Type

{ Note that errors would start creeping in, if Digits were to be allowed
  to be outside the -27 .. + 27 range. }

  tDecimalRoundingCtrl = {Defined rounding methods} {From DecimalRounding_JH0}
   (drNone,     {No rounding.}
    drHalfEven, {Round to nearest else to even digit. a.k.a Bankers}
    drHalfOdd,  {Round to nearest else to odd digit. }
    drHalfPos,  {Round to nearest else toward positive. }
    drHalfNeg,  {Round to nearest else toward negative. }
    drHalfDown, {Round to nearest else toward zero. }
    drHalfUp,   {Round to nearest else away from zero. }
    drRndNeg,   {Round toward negative.               a.k.a. Floor}
    drRndPos,   {Round toward positive.               a.k.a. Ceil }
    drRndDown,  {Round toward zero.                   a.k.a. Trunc}
    drRndUp);   {Round away from zero.}

function RoundExtTo (
    const Value: extended;
    const Digits: integer;   {Allowable Digits range: -27 to +27}
    const Ctrl: tDecimalRoundingCtrl = drHalfEven;
    const SafetyFactor: double = 2)
    : extended;

function RoundDblTo (
    const Value: double; {This might be type extended}
    const Digits: integer;   {Allowable Digits range: -27 to +27}
    const Ctrl: tDecimalRoundingCtrl = drHalfEven;
    const SafetyFactor: double = 2)
    : extended;

function RoundSglTo (
    const Value: single; {This might be type extended}
    const Digits: integer;   {Allowable Digits range: -27 to +27}
    const Ctrl: tDecimalRoundingCtrl = drHalfEven;
    const SafetyFactor: double = 2)
    : extended;

Function DecimalRound(
    const Value: extended;
    const Digits: integer;   {Allowable Digits range: -27 to +27}
    const MaxRelErr: double; {Must be non-negative}
    const Ctrl: tDecimalRoundingCtrl = drHalfEven)
    : extended;
{ The DecimalRounding function is for doing the best possible job of rounding
  floating binary point numbers to the specified (Digits) number of decimal
  fraction digits.  MaxRelErr is the maximum relative error that will allowed
  when determining when to apply the rounding rule.  This is the workhorse
  function called by the other rounding functions above. }

function MaxRoundableValue(
    const Digits: integer   {Allowable Digits range: -27 to +27}
    ): extended;

Const
  DecimalRoundingCtrlStrs: array [tDecimalRoundingCtrl] of
      record Abbr: string[9]; Dscr: string[59]; end = (
    (Abbr: 'None'    ; Dscr: 'No rounding.'),
    (Abbr: 'HalfEven'; Dscr: 'Round to nearest or to even digit'),
    (Abbr: 'HalfOdd' ; Dscr: 'Round to nearest or to odd digit'),
    (Abbr: 'HalfPos' ; Dscr: 'Round to nearest or toward positive'),
    (Abbr: 'HalfNeg' ; Dscr: 'Round to nearest or toward negative'),
    (Abbr: 'HalfDown'; Dscr: 'Round to nearest or toward zero'),
    (Abbr: 'HalfUp'  ; Dscr: 'Round to nearest or away from zero'),
    (Abbr: 'RndNeg'  ; Dscr: 'Round toward negative. (a.k.a. Floor)'),
    (Abbr: 'RndPos'  ; Dscr: 'Round toward positive. (a.k.a. Ceil)'),
    (Abbr: 'RndDown' ; Dscr: 'Round toward zero. (a.k.a. Trunc)'),
    (Abbr: 'RndUp'   ; Dscr: 'Round away from zero.') );

{$WRITEABLECONST OFF}

{ The following "epsilon" values are representative of the resolution of the
  floating point numbers divided by the number being represented.  These
  constants are supplied to the rounding routines to determine how much
  correction should be allowed for the natural errors in representing the
  decimal fractions.  For safety it is advised to use a multiple of these
  values for data that have been massaged through arithmetic calculations. }
Const
  SglEps = 1.1920928955e-07;
  DblEps = 2.2204460493e-16;
  ExtEps = 1.0842021725e-19;
{ The above epsilon values are approximations to the smallest power of two
  for which "1 + epsilon <> 1".  For "1 - epsilon <> 1", divide the above
  values by 2. }
  KnownErrorLimit = 1.234375;
{ If MaxRelErr < XxxEps * KnownErrorLimit where XxxEps is the appropriate
  SGLEpx, DblEps, or ExtEps for the data being rounding, then errors in
  the DecimalRound function can be demonstrated. }
{ Limit (minimum) comparison limits: }
  LimRelErrSgl = SglEps * KnownErrorLimit;
  LimRelErrDbl = DblEps * KnownErrorLimit;
  LimRelErrExt = ExtEps * KnownErrorLimit;
{ Standard comparison limits: }
  SafetyFactor = 4;
  MaxRelErrSgl = SglEps * KnownErrorLimit * SafetyFactor;
  MaxRelErrDbl = DblEps * KnownErrorLimit * SafetyFactor;
  MaxRelErrExt = ExtEps * KnownErrorLimit * SafetyFactor;

function Floor64(const X: Extended): Int64;
{ For abs(x) < high(Int64), Floor64 returns the most positive integer value
  less than or equal to X. }

function Ceil64(const X: Extended): Int64;
{ For abs(x) < high(Int64), Ceil64 returns the lowest integer value greater
  than or equal to X. }

function RoundUp64(const x: extended): Int64;
{ For abs(x) < high(Int64), this is like the Trunc function, except that
  RoundUp64 rounds away from zero instead of toward it. }

implementation

Uses SysUtils, Math;

function Ceil64(const X: Extended): Int64;
{ For abs(x) < high(Int64), Ceil64 returns the lowest integer value greater
  than or equal to X. }
begin
  Result := Trunc(X);
  if Frac(X) > 0
    then Inc(Result);
end;

function Floor64(const X: Extended): Int64;
{ For abs(x) < high(Int64), Floor64 returns the most positive integer value
  less than or equal to X. }
begin
  Result := Trunc(X);
  if Frac(X) < 0
    then Dec(Result);
end;

{ TODO 2 : Need to rewrite Ceil64 and Floor64 with BASM code. }

function RoundUp64(const x: extended): Int64;
{ For abs(x) < high(Int64), this is like the Trunc function, except that
  RoundUp64 rounds away from zero instead of toward it. }
begin
  Result := trunc(x) + Math.Sign(frac(x));
end;

function RoundExtTo
   (const Value: extended;
    const Digits: integer;
    const Ctrl: tDecimalRoundingCtrl = drHalfEven;
    const SafetyFactor: double = 2)
    : extended;
begin
  Result := DecimalRound(Value,-Digits,LimRelErrExt*SafetyFactor,Ctrl);
end;

function RoundDblTo
   (const Value: double; {This might be type extended}
    const Digits: integer;
    const Ctrl: tDecimalRoundingCtrl = drHalfEven;
    const SafetyFactor: double = 2)
    : extended;
begin
  Result := DecimalRound(Value,-Digits,LimRelErrDbl*SafetyFactor,Ctrl);
end;

function RoundSglTo
   (const Value: single; {This might be type extended}
    const Digits: integer;
    const Ctrl: tDecimalRoundingCtrl = drHalfEven;
    const SafetyFactor: double = 2)
    : extended;
begin
  Result := DecimalRound(Value,-Digits,LimRelErrExt*SafetyFactor,Ctrl);
end;

type  TExtPackedRec = packed record Man: Int64; Exp: word end;

const ExtExpBits: word = $7FFF; {15 bits}

{ TODO 2 : Maybe calls to this IsNaN can be replaced by calls to Math.IsNaN. }

Function IsNAN (const ext: extended): boolean;
var InputX: TExtPackedRec absolute ext;
begin
  Result := (InputX.Man <> 0) and ((InputX.Exp and ExtExpBits)=ExtExpBits);
end;

Const
  PowersOfTen: array [0..27] of extended = (
    1e00,1e01,1e02,1e03,1e04,1e05,1e06,1e07,1e08,1e09,
    1e10,1e11,1e12,1e13,1e14,1e15,1e16,1e17,1e18,1e19,
    1e20,1e21,1e22,1e23,1e24,1e25,1e26,1e27);
  MaxScaledValue: extended = (high(Int64) - 2);

function MaxRoundableValue(
    const Digits: integer {Allowable Digits range: -27 to +27})
    : extended;
begin
  Result := MaxScaledValue/PowersOfTen[abs(Digits)];
end;

Function DecimalRound (
    const Value: extended;
    const Digits: integer;   {Allowable Digits range: -27 to +27}
    const MaxRelErr: double; {Must be non-negative}
    const Ctrl: tDecimalRoundingCtrl = drHalfEven): extended;
{ The DecimalRounding function is for doing the best possible job of rounding
  floating binary point numbers to the specified (Digits) number of decimal
  fraction digits.  MaxRelErr is the maximum relative error that will allowed
  when determining where the cut points should be.  }

var RndedVal, j: Int64; Scale, ScaledVal, ScaledErr: extended;
    Negate: boolean; Ctrl2: tDecimalRoundingCtrl;

begin

  If IsNaN(Value) or (Ctrl = drNone)
    then begin Result := Value; EXIT end;

  If (MaxRelErr < 0)
    then raise Exception.Create('DecimalRound: MaxRelErr must be >= 0.');

  If (abs(Digits) > 27)
    then raise Exception.Create('DecimalRound: Digits must be in -27 to +27 range.');

{ Scale the value to be rounded: }
  Scale := PowersOfTen[abs(Digits)];
  If Digits >= 0
    then ScaledVal := Value * Scale
    else ScaledVal := Value / Scale;
  Assert(MaxRelErr >= 0,
      'DecimalRound: MaxRelErr < 0');
  ScaledErr := abs(ScaledVal) * MaxRelErr;

{ Negate if negative and rounding is to be symmetrical about 0: }
  Negate := (ScaledVal < 0) and
            (Ctrl in [drHalfDown,drHalfUp,drRndDown,drRndUp]);
  If Negate
    then ScaledVal := - ScaledVal;

{ Check ScaledVal size before the trunc, floor, or ceil checks it: }
  If (abs(ScaledVal) > MaxScaledValue)
    then raise Exception.Create('DecimalRound: Scaled value is too large to round.');

{ Check for bankers rounding and set Ctrl2: }
  If not (Ctrl in [drHalfEven,drHalfOdd])
    then Ctrl2 := Ctrl
    else begin
      j := floor64(ScaledVal);
      If odd(j) xor (Ctrl = drHalfEven)
        then Ctrl2 := drHalfNeg  {Ceil64 (ScaledVal - 0.5 - ScaledErr)}{OK}
        else Ctrl2 := drHalfPos; {Floor64(ScaledVal + 0.5 + ScaledErr)}{OK}
      end;

{ Branch to do the different roundings: }
  Case Ctrl2 of
    drRndPos,drRndUp:
      RndedVal := Ceil64 (ScaledVal - ScaledErr);       {OK}
    drHalfNeg,drHalfDown:
      RndedVal := Ceil64 (ScaledVal - 0.5 - ScaledErr); {OK}
    drRndNeg,drRndDown:
      RndedVal := Floor64(ScaledVal + ScaledErr);       {OK}
    drHalfPos,drHalfUp:
      RndedVal := Floor64(ScaledVal + 0.5 + ScaledErr); {OK}
    else RndedVal := trunc(ScaledVal); {This line should never be executed.}
    end;

{ Finally convert back to the right order and correct negation: }
  If Digits >= 0
    then Result := RndedVal / Scale
    else Result := RndedVal * Scale;
  If Negate
    then Result := - Result;

end{DecimalRound};

end{RoundToXReplacement_3c}.

