unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, TAFuncSeries, TASeries,
  Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ComCtrls, Menus, StdCtrls, Buttons, Spin, fpexprpars_wp, FPMathExpressionBridge, dlgAbout;

type

  { TForm1 }

  TForm1 = class(TForm)
    Chart1: TChart;
    Chart1FuncSeries1: TFuncSeries;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    FloatSpinEdit1: TFloatSpinEdit;
    FPMathExpressionBridge1: TFPMathExpressionBridge;
    ImageList1: TImageList;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    MenuItem1: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    procedure Chart1FuncSeries1Calculate(const AX: Double; out AY: Double);
    procedure FormCreate(Sender: TObject);
    procedure FPMathExpressionBridge1ConstantParse(Index: integer; AName: string; out
      AValue: real);
    procedure FPMathExpressionBridge1VariableParse(Index: integer; AName: string; out
      AValue: real);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem16Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure PopupMenu1Close(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
  private
    { private declarations }
    Delta_has_already_been_created: boolean;
  public
    { public declarations }
  end;

  Procedure ExprDelta(Var Result: TFPExpressionResult; Const Args: TExprParameterArray);

var
  Form1: TForm1;

implementation

{$R *.lfm}
uses
  typ, mpspe_wp;

{ TForm1 }

procedure TForm1.Chart1FuncSeries1Calculate(const AX: Double; out AY: Double);
var
   R: TEvalueteResult;
begin
   R:= FPMathExpressionBridge1.EvalFunc(AX);
   if R.IsValid then
      AY:= R.Value
   else
      AY:= 0; {or others things....}
end;

//k*(2*sin(x)-sin(2*x))
procedure TForm1.ToolButton2Click(Sender: TObject);
begin
  Chart1FuncSeries1.Active:= False;

  FPMathExpressionBridge1.AddVariable(Edit2.Text); //x
  FPMathExpressionBridge1.AddConstant(Edit3.Text); //k

  FPMathExpressionBridge1.VariableOfFunc:= Edit2.Text; //x
  FPMathExpressionBridge1.Expression:= Edit1.Text;
  Chart1FuncSeries1.Active:= True;  //triggers callback TForm1.Chart1FuncSeries1Calculate
end;

procedure TForm1.PopupMenu1Close(Sender: TObject);
var
    sText: string;
begin
    sText:= (Sender as TMenuItem).Caption;
    if CompareText(sText, 'Exit') = 0  then
      Application.Terminate
    else
    begin
       Chart1FuncSeries1.Active:= False;
       FPMathExpressionBridge1.VariableOfFunc:= 'x';
       FPMathExpressionBridge1.Expression:= sText;
       Chart1FuncSeries1.Active:= True;  //triggers callback TForm1.Chart1FuncSeries1Calculate
    end;
end;

//OnConstantParse ...  call after Expression set...
procedure TForm1.FPMathExpressionBridge1ConstantParse(Index: integer; AName: string; out AValue: real);
begin
    if CompareText(AName,'a')=0 then AValue:= 1;
    if CompareText(AName,'b')=0 then AValue:= 4;
    if CompareText(AName,'c')=0 then AValue:= 5;
    if CompareText(AName,'d')=0 then AValue:= 1;
    if CompareText(AName,'r')=0 then AValue:= 1;
    if CompareText(AName,'k')=0 then AValue:= FloatSpinEdit1.Value;
end;

//OnVariableParse
procedure TForm1.FPMathExpressionBridge1VariableParse(Index: integer; AName: string; out AValue: real);
begin
  if AName = 'Z' then AValue:= 1;
  if AName = 'Q' then AValue:= 2;
  if AName = 'T' then AValue:= 3;
end;

////EvalExpr
procedure TForm1.MenuItem11Click(Sender: TObject);
var
  R: TEvalueteResult;
begin                                  //2*1+3*2+4*3 = 20
  R:= FPMathExpressionBridge1.EvalExpr('2*Z+3*Q+4*T',['Z','Q','T']); //callback OnVariableParse
  ShowMessage(FloatToStrF(R.Value, ffFixed,0,2));
end;

//EvalExpr
procedure TForm1.MenuItem15Click(Sender: TObject);
var
    R: TEvalueteResult;
begin
    R:= FPMathExpressionBridge1.EvalExpr('Max(10,40)',[]); //callback OnVariableParse
    ShowMessage(FloatToStrF(R.Value, ffFixed,0,2));
end;

//EvalExpr
procedure TForm1.MenuItem16Click(Sender: TObject);
var
    R: TEvalueteResult;
begin
    FPMathExpressionBridge1.Expression:='Power(2,3)';
    R:= FPMathExpressionBridge1.EvalExpr;
    ShowMessage(FloatToStrF(R.Value, ffFixed,0,2));
end;
        //new "building" function ...
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
    Result.resFloat := NaN;
end;
            //add new "building" function ...
procedure TForm1.MenuItem18Click(Sender: TObject);
var
    R: TEvalueteResult;
begin
   //add
   if not Delta_has_already_been_created then
   begin
      FPMathExpressionBridge1.AddFunction('Delta', 3 {param count}, @ExprDelta);
      Delta_has_already_been_created:= True;
   end;

   //use
   FPMathExpressionBridge1.Expression:='Delta(2,4,1)';
   R:= FPMathExpressionBridge1.EvalExpr;
   ShowMessage(FloatToStrF(R.Value, ffFixed,0,2));
end;

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

procedure TForm1.FormCreate(Sender: TObject);
begin
     Delta_has_already_been_created:=False;
    //here just for example....

    //constants are CASE insensitive
    FPMathExpressionBridge1.AddConstant('A');
    FPMathExpressionBridge1.AddConstant('B');
    FPMathExpressionBridge1.AddConstant('C');
    FPMathExpressionBridge1.AddConstant('D');
    FPMathExpressionBridge1.AddConstant('R');

    //variables  are CASE insensitive
    FPMathExpressionBridge1.AddVariable('x');
    FPMathExpressionBridge1.AddVariable('t');
end;

end.

