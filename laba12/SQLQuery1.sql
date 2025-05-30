--1
set nocount on
if exists (select * from SYS.objects where object_id = object_id(N'dbo.firstTable'))
drop table firstTable;

declare @c int, @flag char = 'c';
set implicit_transactions on
create table firstTable(x int, fields varchar(20));
insert firstTable values(1, 'cat'), (2, 'dog'), (3, 'fox');
set @c = (select count(*) from firstTable);
print '���������� ����� � �������: ' + cast(@c as varchar(2));
if @flag = 'c' commit;
else rollback;
set implicit_transactions off

if exists(select * from SYS.objects where object_id = object_id(N'dbo.firstTable'))
print '������� ����';
else print '������� ���';

--2
use UNIVER;

begin try
begin tran
insert PULPIT values ('��', '����������� ���������', '��');
insert PULPIT values ('��', '����������� ���������', '��');
commit tran;
end try
begin catch
print '������:' + case
when error_number() = 2627 and patindex('%PK__PULPIT__55166E7F271E95A9%', error_message()) > 0
then '������������ ��������������'
else '����������� ������:' + cast(error_number() as varchar(5)) + error_message()
end;
if @@TRANCOUNT > 0 rollback tran;
end catch;

--3
declare @point varchar(32);
begin try
begin tran
insert PULPIT values ('��', '����������� ���������', '��');
set @point = 'p1';
save tran @point;
insert PULPIT values ('��', '����������� ���������', '��');
set @point = 'p2';
save tran @point;
commit tran;
end try
begin catch
print '������:' + case when error_number() = 2627 and patindex('%PK__PULPIT__55166E7F271E95A9%', error_message()) > 0
then '������������ ��������������'
else '����������� ������:' + cast(error_number() as varchar(5)) + error_message()
end;
if @@TRANCOUNT > 0
begin
print '����������� �����:' + @point;
rollback tran @point;
commit tran;
delete PULPIT where PULPIT.PULPIT = '��'
end;
end catch;

--4
-- A -- 
set transaction isolation level read committed
begin transaction
-- t1 --
select @@SPID, 'insert PULPIT' '�����', * from PULPIT where PULPIT.PULPIT = '��';
select @@SPID, 'insert PULPIT' '�����', * from SUBJECT where SUBJECT.PULPIT = '��';
commit;
-- t2 --

--5
-- A --
set transaction isolation level read committed
begin transaction
select count(*) from SUBJECT where PULPIT = '����';
select SUBJECT, PULPIT from SUBJECT where SUBJECT = '��';
-- t1 --
-- t2 --
select 'update SUBJECT' '���������', count(*)
from SUBJECT where PULPIT = '����';
select SUBJECT, PULPIT from SUBJECT where SUBJECT = '��';
commit;

--6
-- A --
set transaction isolation level repeatable read
begin transaction
select SUBJECT_NAME from SUBJECT where PULPIT = '��';
-- t1 --
-- t2 --
select case
when SUBJECT = '����' then 'insert SUBJECT' else ''
end '���������', SUBJECT_NAME from SUBJECT where PULPIT = '��'
commit;

--7
-- A --
set transaction isolation level serializable
begin transaction
delete SUBJECT where SUBJECT = '����';
insert SUBJECT values('����','���������� ���������������� � ��������','����');
update SUBJECT set SUBJECT_NAME = '���������� ����������������' where SUBJECT = '����';
select SUBJECT_NAME, PULPIT from SUBJECT where PULPIT = '����';
-- t1 --
select SUBJECT_NAME, PULPIT from SUBJECT where PULPIT = '����';
-- t2 --
commit;

--8
select * from SUBJECT;
begin tran
insert SUBJECT values('���', '��������-��������������� ����������������','����');
begin tran
update SUBJECT set SUBJECT_NAME = '��������� ������' where SUBJECT.PULPIT = '����'
commit;
if @@TRANCOUNT > 0 rollback;
select * from SUBJECT;
delete SUBJECT where SUBJECT = '���';




