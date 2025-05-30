use MD_MyBase;

--1
go
create procedure PCREDIT
as
begin
declare @k int = (select count(*) from ������);
select * from ������;
return @k;
end;

go
declare @k int = 0;
exec @k = PCREDIT;
print '���������� ��������: ' + cast(@k as varchar(3));

--2
go
alter procedure PCREDIT @p varchar(20), @c int output
as
begin
declare @k int = (select count(*) from ������);
print '���������: @p = ' + @p + ',@c = ' + cast(@c as varchar(3));
select * from ������ where ������.���_������� = @p;
set @c = @@ROWCOUNT;
return @k;
end;

go
declare @k int = 0, @r int = 0, @p varchar(20) = '������������';
exec @k = PCREDIT @p = @p, @c = @r output;
print '���������� ��������: ' + cast(@k as varchar(3));
print '���������� �������� ���������� ����: ' + @p + ' = ' + cast(@r as varchar(3));

--3
go
alter procedure PCREDIT @p varchar(20)
as
begin
declare @k int = (select count(*) from ������);
select * from ������ where ������.���_������� = @p;
end;

go
create table #������
(
ID_������� int primary key,
���_������� nvarchar(50),
������ real
)

insert #������ exec PCREDIT @p = '������������';
insert #������ exec PCREDIT @P = '�������������';

select * from #������;

drop table #������;

--4
go
create procedure CREDIT_INSERT @a int, @b nvarchar(50), @c real
as declare @rc int = 1;
begin try
insert ������(ID_�������, ���_�������, ������)
values (@a, @b, @c)
return @rc;
end try
begin catch
print '����� ������: ' + cast(error_number() as varchar(6));
print '���������: ' + error_message();
print '�������: ' + cast(error_severity() as varchar(8));
print '�����: ' + cast(error_state() as varchar(8));
print '����� ������: ' + cast(error_line() as varchar(6));
if ERROR_PROCEDURE() is not null
print '��� ���������: ' + error_procedure();
return -1;
end catch;

go
declare @rc int;
exec @rc = CREDIT_INSERT @a = 11, @b = '�������', @c = 0.4;
print '��� ������: ' + cast(@rc as varchar(3));
select * from ������;
drop procedure CREDIT_INSERT;

--5
go
create procedure CREDIT_PRINT @p char(50)
as
declare @rc int = 0;
begin try
declare @tv char(20), @t char(300) = '';
declare secondCursor cursor for select ������.������ from ������ where ������.���_������� = @p;
if not exists (select ������.������ from ������ where ������.���_������� = @p)
raiserror('������',11,1);
else
open secondCursor;
fetch secondCursor into @tv;
print '�������';
while @@FETCH_STATUS = 0
begin
set @t = RTRIM(@tv) + ',' + @t;
set @rc = @rc + 1;
fetch secondCursor into @tv;
end;
print @t;
close secondCursor;
return @rc;
end try
begin catch
print '������ � ����������'
if ERROR_PROCEDURE() is not null
print '��� ���������: ' + error_procedure();
return @rc;
end catch;

go
declare @rc int;
exec @rc = CREDIT_PRINT @p = '������������';
print '��� ������: ' + cast(@rc as varchar(3));
drop procedure CREDIT_PRINT;

--6
go 
create procedure CREDIT_INSERT_X @a int, @b nvarchar(50), @c real, @fk nvarchar(50), @vs nvarchar(50), @ad nvarchar(50), @ph nvarchar(15)
as declare @rc int = 1;
begin try
set transaction isolation level serializable;
begin tran
insert ������(ID_�������, �����_������, ���_�������������, �����, �������, ����������_����)
values (@a, @fk, @vs, @ad, @ph, @b)
exec @rc = CREDIT_INSERT @a, @b, @c;
commit tran;
return @rc;
end try
begin catch
print '����� ������: ' + cast(error_number() as varchar(6));
print '���������: ' + error_message();
print '�������: ' + cast(error_severity() as varchar(8));
print '�����: ' + cast(error_state() as varchar(8));
print '����� ������: ' + cast(error_line() as varchar(6));
if ERROR_PROCEDURE() is not null
print '��� ���������: ' + error_procedure()
if @@TRANCOUNT > 0
rollback tran;
return -1;
end catch;

go
declare @rc int;
exec @rc = CREDIT_INSERT_X @a = 12, @b = '����������', @c = 0.3, @fk = 'Audi', @vs = '�������', @ad = '�.�����', @ph = '+375291234523'
print '��� ������: ' + cast(@rc as varchar(3));
drop procedure CREDIT_INSERT_X;
