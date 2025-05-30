use MD_MyBase; 
exec sp_helpindex'ДОГОВОР'
exec sp_helpindex'КЛИЕНТ'
exec sp_helpindex'КРЕДИТ'

--1
checkpoint;
DBCC DROPCLEANBUFFERS;
select*from ДОГОВОР where Сумма between 10000 and 100000 order by Сумма;

--2
select count(*)[Количество кредитов] from КРЕДИТ;
select*from КРЕДИТ;
create index index1 on КРЕДИТ(Вид_кредита, ставка);

select*from КРЕДИТ where Вид_кредита like '%Краткосрочный%' and Ставка < 0.25
select*from КРЕДИТ order by Вид_кредита, Ставка
select*from КРЕДИТ where ((Вид_кредита like '%Краткосрочный%' or Вид_кредита like '%Долгосрочный%') and Ставка < 0.15)

drop index index1 on КРЕДИТ;

--3
create index index2 on КРЕДИТ(Вид_кредита) include (Ставка)
select Ставка from КРЕДИТ where Вид_кредита like '%срочный%'
drop index index2 on КРЕДИТ;

--4
select Сумма from ДОГОВОР where Сумма = 10000
select Сумма from ДОГОВОР where Сумма >= 15000 and Сумма <= 50000
select Сумма from ДОГОВОР where Сумма >= 55000 and Сумма <= 90000
create index index3 on ДОГОВОР(Сумма) where (Сумма >= 15000 and Сумма <= 50000)
drop index index3 on ДОГОВОР;

--5-6
create index index4 on ДОГОВОР(Сумма);
select name[Индекс], avg_fragmentation_in_percent[Фрагментация (%)]
from sys.dm_db_index_physical_stats(DB_ID(),
OBJECT_ID('ДОГОВОР'), null, null, null) ss
join sys.indexes ii
on ss.object_id = ii.object_id
and ss.index_id = ii.index_id
where name is not null;

alter index index4 on ДОГОВОР reorganize;

alter index index4 on ДОГОВОР rebuild with (online = off);

drop index index4 on ДОГОВОР;

create index index5 on ДОГОВОР(Сумма) with (fillfactor = 65);
select name[Индекс], avg_fragmentation_in_percent[Фрагментация (%)]
from sys.dm_db_index_physical_stats(DB_ID(),
OBJECT_ID('ДОГОВОР'), null, null, null) ss
join sys.indexes ii
on ss.object_id = ii.object_id
and ss.index_id = ii.index_id
where name is not null;

drop index index5 on ДОГОВОР;
