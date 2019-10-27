/*
set echo off; 
set verify off;
set feed off;
*/
drop table tligne purge;
create table tligne (ligne varchar2(200));
variable vnocli char(6);
prompt Saisissez un numero client:
accept vnocli
declare
dreflog char(4);
dloyer number(10,2);
begin
	select reflog, loyer into dreflog, dloyer
	from tlogt2018
	where noloc='&vnocli';
	insert into tligne values('reflog' || dreflog);
	insert into tligne values('loyer' || dloyer);	
exception
	when no_data_found
	then insert into tligne values('Aucune location pour ce client');
	when too_many_rows
	then insert into tligne values('Plusieurs locations pour ce client');

end;
/

select * from tligne;
/*
set echo on; 
set verify on;
set feed on;
*/