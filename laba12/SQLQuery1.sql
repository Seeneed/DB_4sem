--1
set nocount on
if exists (select * from SYS.objects where object_id = object_id(N'dbo.firstTable'))
drop table firstTable;

declare @c int, @flag char = 'c';
set implicit_transactions on
create table firstTable(x int, fields varchar(20));
insert firstTable values(1, 'cat'), (2, 'dog'), (3, 'fox');
set @c = (select count(*) from firstTable);
print 'Количество строк в таблице: ' + cast(@c as varchar(2));
if @flag = 'c' commit;
else rollback;
set implicit_transactions off

if exists(select * from SYS.objects where object_id = object_id(N'dbo.firstTable'))
print 'таблица есть';
else print 'таблицы нет';

--2
use UNIVER;

begin try
begin tran
insert PULPIT values ('ПИ', 'Программная инженерия', 'ИТ');
insert PULPIT values ('ПИ', 'Программная инженерия', 'ИТ');
commit tran;
end try
begin catch
print 'ошибка:' + case
when error_number() = 2627 and patindex('%PK__PULPIT__55166E7F271E95A9%', error_message()) > 0
then 'дублирование специальностей'
else 'неизвестная ошибка:' + cast(error_number() as varchar(5)) + error_message()
end;
if @@TRANCOUNT > 0 rollback tran;
end catch;

--3
declare @point varchar(32);
begin try
begin tran
insert PULPIT values ('ПИ', 'Программная инженерия', 'ИТ');
set @point = 'p1';
save tran @point;
insert PULPIT values ('ПИ', 'Программная инженерия', 'ИТ');
set @point = 'p2';
save tran @point;
commit tran;
end try
begin catch
print 'ошибка:' + case when error_number() = 2627 and patindex('%PK__PULPIT__55166E7F271E95A9%', error_message()) > 0
then 'дублирование специальностей'
else 'неизвестная ошибка:' + cast(error_number() as varchar(5)) + error_message()
end;
if @@TRANCOUNT > 0
begin
print 'контрольная точка:' + @point;
rollback tran @point;
commit tran;
delete PULPIT where PULPIT.PULPIT = 'ПИ'
end;
end catch;

--4
-- A -- 
set transaction isolation level read committed
begin transaction
-- t1 --
select @@SPID, 'insert PULPIT' 'вывод', * from PULPIT where PULPIT.PULPIT = 'ПИ';
select @@SPID, 'insert PULPIT' 'вывод', * from SUBJECT where SUBJECT.PULPIT = 'ПИ';
commit;
-- t2 --

--5
-- A --
set transaction isolation level read committed
begin transaction
select count(*) from SUBJECT where PULPIT = 'ИСиТ';
select SUBJECT, PULPIT from SUBJECT where SUBJECT = 'ИГ';
-- t1 --
-- t2 --
select 'update SUBJECT' 'результат', count(*)
from SUBJECT where PULPIT = 'ИСиТ';
select SUBJECT, PULPIT from SUBJECT where SUBJECT = 'ИГ';
commit;

--6
-- A --
set transaction isolation level repeatable read
begin transaction
select SUBJECT_NAME from SUBJECT where PULPIT = 'ОХ';
-- t1 --
-- t2 --
select case
when SUBJECT = 'ТПВИ' then 'insert SUBJECT' else ''
end 'результат', SUBJECT_NAME from SUBJECT where PULPIT = 'ОХ'
commit;

--7
-- A --
set transaction isolation level serializable
begin transaction
delete SUBJECT where SUBJECT = 'ТПВИ';
insert SUBJECT values('ТПВИ','Технологии программирования в интернет','ИСиТ');
update SUBJECT set SUBJECT_NAME = 'Технологии программирования' where SUBJECT = 'ТПВИ';
select SUBJECT_NAME, PULPIT from SUBJECT where PULPIT = 'ИСиТ';
-- t1 --
select SUBJECT_NAME, PULPIT from SUBJECT where PULPIT = 'ИСиТ';
-- t2 --
commit;

--8
select * from SUBJECT;
begin tran
insert SUBJECT values('ООП', 'Объектно-ориентированное программирование','ИСиТ');
begin tran
update SUBJECT set SUBJECT_NAME = 'Численные методы' where SUBJECT.PULPIT = 'ИСиТ'
commit;
if @@TRANCOUNT > 0 rollback;
select * from SUBJECT;
delete SUBJECT where SUBJECT = 'ООП';




