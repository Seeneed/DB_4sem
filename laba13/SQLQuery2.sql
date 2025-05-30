use MD_MyBase;

--1
go
create procedure PCREDIT
as
begin
declare @k int = (select count(*) from КРЕДИТ);
select * from КРЕДИТ;
return @k;
end;

go
declare @k int = 0;
exec @k = PCREDIT;
print 'Количество кредитов: ' + cast(@k as varchar(3));

--2
go
alter procedure PCREDIT @p varchar(20), @c int output
as
begin
declare @k int = (select count(*) from КРЕДИТ);
print 'параметры: @p = ' + @p + ',@c = ' + cast(@c as varchar(3));
select * from КРЕДИТ where КРЕДИТ.Вид_кредита = @p;
set @c = @@ROWCOUNT;
return @k;
end;

go
declare @k int = 0, @r int = 0, @p varchar(20) = 'Долгосрочный';
exec @k = PCREDIT @p = @p, @c = @r output;
print 'Количество кредитов: ' + cast(@k as varchar(3));
print 'Количество кредитов следующего вида: ' + @p + ' = ' + cast(@r as varchar(3));

--3
go
alter procedure PCREDIT @p varchar(20)
as
begin
declare @k int = (select count(*) from КРЕДИТ);
select * from КРЕДИТ where КРЕДИТ.Вид_кредита = @p;
end;

go
create table #КРЕДИТ
(
ID_кредита int primary key,
Вид_кредита nvarchar(50),
Ставка real
)

insert #КРЕДИТ exec PCREDIT @p = 'Долгосрочный';
insert #КРЕДИТ exec PCREDIT @P = 'Краткосрочный';

select * from #КРЕДИТ;

drop table #КРЕДИТ;

--4
go
create procedure CREDIT_INSERT @a int, @b nvarchar(50), @c real
as declare @rc int = 1;
begin try
insert КРЕДИТ(ID_кредита, Вид_кредита, Ставка)
values (@a, @b, @c)
return @rc;
end try
begin catch
print 'номер ошибки: ' + cast(error_number() as varchar(6));
print 'сообщение: ' + error_message();
print 'уровень: ' + cast(error_severity() as varchar(8));
print 'метка: ' + cast(error_state() as varchar(8));
print 'номер строки: ' + cast(error_line() as varchar(6));
if ERROR_PROCEDURE() is not null
print 'имя процедуры: ' + error_procedure();
return -1;
end catch;

go
declare @rc int;
exec @rc = CREDIT_INSERT @a = 11, @b = 'Ипотека', @c = 0.4;
print 'код ошибки: ' + cast(@rc as varchar(3));
select * from КРЕДИТ;
drop procedure CREDIT_INSERT;

--5
go
create procedure CREDIT_PRINT @p char(50)
as
declare @rc int = 0;
begin try
declare @tv char(20), @t char(300) = '';
declare secondCursor cursor for select КРЕДИТ.Ставка from КРЕДИТ where КРЕДИТ.Вид_кредита = @p;
if not exists (select КРЕДИТ.Ставка from КРЕДИТ where КРЕДИТ.Вид_кредита = @p)
raiserror('ошибка',11,1);
else
open secondCursor;
fetch secondCursor into @tv;
print 'Кредиты';
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
print 'ошибка в параметрах'
if ERROR_PROCEDURE() is not null
print 'имя процедуры: ' + error_procedure();
return @rc;
end catch;

go
declare @rc int;
exec @rc = CREDIT_PRINT @p = 'Долгосрочный';
print 'код ошибки: ' + cast(@rc as varchar(3));
drop procedure CREDIT_PRINT;

--6
go 
create procedure CREDIT_INSERT_X @a int, @b nvarchar(50), @c real, @fk nvarchar(50), @vs nvarchar(50), @ad nvarchar(50), @ph nvarchar(15)
as declare @rc int = 1;
begin try
set transaction isolation level serializable;
begin tran
insert КЛИЕНТ(ID_клиента, Фирма_клиент, Вид_собственности, Адрес, Телефон, Контактное_лицо)
values (@a, @fk, @vs, @ad, @ph, @b)
exec @rc = CREDIT_INSERT @a, @b, @c;
commit tran;
return @rc;
end try
begin catch
print 'номер ошибки: ' + cast(error_number() as varchar(6));
print 'сообщение: ' + error_message();
print 'уровень: ' + cast(error_severity() as varchar(8));
print 'метка: ' + cast(error_state() as varchar(8));
print 'номер строки: ' + cast(error_line() as varchar(6));
if ERROR_PROCEDURE() is not null
print 'имя процедуры: ' + error_procedure()
if @@TRANCOUNT > 0
rollback tran;
return -1;
end catch;

go
declare @rc int;
exec @rc = CREDIT_INSERT_X @a = 12, @b = 'Автокредит', @c = 0.3, @fk = 'Audi', @vs = 'Частная', @ad = 'г.Минск', @ph = '+375291234523'
print 'код ошибки: ' + cast(@rc as varchar(3));
drop procedure CREDIT_INSERT_X;
