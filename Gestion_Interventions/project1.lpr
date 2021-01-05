program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, datetimectrls, zcomponent, u_accueil, u_feuille_style,
  u_select_intervention, u_list_intervention, u_detail_intervention,
  u_facture_list, u_facture_ajout, u_modele
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(Tf_accueil, f_accueil);
  Application.CreateForm(Tf_select_intervention, f_select_intervention);
  Application.CreateForm(Tf_list_intervention, f_list_intervention);
  Application.CreateForm(Tf_detail_intervention, f_detail_intervention);
  Application.CreateForm(Tf_facture_list, f_facture_list);
  Application.CreateForm(Tf_facture_ajout, f_facture_ajout);
  Application.Run;
end.

