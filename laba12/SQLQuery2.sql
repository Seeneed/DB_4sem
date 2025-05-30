--1
set nocount on
if exists (select * from SYS.objects where object_id = object_id(N'dbo.secondTable'))
drop table secondTable;

declare @c int, @flag char = 'c';
set implicit_transactions on
create table secondTable(x int, field varchar(20));
insert secondTable values(1, 'cat'), (2, 'dog'), (3, 'fish');
set @c = (select count(*) from secondTable);
print 'Количество строк в таблице: ' + cast(@c as varchar(2));
if @flag = 'c' commit;
else rollback;
set implicit_transactions off

if exists (select * from sys.objects where object_id = object_id(N'dbo.secondTable'))
print 'таблица есть';
else print 'таблицы нету'

--2
use MD_MyBase;

begin try
begin tran
insert КРЕДИТ values(11, 'Ипотека', 0.4);
insert КРЕДИТ values(11, 'Ипотека', 0.4);
commit tran;
end try
begin catch
print 'ошибка:' + case when error_number() = 2627
then 'дублирование кредитов'
else 'неизвестная ошибка:' + cast(error_number() as varchar(5)) + error_message()
end;
if @@TRANCOUNT > 0 rollback tran;
end catch;

--3
declare @point varchar(32);
begin try
begin tran
insert КРЕДИТ values(11, 'Ипотека', 0.4);
set @point = 'p1';
save tran @point;
insert КРЕДИТ values(11, 'Ипотека', 0.4);
set @point = 'p2';
save tran @point;
commit tran;
end try
begin catch
print 'ошибка: ' + case when error_number() = 2627
then 'дублирование кредитов'
else 'неизвестная ошибка: ' + cast(error_number() as varchar(5)) + error_message()
end;
if @@TRANCOUNT > 0
begin
print 'Контрольная точка: ' + @point;
rollback tran @point;
commit tran;
delete КРЕДИТ where ID_кредита = 11;
end;
end catch;

--4
-- A --
set transaction isolation level read uncommitted
begin transaction
-- t1 --
select @@SPID, 'insert КРЕДИТ' 'результат', * from КРЕДИТ where КРЕДИТ.ID_кредита = 11;
select @@SPID, 'insert ДОГОВОР' 'результат', ID_договора, ID_кредита from ДОГОВОР where ДОГОВОР.ID_кредита = 11;
commit;
-- t2 --
-- B --
begin transaction
select @@SPID
insert КРЕДИТ values(11, 'Ипотека', 0.4);
update ДОГОВОР set ID_кредита = 11 where Сумма = 5000;
-- t1 --
-- t2 --
rollback;

--5
-- A --
set transaction isolation level read committed
begin transaction
select count(*) from ДОГОВОР where Сумма = 5000;
-- t1 --
-- t2 --
select 'update ДОГОВОР' 'результат', count(*)
from ДОГОВОР where Сумма = 5000;
commit;
-- B --
begin transaction
-- t1 --
update ДОГОВОР set Сумма = 42000 where Сумма = 45000
commit;
-- t2 --

--6
-- A --
set transaction isolation level repeatable read
begin transaction
select Сумма from ДОГОВОР where Дата_выдачи = '2020-04-12';
-- t1 --
-- t2 --
select case 
when Дата_возврата = '2026-11-13' then 'insert ДОГОВОР' else ''
end 'результат', Сумма from ДОГОВОР where Дата_выдачи = '2020-04-12';
commit;
-- B --
begin transaction
-- t1 --
insert ДОГОВОР values(11, 33000, '2020-04-12', '2026-11-13', 11, 11);
commit;
-- t2 --
delete ДОГОВОР where Дата_возврата = '2026-11-13';

--7
-- A --
set transaction isolation level serializable
begin transaction
delete ДОГОВОР where ID_договора = 1;
insert ДОГОВОР values(1, 5000, '2020-04-12', '2026-11-13', 1, 1);
update ДОГОВОР set Сумма = 25000 where ID_договора = 1;
select Сумма from ДОГОВОР where ID_договора = 1;
-- t1 --
select Сумма from ДОГОВОР where ID_договора = 1;
-- t2 --
commit;
-- B --
begin transaction
delete ДОГОВОР where ID_договора = 1;
insert ДОГОВОР values(1, 5000, '2020-04-12', '2026-11-13', 1, 1);
update ДОГОВОР set Сумма = 28000 where ID_договора = 1;
select Сумма from ДОГОВОР where ID_договора = 1;
-- t1 --
commit;
select Сумма from ДОГОВОР where ID_договора = 1;
-- t2 --

--8
select * from ДОГОВОР
begin tran
insert ДОГОВОР values(12, 34000, '2020-04-12', '2026-11-13', 1, 1);
begin tran
update ДОГОВОР set Сумма = 40000 where ID_договора = 12;
commit;
if @@TRANCOUNT > 0 rollback;
select * from ДОГОВОР;
