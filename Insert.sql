DELETE FROM "Personels";
DELETE FROM "Agreements";
DELETE FROM "Bills";
DELETE FROM "Cashiers";
DELETE FROM "customers";
DELETE FROM "foods";
DELETE FROM "order_Agreement";
DELETE FROM "order_bills";

INSERT INTO "Agreements" VALUES(1,1,1,'2020-12-2','2020-12-3','1' ,100);
INSERT INTO "Agreements" VALUES(2,2,2,'2020-11-3','2020-12-3','2' ,500);
INSERT INTO "Agreements" VALUES(3,3,3,'2020-8-4','2020-12-3','3' ,400);
INSERT INTO "Agreements" VALUES(4,4,4,'2020-9-5','2020-12-3','4' ,300);
INSERT INTO "Agreements" VALUES(5,5,5,'2020-10-6','2020-12-3','5' ,200);

INSERT INTO "Bills" VALUES(1,1,'2020-12-2',1 ,100);
INSERT INTO "Bills" VALUES(2,2,'2020-1-20',2 ,200);
INSERT INTO "Bills" VALUES(3,3,'2020-11-5',3 ,300);
INSERT INTO "Bills" VALUES(4,4,'2020-12-3',4 ,400);
INSERT INTO "Bills" VALUES(5,5,'2020-10-3',5 ,500);

INSERT INTO "Cashiers" VALUES(1,'faeze','mosavi');
INSERT INTO "Cashiers" VALUES(2,'ghazaleh','gholizade');
INSERT INTO "Cashiers" VALUES(3,'sina','ghsemi');
INSERT INTO "Cashiers" VALUES(4,'amir','banar');
INSERT INTO "Cashiers" VALUES(5,'ali','alavi');

INSERT INTO "Personels" VALUES(1,'zahra','firozi' ,'sari_gharan');
INSERT INTO "Personels" VALUES(2,'fateme','faraji' ,'babol_shirokhorshid');
INSERT INTO "Personels" VALUES(3,'mahsa','shams' ,'amol_haraz');
INSERT INTO "Personels" VALUES(4,'reza','abedi' ,'ghaemshahr_emam');
INSERT INTO "Personels" VALUES(5,'mohammad','ghaderi' ,'babol _keshvari');

INSERT INTO "customers" VALUES(1,'ali','taghavi','2150527320','babol' ,'09366351302');
INSERT INTO "customers" VALUES(2,'mehshad','jabari','2150527323','sari' ,'09111284569');
INSERT INTO "customers" VALUES(3,'mahmod','mohammadi','2150526320','amol' ,'09114526897');
INSERT INTO "customers" VALUES(4,'toba','razi','2160527320','shahsavar' ,'09362541478');
INSERT INTO "customers" VALUES(5,'farima','salehi','2150527322','shirgah' ,'09365428725');

INSERT INTO "foods" VALUES(1,'berger',400,'gosht-nan-salad');
INSERT INTO "foods" VALUES(2,'pizaa',900,'gharch-zhambon-gosht');
INSERT INTO "foods" VALUES(3,'sibzamini makhsos',300,'gharch -panir');
INSERT INTO "foods" VALUES(4,'pasta',500,'gharch-pani-pasta');
INSERT INTO "foods" VALUES(5,'sokhari',100,'morgh-panir');

INSERT INTO "order_Agreement" VALUES(1,1,1,1);
INSERT INTO "order_Agreement" VALUES(2,2,2,2);
INSERT INTO "order_Agreement" VALUES(3,3,3,3);
INSERT INTO "order_Agreement" VALUES(4,4,4,4);
INSERT INTO "order_Agreement" VALUES(5,5,5,5);

INSERT INTO "order_bills" VALUES(1,1,1,1);
INSERT INTO "order_bills" VALUES(2,2,2,2);
INSERT INTO "order_bills" VALUES(3,3,3,3);
INSERT INTO "order_bills" VALUES(4,4,4,4);
INSERT INTO "order_bills" VALUES(5,5,5,5);