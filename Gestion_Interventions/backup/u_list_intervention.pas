unit u_list_intervention;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, u_liste;

type

  { Tf_list_intervention }

  Tf_list_intervention = class(TF_liste)
    procedure btn_line_addClick(Sender: TObject);
    procedure btn_line_deleteClick(Sender: TObject);
    procedure btn_line_detailClick(Sender: TObject);
    procedure btn_line_editClick(Sender: TObject);
  procedure Init;
  private

  public

  end;

var
  f_list_intervention: Tf_list_intervention;

implementation

{$R *.lfm}

uses    u_feuille_style, u_detail_intervention ;

procedure Tf_list_intervention.btn_line_addClick(Sender: TObject);
begin
   f_detail_intervention.add;
end;

procedure Tf_list_intervention.btn_line_deleteClick(Sender: TObject);
begin
    f_detail_intervention.delete (sg_liste.cells[0,sg_liste.row]);
end;

procedure Tf_list_intervention.btn_line_detailClick(Sender: TObject);
begin
   f_detail_intervention.detail (sg_liste.cells[0,sg_liste.row]);
end;

procedure Tf_list_intervention.btn_line_editClick(Sender: TObject);
begin
    f_detail_intervention.edit (sg_liste.cells[0,sg_liste.row]);
end;

procedure Tf_list_intervention.Init;
begin
  style.panel_travail(pnl_titre);
  style.panel_travail(pnl_btn);
  style.panel_travail(pnl_affi);
  style.grille (sg_liste);
end;
end.

