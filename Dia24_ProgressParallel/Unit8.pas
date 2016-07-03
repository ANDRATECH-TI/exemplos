unit Unit8;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  System.LogEvents.Progress,
  System.LogEvents,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin;

type
  TForm8 = class(TForm)
    Button1: TButton;
    SpinEdit1: TSpinEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

{$R *.dfm}

procedure TForm8.Button1Click(Sender: TObject);
var
  LProgr: IProgressEvents;
  i: integer;
begin
  // inicializa a janela de progresso
  LProgr := TProgressEvents.new;
  LProgr.max := 100;  // opcional: marca o n�mero m�ximo itens
  LProgr.MaxThreads := SpinEdit1.Value ;  // indica o n�mero m�ximo de threads em paralelo
  LProgr.CanCancel := true;    // marca se pode cancelar a opera��o

  for i := 1 to 100 do
  begin   // loop de demonstra��o - simulando uma lista de processos
    LProgr.Text := 'Produto: ' + intToStr(i);   // texto livre
    LProgr.add(i, 'Produto: ' + intToStr(i),    // processo a executar
      procedure(x: integer)
      var
        n: integer;
        msg: string;
      begin
        msg := 'Produto: ' + intToStr(x);    // processo em execu��o
        LogEvents.DoProgress(self, 0, etStarting, msg);
        n := Random(10000);
        sleep(n);
        LogEvents.DoProgress(self, 0, etWorking, msg);
        n := Random(10000);
        if LProgr.Terminated then exit;    // checa se o usuario cancelou a opera��o
        sleep(n);
      end);
    if LProgr.Terminated then
      break;
  end;
  LogEvents.DoProgress(self, 0, etAllFinished, '');  // sinaliza que todas os processo foram completados.
end;

end.
