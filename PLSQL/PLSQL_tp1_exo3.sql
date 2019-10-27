
set echo off;
set verify off;
set feed off;

drop table tligne purge;
create table tligne(ligne varchar2(400));
variable vreflog char(4);
variable vdate char(10);
variable vnocli char(6);
prompt Entrez la reference du logement
accept vreflog
prompt Entrez la date
accept vdate
prompt Entrez la reference client
accept vnocli
declare
	dreflog char (4);
	dnocli char(6);
	ddate date;
	dfinloc date;
	danciencli char(6);
	dmessage varchar2(400); 
begin
	dmessage:='référence du logement inconnu';
	ddate:=to_date('&vdate','DD/MM/YYYY');
	select reflog into dreflog
	from Tlogt2018
	where reflog='&vreflog';

	dmessage:='numero du client inconnu';
	select nocli into dnocli from tclient2018
	where nocli='&vnocli';

	update Tlogt2018
	/*set nocli=dnocli*/
set noloc=dnocli
	where reflog = dreflog;

	update tlocation2018
	set finloc = ddate
	where reflog=dreflog
	and finloc is null;

	/* insert into tlocation2018 values('&vreflog','ddate','null','&vnocli');*/
insert into tlocation2018 values('&vreflog',ddate,null,'&vnocli');
	insert into tligne values('depart du locataire' || danciencli || 'du logement' || dreflog || 'enregistre');
	/*insert into tligne values ('Arrivee du locataire ' || noloc || 'du logement ' || dreflog || 'enregistree.');*/
insert into tligne values ('Arrivee du locataire ' || dnocli || 'du logement ' || dreflog || 'enregistree.');
exception
	when no_data_found
	then insert into tligne values(dmessage);
	when too_many_rows
	then insert into tligne values('ERROR  TOO_MANY_ROWS EXCEPTION');
	
	
end;
/
select * from tligne;

set echo on;
set verify on;
set feed on;

