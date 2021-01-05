unit u_accueil;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ExtCtrls, StdCtrls;

type

  { Tf_accueil }

  Tf_accueil = class(TForm)
    lbl_appli: TLabel;
    lbl_sat: TLabel;
    item_clients: TMenuItem;
    item_sites: TMenuItem;
    item_intervention: TMenuItem;
    item_quitter: TMenuItem;
    item_prest: TMenuItem;
    item_contrats: TMenuItem;
    item_accueil: TMenuItem;
    mnu_main: TMainMenu;
    pnl_selection: TPanel;
    pnl_travail: TPanel;
    pnl_info: TPanel;
    pnl_ariane: TPanel;
    procedure FormShow(Sender: TObject);
    procedure item_quitterClick(Sender: TObject);
    procedure mnu_item_Click(Sender: TObject);
    procedure choix_item_liste;
  private

  public

  end;

var
  f_accueil: Tf_accueil;

implementation

{$R *.lfm}

{ Tf_accueil }

USES u_feuille_style,   u_select_intervention,   u_list_intervention, , u_detail_intervention ;

procedure Tf_accueil.item_quitterClick(Sender: TObject);
begin
  close;
end;

procedure Tf_accueil.FormShow(Sender: TObject);
begin
     style.panel_selection (pnl_ariane);
     style.panel_defaut     (pnl_selection);
     style.panel_travail     (pnl_travail);
     style.panel_defaut     (pnl_info);
     f_accueil.width := 1200;
     f_accueil.height :=  800;
end;


procedure Tf_accueil.mnu_item_Click(Sender: TObject);
var
   item : TMenuItem;
begin
   pnl_selection.show;

   pnl_ariane.Caption := '';
   item := TmenuItem(Sender);
   repeat
         pnl_ariane.caption := ' >' + item.caption +pnl_ariane.Caption;
         item := item.parent;
   until item.parent = nil;
      item := TmenuItem(Sender);
      if item=item_intervention then choix_item_liste;
end;

procedure Tf_accueil.choix_item_liste;
begin
      f_list_intervention.borderstyle := bsNone;
      f_list_intervention.parent  := pnl_travail;
      f_list_intervention.align  := alClient;
      f_list_intervention.init;
      f_list_intervention.show ;
      f_select_intervention.borderstyle := bsNone;
      f_select_intervention.parent          := pnl_selection;
      f_select_intervention.align            := alClient;
      f_select_intervention.init;
      f_select_intervention.show;

       f_detail_intervention.borderstyle := bsNone;
       f_detail_intervention.parent      := pnl_travail;
       f_detail_intervention.align       := alClient;

end;



end.

