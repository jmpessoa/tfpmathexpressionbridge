{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit tfpmathexpressionbridge_pack;

interface

uses
  FPMathExpressionBridge, fpexprpars_wp, mpMath_wp, mpspe_wp, 
  regmathexpressionbridge, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('regmathexpressionbridge', @regmathexpressionbridge.Register);
end;

initialization
  RegisterPackage('tfpmathexpressionbridge_pack', @Register);
end.
