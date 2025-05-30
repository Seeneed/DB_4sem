use UNIVER;

--1
go
create procedure PSUBJECT
as
begin
declare @k int = (select count(*) from SUBJECT);
select * from SUBJECT;
return @k;
end;

go
declare @k int = 0;
exec @k = PSUBJECT;
print 'Количество дисциплин: ' + cast(@k as varchar(3));
drop procedure PSUBJECT;

--2
go
alter procedure PSUBJECT @p varchar(20), @c int output
as
begin
declare @k int = (select count(*) from SUBJECT);
print 'параметры: @p = ' + @p + ',@c = ' + cast(@c as varchar(3));
select * from  SUBJECT where SUBJECT.PULPIT = @p;
set @c = @@ROWCOUNT;
return @k;
end;

go
declare @k int = 0,  @r int = 0, @p varchar(20) = 'ИСиТ';
exec @k = PSUBJECT @p = @p , @c = @r output;
print 'Количество дисциплин всего: ' + cast(@k as varchar(3));
print 'Количество дисциплин на кафедре ' + @p + ': ' + cast(@r as varchar(3));

--3
go
alter procedure PSUBJECT @p varchar(20)
as
begin
declare @k int = (select count(*) from SUBJECT);
select * from SUBJECT where SUBJECT.PULPIT = @p;
end;

go
create table #SUBJECT
(
SUBJECT varchar(10) primary key,
SUBJECT_NAME varchar(50),
PULPIT varchar(10)
)

insert #SUBJECT exec PSUBJECT @p = 'ИСиТ';
insert #SUBJECT exec PSUBJECT @p = 'ПИ';

select * from #SUBJECT;

drop table #SUBJECT;

--4
go
create procedure PAUDITORIUM_INSERT @a char(20), @n varchar(50), @c int = 0, @t char(10)
as declare @rc int = 1;
begin try
insert AUDITORIUM(AUDITORIUM, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY, AUDITORIUM_NAME)
values (@a, @n, @c, @t)
return @rc;
end try
begin catch
print 'номер ошибки: ' + cast(error_number() as varchar(6));
print 'сообщение: ' + error_message();
print 'уровень: ' + cast(error_severity() as varchar(6));
print 'метка: ' + cast(error_state() as varchar(8));
print 'номер строки: ' + cast(error_line() as varchar(8));
if ERROR_PROCEDURE() is not null
print 'имя процедуры: ' + error_procedure();
return -1;
end catch;

go
declare @rc int;
exec @rc = PAUDITORIUM_INSERT @a = '310-1', @n = 'ЛБ-К', @c = 20, @t = '310-1';
print 'код ошибки: ' + cast(@rc as varchar(3));
select * from AUDITORIUM;
drop procedure PAUDITORIUM_INSERT;

--5
go
create procedure SUBJECT_REPORT @p char(10)
as
declare @rc int = 0;
begin try
declare @tv char(20), @t char(300) = '';
declare firstCursor cursor for select SUBJECT.SUBJECT from SUBJECT where SUBJECT.PULPIT = @p;
if not exists(select SUBJECT.SUBJECT from SUBJECT where SUBJECT.PULPIT = @p)
raiserror('ошибка', 11, 1);
else
open firstCursor;
fetch firstCursor into @tv;
print 'Названия дисциплин';
while @@FETCH_STATUS = 0
begin
set @t = RTRIM(@tv) + ',' + @t;
set @rc = @rc + 1;
fetch firstCursor into @tv;
end;
print @t;
close firstCursor;
return @rc;
end try
begin catch
print 'ошибка в параметрах'
if ERROR_PROCEDURE() is not null
print 'имя процедуры: ' + error_procedure();
return @rc;
end catch;

go
declare @rc int;
exec @rc = SUBJECT_REPORT @p = 'ИСиТ';
print 'Количество дисциплин: ' + cast(@rc as varchar(3));
drop procedure SUBJECT_REPORT;

--6
select * from AUDITORIUM;

	go
create procedure PAUDITORIUM_INSERTX @a char(20), @n varchar(50), @c int = 0, @t char(10), @tn varchar(50)
as declare @rc int = 1;
begin try
set transaction isolation level serializable;
begin tran
insert AUDITORIUM_TYPE(AUDITORIUM_TYPE, AUDITORIUM_TYPENAME)
values (@t, @tn)
exec @rc = PAUDITORIUM_INSERT @a, @n, @c, @t;
commit tran;
return @rc;
end try
begin catch
print 'номер ошибки: ' + cast(error_number() as varchar(6));
print 'сообщение: ' + error_message();
print 'уровень: ' + cast(error_severity() as varchar(6));
print 'метка: ' + cast(error_state() as varchar(8));
print 'номер строки: ' + cast(error_line() as varchar(8));
if ERROR_PROCEDURE() is not null
print 'имя процедуры: ' + error_procedure();
if @@TRANCOUNT > 0
rollback tran;
return -1;
end catch;

go
declare @rc int;
exec @rc = PAUDITORIUM_INSERTX @a = '204-1', @n = 'ЛБ-К', @c = 20, @t = '204-1', @tn = 'Лабораторная'
print 'код ошибки: ' + cast(@rc as varchar(3));
drop procedure PAUDITORIUM_INSERTX;