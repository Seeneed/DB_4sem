use MD_MyBase;

--1.1
go
create function COUNT_CREDITS(@credit varchar(20)) returns int
as begin declare @rc int = 0;
set @rc = (select count(КРЕДИТ.Вид_кредита) from КРЕДИТ inner join ДОГОВОР
on КРЕДИТ.ID_кредита = ДОГОВОР.ID_кредита
where КРЕДИТ.Вид_кредита = @credit);
return @rc;
end;

go
declare @credit varchar(20) = dbo.COUNT_CREDITS('Краткосрочный');
print 'Количество кредитов: ' + cast(@credit as varchar(3));

drop function COUNT_CREDITS;

--1.2
go
alter function COUNT_CREDITS(@credit varchar(20), @stavka real) returns int
as begin declare @rc int = 0;
set @rc = (select count(КРЕДИТ.Вид_кредита) from КРЕДИТ inner join ДОГОВОР
on КРЕДИТ.ID_кредита = ДОГОВОР.ID_кредита
where КРЕДИТ.Вид_кредита = @credit and КРЕДИТ.Ставка = @stavka);
return @rc;
end;

go
select dbo.COUNT_CREDITS('Краткосрочный', 0.1);

--2
go 
create function COUNT_CREDIT(@credit varchar(20)) returns char(300)
as
begin
declare @tv char(20);
declare @t varchar(300) = 'Кредиты';
declare secondCursor cursor local static
for select КРЕДИТ.Ставка from КРЕДИТ where КРЕДИТ.Вид_кредита = @credit;
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
select distinct Вид_кредита, dbo.COUNT_CREDIT(Вид_кредита) from КРЕДИТ;

drop function COUNT_CREDIT;

--3
go
create function CREDITDOGOVOR(@c varchar(20), @d varchar(20)) returns table
as return
select КРЕДИТ.Вид_кредита, ДОГОВОР.Сумма from КРЕДИТ left outer join ДОГОВОР
on ДОГОВОР.ID_кредита = КРЕДИТ.ID_кредита
where КРЕДИТ.Вид_кредита = isnull(@c, КРЕДИТ.Вид_кредита) and ДОГОВОР.Сумма = isnull(@d, ДОГОВОР.Сумма);

go
select * from dbo.CREDITDOGOVOR(null, null);
select * from dbo.CREDITDOGOVOR('Краткосрочный', null);
select * from dbo.CREDITDOGOVOR(null, 5000);

drop function CREDITDOGOVOR;

--4
go
create function FUNC(@p varchar(50)) returns int
as
begin
declare @rc int = (select count(*) from КЛИЕНТ
inner join ДОГОВОР on КЛИЕНТ.ID_клиента = ДОГОВОР.ID_клиента
where КЛИЕНТ.Вид_собственности = isnull(@p, КЛИЕНТ.Вид_собственности));
return @rc;
end;

go
select Вид_собственности, dbo.FUNC(Вид_собственности) from КЛИЕНТ;

drop function FUNC;