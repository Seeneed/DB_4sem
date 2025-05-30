use MD_MyBase;

--1.1
go
create function COUNT_CREDITS(@credit varchar(20)) returns int
as begin declare @rc int = 0;
set @rc = (select count(������.���_�������) from ������ inner join �������
on ������.ID_������� = �������.ID_�������
where ������.���_������� = @credit);
return @rc;
end;

go
declare @credit varchar(20) = dbo.COUNT_CREDITS('�������������');
print '���������� ��������: ' + cast(@credit as varchar(3));

drop function COUNT_CREDITS;

--1.2
go
alter function COUNT_CREDITS(@credit varchar(20), @stavka real) returns int
as begin declare @rc int = 0;
set @rc = (select count(������.���_�������) from ������ inner join �������
on ������.ID_������� = �������.ID_�������
where ������.���_������� = @credit and ������.������ = @stavka);
return @rc;
end;

go
select dbo.COUNT_CREDITS('�������������', 0.1);

--2
go 
create function COUNT_CREDIT(@credit varchar(20)) returns char(300)
as
begin
declare @tv char(20);
declare @t varchar(300) = '�������';
declare secondCursor cursor local static
for select ������.������ from ������ where ������.���_������� = @credit;
open secondCursor;
fetch secondCursor into @tv;
while @@FETCH_STATUS = 0
begin
set @t = @t + ',' + RTRIM(@tv);
fetch secondCursor into @tv;
end
close secondCursor;
deallocate secondCursor;
return @t;
end;

go
select distinct ���_�������, dbo.COUNT_CREDIT(���_�������) from ������;

drop function COUNT_CREDIT;

--3
go
create function CREDITDOGOVOR(@c varchar(20), @d varchar(20)) returns table
as return
select ������.���_�������, �������.����� from ������ left outer join �������
on �������.ID_������� = ������.ID_�������
where ������.���_������� = isnull(@c, ������.���_�������) and �������.����� = isnull(@d, �������.�����);

go
select * from dbo.CREDITDOGOVOR(null, null);
select * from dbo.CREDITDOGOVOR('�������������', null);
select * from dbo.CREDITDOGOVOR(null, 5000);

drop function CREDITDOGOVOR;

--4
go
create function FUNC(@p varchar(50)) returns int
as
begin
declare @rc int = (select count(*) from ������
inner join ������� on ������.ID_������� = �������.ID_�������
where ������.���_������������� = isnull(@p, ������.���_�������������));
return @rc;
end;

go
select ���_�������������, dbo.FUNC(���_�������������) from ������;

drop function FUNC;