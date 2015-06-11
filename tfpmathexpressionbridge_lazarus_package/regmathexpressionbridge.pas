unit regmathexpressionbridge;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,
  FPMathExpressionBridge, LResources;

Procedure Register;

implementation

Procedure Register;

begin
  {$I fpmathexpressionbridge_icon.lrs}
  RegisterComponents('Graphics Bridges',[TFPMathExpressionBridge]);
end;

end.

