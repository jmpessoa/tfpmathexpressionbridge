unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, TAFuncSeries, TASeries, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, ComCtrls, Menus, Buttons, StdCtrls,
  fpexprpars_wp, FPMathExpressionBridge, dlgAbout;

type

  { TForm1 }

  TForm1 = class(TForm)
    Chart1: TChart;
    Chart1ParametricCurveSeries1: TParametricCurveSeries;
    FPMathExpressionBridge1: TFPMathExpressionBridge;
    FPMathExpressionBridge2: TFPMathExpressionBridge;
    ImageList1: TImageList;
    Label1: TLabel;
    MenuItem10: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem5: TMenuItem;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton4: TToolButton;
    procedure Chart1ParametricCurveSeries1Calculate(const AT: Double; out AX,
      AY: Double);
    procedure FormCreate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FPMathExpressionBridge1ConstantParse(Index: integer; AName: string; out
      AValue: real);
    procedure FPMathExpressionBridge2ConstantParse(Index: integer; AName: string; out
      AValue: real);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure PopupMenu1Close(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;


var
  Form1: TForm1;

implementation

{$R *.lfm}

uses
  mpspe_wp;

  { TForm1 }

procedure TForm1.PopupMenu1Close(Sender: TObject);
var
    sText: string;
begin
    sText:= (Sender as TMenuItem).Caption;
    if CompareText(sText, 'Exit') = 0  then Application.Terminate;
end;

procedure TForm1.Chart1ParametricCurveSeries1Calculate(const AT: Double; out
  AX, AY: Double);
var
   R1: TEvalueteResult;
   R2: TEvalueteResult;
begin
   R1:= FPMathExpressionBridge1.EvalFunc(AT);
   if R1.IsValid then
   begin
      AX:= R1.Value
   end
   else AX:= 0; {or others things....}

   R2:= FPMathExpressionBridge2.EvalFunc(AT);
   if R2.IsValid then
   begin
      AY:= R2.Value
   end
   else AY:= 0; {or others things....}
end;

     //cycloid
procedure TForm1.MenuItem12Click(Sender: TObject);
begin
   Chart1ParametricCurveSeries1.Active:=False;

   FPMathExpressionBridge1.VariableOfFunc:= 't';
   FPMathExpressionBridge1.Expression:= 'h*t - r*sin(h*t)'; //x

   FPMathExpressionBridge2.VariableOfFunc:= 't';
   FPMathExpressionBridge2.Expression:= 'h - r*cos(h*t)'; //y

   Chart1ParametricCurveSeries1.Active:=True;
end;
      //Tractrix
procedure TForm1.MenuItem13Click(Sender: TObject);
begin
   Chart1ParametricCurveSeries1.Active:=False;

   FPMathExpressionBridge1.VariableOfFunc:= 't';
   FPMathExpressionBridge1.Expression:= 'p*(1/cosh(t))';    //x

   FPMathExpressionBridge2.VariableOfFunc:= 't';
   FPMathExpressionBridge2.Expression:='p*(t - tanh(t))';  //y

   Chart1ParametricCurveSeries1.Active:=True;
end;

//deltoid
procedure TForm1.MenuItem5Click(Sender: TObject);
begin
   Chart1ParametricCurveSeries1.Active:=False;

   FPMathExpressionBridge1.VariableOfFunc:= 't';
   FPMathExpressionBridge1.Expression:= '2*r*cos(t)+r*cos(2*t)'; //x

   FPMathExpressionBridge2.VariableOfFunc:= 't';
   FPMathExpressionBridge2.Expression:= '2*r*sin(t)-r*sin(2*t)';  //y

   Chart1ParametricCurveSeries1.Active:=True;
end;

//projectile motion
procedure TForm1.MenuItem14Click(Sender: TObject);
begin
  Chart1ParametricCurveSeries1.Active:=False;

  FPMathExpressionBridge1.VariableOfFunc:= 't';
  FPMathExpressionBridge1.Expression:= 'Vo*cos(angle)*t';  //x

  FPMathExpressionBridge2.VariableOfFunc:= 't';
  FPMathExpressionBridge2.Expression:= '(-1/2)*sqr(t)*G + (Vo*sin(angle))*t';  //y

  Chart1ParametricCurveSeries1.Active:=True;
end;

  //cardioid
procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  Chart1ParametricCurveSeries1.Active:=False;

  FPMathExpressionBridge1.VariableOfFunc:= 't';
  FPMathExpressionBridge1.Expression:= 'd*(2*cos(t)-cos(2*t))';  //x

  FPMathExpressionBridge2.VariableOfFunc:= 't';
  FPMathExpressionBridge2.Expression:= 'd*(2*sin(t)-sin(2*t))';  //y

  Chart1ParametricCurveSeries1.Active:=True;
end;

                //call after Expression set...
procedure TForm1.FPMathExpressionBridge2ConstantParse(Index: integer; AName: string; out
  AValue: real);
begin          //Case Insensitive!
    if CompareText(AName,'r')=0 then AValue:= 1;
    if CompareText(AName,'d')=0 then AValue:= 0.75;
    if CompareText(AName,'angle')=0 then AValue:= 3.14/8;
    if CompareText(AName,'Vo')=0 then AValue:= 4;
    if CompareText(AName,'G')=0 then AValue:= 9.8;
    if CompareText(AName,'h')=0 then AValue:= 2.5;
    if CompareText(AName,'p')=0 then AValue:= 1.5;
end;
                 //call after Expression set...
procedure TForm1.FPMathExpressionBridge1ConstantParse(Index: integer; AName: string; out AValue: real);
begin     //Case Insensitive!
    if CompareText(AName,'r')=0 then AValue:= 1;
    if CompareText(AName,'d')=0 then AValue:= 0.75;
    if CompareText(AName,'angle')=0 then AValue:= 3.14/8;
    if CompareText(AName,'Vo')=0 then AValue:= 4;
    if CompareText(AName,'h')=0 then AValue:= 2.5;
    if CompareText(AName,'p')=0 then AValue:= 1.5;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    //here just for example....

    //MathExpressionBridge 1 - Case Insensitive!
    FPMathExpressionBridge1.AddConstant('R');
    FPMathExpressionBridge1.AddConstant('d');
    FPMathExpressionBridge1.AddConstant('angle');
    FPMathExpressionBridge1.AddConstant('Vo');
    FPMathExpressionBridge1.AddConstant('h');
    FPMathExpressionBridge1.AddConstant('p');

    FPMathExpressionBridge1.AddVariable('t');

    //MathExpressionBridge 2   - Case Insensitive!
    FPMathExpressionBridge2.AddConstant('R');
    FPMathExpressionBridge2.AddConstant('d');
    FPMathExpressionBridge2.AddConstant('angle');
    FPMathExpressionBridge2.AddConstant('Vo');
    FPMathExpressionBridge2.AddConstant('G');
    FPMathExpressionBridge2.AddConstant('h');
    FPMathExpressionBridge2.AddConstant('p');

    FPMathExpressionBridge2.AddVariable('t');
end;

procedure TForm1.FormDeactivate(Sender: TObject);
begin
   Close;
end;

//About-Help
procedure TForm1.ToolButton4Click(Sender: TObject);
var
    strAbout: TStringList;
begin
    strAbout:= TStringList.Create;
    strAbout.Add('TFPMathExpressionBridge - Version 0.1 - 02/2013');

    strAbout.Add('Author: Jose Marques Pessoa : jmpessoa__hotmail_com');
    strAbout.Add('Acknowledgment: Thank you WP!');

    strAbout.Add('TFPMathExpressionBridge is a warapper for [math]* subset');
    strAbout.Add('of TFPExpressionParse** attempting to establish a easy semantics');
    strAbout.Add('for construction of function graph and expression evaluete.');
    strAbout.Add('0. Warning: at the moment this code is just a "proof-of-concept".');
    strAbout.Add('1.Data');
    strAbout.Add('1.1 Add Data');
     strAbout.Add('Add Constants');
     strAbout.Add('Add Variables');
     strAbout.Add('Add Expressions');
     strAbout.Add('use: AddConstant(''k'')');
          strAbout.Add('AddVariable(''x'')');
          strAbout.Add('AddExpression(''kx+1'')');
     strAbout.Add('Obs.: Data are Case Insensitive!');
    strAbout.Add('1.2 Set Data');
      strAbout.Add('Set Expression         //triggers OnConstantParse...');
      strAbout.Add('use: Expression:= ''k*x+1''');
              strAbout.Add('Helpers:');
                 strAbout.Add('procedure SetExpressionByIndex(Index: integer);');
                 strAbout.Add('function GetExpressionByIndex(Index: integer): string;');
                 strAbout.Add('function GetExpressionIndexByName(AName: string): integer;');
      strAbout.Add('Set VariableOfFunc     //variable of "functions of one variable"');
           strAbout.Add('use: VariableOfFunc:= ''x''');
    strAbout.Add('2.Evaluete');
    strAbout.Add('2.1 Function Evaluete');
      strAbout.Add('function EvalFunc(AValue: real)                //eval function for one variable....');
           strAbout.Add('use: EvalFunc(AValue)');
      strAbout.Add('function EvalFunc(AValues: array of real)      //eval function for many variables...');
           strAbout.Add('EvalFunc([AValue1, AValue2, AValue3])');
    strAbout.Add('2.2 Expression Evaluete //event driver');
      strAbout.Add('function EvalExpr(Expr: string; ANamesVar: array of string)');
      strAbout.Add('use:  EvalExpr(''A*x**x+ B*x + C'', [''x'',''A'',''B'',''C'']) //triggers OnVariableParse');
      strAbout.Add('function EvalExpr' );
            strAbout.Add('use:');
            strAbout.Add('AddConstant(''A'')');
            strAbout.Add('AddConstant(''B'')');
            strAbout.Add('AddConstant(''C'')');
            strAbout.Add('AddVariable(''x'')');
            strAbout.Add('Expression:= ''A*x**x+ B*x + k*C''');
            strAbout.Add('EvalExpr; //triggers OnVariableParse');
    strAbout.Add('3. Events');
    strAbout.Add('3.1 OnConstantParse  //triggers every time Expression is Set.....');
       strAbout.Add('use: set constant value');
    strAbout.Add('3.2 OnVariableParse  //triggers every time EvalExpr is called.....');
       strAbout.Add('use: set variable value');
    strAbout.Add('4.Add "building" function');
     strAbout.Add('//signature:');
      strAbout.Add('type');
        strAbout.Add('TExprFunc = procedure(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);');
      strAbout.Add('//"Add building" funtion code example:');
      strAbout.Add('Procedure ExprDelta(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);');
      strAbout.Add('var');
         strAbout.Add('a,b,c: Double;');
      strAbout.Add('begin');
         strAbout.Add('a := ArgToFloat(Args[0]);');
         strAbout.Add('b := ArgToFloat(Args[1]);');
         strAbout.Add('c := ArgToFloat(Args[2]);');
         strAbout.Add('if IsNumber(a) and IsNumber(b) and IsNumber(c) then');
             strAbout.Add('Result.resFloat := b*b - 4*a*c');
         strAbout.Add('else');
            strAbout.Add('result.resFloat := NaN;');
      strAbout.Add('end;');
      strAbout.Add('4.1 AddFunction(AName: string; paramCount: integer; callFunc: TExprFunc)');
      strAbout.Add('Use:');
        strAbout.Add('AddFunction(''Delta'', 3, @ExprDelta);');
      strAbout.Add('Use:');
        strAbout.Add('Expression:=''Delta(2,4,1)'';');
        strAbout.Add('EvalExpr;');
    strAbout.Add('5. Have Fun!');
    //--------------------------------
    strAbout.Add('*FParser.BuiltIns:= [bcMath]');
    strAbout.Add('**(freepascal fpexprpars.pas) More specifically a WP revision and addOns.');
    strAbout.Add('(Thank you WP!)');
    strAbout.Add('See: http://www.lazarus.freepascal.org/index.php/topic,19627.0.html');
    AboutBridge.MemoAbout.Append(strAbout.Text);
    AboutBridge.Execute;

    strAbout.Free;
end;


end.

