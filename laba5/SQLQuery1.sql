use UNIVER;

--1
select distinct PULPIT.PULPIT_NAME
from PULPIT, FACULTY, PROFESSION
where PULPIT.FACULTY = FACULTY.FACULTY
and FACULTY.FACULTY In(select PROFESSION.FACULTY from PROFESSION
where PROFESSION_NAME like '%технология%'
or PROFESSION_NAME like '%технологии%')

--2 
select distinct PULPIT.PULPIT_NAME
from PULPIT inner join FACULTY
on PULPIT.FACULTY = FACULTY.FACULTY
and FACULTY.FACULTY In(select PROFESSION.FACULTY from PROFESSION
where PROFESSION_NAME like '%технология%'
or PROFESSION_NAME like '%технологии%')

--3
select distinct PULPIT.PULPIT_NAME
from PULPIT inner join FACULTY
on PULPIT.FACULTY = FACULTY.FACULTY
inner join PROFESSION
on PROFESSION.FACULTY = PULPIT.FACULTY
where PROFESSION_NAME like '%технология%'
or PROFESSION_NAME like '%технологии%'

--4
select AUDITORIUM_NAME, AUDITORIUM_CAPACITY, AUDITORIUM_TYPE
from AUDITORIUM a
where AUDITORIUM_CAPACITY = (select top(1) AUDITORIUM_CAPACITY from AUDITORIUM aa
where aa.AUDITORIUM_TYPE = a.AUDITORIUM_TYPE
order by AUDITORIUM_CAPACITY desc)
order by AUDITORIUM_CAPACITY desc

--5
select FACULTY.FACULTY_NAME from FACULTY
where not exists (select*from PULPIT
where PULPIT.FACULTY = FACULTY.FACULTY)

--6
select top 1
(select avg(PROGRESS.NOTE) from PROGRESS
where PROGRESS.SUBJECT like 'ОАиП')[ОАиП],
(select avg(PROGRESS.NOTE) from PROGRESS
where PROGRESS.SUBJECT like 'БД')[БД],
(select avg(PROGRESS.NOTE) from PROGRESS
where PROGRESS.SUBJECT like 'СУБД')[СУБД]

--7
select NOTE, SUBJECT from PROGRESS
where NOTE >=all(select NOTE from PROGRESS where SUBJECT like '0%')

--8
select NOTE, SUBJECT from PROGRESS
where NOTE >any (select NOTE from PROGRESS where NOTE > 5)