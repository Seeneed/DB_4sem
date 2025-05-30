--1
set nocount on
if exists (select * from SYS.objects where object_id = object_id(N'dbo.secondTable'))
drop table secondTable;

declare @c int, @flag char = 'c';
set implicit_transactions on
create table secondTable(x int, field varchar(20));
insert secondTable values(1, 'cat'), (2, 'dog'), (3, 'fish');
set @c = (select count(*) from secondTable);
print '���������� ����� � �������: ' + cast(@c as varchar(2));
if @flag = 'c' commit;
else rollback;
set implicit_transactions off

if exists (select * from sys.objects where object_id = object_id(N'dbo.secondTable'))
print '������� ����';
else print '������� ����'

--2
use MD_MyBase;

begin try
begin tran
insert ������ values(11, '�������', 0.4);
insert ������ values(11, '�������', 0.4);
commit tran;
end try
begin catch
print '������:' + case when error_number() = 2627
then '������������ ��������'
else '����������� ������:' + cast(error_number() as varchar(5)) + error_message()
end;
if @@TRANCOUNT > 0 rollback tran;
end catch;

--3
declare @point varchar(32);
begin try
begin tran
insert ������ values(11, '�������', 0.4);
set @point = 'p1';
save tran @point;
insert ������ values(11, '�������', 0.4);
set @point = 'p2';
save tran @point;
commit tran;
end try
begin catch
print '������: ' + case when error_number() = 2627
then '������������ ��������'
else '����������� ������: ' + cast(error_number() as varchar(5)) + error_message()
end;
if @@TRANCOUNT > 0
begin
print '����������� �����: ' + @point;
rollback tran @point;
commit tran;
delete ������ where ID_������� = 11;
end;
end catch;

--4
-- A --
set transaction isolation level read uncommitted
begin transaction
-- t1 --
select @@SPID, 'insert ������' '���������', * from ������ where ������.ID_������� = 11;
select @@SPID, 'insert �������' '���������', ID_��������, ID_������� from ������� where �������.ID_������� = 11;
commit;
-- t2 --
-- B --
begin transaction
select @@SPID
insert ������ values(11, '�������', 0.4);
update ������� set ID_������� = 11 where ����� = 5000;
-- t1 --
-- t2 --
rollback;

--5
-- A --
set transaction isolation level read committed
begin transaction
select count(*) from ������� where ����� = 5000;
-- t1 --
-- t2 --
select 'update �������' '���������', count(*)
from ������� where ����� = 5000;
commit;
-- B --
begin transaction
-- t1 --
update ������� set ����� = 42000 where ����� = 45000
commit;
-- t2 --

--6
-- A --
set transaction isolation level repeatable read
begin transaction
select ����� from ������� where ����_������ = '2020-04-12';
-- t1 --
-- t2 --
select case 
when ����_�������� = '2026-11-13' then 'insert �������' else ''
end '���������', ����� from ������� where ����_������ = '2020-04-12';
commit;
-- B --
begin transaction
-- t1 --
insert ������� values(11, 33000, '2020-04-12', '2026-11-13', 11, 11);
commit;
-- t2 --
delete ������� where ����_�������� = '2026-11-13';

--7
-- A --
set transaction isolation level serializable
begin transaction
delete ������� where ID_�������� = 1;
insert ������� values(1, 5000, '2020-04-12', '2026-11-13', 1, 1);
update ������� set ����� = 25000 where ID_�������� = 1;
select ����� from ������� where ID_�������� = 1;
-- t1 --
select ����� from ������� where ID_�������� = 1;
-- t2 --
commit;
-- B --
begin transaction
delete ������� where ID_�������� = 1;
insert ������� values(1, 5000, '2020-04-12', '2026-11-13', 1, 1);
update ������� set ����� = 28000 where ID_�������� = 1;
select ����� from ������� where ID_�������� = 1;
-- t1 --
commit;
select ����� from ������� where ID_�������� = 1;
-- t2 --

--8
select * from �������
begin tran
insert ������� values(12, 34000, '2020-04-12', '2026-11-13', 1, 1);
begin tran
update ������� set ����� = 40000 where ID_�������� = 12;
commit;
if @@TRANCOUNT > 0 rollback;
select * from �������;
