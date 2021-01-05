unit u_detail_intervention;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, DateTimePicker, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, StdCtrls;

type

  { Tf_detail_intervention }

  Tf_detail_intervention = class(TForm)
    btn_retour: TButton;
    btn_valider: TButton;
    edt_total: TEdit;
    edt_num_conseiller: TEdit;
    edt_num_contrat: TEdit;
    edt_dt: TDateTimePicker;
    edt_de: TDateTimePicker;
    edt_a: TDateTimePicker;
    edt_num: TEdit;
    lbl_num_erreur: TLabel;
    lbl_contrat_erreur: TLabel;
    lbl_conseiller_erreur: TLabel;
    lbl_facture_erreur: TLabel;
    lbl_total: TLabel;
    lbl_facture: TLabel;
    lbl_conseiller: TLabel;
    lbl_num_contrat: TLabel;
    lbl_adresse: TLabel;
    lbl_client: TLabel;
    lbl_installateur: TLabel;
    lbl_contrat: TLabel;
    lbl_num: TLabel;
    lbl_le: TLabel;
    lbl_de: TLabel;
    lbl_a: TLabel;
    lbl_maj: TLabel;
    lbl_ident: TLabel;
    mmo_conseiller: TMemo;
    mmo_adresse: TMemo;
    mmo_client: TMemo;
    mmo_installateur: TMemo;
    pnl_facture_titre: TPanel;
    pnl_facture_list: TPanel;
    pnl_facture_ajout: TPanel;
    pnl_facture: TPanel;
    pnl_conseiller: TPanel;
    pnl_contrat: TPanel;
    pnl_ident: TPanel;
    pnl_detail: TPanel;
    pnl_btn: TPanel;
    pnl_titre: TPanel;
    procedure btn_validerClick(Sender: TObject);
    procedure init ( idint : string; affi : boolean);
    procedure detail   ( idint : string);
    procedure edit      ( idint : string);
    procedure add;
    procedure delete  ( idint : string);

  private
    procedure btn_retourClick(Sender: TObject);
    procedure edt_numEnter(Sender: TObject);
    procedure edt_numExit(Sender: TObject);
    procedure edt_num_conseillerExit(Sender: TObject);
    procedure  edt_Enter (Sender : TObject );
    procedure affi_page;
    procedure affi_contrat      (num : string);
    procedure affi_conseiller     (num : string);
    function  affi_erreur_saisie     (erreur : string; lbl : TLabel; edt : TEdit) : boolean;
  public

  end;

var
  f_detail_intervention: Tf_detail_intervention;

implementation

{$R *.lfm}

uses u_feuille_style, u_list_intervention, u_facture_list, u_facture_ajout, u_modele, u_loaddataset;

{ Tf_detail_intervention }

Var oldvaleur  : string; // utilisée dans la modification pour comparer l’ancienne valeur avec la saisie
    id  : string; // variable active dans toute l'unité, contenant l'id infraction affichée

procedure Tf_detail_intervention.btn_retourClick(Sender: TObject);
begin
 close;
end;

procedure Tf_detail_intervention.edt_numEnter(Sender: TObject);
begin

end;

procedure Tf_detail_intervention.edt_numExit(Sender: TObject);
begin
  edt_num.text := TRIM(edt_num.text);
end;

procedure Tf_detail_intervention.edt_num_conseillerExit(Sender: TObject);
begin
  mmo_conseiller.text := TRIM(mmo_conseiller.text);
  IF   NOT  ( mmo_conseiller.text = oldvaleur )
  THEN affi_conseiller (mmo_conseiller.text);
end;

procedure	Tf_detail_intervention.Init   ( idint : string;	affi : boolean);
//  ajout nouvelle infraction : id est vide
// affichage détail d'une infraction : affi est vrai sinon affi est faux
begin
   style.panel_travail (pnl_titre);
   style.panel_travail (pnl_btn);
   style.panel_travail (pnl_detail);
   style.panel_travail  (pnl_ident);
	style.label_titre  (lbl_ident);
   style.panel_travail (pnl_contrat);
	style.label_titre (lbl_contrat);
   style.panel_travail (pnl_conseiller);
	style.label_titre (lbl_conseiller);
   style.panel_travail (pnl_facture);
	style.panel_travail (pnl_facture_titre);
		style.label_titre (lbl_facture);
	style.panel_travail (pnl_facture_list);
	style.panel_travail (pnl_facture_ajout);

// initialisation identification
           edt_num.clear;
           edt_num.ReadOnly	:=affi;
           edt_dt.NullInputAllowed	:=false;   // valeur nulle interdite : zone obligatoirement renseignée
           edt_dt.DateMode	:=dmComboBox;   //mode liste déroulante
           edt_dt.ReadOnly	:=affi;
           edt_de.NullInputAllowed	:=false;   // valeur nulle interdite : zone obligatoirement renseignée
           edt_de.DateMode	:=dmComboBox;   //mode liste déroulante
           edt_de.ReadOnly	:=affi;
           edt_a.NullInputAllowed	:=false;   // valeur nulle interdite : zone obligatoirement renseignée
           edt_a.DateMode	:=dmComboBox;   //mode liste déroulante
           edt_a.ReadOnly	:=affi;

// initialisation contrat
           edt_num_contrat.clear;
           edt_num_contrat.ReadOnly	:=affi;
           mmo_adresse.clear;
           mmo_adresse.ReadOnly	:=affi;
           mmo_client.clear;
           mmo_client.ReadOnly	:=affi;
           mmo_installateur.clear;
           mmo_installateur.ReadOnly	:=affi;

// initialisation conseiller
              edt_num_conseiller.clear;
              edt_num_conseiller.ReadOnly		:=affi;
              mmo_conseiller.clear;
              mmo_conseiller.ReadOnly		:=affi;

   btn_retour.visible	:=affi;  // visible quand affichage détail

// initialisation facture

   show;
   f_facture_list.borderstyle	      := bsNone;
   f_facture_list.parent	      := pnl_facture_list;
   f_facture_list.align	      := alClient;
   f_facture_list.init(affi);
   f_facture_list.show;
   f_facture_list.affi_data(modele.intervention_facture(idint));
   f_facture_list.affi_total;
   f_facture_ajout.borderstyle   := bsNone;
   f_facture_ajout.parent	      := pnl_facture_ajout;
   f_facture_ajout.align	      := alClient;

   id  := idint;
   IF  NOT  ( id = '')   // affichage/modification infraction
   THEN  affi_page;

end;

procedure Tf_detail_intervention.btn_validerClick(Sender: TObject);
var
    flux	     : TLoadDataSet;
    saisie, erreur, ch	 : string;
    i 	     : integer;
    valide  : boolean;
begin
    valide := true;

    erreur := '';
    if  f_facture_list.sg_liste.RowCount = 0
    then  begin
              erreur := 'La facture doit être renseignée.';
              valide := false;
    end;
    lbl_facture_erreur.caption := erreur;

    erreur := '';
    saisie := edt_num_conseiller.text;
    if  NOT (saisie = '')
    then  begin
             ch  := modele.intervention_conseiller(saisie);
             if  ch = ''  then  erreur := 'numéro inexistant.';
    end;
    valide := affi_erreur_saisie (erreur, lbl_conseiller_erreur, edt_num_conseiller)  AND  valide;

    erreur := '';
    saisie := edt_num_contrat.text;
    if  saisie = ''  then  erreur := 'Le contrat doit être rempli.'
    else  begin
             ch := modele.intervention_contrat(saisie);
	  if  ch = ''  then erreur := 'numéro inexistant.';
    end;
    valide := affi_erreur_saisie (erreur, lbl_contrat_erreur, edt_num_contrat)  AND  valide;

       if  id = ''
   then  begin
            erreur := '';
            saisie := edt_num.text;
            if   saisie = ''   then  erreur := 'Le numéro doit être rempli.'
           else  begin
                   flux := modele.intervention_liste_num(saisie);
                   if  NOT  flux.endOf
                   then  erreur := 'Le numéro existe déjà';
           end;
           valide := affi_erreur_saisie (erreur, lbl_num_erreur, edt_num)  AND  valide;
   end;

       	if  NOT  valide
	then  messagedlg ('Erreur enregistrement Intervention', 'La saisie est incorrecte.' +#13 +'Corrigez la saisie et validez à nouveau.', mtWarning, [mbOk], 0)
	else  begin
              if  id =''
	      then  modele.intervention_insert(edt_num.text, edt_num_contrat.text, datetostr(edt_dt.date), datetostr(edt_de.date), datetostr(edt_a.date))
	      else begin
	         modele.intervention_update(edt_num.text, edt_num_contrat.text,  edt_num_contrat.text, datetostr(edt_dt.date), datetostr(edt_de.date), datetostr(edt_a.date));
		  // suppression de la composition de l'amende
		    modele.intervention_facture_delete (edt_num.text);
	      end;

        i := 1;
   	while  ( i  <  f_facture_list.sg_liste.RowCount )
   	do  begin
           modele.intervention_facture_insert (edt_num.text, f_facture_list.sg_liste.Cells[0,i]);
           i := i +1;
   	end;
   	if  id=''   then   f_list_intervention.line_add(modele.intervention_liste_num(edt_num.text))
   	else
          f_list_intervention.line_edit(modele.intervention_liste_num(id));
   	close;
   end;



end;

procedure Tf_detail_intervention.detail(idint: string);
begin
   init (idint, true);    // mode affichage
   pnl_titre.caption	:= 'Détail d''une intervention';
   edt_dt.DateMode	:= dmNone;	// zone date sans liste déroulante
   btn_retour.setFocus;
end;

procedure Tf_detail_intervention.edit(idint: string);
begin
   init (idint, false);
   pnl_titre.caption	:= 'Modification d''une intervention';
   edt_num.ReadOnly	 := true;
   edt_dt.setFocus;
end;

procedure Tf_detail_intervention.add;
begin
   init ('',false);   // pas de numéro d'intervention
   pnl_titre.caption   := 'Nouvelle intervention';
   edt_dt.Date	           := date;   // initialisation à la date du jour
   edt_num.setFocus;
end;

procedure Tf_detail_intervention.delete(idint: string);
begin
  IF   messagedlg ('Demande de confirmation'
	,'Confirmez-vous la suppression de l''intervention n°' +idint
	,mtConfirmation, [mbYes,mbNo], 0, mbNo) = mrYes
   THEN  BEGIN
          modele.intervention_facture_delete (idint);
          modele.intervention_delete (idint);
               f_list_intervention.line_delete;
   END;
end;

procedure Tf_detail_intervention.affi_page;
var
    flux : TLoadDataSet;
begin
     flux   := modele.intervention_num(id);
     flux.read;
     edt_num.text	:= flux.Get('id_interv');
     edt_dt.date	:= strtodate(flux.Get('date_interv'));
     edt_num_contrat.text	:= flux.Get('no_contrat');
     edt_num_conseiller.text	:= flux.Get('no_cons');
     flux.destroy;
     affi_contrat	(edt_num_contrat.text);
     affi_conseiller	(edt_num_conseiller.text);
end;

{ Tf_detail_intervention }

 procedure Tf_detail_intervention.edt_Enter(Sender : TObject);
 begin
   oldvaleur := TEdit(Sender).text;
 end;

 procedure Tf_detail_intervention.affi_contrat (num : string);
var
   ch : string;
begin
     mmo_adresse.clear;
     mmo_client.clear;
     mmo_installateur.clear;
   if  num = ''
   then  mmo_adresse.lines.add('contrat non identifié.')
   else  begin
               ch := modele.intervention_contrat(num);
    if  ch = ''	then mmo_adresse.lines.add('adresse inconnue.')
    else begin
            mmo_client.lines.text := ch;
            ch := modele.contrat_client(num);
            if  ch =''
            then  mmo_client.lines.add('client inconnu.')
            else begin
                    lbl_client.visible := true;
                    mmo_client.lines.text := ch;
    begin
            mmo_installateur.lines.text := ch;
            ch := modele.contrat_conseiller(num);
            if  ch =''
            then  mmo_installateur.lines.add('installateur inconnu.')
            else begin
                    lbl_installateur.visible := true;
                    mmo_installateur.lines.text := ch;
                    end;
            end;

   end;
end;
end;
end;

 procedure Tf_detail_intervention.affi_conseiller (num : string);
var
   ch : string;
begin
   mmo_conseiller.clear;
   if  num = ''
   then  mmo_conseiller.lines.add('conseiller non identifié.')
   else  begin
    ch := modele.intervention_conseiller(num);
    if  ch = ''	then mmo_conseiller.lines.add('conseiller  inconnu.')
    else  mmo_conseiller.lines.text := ch;
   end;
end;

 function  Tf_detail_intervention.affi_erreur_saisie (erreur : string; lbl : TLabel; edt : TEdit) : boolean;
begin
   lbl.caption := erreur;
   if  NOT (erreur = '')
   then begin
	edt.setFocus;
	result := false;
   end
   else result := true;
end;

end.

