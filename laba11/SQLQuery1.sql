use UNIVER;

--1
declare @sb1 char(20), @str1 char(300) = '';
declare listOfSubjects cursor for select SUBJECT from SUBJECT where SUBJECT.PULPIT like '%ИСиТ%';
open listOfSubjects;
fetch listOfSubjects into @sb1;
print 'Названия дисциплин кафедры ИСиТ:';
while @@FETCH_STATUS = 0
begin
set @str1 = RTRIM(@sb1) + ',' + @str1;
fetch listOfSubjects into @sb1;
end;
print @str1;
close listOfSubjects;
deallocate listOfSubjects;

--2
declare listOfAuditories_one cursor local for select AUDITORIUM_TYPE, AUDITORIUM_CAPACITY from AUDITORIUM;
declare @at1 char(20), @capacity1 int;
open listOfAuditories_one;
fetch listOfAuditories_one into @at1, @capacity1;
print '1.' + @at1 + cast(@capacity1 as varchar(6));
go
declare @at1 char(20), @capacity1 int;
open listOfAuditories_one;
fetch listOfAuditories_one into @at1, @capacity1;
print '2.' + @at1 + cast(@capacity1 as varchar(6));
go

declare listOfAuditories_two cursor global for select AUDITORIUM_TYPE, AUDITORIUM_CAPACITY from AUDITORIUM;
declare @at2 char(20), @capacity2 int;
open listOfAuditories_two;
fetch listOfAuditories_two into @at2, @capacity2;
print '1.' + @at2 + cast(@capacity2 as varchar(6));
go
declare @at2 char(20), @capacity2 int;
fetch listOfAuditories_two into @at2, @capacity2;
print '2.' + @at2 + cast(@capacity2 as varchar(6));
close listOfAuditories_two;
deallocate listOfAuditories_two;
go

--3
declare listOfAuditories_three cursor local static for select AUDITORIUM_TYPE, AUDITORIUM_CAPACITY, AUDITORIUM_NAME from AUDITORIUM where AUDITORIUM_TYPE like '%ЛБ-К%';
declare @at3_1 char(10), @at3_2 char(40), @at3_3 char(1);
open listOfAuditories_three;
print 'Количество строк: ' + cast(@@CURSOR_ROWS as varchar(5));
update AUDITORIUM set AUDITORIUM_CAPACITY = 50 where AUDITORIUM_NAME = '206-1';
delete AUDITORIUM where AUDITORIUM_NAME = '408-2';
insert AUDITORIUM(AUDITORIUM, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY, AUDITORIUM_NAME)
values ('408-2', 'ЛК', 90, '408-2');
fetch listOfAuditories_three into @at3_1, @at3_2, @at3_3;
while @@FETCH_STATUS = 0
begin
print @at3_1 + '' + @at3_2 + '' + @at3_3;
fetch listOfAuditories_three into @at3_1, @at3_2, @at3_3;
end;
close listOfAuditories_three;
select*from AUDITORIUM;

declare listOfAuditories_four cursor local dynamic for select AUDITORIUM_TYPE, AUDITORIUM_CAPACITY, AUDITORIUM_NAME from AUDITORIUM where AUDITORIUM_TYPE like '%ЛБ-К';
declare @at3_4 char(10), @at3_5 char(40), @at3_6 char(1);
open listOfAuditories_four;
print 'Количество строк: ' + cast(@@CURSOR_ROWS as varchar(5));
update AUDITORIUM set AUDITORIUM_CAPACITY = 50 where AUDITORIUM_NAME = '206-1';
delete AUDITORIUM where AUDITORIUM_NAME = '408-2';
insert AUDITORIUM(AUDITORIUM, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY, AUDITORIUM_NAME)
values ('408-2', 'ЛК', 90, '408-2');
fetch listOfAuditories_four into @at3_4, @at3_5, @at3_6;
while @@FETCH_STATUS = 0
begin
print @at3_4 + '' + @at3_5 + '' + @at3_6;
fetch listOfAuditories_four into @at3_4, @at3_5, @at3_6;
end;
close listOfAuditories_four;
select*from AUDITORIUM;

--4
declare listOfAuditories_five cursor local dynamic scroll for 
select ROW_NUMBER() over (order by AUDITORIUM_CAPACITY) Вместимость, 
       AUDITORIUM.AUDITORIUM, 
       AUDITORIUM.AUDITORIUM_TYPE, 
       AUDITORIUM.AUDITORIUM_CAPACITY
from AUDITORIUM;
declare @at4_1 char(10), @at4_2 char(10), @at4_3 char(10), @at4_4 char(10);
open listOfAuditories_five;
fetch listOfAuditories_five into @at4_1, @at4_2, @at4_3, @at4_4;
print 'Первая строка: ' + rtrim(@at4_1) + ' ' + rtrim(@at4_2) + ' ' + rtrim(@at4_3) + ' ' + rtrim(@at4_4);
fetch next from listOfAuditories_five into @at4_1, @at4_2, @at4_3, @at4_4;
print 'Следующая строка после текущей: ' + rtrim(@at4_1) + ' ' + rtrim(@at4_2) + ' ' + rtrim(@at4_3) + ' ' + rtrim(@at4_4);
fetch last from listOfAuditories_five into @at4_1, @at4_2, @at4_3, @at4_4;
print 'Последняя строка: ' + rtrim(@at4_1) + ' ' + rtrim(@at4_2) + ' ' + rtrim(@at4_3) + ' ' + rtrim(@at4_4);
fetch absolute 3 from listOfAuditories_five into @at4_1, @at4_2, @at4_3, @at4_4;
print 'Третья строка от начала: ' + rtrim(@at4_1) + ' ' + rtrim(@at4_2) + ' ' + rtrim(@at4_3) + ' ' + rtrim(@at4_4);
fetch relative 4 from listOfAuditories_five into @at4_1, @at4_2, @at4_3, @at4_4;
print 'Четвертая строка вперед от текущей: ' + rtrim(@at4_1) + ' ' + rtrim(@at4_2) + ' ' + rtrim(@at4_3) + ' ' + rtrim(@at4_4);
close listOfAuditories_five;

--5
--use tempdb;
--create table #example
--(
--ID int identity (1,1),
--Number int 
--)
--insert into #example values(10),(20),(30),(40),(50);
--select*from #example;

--declare primer cursor local dynamic for select * from #example for update;
--declare @ex5_1 int, @ex5_2 varchar(10);
--open primer;
--fetch primer into @ex5_1, @ex5_2;
--delete #example where current of primer;
--fetch primer into @ex5_1, @ex5_2;
--update #example set NUMBER = NUMBER + 10 where current of primer;
--print @ex5_1 + ' ' + @ex5_2;
--close primer;
--drop table #example;

--6.1
select*from PROGRESS;
insert into PROGRESS (SUBJECT, IDSTUDENT, PDATE, NOTE)
values ('КГ', 1024,  '06.05.2013', 3),
	   ('КГ', 1025,  '06.05.2013', 4)
delete PROGRESS where IDSTUDENT = 1024 and IDSTUDENT = 1025;

declare primer1 cursor local dynamic for select p.IDSTUDENT, p.PDATE, p.NOTE from PROGRESS p
inner join STUDENT s on s.IDSTUDENT = p.IDSTUDENT
where p.NOTE < 4 for update
declare @ex6_1 varchar(5), @ex6_2 varchar(50), @ex6_3 int;
open primer1;
fetch primer1 into @ex6_1, @ex6_2, @ex6_3;
print 'Информация о данном студенте: ' + @ex6_1 + ' ' + @ex6_2 + ' ' + cast(@ex6_3 as varchar(5));
delete PROGRESS where current of primer1;
close primer1;

--6.2
declare primer2 cursor local dynamic for select p.IDSTUDENT, p.PDATE, p.NOTE from PROGRESS p
inner join STUDENT s on s.IDSTUDENT = p.IDSTUDENT
where p.IDSTUDENT = 1025 for update
declare @ex6_4 varchar(5), @ex6_5 varchar(50), @ex6_6 int;
open primer2;
fetch primer2 into @ex6_4, @ex6_5, @ex6_6;
update PROGRESS set NOTE = NOTE + 1 where current of primer2;
fetch primer2 into @ex6_4, @ex6_5, @ex6_6;
print 'Обновленная информация о данном студенте: ' + @ex6_4 + ' ' + @ex6_5 + ' ' + cast(@ex6_6 as varchar(5));
close primer2;



