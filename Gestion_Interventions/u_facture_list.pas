unit u_facture_list;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, Grids, StdCtrls, u_liste;

type

  { Tf_facture_list }

  Tf_facture_list = class(TF_liste)
    lbl_titre: TLabel;
    lbl_facture_total: TLabel;
    procedure btn_line_addClick(Sender: TObject);
    procedure btn_line_deleteClick(Sender: TObject);
    procedure Init (affi : boolean);
    procedure affi_total;
  private

  public

  end;

var
  f_facture_list: Tf_facture_list;

implementation

{$R *.lfm}

uses   u_feuille_style, u_facture_ajout;

procedure  Tf_facture_list.Init (affi : boolean);
begin
   style.panel_travail(pnl_titre);
   style.panel_travail(pnl_btn);
   style.panel_travail(pnl_affi);
   style.label_titre  (lbl_facture_total);
   style.grille (sg_liste);
   sg_liste.Columns[2].Alignment:=taRightJustify;
   lbl_facture_total.caption := '';
   pnl_btn_page.Hide;
   btn_line_detail.Hide;
   btn_line_edit.hide;
   pnl_btn_ligne.visible := NOT affi;
   f_facture_ajout.hide;
end;

procedure Tf_facture_list.btn_line_addClick(Sender: TObject);
begin
  pnl_btn_ligne.visible := false;
  f_facture_ajout.add;
end;

procedure Tf_facture_list.btn_line_deleteClick(Sender: TObject);
begin
  f_facture_ajout.delete;
end;

procedure  Tf_facture_list.affi_total;
begin
   lbl_facture_total.caption := '  ' +floattostrF(f_facture_list.SumColumn('tarif'),FFFixed,7,2) +' €';
end;




end.

