use UNIVER;

--1
select * from TEACHER;
create table TR_AUDIT
(
ID int identity,
STMT varchar(20) check (STMT in ('INS', 'DEL', 'UPD')),
TRNAME varchar(50),
CC varchar(300)
)

go
create or alter trigger TR_TEACHER_INS on TEACHER after insert
as declare @a1 varchar(20), @a2 varchar(50), @a3 varchar(20), @a4 varchar(20), @ins varchar(300);
print 'Операция вставки';
set @a1 = (select [Teacher] from inserted);
set @a2 = (select [Teacher_name] from inserted);
set @a3 = (select [GENDER] from inserted);
set @a4 = (select [PULPIT] from inserted);
set @ins = @a1 + ';' + @a2 + ';' + @a3 + ';' + @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) values('INS', 'TR_TEACHER_INS', @ins);
return;

go
insert into TEACHER values ('asd', 'asdf', 'м', 'ИСиТ');

select * from TR_AUDIT;
drop table TR_AUDIT;

--2
go
create or alter trigger TR_TEACHER_DEL on TEACHER after delete
as declare @a1 varchar(20), @a2 varchar(50), @a3 varchar(20), @a4 varchar(20), @ins varchar(300);
print 'Операция удаления';
set @a1 = (select [TEACHER] from deleted);
set @a2 = (select [Teacher_name] from deleted);
set @a3 = (select [GENDER] from deleted);
set @a4 = (select [PULPIT] from deleted);
set @ins = @a1 + ';' + @a2 + ';' + @a3 + ';' + @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER_DEL', @ins);
return;

go
delete from TEACHER where TEACHER = 'asd';

select * from TR_AUDIT;

--3
go
create or alter trigger TR_TEACHER_UPD on TEACHER after update
as declare @a1 varchar(20), @a2 varchar(50), @a3 varchar(20), @a4 varchar(20), @ins varchar(300);
print 'Операция обновления';
set @a1 = (select [TEACHER] from inserted);
set @a2 = (select [Teacher_name] from inserted);
set @a3 = (select [GENDER] from inserted);
set @a4 = (select [PULPIT] from inserted);
set @ins = @a1 + ';' + @a2 + ';' + @a3 + ';' + @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('UPD', 'TR_TEACHER_UPD', @ins);
return;

go
update TEACHER set TEACHER = 'fgh' where TEACHER = 'asd';

select * from TR_AUDIT;

--4
go
create or alter trigger TR_TEACHER on TEACHER after insert, delete, update
as declare @a1 varchar(20), @a2 varchar(50), @a3 varchar(20), @a4 varchar(20), @in varchar(300);
declare @ins int = (select count(*) from inserted),
@del int = (select count(*) from deleted);
if @ins > 0 and @del = 0
begin
print 'Операция вставки';
set @a1 = (select [Teacher] from inserted);
set @a2 = (select [Teacher_name] from inserted);
set @a3 = (select [GENDER] from inserted);
set @a4 = (select [PULPIT] from inserted);
set @in = @a1 + ';' + @a2 + ';' + @a3 + ';' + @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) values('INS', 'TR_TEACHER', @in);
end;
else
if @ins = 0 and @del > 0
begin
print 'Операция удаления';
set @a1 = (select [TEACHER] from deleted);
set @a2 = (select [Teacher_name] from deleted);
set @a3 = (select [GENDER] from deleted);
set @a4 = (select [PULPIT] from deleted);
set @in = @a1 + ';' + @a2 + ';' + @a3 + ';' + @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER', @in);
end;
else
if @ins > 0 and @del > 0
begin
print 'Операция обновления';
set @a1 = (select [TEACHER] from inserted);
set @a2 = (select [Teacher_name] from inserted);
set @a3 = (select [GENDER] from inserted);
set @a4 = (select [PULPIT] from inserted);
set @in = @a1 + ';' + @a2 + ';' + @a3 + ';' + @a4;
set @a1 = (select [TEACHER] from deleted);
set @a2 = (select [Teacher_name] from deleted);
set @a3 = (select [GENDER] from deleted);
set @a4 = (select [PULPIT] from deleted);
set @in = @a1 + ';' + @a2 + ';' + @a3 + ';' + @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('UPD', 'TR_TEACHER', @in);
end;
return;

go
insert into TEACHER values('qwe', 'qwer', 'м', 'ИСиТ');
update TEACHER set TEACHER = 'rty' where TEACHER = 'qwe';
delete from TEACHER where TEACHER_NAME = 'qwer';

select * from TR_AUDIT;

--5
select * from AUDITORIUM;

alter table AUDITORIUM add constraint AUDITORIUM_CAPACITY_CHECK check(AUDITORIUM_CAPACITY >= 15)
go
update AUDITORIUM set AUDITORIUM_CAPACITY = 10 where AUDITORIUM = '204-1';

--6
go
create or alter trigger TR_TEACHER_DEL1 on TEACHER after delete
as declare @a1 varchar(20), @a2 varchar(50), @a3 varchar(20), @a4 varchar(20), @ins varchar(300);
print 'Операция удаления №1';
set @a1 = (select [TEACHER] from deleted);
set @a2 = (select [Teacher_name] from deleted);
set @a3 = (select [GENDER] from deleted);
set @a4 = (select [PULPIT] from deleted);
set @ins = @a1 + ';' + @a2 + ';' + @a3 + ';' + @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER_DEL1', @ins);
return;

go
create or alter trigger TR_TEACHER_DEL2 on TEACHER after delete
as declare @a1 varchar(20), @a2 varchar(50), @a3 varchar(20), @a4 varchar(20), @ins varchar(300);
print 'Операция удаления №2';
set @a1 = (select [TEACHER] from deleted);
set @a2 = (select [Teacher_name] from deleted);
set @a3 = (select [GENDER] from deleted);
set @a4 = (select [PULPIT] from deleted);
set @ins = @a1 + ';' + @a2 + ';' + @a3 + ';' + @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER_DEL2', @ins);
return;

go
create or alter trigger TR_TEACHER_DEL3 on TEACHER after delete
as declare @a1 varchar(20), @a2 varchar(50), @a3 varchar(20), @a4 varchar(20), @ins varchar(300);
print 'Операция удаления №3';
set @a1 = (select [TEACHER] from deleted);
set @a2 = (select [Teacher_name] from deleted);
set @a3 = (select [GENDER] from deleted);
set @a4 = (select [PULPIT] from deleted);
set @ins = @a1 + ';' + @a2 + ';' + @a3 + ';' + @a4;
insert into TR_AUDIT(STMT, TRNAME, CC) values ('DEL', 'TR_TEACHER_DEL3', @ins);
return;

select t.name, e.type_desc
from sys.triggers t join sys.trigger_events e
on t.object_id = e.object_id
where OBJECT_NAME(t.parent_id) = 'TEACHER' and e.type_desc = 'DELETE'

exec sp_settriggerorder @triggername = 'TR_TEACHER_DEL3',
@order = 'First', @stmttype = 'DELETE';

exec sp_settriggerorder @triggername = 'TR_TEACHER_DEL2',
@order = 'Last', @stmttype = 'DELETE';

insert into TEACHER values 
          ('йцукен','qwerty','м','ИСиТ')
delete TEACHER where TEACHER = 'йцукен';

--7
select * from AUDITORIUM;

go
create or alter trigger ex7
on AUDITORIUM after insert, delete, update
as declare @c int = (select sum(AUDITORIUM.AUDITORIUM_CAPACITY) from AUDITORIUM);
if (@c > 200)
begin
raiserror('Больше > 200', 10, 1);
rollback;
end;
return;

update AUDITORIUM set AUDITORIUM_CAPACITY = 250 where AUDITORIUM = '204-1';

--8
select * from FACULTY;

go
create or alter trigger FACULTY_INSTEAD_OF on FACULTY instead of delete
as raiserror(N'Удаление запрещено', 10, 1);
return;
delete from FACULTY where FACULTY = 'ИДиП';

--9
go
create or alter trigger DDL_UNIVER on database for CREATE_TABLE, DROP_TABLE
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
create table test
(
ID int
)

go
drop table AUDITORIUM

