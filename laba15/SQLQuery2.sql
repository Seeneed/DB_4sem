use MD_MyBase;

--1
select * from КРЕДИТ;

create table TR_CREDIT
(
ID int identity,
STMT varchar(20) check (STMT in ('INS', 'DEL', 'UPD')),
TRNAME varchar(50), 
CC varchar(300)
)

go
create or alter trigger TR_CREDIT_INS on КРЕДИТ after insert
as declare @a1 varchar(20), @a2 varchar(50), @a3 real, @in varchar(300)
print 'Операция вставки';
set @a1 = (select [ID_кредита] from inserted);
set @a2 = (select [Вид_кредита] from inserted);
set @a3 = (select [Ставка] from inserted);
set @in = @a1 + ';' + @a2 + ';' + cast(@a3 as varchar(5));
insert into TR_CREDIT(STMT, TRNAME, CC) values ('INS', 'TR_CREDIT1', @in);
return;

go
insert into КРЕДИТ values (13,'Рефинансирование', 0.13);

select * from TR_CREDIT
drop table TR_CREDIT;

--2
go
create or alter trigger TR_CREDIT_DEL on КРЕДИТ after delete
as declare @a1 varchar(20), @a2 varchar(50), @a3 real, @in varchar(300)
print 'Операция удаления';
set @a1 = (select [ID_кредита] from deleted);
set @a2 = (select [Вид_кредита] from deleted);
set @a3 = (select [Ставка] from deleted);
set @in = @a1 + ';' + @a2 + ';' + cast(@a3 as varchar(5));
insert into TR_CREDIT(STMT, TRNAME, CC) values ('DEL', 'TR_CREDIT_DEL', @in);
return;

go
delete from КРЕДИТ where Ставка = 0.13;

select * from TR_CREDIT;

--3
go
create or alter trigger TR_CREDIT_UPD on КРЕДИТ after update
as declare @a1 varchar(20), @a2 varchar(50), @a3 real, @in varchar(300)
print 'Операция обновления';
set @a1 = (select [ID_кредита] from inserted);
set @a2 = (select [Вид_кредита] from inserted);
set @a3 = (select [Ставка] from inserted);
set @in = @a1 + ';' + @a2 + ';' + cast(@a3 as varchar(5));
insert into TR_CREDIT(STMT, TRNAME, CC) values ('UPD', 'TR_CREDIT_UPD', @in);
return;

go
update КРЕДИТ set Ставка = 0.33 where Ставка = 0.3

select * from TR_CREDIT;

--4
go
create or alter trigger TR_CREDIT1 on КРЕДИТ after insert, delete, update
as declare @a1 varchar(20), @a2 varchar(50), @a3 real, @in varchar(300);
declare @ins int = (select count(*) from inserted),
@del int = (select count(*) from deleted);
if @ins > 0 and @del = 0
begin
print 'Операция вставки';
set @a1 = (select [ID_кредита] from inserted);
set @a2 = (select [Вид_кредита] from inserted);
set @a3 = (select [Ставка] from inserted);
set @in = @a1 + ';' + @a2 + ';' + cast(@a3 as varchar(5));
insert into TR_CREDIT(STMT, TRNAME, CC) values ('INS', 'TR_CREDIT1', @in);
end;
else
if @ins = 0 and @del > 0
begin
print 'Операция удаления';
set @a1 = (select [ID_кредита] from deleted);
set @a2 = (select [Вид_кредита] from deleted);
set @a3 = (select [Ставка] from deleted);
set @in = @a1 + ';' + @a2 + ';' + cast(@a3 as varchar(5));
insert into TR_CREDIT(STMT, TRNAME, CC) values ('DEL', 'TR_CREDIT1', @in);
end;
else 
if @ins > 0 and @del > 0
begin
print 'Операция обновления';
set @a1 = (select [ID_кредита] from inserted);
set @a2 = (select [Вид_кредита] from inserted);
set @a3 = (select [Ставка] from inserted);
set @in = @a1 + ';' + @a2 + ';' + cast(@a3 as varchar(5));
set @a1 = (select [ID_кредита] from deleted);
set @a2 = (select [Вид_кредита] from deleted);
set @a3 = (select [Ставка] from deleted);
set @in = @a1 + ';' + @a2 + ';' + cast(@a3 as varchar(5));
insert into TR_CREDIT(STMT, TRNAME, CC) values ('UPD', 'TR_CREDIT1', @in);
end;
return;

go
insert into КРЕДИТ values(14, 'Кредитки', 0.11);
update КРЕДИТ set Ставка = 0.14 where Ставка = 0.11;
delete from КРЕДИТ where Ставка = 0.14;

select * from TR_CREDIT;

--5
select * from ДОГОВОР

alter table ДОГОВОР add constraint Cумма check(Сумма >= 65000)
go
update ДОГОВОР set Сумма = 62000 where Дата_выдачи = '2025-04-19'

--6
go
create or alter trigger TR_CREDIT_DEL1 on КРЕДИТ after delete
as declare @a1 varchar(20), @a2 varchar(50), @a3 real, @in varchar(300)
print 'Операция удаления №1';
set @a1 = (select [ID_кредита] from deleted);
set @a2 = (select [Вид_кредита] from deleted);
set @a3 = (select [Ставка] from deleted);
set @in = @a1 + ';' + @a2 + ';' + cast(@a3 as varchar(5));
insert into TR_CREDIT(STMT, TRNAME, CC) values ('DEL', 'TR_CREDIT_DEL1', @in);
return;

go
create or alter trigger TR_CREDIT_DEL2 on КРЕДИТ after delete
as declare @a1 varchar(20), @a2 varchar(50), @a3 real, @in varchar(300)
print 'Операция удаления №2';
set @a1 = (select [ID_кредита] from deleted);
set @a2 = (select [Вид_кредита] from deleted);
set @a3 = (select [Ставка] from deleted);
set @in = @a1 + ';' + @a2 + ';' + cast(@a3 as varchar(5));
insert into TR_CREDIT(STMT, TRNAME, CC) values ('DEL', 'TR_CREDIT_DEL2', @in);
return;

go
create or alter trigger TR_CREDIT_DEL3 on КРЕДИТ after delete
as declare @a1 varchar(20), @a2 varchar(50), @a3 real, @in varchar(300)
print 'Операция удаления №3';
set @a1 = (select [ID_кредита] from deleted);
set @a2 = (select [Вид_кредита] from deleted);
set @a3 = (select [Ставка] from deleted);
set @in = @a1 + ';' + @a2 + ';' + cast(@a3 as varchar(5));
insert into TR_CREDIT(STMT, TRNAME, CC) values ('DEL', 'TR_CREDIT_DEL3', @in);
return;

select t.name, e.type_desc
from sys.triggers t join sys.trigger_events e
on t.object_id = e.object_id
where OBJECT_NAME(t.parent_id) = 'КРЕДИТ' and e.type_desc = 'DELETE';

exec sp_settriggerorder @triggername = 'TR_CREDIT_DEL3',
@order = 'First', @stmttype = 'DELETE';

exec sp_settriggerorder @triggername = 'TR_CREDIT_DEL2',
@order = 'Last', @stmttype = 'DELETE';

insert into КРЕДИТ values(15, 'Краткосрочный', 0.7);
delete from КРЕДИТ where Ставка = 0.7;

--7
select * from ДОГОВОР

go
create or alter trigger ex7 on ДОГОВОР after insert, delete, update
as declare @c int = (select sum(Сумма) from ДОГОВОР);
if (@c > 150000)
begin
raiserror('Больше 150000', 10, 1);
rollback;
end;
return;

update ДОГОВОР set Сумма = 200000 where Дата_выдачи = '2024-05-22';

--8
go
create or alter trigger CREDIT_INSTEAD_OF on КРЕДИТ instead of delete
as raiserror(N'Удаление запрещено',10,1);
return;

delete from КРЕДИТ where ID_кредита = 12;

--9
go
create or alter trigger DDL_MYBASE on database for CREATE_TABLE, DROP_TABLE
as begin
declare @t varchar(50) =  EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)');
declare @t1 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(50)');
declare @t2 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(50)');
print 'Тип события:' + @t;
print 'Имя объекта:' + @t1;
print 'Тип объекта:' + @t2;
raiserror(N'Операции с таблицами запрещены', 16, 1);
rollback;
end;

go
create table test1
(
ID int
)

go
drop table КЛИЕНТ;
