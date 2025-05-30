use MD_MyBase;

--1
go
create view [Кредит_банка]
as select ID_кредита[ID],
		  Вид_кредита[Вид кредита],
		  Ставка[Ставка]
from КРЕДИТ

go
select*from [Кредит_банка]

go
drop view [Кредит_банка]

--2
go
create view [Количество видов собственности]
as select Вид_кредита[Вид кредита],
		  COUNT(Вид_собственности)[Вид собственности]
from КРЕДИТ inner join ДОГОВОР
on КРЕДИТ.ID_кредита = ДОГОВОР.ID_кредита
inner join КЛИЕНТ
on КЛИЕНТ.ID_клиента = ДОГОВОР.ID_клиента
group by Вид_кредита

--6
go
alter view [Количество видов собственности] with schemabinding
as select crdt.Вид_кредита[Вид кредита],
		  COUNT(clnt.Вид_собственности)[Вид собственности]
from dbo.КРЕДИТ crdt inner join dbo.ДОГОВОР dgv
on crdt.ID_кредита = dgv.ID_кредита
inner join dbo.КЛИЕНТ clnt
on clnt.ID_клиента = dgv.ID_клиента
group by Вид_кредита

go
select*from [Количество видов собственности]

go
drop view [Количество видов собственности]

--3
go
create view [Виды_кредитов]
as select ID_кредита[ID],
		  Вид_кредита[Вид кредита],
		  Ставка[Ставка]
from КРЕДИТ
where Вид_кредита like '%срочный%'

go
select*from [Виды_кредитов]

go
drop view [Виды_кредитов]

--4
go
create view [Виды_кредитов]
as select ID_кредита[ID],
		  Вид_кредита[Вид кредита],
		  Ставка[Ставка]
from КРЕДИТ
where Вид_кредита like '%срочный%' with check option

go
select*from [Виды_кредитов]

go
drop view [Виды_кредитов]

--5
go
create view [Виды_кредитов]
as select top 10 ID_кредита[ID],
				 Вид_кредита[Вид кредита],
				 Ставка[Ставка]
from КРЕДИТ order by [Вид кредита]

go
select*from [Виды_кредитов]

go
drop view [Виды_кредитов]
