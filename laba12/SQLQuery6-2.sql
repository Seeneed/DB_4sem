use UNIVER;
-- B --
begin transaction
-- t1 --
insert SUBJECT values('ТПВИ','Технологии программирования в интернет','ОХ');
commit;
-- t2 --
delete SUBJECT where SUBJECT = 'ТПВИ';