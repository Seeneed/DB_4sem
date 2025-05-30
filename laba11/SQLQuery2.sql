use MD_MyBase;

--1
declare primer1_1 cursor for select ���_������� from ������;
declare @ex1_1 char(20), @ex1_2 char(300) = '';
open primer1_1;
fetch primer1_1 into @ex1_1;
print '�������';
while @@FETCH_STATUS = 0
begin
set @ex1_2 = rtrim(@ex1_1) + ',' + @ex1_2;
fetch primer1_1 into @ex1_1;
end;
print @ex1_2;
close primer1_1;

--2
declare primer2_1 cursor local for select ������, ���_������� from ������;
declare @ex2_1 real, @ex2_2 varchar(20);
open primer2_1;
fetch primer2_1 into @ex2_1, @ex2_2;
print '1.' + cast(@ex2_1 as varchar(20)) + @ex2_2;
go
declare @ex2_1 real, @ex2_2 varchar(20);
open primer2_1;
fetch primer2_1 into @ex2_1, @ex2_2;
print '2.' + cast(@ex2_1 as varchar(20)) + @ex2_2;
go

declare primer2_2 cursor global for select ������, ���_������� from ������;
declare @ex2_3 real, @ex2_4 varchar(20);
open primer2_2;
fetch primer2_2 into @ex2_3, @ex2_4;
print '1.' + ' ' + cast(@ex2_3 as varchar(20)) + ' ' + @ex2_4;
go
declare @ex2_3 real, @ex2_4 varchar(20);
fetch primer2_2 into @ex2_3, @ex2_4;
print '2.' +  ' ' + cast(@ex2_3 as varchar(20)) + ' ' + @ex2_4;
close primer2_2;
deallocate primer2_2;
go

--3
declare primer3_1 cursor local static for select ������, ���_������� from ������;
declare @ex3_1 real, @ex3_2 varchar(20);
open primer3_1;
print '���������� �����: ' + cast(@@cursor_rows as varchar(5));
update ������ set ������ = 0.4 where ���_������� = '���������������';
delete ������ where ���_������� = '��������';
insert ������(ID_�������, ���_�������, ������)
values(6, '��������', 0.5);
fetch primer3_1 into @ex3_1, @ex3_2;
while @@FETCH_STATUS = 0
begin
print cast(@ex3_1 as varchar(20)) + ' ' + @ex3_2;
fetch primer3_1 into @ex3_1, @ex3_2;
end;
close primer3_1;
select*from ������;

declare primer3_2 cursor local dynamic for select ������, ���_������� from ������;
declare @ex3_3 real, @ex3_4 varchar(20);
open primer3_2;
print '���������� �����: ' + cast(@@cursor_rows as varchar(5));
update ������ set ������ = 0.4 where ���_������� = '���������������';
delete ������ where ���_������� = '��������';
insert ������(ID_�������, ���_�������, ������)
values(6, '��������', 0.5);
fetch primer3_2 into @ex3_3, @ex3_4;
while @@FETCH_STATUS = 0
begin
print cast(@ex3_3 as varchar(20)) + ' ' + @ex3_4;
fetch primer3_2 into @ex3_3, @ex3_4;
end;
close primer3_2;
select*from ������;

--4
declare primer4 cursor local dynamic scroll for
select ROW_NUMBER() over (order by ������) as ������,
ID_�������,
���_�������
from ������
declare @ex4_1 real, @ex4_2 int, @ex4_3 varchar(20);
open primer4;
fetch primer4 into @ex4_1, @ex4_2, @ex4_3;
print '������ ������: ' + cast(@ex4_1 as varchar(20)) + ' ' + cast(@ex4_2 as varchar(20)) + ' ' + @ex4_3;
fetch next from primer4 into @ex4_1, @ex4_2, @ex4_3;
print '��������� ������ ������������ �������: ' + cast(@ex4_1 as varchar(20)) + ' ' + cast(@ex4_2 as varchar(20)) + ' ' + @ex4_3;
fetch relative 3 from primer4 into @ex4_1, @ex4_2, @ex4_3;
print '������ ������ ������������ �������: ' + cast(@ex4_1 as varchar(20)) + ' ' + cast(@ex4_2 as varchar(20)) + ' ' + @ex4_3;
fetch last from primer4 into @ex4_1, @ex4_2, @ex4_3;
print '��������� ������: ' + cast(@ex4_1 as varchar(20)) + ' ' + cast(@ex4_2 as varchar(20)) + ' ' + @ex4_3;
close primer4;

--6.1
select*from �������;
insert into �������(ID_��������, �����, ����_������, ����_��������, ID_�������, ID_�������)
values(1, 5000, '2020-04-12', '2022-06-24', 1, 1)
delete ������� where ID_�������� = 1;

declare primer5 cursor local dynamic for 
    select 
        �������.ID_��������, 
        �������.�����, 
        �������.����_������, 
        �������.����_��������, 
        �������.ID_�������, 
        �������.ID_�������
    from �������
inner join ������
on ������.ID_������� = �������.ID_�������
where �������.����� < 5100 for update
declare @ex5_1 int, @ex5_2 int, @ex5_3 date, @ex5_4 date, @ex5_5 int, @ex5_6 int;
open primer5;
fetch primer5 into @ex5_1, @ex5_2, @ex5_3, @ex5_4, @ex5_5, @ex5_6;
print '���������� � ������ ��������: ' + cast(@ex5_1 as varchar(20)) + ' ' + cast(@ex5_2 as varchar(20)) + ' ' + cast(@ex5_3 as varchar(20)) + ' ' + cast(@ex5_4 as varchar(20)) + ' ' + cast(@ex5_5 as varchar(20)) + ' ' + cast(@ex5_6 as varchar(20));
delete ������� where current of primer5;
close primer5;

declare primer6 cursor local dynamic for
    select 
        �������.ID_��������, 
        �������.�����, 
        �������.����_������, 
        �������.����_��������, 
        �������.ID_�������, 
        �������.ID_�������
    from �������
inner join ������
on ������.ID_������� = �������.ID_�������
where �������.����� = 5000 for update
declare @ex6_1 int, @ex6_2 int, @ex6_3 date, @ex6_4 date, @ex6_5 int, @ex6_6 int;
open primer6;
fetch primer6 into @ex6_1, @ex6_2, @ex6_3, @ex6_4, @ex6_5, @ex6_6;
update ������� set ����� = ����� + 100 where current of primer6;
fetch primer6 into @ex6_1, @ex6_2, @ex6_3, @ex6_4, @ex6_5, @ex6_6;
print '���������� � ������ ��������: ' + cast(@ex6_1 as varchar(20)) + ' ' + cast(@ex6_2 as varchar(20)) + ' ' + cast(@ex6_3 as varchar(20)) + ' ' + cast(@ex6_4 as varchar(20)) + ' ' + cast(@ex6_5 as varchar(20)) + ' ' + cast(@ex6_6 as varchar(20));
close primer6;

