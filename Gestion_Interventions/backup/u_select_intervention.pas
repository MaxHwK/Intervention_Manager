unit u_select_intervention;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, DateTimePicker, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls;

type

  { Tf_select_intervention }

  Tf_select_intervention = class(TForm)
    btn_rechercher: TButton;
    edt_dtdeb: TDateTimePicker;
    edt_dtfin: TDateTimePicker;
    edt_num_cl: TEdit;
    edt_nom_cl: TEdit;
    edt_num_int: TEdit;
    edt_nom_int: TEdit;
    edt_cont: TEdit;
    edt_num: TEdit;
    lbl_du: TLabel;
    lbl_au: TLabel;
    lbl_num_cl: TLabel;
    lbl_nom_cl: TLabel;
    lbl_num_int: TLabel;
    lbl_nom_int: TLabel;
    pnl_rechercher: TPanel;
    pnl_periode_btn: TPanel;
    pnl_periode_edit: TPanel;
    pnl_periode: TPanel;
    pnl_client_btn: TPanel;
    pnl_client_edit: TPanel;
    pnl_client: TPanel;
    pnl_intervenant_btn: TPanel;
    pnl_intervenant_edit: TPanel;
    pnl_intervenant: TPanel;
    pnl_contrat_btn: TPanel;
    pnl_contrat_edit: TPanel;
    pnl_contrat: TPanel;
    pnl_num_btn: TPanel;
    pnl_num_edit: TPanel;
    pnl_num: TPanel;
    pnl_tous_edit: TPanel;
    pnl_tous_btn: TPanel;
    pnl_tous: TPanel;
    pnl_choix: TPanel;
    pnl_titre: TPanel;
    procedure btn_rechercherClick(Sender: TObject);
    procedure Init;
    procedure  NonSelectionPanel (pnl : TPanel);
    procedure  AucuneSelection;
    procedure  pnl_choix_btnClick (Sender: TObject);
  private

  public

  end;

var
  f_select_intervention: Tf_select_intervention;

implementation

{$R *.lfm}

 uses u_feuille_style;

 var
   pnl_actif : TPanel;

 procedure Tf_select_intervention.Init;
 begin
   style.panel_defaut(pnl_choix);
   style.panel_selection(pnl_titre);
   style.panel_defaut(pnl_rechercher);
   pnl_choix_btnClick (pnl_tous_btn);
 end;

procedure Tf_select_intervention.btn_rechercherClick(Sender: TObject);
begin
   btn_rechercher.visible := false;
   pnl_actif.enabled := false;
end;

 procedure   Tf_select_intervention.pnl_choix_btnClick (Sender : TObject);
var
   pnl :TPanel;
begin
	AucuneSelection;
    pnl := TPanel(Sender);
	style.panel_selection (pnl);
	pnl	:= TPanel(pnl.Parent);	style.panel_selection (pnl);
	Pnl	:= TPanel(f_select_intervention.FindComponent(pnl.name +'_edit'));
	style.panel_selection (pnl);
	pnl.show;
        pnl_actif := pnl;     pnl_actif.enabled := true;
	btn_rechercher.visible := true;
end;

 procedure   Tf_select_intervention.AucuneSelection;
begin
	NonSelectionPanel (pnl_tous);		NonSelectionPanel (pnl_num);
	NonSelectionPanel (pnl_contrat);		NonSelectionPanel (pnl_intervenant);
	NonSelectionPanel (pnl_client);		NonSelectionPanel (pnl_periode);
end;

 procedure  Tf_select_intervention.NonSelectionPanel (pnl : TPanel);
 var
 	pnl_enfant : TPanel;
 begin
 	style.panel_defaut(pnl);
 	pnl_enfant	:= TPanel(f_select_intervention.FindComponent(pnl.name +'_btn'));
 	style.panel_bouton(pnl_enfant);
 	pnl_enfant	:= TPanel(f_select_intervention.FindComponent(pnl.name +'_edit'));
 	pnl_enfant.Hide;
 end;


end.

