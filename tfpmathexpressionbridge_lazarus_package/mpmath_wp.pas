unit mpMath_wp; {wp revision}

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fpexprpars_wp;

Procedure ExprDegtorad(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
Procedure ExprRadtodeg(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);

Procedure ExprTan(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
Procedure ExprCot(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);

Procedure ExprArcsin(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
Procedure ExprArccos(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
Procedure ExprArccot(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);

Procedure ExprCosh(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
Procedure ExprCoth(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
Procedure ExprSinh(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
Procedure ExprTanh(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);

Procedure ExprArcosh(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
Procedure ExprArsinh(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
Procedure ExprArtanh(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
Procedure ExprArcoth(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);

Procedure ExprSinc(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);

Procedure ExprPower(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
Procedure ExprHypot(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);

Procedure ExprLog10(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
Procedure ExprLog2(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);

Procedure ExprErf(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
Procedure ExprErfc(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);

Procedure ExprI0(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
Procedure ExprI1(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
Procedure ExprJ0(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
Procedure ExprJ1(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
Procedure ExprK0(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
Procedure ExprK1(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
Procedure ExprY0(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
Procedure ExprY1(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);

Procedure ExprMax(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
Procedure ExprMin(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);

function FixDecSep(const AExpression: String): String;

implementation

uses
  Math, typ, mpspe_wp {wp revision}; //numlib;

{Additional functions for the parser... by wp}
Procedure ExprDegToRad(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if IsNumber(x) then
    Result.resFloat := degtorad(x)
  else
    result.resFloat := NaN;
end;

Procedure ExprRadToDeg(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if IsNumber(x) then
    Result.resFloat := radtodeg(x)
  else
    Result.resFloat := NaN;
end;

Procedure ExprTan(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if IsNumber(x) and ((frac(x - 0.5) / pi) <> 0.0) then
    Result.resFloat := tan(x)
  else
    Result.resFloat := NaN;
end;

Procedure ExprCot(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if IsNumber(x) and (frac(x/pi) <> 0.0) then
    Result.resFloat := cot(x)
  else
    Result.resFloat := NaN;
end;

Procedure ExprArcsin(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if IsNumber(x) and InRange(x, -1.0, 1.0) then
    Result.resFloat := arcsin(x)
  else
    Result.resFloat := NaN;
end;

Procedure ExprArccos(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if IsNumber(x) and InRange(x, -1.0, 1.0) then
    Result.resFloat := arccos(x)
  else
    Result.resFloat := NaN;
end;

Procedure ExprArccot(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if IsNumber(x) and InRange(x, -1.0, 1.0) then
    Result.resFloat := pi/2 - arctan(x)
  else
    Result.resFloat := NaN;
end;

Procedure ExprCosh(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if IsNumber(x) then
    Result.resFloat := cosh(x)
  else
    Result.resFloat := NaN;
end;

Procedure ExprCoth(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if IsNumber(x) and (x <> 0.0) then
    Result.resFloat := 1/tanh(x)
  else
    Result.resFloat := NaN;
end;

Procedure ExprSinh(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if IsNumber(x) then
    Result.resFloat := sinh(x)
  else
    Result.resFloat := NaN;
end;

Procedure ExprTanh(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if IsNumber(x) then
    Result.resFloat := tanh(x)
  else
    Result.resFloat := NaN;
end;

Procedure ExprArcosh(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if IsNumber(x) and (x >= 1.0) then
    Result.resFloat := arcosh(x)
  else
    Result.resFloat := NaN;
end;

Procedure ExprArsinh(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgtoFloat(Args[0]);
  if IsNumber(x) then
    Result.resFloat := arsinh(x)
  else
    Result.resFloat := NaN;
end;

Procedure ExprArtanh(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if IsNumber(x) and (x > -1.0) and (x < 1.0) then
    Result.resFloat := artanh(x)
  else
    Result.resFloat := NaN;
end;

Procedure ExprArcoth(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if IsNumber(x) and (x < -1.0) and (x > 1.0) then
    Result.resFloat := artanh(1.0/x)
  else
    Result.resFloat := NaN;
end;

Procedure ExprSinc(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if IsNumber(x) then begin
    if x = 0 then
      Result.ResFloat := 1.0
    else
      Result.resFloat := sin(x)/x;
  end else
    Result.resFloat := NaN;
end;

Procedure ExprPower(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x,y: Double;
begin
  x := ArgToFloat(Args[0]);
  y := ArgToFloat(Args[1]);
  if IsNumber(x) and IsNumber(y) then
    Result.resFloat := Power(x, y)
  else
    Result.resFloat := NaN;
end;

Procedure ExprHypot(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x,y: Double;
begin
  x := ArgToFloat(Args[0]);
  y := ArgToFloat(Args[1]);
  if IsNumber(x) and IsNumber(y) then
    Result.resFloat := Hypot(x,y)
  else
    Result.resFloat := NaN;
end;

Procedure ExprLg(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if IsNumber(x) then
    Result.resFloat := log10(x)
  else
    Result.resFloat := NaN;
end;

Procedure ExprLog10(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if IsNumber(x) then
    Result.resFloat := log10(x)
  else
    Result.resFloat := NaN;
end;

Procedure ExprLog2(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if IsNumber(x) then
    Result.resFloat := log2(x)
  else
    Result.resFloat := NaN;
end;

Procedure ExprErf(Var Result: TFPExpressionResult; const Args: TExprParameterArray);
// Error function
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if IsNumber(x) then
    Result.resFloat := speerf(x)
  else
    Result.resFloat := NaN;
end;

Procedure ExprErfc(Var Result: TFPExpressionResult; const Args: TExprParameterArray);
// Error function complement
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if IsNumber(x) then
    Result.resFloat := speefc(x)
  else
    Result.resFloat := NaN;
end;

Procedure ExprI0(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
// Bessel function of the first kind I0(x)
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if IsNumber(x) then
    Result.resFloat := spebi0(x)
  else
    Result.resFloat := NaN;
end;

Procedure ExprI1(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
// Bessel function of the first kind I1(x)
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if IsNumber(x) then
    Result.resFloat := spebi1(x)
  else
    Result.resFloat := NaN;
end;

Procedure ExprJ0(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
// Bessel function of the first kind J0(x)
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if IsNumber(x) then
    Result.resFloat := spebj0(x)
  else
    Result.resFloat := NaN;
end;

Procedure ExprJ1(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
// Bessel function of the first kind J1(x)
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if IsNumber(x) then
    Result.resFloat := spebj1(x)
  else
    Result.resFloat := NaN;
end;

Procedure ExprK0(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
// Bessel function of the second kind K0(x)
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if IsNumber(x) then
    Result.resFloat := spebk0(x)
  else
    Result.resFloat := NaN;
end;

Procedure ExprK1(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
// Bessel function of the second kind K1(x)
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if IsNumber(x) then
    Result.resFloat := spebk1(x)
  else
    Result.resFloat := NaN;
end;

Procedure ExprY0(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
// Bessel function of the second kind Y0(x)
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if IsNumber(x) then
    Result.resFloat := speby0(x)
  else
    Result.resFloat := NaN;
end;

Procedure ExprY1(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
// Bessel function of the second kind Y1(x)
var
  x: Double;
begin
  x := ArgToFloat(Args[0]);
  if IsNumber(x) then
    Result.resFloat := speby1(x)
  else
    Result.resFloat := NaN;
end;

Procedure ExprMax(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x1, x2: Double;
begin
  x1 := ArgToFloat(Args[0]);
  x2 := ArgToFloat(Args[1]);
  if IsNumber(x1) and IsNumber(x2) then
    Result.resFloat := Max(x1, x2)
  else
    Result.resFloat := NaN;
end;

Procedure ExprMin(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
var
  x1, x2: Double;
begin
  x1 := ArgToFloat(Args[0]);
  x2 := ArgToFloat(Args[1]);
  if IsNumber(x1) and IsNumber(x2) then
    Result.resFloat := Min(x1, x2)
  else
    Result.resFloat := NaN;
end;

function FixDecSep(const AExpression: String): String;
var
  i: Integer;
begin
  Result := AExpression;
  for i:=1 to Length(Result) do begin
    if Result[i] = ',' then Result[i] := '.';
  end;
end;

end.

