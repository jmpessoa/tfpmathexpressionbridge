unit dlgAbout;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TAboutBridge }

  TAboutBridge = class(TForm)
    Button1: TButton;
    MemoAbout: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
  private
    { private declarations }
  public
    { public declarations }
    AboutCaption: string;
    function Execute: Boolean; // added by you
  end;

var
  AboutBridge: TAboutBridge;

implementation

{$R *.lfm}

function TAboutBridge.Execute: Boolean;
begin
   Result := (ShowModal = mrOK);
   AboutCaption := Self.Caption;
end;

end.

