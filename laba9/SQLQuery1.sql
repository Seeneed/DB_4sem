use UNIVER;

--1
declare @c char = 'Д',
		@vc varchar(4) = 'БГТУ',
		@dt datetime,
		@t time,
		@i int,
		@si smallint,
		@ti tinyint,
		@n numeric(12,5);
set @dt = GETDATE();
set @i = 1;
select @si = 4;
select @ti = 200;
print 'dt: ' + cast(@dt as varchar(20));
print 'i: ' + cast(@i as varchar(10));
select @c, @vc,@i, @si;

--2
declare @a1 int = (select cast(sum(AUDITORIUM.AUDITORIUM_CAPACITY)as int) from AUDITORIUM),
		@a2 int,
		@a3 int,
		@a4 int,
		@a5 int
if @a1 > 200
begin
select @a2 = (select cast(count(*) as int) from AUDITORIUM),
	   @a3 = (select cast(avg(AUDITORIUM.AUDITORIUM_CAPACITY) as int) from AUDITORIUM)
set @a4 = (select cast(count(*) as int) from AUDITORIUM where AUDITORIUM_CAPACITY < @a3)
set @a5 = (@a4 * 100) / @a3
select @a2 'Количество аудиторий', @a3 'Средняя вместимость аудиторий', 
@a4 'Количество аудиторий, вместимость которых меньше средней', @a5 'Процент аудиторий'
end
else print 'Размер общей вместимости' + cast(@a1 as varchar(5));

--3
print 'Число обработанных строк: ' + cast(@@ROWCOUNT as varchar(10));
print 'Версия SQL Server: ' + cast(@@VERSION as varchar(300));
print 'Системный идентификатор процесса, назначенный сервером текущему подключению: ' + cast(@@SPID as varchar(10));
print 'Код последней ошибки: ' + cast(@@ERROR as varchar(30));
print 'Имя сервера: ' + cast(@@SERVERNAME as varchar(30));
print 'Уровень вложенности транзакции: ' + cast(@@trancount as varchar(30));
print 'Проверка результата считывания строк результирующего набора: ' + cast(@@FETCH_STATUS as varchar(30));
print 'Уровень вложенности текущей процедуры: ' + cast(@@NESTLEVEL as varchar(30));

--4.1
declare @t1 int = 10, 
		@x1 int = 12,
		@z1 float(10);
if @t1 > @x1
begin
set @z1 = POWER(SIN(@t1),2);
print 'z1 = ' + cast(@z1 as varchar(10));
end
else if @t1 < @x1
begin
set @z1 = 4 * (@t1 + @x1);
print 'z1 = ' + cast(@z1 as varchar(10));
end
else if @t1 = @x1
begin
set @z1 = 1 - EXP(@x1 - 2);
print 'z1 = ' + cast(@z1 as varchar(10));
end;

--4.2
declare @full_name varchar(100) = 'Мамонько Денис Александрович';
set @full_name = (select substring(@full_name, 1, charindex(' ', @full_name)) +
substring(@full_name, charindex(' ', @full_name) + 1, 1) + '.' +
substring(@full_name, charindex(' ', @full_name, charindex(' ', @full_name) + 1)+ 1, 1) + '.');
print @full_name;

--4.3
declare @next_month int = MONTH(GETDATE()) + 1;
select * from STUDENT where MONTH(STUDENT.BDAY) = @next_month;

--4.4
select 
case
when DATEPART(WEEKDAY, PDATE) = 1 then 'Понедельник'
when DATEPART(WEEKDAY, PDATE) = 2 then 'Вторник'
when DATEPART(WEEKDAY, PDATE) = 3 then 'Среда'
when DATEPART(WEEKDAY, PDATE) = 4 then 'Четверг'
when DATEPART(WEEKDAY, PDATE) = 5 then 'Пятница'
when DATEPART(WEEKDAY, PDATE) = 6 then 'Суббота'
when DATEPART(WEEKDAY, PDATE) = 7 then 'Воскресенье'
end
from PROGRESS where PROGRESS.SUBJECT = 'СУБД'

--5
--use MD_MyBase;
--declare @s1 int = (select cast(avg(ДОГОВОР.СУММА) as int) from ДОГОВОР)
--if @s1 > '35000'
--begin
--print 'Средняя сумма взятых кредитов больше 35000'
--end
--else print 'Средняя сумма взятых кредитов меньше 35000'

--6
select PROGRESS.SUBJECT, PROGRESS.IDSTUDENT,
case
when avg(PROGRESS.NOTE) = 4 then 'Удовлетворительно'
when avg(PROGRESS.NOTE) between 5 and 6 then 'Ниже среднего'
when avg(PROGRESS.NOTE) between 7 and 8 then 'Хорошо'
when avg(PROGRESS.NOTE) between 9 and 10 then 'Отлично'
else 'Не удовлетворительно'
end
from PROGRESS
group by PROGRESS.SUBJECT, PROGRESS.IDSTUDENT

--7
drop table #examle;
create table #examle
(
	ID int,
	random_number_one int,
	random_number_two int,
);
declare @iteration int = 0;
declare @index int = 1;
while @iteration < 10
	begin
	insert #examle(ID, random_number_one, random_number_two)
			values(@index, rand() * 1000, rand() * 1000);
	set @iteration = @iteration + 1;
	set @index = @index + 1;
	end
select * from #examle;

--8
declare @x int = 1
print @x + 1
print @x + 2
return
print @x + 3

--9
begin try
update AUDITORIUM set AUDITORIUM_CAPACITY = 'Строка' where AUDITORIUM_CAPACITY = '15'
end try
begin catch
print ERROR_NUMBER()
print ERROR_MESSAGE()
print ERROR_LINE()
print ERROR_PROCEDURE()
print ERROR_SEVERITY()
print ERROR_STATE()
end catch
