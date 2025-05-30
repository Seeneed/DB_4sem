use MD_MyBase;

--1
select * from ������;

create table TR_CREDIT
(
ID int identity,
STMT varchar(20) check (STMT in ('INS', 'DEL', 'UPD')),
TRNAME varchar(50), 
CC varchar(300)
)

go
create or alter trigger TR_CREDIT_INS on ������ after insert
as declare @a1 varchar(20), @a2 varchar(50), @a3 real, @in varchar(300)
print '�������� �������';
set @a1 = (select [ID_�������] from inserted);
set @a2 = (select [���_�������] from inserted);
set @a3 = (select [������] from inserted);
set @in = @a1 + ';' + @a2 + ';' + cast(@a3 as varchar(5));
insert into TR_CREDIT(STMT, TRNAME, CC) values ('INS', 'TR_CREDIT1', @in);
return;

go
insert into ������ values (13,'����������������', 0.13);

select * from TR_CREDIT
drop table TR_CREDIT;

--2
go
create or alter trigger TR_CREDIT_DEL on ������ after delete
as declare @a1 varchar(20), @a2 varchar(50), @a3 real, @in varchar(300)
print '�������� ��������';
set @a1 = (select [ID_�������] from deleted);
set @a2 = (select [���_�������] from deleted);
set @a3 = (select [������] from deleted);
set @in = @a1 + ';' + @a2 + ';' + cast(@a3 as varchar(5));
insert into TR_CREDIT(STMT, TRNAME, CC) values ('DEL', 'TR_CREDIT_DEL', @in);
return;

go
delete from ������ where ������ = 0.13;

select * from TR_CREDIT;

--3
go
create or alter trigger TR_CREDIT_UPD on ������ after update
as declare @a1 varchar(20), @a2 varchar(50), @a3 real, @in varchar(300)
print '�������� ����������';
set @a1 = (select [ID_�������] from inserted);
set @a2 = (select [���_�������] from inserted);
set @a3 = (select [������] from inserted);
set @in = @a1 + ';' + @a2 + ';' + cast(@a3 as varchar(5));
insert into TR_CREDIT(STMT, TRNAME, CC) values ('UPD', 'TR_CREDIT_UPD', @in);
return;

go
update ������ set ������ = 0.33 where ������ = 0.3

select * from TR_CREDIT;

--4
go
create or alter trigger TR_CREDIT1 on ������ after insert, delete, update
as declare @a1 varchar(20), @a2 varchar(50), @a3 real, @in varchar(300);
declare @ins int = (select count(*) from inserted),
@del int = (select count(*) from deleted);
if @ins > 0 and @del = 0
begin
print '�������� �������';
set @a1 = (select [ID_�������] from inserted);
set @a2 = (select [���_�������] from inserted);
set @a3 = (select [������] from inserted);
set @in = @a1 + ';' + @a2 + ';' + cast(@a3 as varchar(5));
insert into TR_CREDIT(STMT, TRNAME, CC) values ('INS', 'TR_CREDIT1', @in);
end;
else
if @ins = 0 and @del > 0
begin
print '�������� ��������';
set @a1 = (select [ID_�������] from deleted);
set @a2 = (select [���_�������] from deleted);
set @a3 = (select [������] from deleted);
set @in = @a1 + ';' + @a2 + ';' + cast(@a3 as varchar(5));
insert into TR_CREDIT(STMT, TRNAME, CC) values ('DEL', 'TR_CREDIT1', @in);
end;
else 
if @ins > 0 and @del > 0
begin
print '�������� ����������';
set @a1 = (select [ID_�������] from inserted);
set @a2 = (select [���_�������] from inserted);
set @a3 = (select [������] from inserted);
set @in = @a1 + ';' + @a2 + ';' + cast(@a3 as varchar(5));
set @a1 = (select [ID_�������] from deleted);
set @a2 = (select [���_�������] from deleted);
set @a3 = (select [������] from deleted);
set @in = @a1 + ';' + @a2 + ';' + cast(@a3 as varchar(5));
insert into TR_CREDIT(STMT, TRNAME, CC) values ('UPD', 'TR_CREDIT1', @in);
end;
return;

go
insert into ������ values(14, '��������', 0.11);
update ������ set ������ = 0.14 where ������ = 0.11;
delete from ������ where ������ = 0.14;

select * from TR_CREDIT;

--5
select * from �������

alter table ������� add constraint C���� check(����� >= 65000)
go
update ������� set ����� = 62000 where ����_������ = '2025-04-19'

--6
go
create or alter trigger TR_CREDIT_DEL1 on ������ after delete
as declare @a1 varchar(20), @a2 varchar(50), @a3 real, @in varchar(300)
print '�������� �������� �1';
set @a1 = (select [ID_�������] from deleted);
set @a2 = (select [���_�������] from deleted);
set @a3 = (select [������] from deleted);
set @in = @a1 + ';' + @a2 + ';' + cast(@a3 as varchar(5));
insert into TR_CREDIT(STMT, TRNAME, CC) values ('DEL', 'TR_CREDIT_DEL1', @in);
return;

go
create or alter trigger TR_CREDIT_DEL2 on ������ after delete
as declare @a1 varchar(20), @a2 varchar(50), @a3 real, @in varchar(300)
print '�������� �������� �2';
set @a1 = (select [ID_�������] from deleted);
set @a2 = (select [���_�������] from deleted);
set @a3 = (select [������] from deleted);
set @in = @a1 + ';' + @a2 + ';' + cast(@a3 as varchar(5));
insert into TR_CREDIT(STMT, TRNAME, CC) values ('DEL', 'TR_CREDIT_DEL2', @in);
return;

go
create or alter trigger TR_CREDIT_DEL3 on ������ after delete
as declare @a1 varchar(20), @a2 varchar(50), @a3 real, @in varchar(300)
print '�������� �������� �3';
set @a1 = (select [ID_�������] from deleted);
set @a2 = (select [���_�������] from deleted);
set @a3 = (select [������] from deleted);
set @in = @a1 + ';' + @a2 + ';' + cast(@a3 as varchar(5));
insert into TR_CREDIT(STMT, TRNAME, CC) values ('DEL', 'TR_CREDIT_DEL3', @in);
return;

select t.name, e.type_desc
from sys.triggers t join sys.trigger_events e
on t.object_id = e.object_id
where OBJECT_NAME(t.parent_id) = '������' and e.type_desc = 'DELETE';

exec sp_settriggerorder @triggername = 'TR_CREDIT_DEL3',
@order = 'First', @stmttype = 'DELETE';

exec sp_settriggerorder @triggername = 'TR_CREDIT_DEL2',
@order = 'Last', @stmttype = 'DELETE';

insert into ������ values(15, '�������������', 0.7);
delete from ������ where ������ = 0.7;

--7
select * from �������

go
create or alter trigger ex7 on ������� after insert, delete, update
as declare @c int = (select sum(�����) from �������);
if (@c > 150000)
begin
raiserror('������ 150000', 10, 1);
rollback;
end;
return;

update ������� set ����� = 200000 where ����_������ = '2024-05-22';

--8
go
create or alter trigger CREDIT_INSTEAD_OF on ������ instead of delete
as raiserror(N'�������� ���������',10,1);
return;

delete from ������ where ID_������� = 12;

--9
go
create or alter trigger DDL_MYBASE on database for CREATE_TABLE, DROP_TABLE
as begin
declare @t varchar(50) =  EVENTDATA().value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)');
declare @t1 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(50)');
declare @t2 varchar(50) = EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(50)');
print '��� �������:' + @t;
print '��� �������:' + @t1;
print '��� �������:' + @t2;
raiserror(N'�������� � ��������� ���������', 16, 1);
rollback;
end;

go
create table test1
(
ID int
)

go
drop table ������;
