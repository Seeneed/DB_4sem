use UNIVER;
exec sp_helpindex'AUDITORIUM_TYPE'
exec sp_helpindex'AUDITORIUM'
exec sp_helpindex'FACULTY'
exec sp_helpindex'GROUPS'
exec sp_helpindex'PROFESSION'
exec sp_helpindex'PROGRESS'
exec sp_helpindex'PULPIT'
exec sp_helpindex'STUDENT'
exec sp_helpindex'SUBJECT'
exec sp_helpindex'TEACHER'

--1
create table #ex1
(
Id int,
Random_one int,
Random_two int
);

set nocount on;
declare @i int = 0;
declare @index int = 1;
while @i < 1000
begin
insert #ex1(Id, Random_one, Random_two)
values (@index, RAND()*1000, RAND()*1000)
set @i = @i + 1;
set @index = @index + 1;
end;

select*from #ex1 where Id between 200 and 500 order by Id;

checkpoint;
DBCC DROPCLEANBUFFERS;

create clustered index #ex1_index on #ex1(Id asc);
drop index #ex1_index on #ex1;
drop table #ex1;

--2
create table #ex2
(
TKEY int,
CC int identity(1,1),
TF varchar(100)
);

set nocount on;
declare @iter int = 0;
while @iter < 20000
begin
insert #ex2(TKEY, TF) 
values (FLOOR(30000*RAND()), REPLICATE('строка', 10));
set @iter = @iter + 1;
end;
select count(*)[Количество строк] from #ex2;
select*from #ex2

create index #ex2_index on #ex2(TKEY, CC);
checkpoint;
DBCC DROPCLEANBUFFERS;

select*from #ex2 where TKEY > 1500 and CC < 4500;
select*from #ex2 order by TKEY, CC;
select*from #ex2 where TKEY = 556 and CC > 3;

drop index #ex2_index on #ex2;
drop table #ex2;

--3
create table #ex3
(
TKEY int,
CC int identity(1,1),
TFIELD varchar(100)
);

set nocount on;
declare @iteration int = 0;
while @iteration < 20000
begin
insert #ex3(TKEY, TFIELD)
values (floor(30000*rand()), REPLICATE('строка', 10));
set @iteration = @iteration + 1;
end;

select CC from #ex3 where TKEY > 15000;

checkpoint;
DBCC DROPCLEANBUFFERS;
create index #ex3_index on #ex3(TKEY) include (CC);

drop index #ex3_index on #ex3;
drop table #ex3;

--4
create table #ex4
(
TKEY int,
CC int identity(1,1),
TFIELD varchar(100)
);

set nocount on;
declare @iterations int = 0;
while @iterations < 20000
begin
insert #ex4(TKEY, TFIELD)
values (FLOOR(30000*RAND()), REPLICATE('строка', 10));
set @iterations = @iterations + 1;
end;

select TKEY from #ex4 where TKEY between 5000 and 19999;
select TKEY from #ex4 where TKEY > 1500 and TKEY < 20000;
select TKEY from #ex4 where TKEY = 17000;

checkpoint;
DBCC DROPCLEANBUFFERS;

create index #ex4_index on #ex4(TKEY) where (TKEY >= 15000 and TKEY < 20000);

drop index #ex4_index on #ex4;
drop table #ex4;

--5-6
use tempdb;

create table #ex5
(
TKEY int,
СС int identity(1,1),
TFIELD varchar(100)
);

set nocount on;
declare @iteration_one int = 0;
while @iteration_one < 20000
begin
insert #ex5(TKEY, TFIELD)
values (FLOOR(30000*rand()), REPLICATE('строка', 10));
set @iteration_one = @iteration_one + 1;
end;

create index #ex5_index on #ex5(TKEY);

select name[Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),
object_id('N#ex5'), null, null, null) ss 
join sys.indexes ii
on ss.object_id = ii.object_id
and ss.index_id = ii.index_id
where name is not null;

insert top(10000) #ex5(TKEY, TFIELD) select TKEY, TFIELD from #ex5;
alter index #ex5_index on #ex5 reorganize;
alter index #ex5_index on #ex5 rebuild with (online = off);

drop index #ex5_index on #ex5;

create index #ex6_index on #ex5(TKEY) with (fillfactor = 65);

insert top(50) percent into #ex5(TKEY, TFIELD) select TKEY, TFIELD from #ex5;

select name[Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
from sys.dm_db_index_physical_stats(DB_ID(N'TEMPDB'),
object_id('N#ex5'), null, null, null) ss 
join sys.indexes ii
on ss.object_id = ii.object_id
and ss.index_id = ii.index_id
where name is not null;

drop index #ex6_index on #ex5;
drop table #ex5;