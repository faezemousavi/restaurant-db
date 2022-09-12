--select
--1
select max(bcost) from public."Bills";
select min(bcost) from public."Bills";
select sum(bcost) from public."Bills";
select avg(bcost) from public."Bills";
--2
select "PFamily" ,sum("ACost") from public."Personels" natural join public."Agreements" group by "PFamily";
--3
select Bcode from public."Bills" where Bdate< '2020-12-3'and Bdate>'2020-1-2'
union(select Bcode from public."Bills" where Bdate<'2020-11-3' and Bdate>'2020-10-3');
--4
select Cname , Cfamily from public."customers" order by Ccm;
--5
select "PName" from public."customers" natural join public."Agreements" natural join public."Personels" as personels where
		Cname like 't%' or Cfamily like'_a%' group by  "PName" having  "PName" like 'm%';
--6
select t.fname from foods as t where t.fdescription like '%gosht%' and t.fname
in(select r.fname from foods as r where r.fdescription like '%nan%');
--7
select "CAfamily" from public."Cashiers" natural join public."Bills" where bcost>300 
except (select "CAfamily" from public."Cashiers"  natural join public."Bills" where Bdate<'2020-12-3');
--8
select "PFamily","PAele" from public."Personels" natural join  public."Agreements" where "ACost">200
intersect (select "PFamily","PAele" from public."Personels" natural join  public."Agreements" natural join  public."customers" where
		  "ccm" like '5%');
--9
select "Number" from public."order_Agreement" natural join public."Agreements" where "ADate"<'2020-9-4';
--10
select f.fname from foods as f
where 1<=(select count(t.fcode)
		 from foods as t , order_bills as o
		 where t.fcode=o."FCode");
--11
select Fcode from foods where (Fcode not in (select Fcode from order_bills));

--12
select distinct  Fname from foods natural left outer join order_bills;

--13
select Fname,Fcost from foods where Fcost >= all (select (Fcost) from foods);

--14
select "CAname","CAcode" from public."Cashiers" where  exists (select * from public."Bills");

--15
select * from customers s where
s.ccm > any (select s2.ccm
			from customers s2
			where ccm > '09366351302');
--trigger
--1
create or replace function upgradeCustomers() returns trigger as $$
begin 
	new.cname = trim(new.cname);
	new.cfamily = trim(new.cfamily);
	new.cname = upper(new.cname);
	new.cfamily = upper(new.cfamily);
	return new;
end;
$$ language plpgsql;

create trigger upgradecustomers
	before insert on "customers"
for each row
execute procedure upgradeCustomers();

insert into public."customers" values (11,'              ali','taghavi','2150527320','babol' ,'09366351302');
select * from "customers"
drop trigger upgradecustomers on "customers" cascade;

--2
create or replace function upgradefoods() returns trigger as $$
begin 
	if new.fcost <500 then
	new.fcost = new.fcost+100;
	end if;
	return new;
end;
$$ language plpgsql;

create trigger upgradefood
	before insert on "foods"
for each row
execute procedure upgradefoods();


INSERT INTO "foods" VALUES(11,'berger2',400,'gosht-nan-salad');
select * from "foods";
drop trigger upgradecustomers on "foods" cascade;

--3 
create or replace function in_outCustomers() returns trigger as $$
begin 
	if length(trim(new.cphone))<=11 then
	raise  exception 'length is rong';
	end if;
	if length(trim(new.ccm)) <=10 then
	raise  exception 'length is rong';
	end if;
	return new;
end;
$$ language plpgsql;

create trigger customers_in
	before insert or update on "customers"
for each row
execute procedure in_outCustomers();

INSERT INTO "customers" VALUES(992,'mehshad','jabari','21548527558','sari' ,'93888456856');
select * from "customers";
drop trigger customers_in on "customers" cascade;

--4
create or replace function in_up_food() returns trigger as $$
begin 
	if new.fname ~ '[0-9]*' then
	raise  exception 'State must character.';
	return null;
	end if;
	return new;
end;
$$ language plpgsql;

create trigger foods
	before insert or update on "foods"
for each row
execute procedure in_up_food();

INSERT INTO "foods" VALUES(713,'1pizaa',900,'gharch-zhambon-gosht');

drop trigger foods on "foods" cascade;

--5
create or replace function Agreement() returns trigger as $$
begin 
	update public."Agreements" as t set "ACost"="ACost"+10
	where t."ACode"=new."ACode";
	return null;
end;
$$ language plpgsql;

create trigger agreement
	after insert  on public."Agreements"
for each row
when(new."ACost"<300)
execute procedure Agreement();

INSERT INTO public."Agreements" VALUES(44,4,4,'2020-9-5','2020-12-3','4' ,30);

select * from PUBLIC."Agreements";
drop trigger upgradecustomers on "Agreements" cascade;

--fuction & procedures
--1
create function ft() returns record as 
$$
declare 
	t record;
begin
	select * into t from "foods"
	where fname like '%a%' and fcost<400;
	if not found then 
		select * into t from "foods"
		where fcost>500;
	end if;
	return t;
end;
$$ language plpgsql;

select ft();

--2
create or replace function chek_cost_food(f1 integer,f2 integer) returns void as 
$$
declare 
	food1 integer;
	food2 integer;
begin
	select fcost into food1 from "foods" where fcode=f1;
	select fcost into food2 from "foods" where fcode=f2;
	if food1>food2 then 
		raise notice 'food1 is larger than food2';
	elsif food2>food1 then
		raise notice 'food2 is larger than food1';
	else
		raise notice 'food2 is equal to food1';
	end if;
end;
$$ language plpgsql;

select chek_cost_food(3,4);

--3
create or replace function insert_food(Fcode integer, Fname character(40),Fcost integer ,Fdesc character(100)) returns void
as $$
begin
insert into foods(fcode,fname ,fcost,fdescription)values(Fcode,Fname,Fcost,Fdesc);
end;
$$ language plpgsql;

select insert_food('10','geyme','700','lape');
select * from foods;

--4
Create or replace Procedure asd()
language plpgsql
as $$
begin
select "PFamily" ,sum("ACost") 
	from public."Personels" natural join public."Agreements" group by "PFamily";

end;
$$ ;
  
call asd();
--5
CREATE OR REPLACE PROCEDURE show(a integer)
LANGUAGE plpgsql    
AS $$
declare t record;
BEGIN
	  UPDATE public."Agreements"  
    SET "ACost" = "ACost" - ("ACost"/0.2)
    WHERE "ACode" = a;
    COMMIT;
END;
$$;
call show(4);
CALL show(1);
SELECT * FROM public."Agreements";


--transaction
--1
begin transaction;
	update foods set fcost=fcost-100 where fcode=1;
	update foods set fcost=fcost+100 where fcode=2;
commit;	

select * from foods;

begin;
update foods set fcost =fcost -100 where fcode=1;
savepoint pointsave;
update foods set fcost=fcost+100 where fcode=2;

rollback to pointsave;
select * from foods;

--2
begin transaction;
	update Public."Agreements" set "ACost"="ACost" - 10 where "ACode"=1;
	update public."Agreements" set "ACost"="ACost"+10 where "ACode"=2;
commit;	

select * from public."Agreements";

begin;
update public."Agreements" set "ACost" ="ACost" -10 where "ACost"=1;
savepoint pointsave;
update public."Agreements" set "ACost"="ACost"+10 where "ACost"=2;

rollback to pointsave;
select * from public."Agreements";

--update & delete
UPDATE public."Personels" SET Pcode=11 where PName='sina'
UPDATE public."order_bills" SET Number=09365248485 where OBcode=1
UPDATE public."foods" SET Fname="makhsos" where Fcost>500 and Fname like 'h%'

delete from "Agreements" where Ccode=5
delete from "customers" where Ccm="2150527322"
delete from "order_Agreements" where Number=09365689752
