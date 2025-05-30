use MD_MyBase;

--1
select distinct ÊËÈÅÍÒ.Ôèðìà_êëèåíò
from ÄÎÃÎÂÎÐ, ÊËÈÅÍÒ, ÊÐÅÄÈÒ
where ÊËÈÅÍÒ.ID_êëèåíòà = ÄÎÃÎÂÎÐ.ID_êëèåíòà
and ÄÎÃÎÂÎÐ.ID_êðåäèòà in (select ÊÐÅÄÈÒ.ID_êðåäèòà from ÊÐÅÄÈÒ
where Âèä_êðåäèòà like '%êðàòêîñðî÷íûé%'
or Âèä_êðåäèòà like '%äîëãîñðî÷íûé%')

--2
select distinct ÊËÈÅÍÒ.Ôèðìà_êëèåíò
from ÊËÈÅÍÒ inner join ÄÎÃÎÂÎÐ
on ÊËÈÅÍÒ.ID_êëèåíòà = ÄÎÃÎÂÎÐ.ID_êëèåíòà
and ÄÎÃÎÂÎÐ.ID_êðåäèòà in (select ÊÐÅÄÈÒ.ID_êðåäèòà from ÊÐÅÄÈÒ
where Âèä_êðåäèòà like '%êðàòêîñðî÷íûé%'
or Âèä_êðåäèòà like '%äîëãîñðî÷íûé%')

--3 
select distinct ÊËÈÅÍÒ.Ôèðìà_êëèåíò
from ÊËÈÅÍÒ inner join ÄÎÃÎÂÎÐ
on ÊËÈÅÍÒ.ID_êëèåíòà = ÄÎÃÎÂÎÐ.ID_êëèåíòà
inner join ÊÐÅÄÈÒ
on ÊÐÅÄÈÒ.ID_êðåäèòà = ÄÎÃÎÂÎÐ.ID_êðåäèòà
where Âèä_êðåäèòà like '%êðàòêîñðî÷íûé%'
or Âèä_êðåäèòà like '%äîëãîñðî÷íûé%'

--4
select ID_äîãîâîðà, Ñóììà
from ÄÎÃÎÂÎÐ d
where Ñóììà = (select top(1) Ñóììà from ÄÎÃÎÂÎÐ dd
where dd.ID_äîãîâîðà = d.ID_äîãîâîðà
order by Ñóììà desc)
order by Ñóììà desc

--5
select ID_äîãîâîðà from ÄÎÃÎÂÎÐ
where not exists (select*from ÊÐÅÄÈÒ
where ÊÐÅÄÈÒ.ID_êðåäèòà = ÄÎÃÎÂÎÐ.ID_êðåäèòà)

--6
select top 1
(select avg(Ñóììà) from ÄÎÃÎÂÎÐ
where Äàòà_âîçâðàòà like '2022-06-24')[Äàòà 1],
(select avg(Ñóììà) from ÄÎÃÎÂÎÐ
where Äàòà_âîçâðàòà like '2025-05-12')[Äàòà 2]

--7
select ID_äîãîâîðà, Ñóììà from ÄÎÃÎÂÎÐ
where Ñóììà >=all(select Ñóììà from ÄÎÃÎÂÎÐ where ID_äîãîâîðà like '0%')

--8
select ID_äîãîâîðà, Ñóììà from ÄÎÃÎÂÎÐ
where ID_äîãîâîðà > any(select ID_äîãîâîðà from ÄÎÃÎÂÎÐ where Ñóììà > 40000)