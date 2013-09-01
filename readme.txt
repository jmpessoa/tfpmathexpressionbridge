
TFPMathExpressionBridge - Version 0.1 - 02/2013

Author: Jose Marques Pessoa : jmpessoa__hotmail_com

Acknowledgment: Thank you WP!

TFPMathExpressionBridge is a warapper for [math]* subset
of TFPExpressionParse** attempting to establish a easy semantics
for construction of function graph and expression evaluete.

0. Warning: at the moment this code is just a "proof-of-concept".

1.Data
1.1 Add Data
  
  Add Constants
  Add Variables
  Add Expressions
  
  use: 
  
  AddConstant('k')
  AddVariable('x')
  AddExpression('kx+1')
  
  Obs.: Data are Case Insensitive!

1.2 Set Data

  Set Expression         //triggers OnConstantParse...
  use: Expression:= 'k*x+1'

  Helpers:
	procedure SetExpressionByIndex(Index: integer);
	function GetExpressionByIndex(Index: integer): string;
	function GetExpressionIndexByName(AName: string): integer;

  Set VariableOfFunc     //variable of "functions of one variable"
  use: VariableOfFunc:= 'x'

2.Evaluete
2.1 Function Evaluete

  function EvalFunc(AValue: real)                //eval function for one variable....
  use: EvalFunc(AValue)

  function EvalFunc(AValues: array of real)      //eval function for many variables...
  use:EvalFunc([AValue1, AValue2, AValue3])

2.2 Expression Evaluete //event driver

  function EvalExpr(Expr: string; ANamesVar: array of string)
  use:  EvalExpr('A*x**x+ B*x + C', ['x','A','B','C']) //triggers OnVariableParse

  function EvalExpr
  use:
  AddConstant('A')
  AddConstant('B')
  AddConstant('C')
  AddVariable('x')
  Expression:= 'A*x**x+ B*x + k*C'
  EvalExpr; //triggers OnVariableParse

3. Events
3.1 OnConstantParse  //triggers every time Expression is Set.....

    use: set constant value

3.2 OnVariableParse  //triggers every time EvalExpr is called.....

    use: set variable value

4.Add "building" function

  //signature:
  type
    TExprFunc = procedure(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);

  //"building" funtion code example:
  Procedure ExprDelta(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);
  var
    a,b,c: Double;
  begin
	a := ArgToFloat(Args[0]);
	b := ArgToFloat(Args[1]);
	c := ArgToFloat(Args[2]);

	if IsNumber(a) and IsNumber(b) and IsNumber(c) then
	   Result.resFloat := b*b - 4*a*c
	else
	   result.resFloat := NaN;
  end;   
    
4.1 AddFunction(AName: string; paramCount: integer; callFunc: TExprFunc)
  
  Use:
   AddFunction('Delta', 3, @ExprDelta);
  
  Use:
   Expression:='Delta(2,4,1)';
   EvalExpr;

5. Have Fun!

   *FParser.BuiltIns:= [bcMath]
   **(freepascal fpexprpars.pas) More specifically a WP revision and addOns. (Thank you WP!)
   See: http://www.lazarus.freepascal.org/index.php/topic,19627.0.html
