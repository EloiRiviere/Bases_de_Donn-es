
drop table tligne purge;
create table tligne(ligne varchar2(200));

variable vreflog char(4);
prompt saisissez une reference logement SVP
accept vreflog

declare 
dreflog char(4);
dcpt number;
dnoloc char(6);
dsuperf number(4);
dloyer number(10,2);
dnomcli varchar2(20);

begin
select count(*) into dcpt from tlogt2018 where reflog='&vreflog';
if dcpt = 0
	then insert into tligne values ('numero logement inconnu');
else
	select noloc, superf, loyer into dnoloc, dsuperf, dloyer from tlogt2018 where reflog='&vreflog';
		if dnoloc is null
	then insert into tligne values ('superf' || dsuperf);
	insert into tligne values ('loyer' || dloyer);
		else
		insert into tligne values ('superf' || dsuperf);
		insert into tligne values ('loyer' || dloyer);
		insert into tligne values ('num locataire'|| dnoloc);
		end if;
	
		
	end if;


end;
/

select * from tligne;
set echo on; 
set verify on;
set feed on;
