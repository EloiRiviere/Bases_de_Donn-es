drop table venteproduit purge;
drop table produit purge;
drop table vente purge;
drop table famille purge;
drop table client purge;

set linesize 250;

create table famille(
CodeFamille char(6) constraint PrimaryKeyFamille primary key,
Nom varchar2(30) constraint NomFamille not null
);

create table client(
ReferenceClient char(6) constraint PrimaryKeyClient primary key,
Nom varchar2(20) constraint NomClient not null,
Rue varchar2(30) constraint Rue not null,
CodePostal char(5) constraint CodePostal not null,
Ville varchar2(20) constraint Ville not null,
TypeClient char(1) constraint TypeClient check(TypeClient in ('G','N')) not null,
TypeTarif char(1) constraint TypeTarif check(TypeTarif in ('0','1','2','3')) not null,
constraint EligibleGrossiste check (not(TypeTarif=0 AND TypeClient='G'))
);

create table produit(
ReferenceProduit char(6) constraint PrimaryKeyProduit primary key,
Designation varchar2(30) constraint Designation not null,
Stock number(6) constraint Stock check(Stock>=0) not null,
CodeEtat char(1) constraint CodeEtatDesStocks not null check(CodeEtat in ('E','D')),
PrixNormal number(8,2) constraint PrixNormal not null,
PrixGrossiste number(8,2) constraint PrixGrossiste not null,
CodeFamille char(6) constraint famille references famille,
constraint CoherencePrix check(PrixNormal>PrixGrossiste)
);

create table vente(
NumVente char(6) constraint PrimaryKeyVente primary key,
DateVente date constraint DateVente not null,
ReferenceClient char(6) constraint ReferenceClientVente references client
);

create table venteproduit(
Quantite number(6) not null,
PrixVenteUnitaire number(8,2) not null,
NumeroVente char(6) not null constraint PKVenteInVenteProduit references vente,
ReferenceProduit char(6) not null constraint ReferenceProduitVenteProduit references produit,
constraint PrimaryKeyVenteProduit primary key(NumeroVente,ReferenceProduit)
);

insert into client values ('CL0001','DUBOIS','46 rue de la Boustifaille','63000','BOURG PALETTE','G','2');
insert into client values ('CL0002','MARTIN','89 bis rue du Supo','63000','DRESSROSA','N','0');
insert into client values ('CL0003','MARTINOT','354 boulevard of Rockendreams','42000','BLANCHERIVE','N','3');
insert into client values ('CL0004','D''AUBERT','98 place du Bucher','63000','NOVIGRAD','N','0');
insert into client values ('CL0005','BALLOT','3 route de Cesttropdommage','42000','ZUT','G','1');
insert into client values ('CL0006','DUBOIS','Forêt de Jade','15000','ALABASTA','G','1');

insert into famille values ('F00001','eclairage');
insert into famille values ('F00002','chauffage');

insert into  produit values('P00001','Ampoule',1500,'D',3,0.90,'F00001');
insert into  produit values('P00002','Radiateur',47,'D',50,45,'F00002');
insert into  produit values('P00003','Led',1001,'D',6,4,'F00001');
insert into  produit values('P00004','Chaudiere',0,'E',150,130,'F00002');
insert into  produit values('P00005','Guirlande',1020,'D',10,7,'F00001');
insert into  produit values('P00006','Bouillotte Hi-Tech',0,'E',5,4,'F00002');

insert into vente values ('V00001','10/08/2015','CL0001');
insert into vente values ('V00002','10/12/2015','CL0001');
insert into vente values ('V00003','20/12/2014','CL0002');
insert into vente values ('V00004','10/01/2013','CL0005');
insert into vente values ('V00005','20/01/2015','CL0001');
insert into vente values ('V00006','25/01/2014','CL0002');


insert into venteproduit values(10,4,'V00001','P00003');
insert into venteproduit values(20,7,'V00001','P00005');
insert into venteproduit values(10,0.90,'V00002','P00001');
insert into venteproduit values(20,4,'V00002','P00003');
insert into venteproduit values(10,3,'V00003','P00001');
insert into venteproduit values(20,6,'V00003','P00003');
insert into venteproduit values(10,0.90,'V00004','P00001');
insert into venteproduit values(20,7,'V00004','P00005');
insert into venteproduit values(10,4,'V00005','P00003');
insert into venteproduit values(20,7,'V00005','P00005');
insert into venteproduit values(10,3,'V00006','P00001');
insert into venteproduit values(20,10,'V00006','P00005');


select * from famille;
select * from client;
select * from produit;
select * from vente;
select * from venteproduit;
select * from cat;
