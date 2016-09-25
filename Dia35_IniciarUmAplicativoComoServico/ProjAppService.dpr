program ProjAppService;

uses
  Vcl.SvcMgr,
  uServiceApp,
  System.SysUtils,
  UnitApp,
  UnitService in 'UnitService.pas' {AppService: TService};

const
  NomeServico = 'AppService';

{$R *.RES}

begin

  { parametros
      /app  -> executa como aplicativo
      /install -> instala como servi�o
      /uninstall -> desinstala o servi�o
  }


  if IsServiceInstalled(NomeServico) and
    (not(FindCmdLineSwitch('app', ['-', '\', '/'], true))) then
  begin         // � servi�o
    try
     if not Application.DelayInitialize or Application.Installing then
        Application.Initialize;
      Application.CreateForm(TAppService, AppService);
      AppService.name := NomeServico;
      Application.Run;
    finally
    end;
  end
  else
  begin       // � app
      Application.CreateForm(TForm10, Form10);
      form10.ShowModal;
  end;

end.
