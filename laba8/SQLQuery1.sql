use UNIVER;

--1
go
create view [Преподаватель]
as select GENDER[Пол], 
		  TEACHER_NAME[Имя преподавателя], 
		  PULPIT[Код кафедры], 
		  TEACHER[Код]
from TEACHER

go
select*from [Преподаватель]

go
drop view [Преподаватель]

--2
go
create view [Количество кафедр]
as select FACULTY_NAME[Факультет],
		  COUNT(PULPIT)[Количество кафедр]
from PULPIT inner join FACULTY
on FACULTY.FACULTY = PULPIT.FACULTY
group by FACULTY_NAME

--6
go
alter view [Количество кафедр] with SCHEMABINDING
as select fclt.FACULTY_NAME[Факультет],
		  COUNT(plpt.PULPIT)[Количество кафедр]
from dbo.PULPIT plpt inner join dbo.FACULTY fclt
on fclt.FACULTY = plpt.FACULTY
group by FACULTY_NAME

go
select*from [Количество кафедр]

go
drop view [Количество кафедр]

--3
go
create view [Аудитории]
as select AUDITORIUM[Код],
		  AUDITORIUM_NAME[Наименование аудитории]
from AUDITORIUM
where AUDITORIUM_TYPE like '%ЛК%'

go 
select*from [Аудитории]

go 
drop view [Аудитории]

--4
go
create view [Лекционные_аудитории]
as select AUDITORIUM[Код],
		  AUDITORIUM_NAME[Намменование аудитории]
from AUDITORIUM
where AUDITORIUM_TYPE like '%ЛК%' with check option

go
select*from [Лекционные_аудитории]

go
drop view [Лекционные_аудитории]

--5
go
create view [Дисциплины]
as select TOP 10 SUBJECT[Код],
	      SUBJECT_NAME[Наименование дисциплины],
		  PULPIT[Код_кафедры]
from SUBJECT order by [Наименование дисциплины]

go
select*from [Дисциплины]

go
drop view [Дисциплины]


