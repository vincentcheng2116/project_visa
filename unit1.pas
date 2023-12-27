unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  session;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Memo_tx: TMemo;
    Panel1: TPanel;
    Splitter1: TSplitter;
    VisaSession1: TVisaSession;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Memo_txDblClick(Sender: TObject);
  private

  public

  end;

const
  ADDRESS = 'GPIB0::15::INSTR';

var
  Form1: TForm1;


implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  VisaSession1 := TVisaSession.Create(nil);

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  VisaSession1.Destroy;

end;

procedure TForm1.Button1Click(Sender: TObject);
var
  s: string;
begin
  s := VisaSession1.read();
  memo1.Lines.add(s);
end;

procedure TForm1.FormShow(Sender: TObject);
var
  s: string;
begin
  VisaSession1.Address := ADDRESS;
  VisaSession1.Active := True;
  memo1.Lines.Add(VisaSession1.Query('*IDN?'));
  VisaSession1.Write('*IDN?');
  s := VisaSession1.Read;
  memo1.lines.add(s);
end;

procedure TForm1.Memo_txDblClick(Sender: TObject);
var
  s:string;
begin
    s := Memo_tx.Lines[(Memo_tx.CaretPos.y)];
  Memo1.Lines.Add('Send:' + s);
  if pos('?',s)>0 then
  begin
    memo1.Lines.Add(VisaSession1.Query(s));
    exit;
  end;
  if trim(s)='' then
  begin
    //
  end
  else
  begin
     VisaSession1.write(s)
  end;



end;

end.
