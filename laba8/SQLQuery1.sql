use UNIVER;

--1
go
create view [�������������]
as select GENDER[���], 
		  TEACHER_NAME[��� �������������], 
		  PULPIT[��� �������], 
		  TEACHER[���]
from TEACHER

go
select*from [�������������]

go
drop view [�������������]

--2
go
create view [���������� ������]
as select FACULTY_NAME[���������],
		  COUNT(PULPIT)[���������� ������]
from PULPIT inner join FACULTY
on FACULTY.FACULTY = PULPIT.FACULTY
group by FACULTY_NAME

--6
go
alter view [���������� ������] with SCHEMABINDING
as select fclt.FACULTY_NAME[���������],
		  COUNT(plpt.PULPIT)[���������� ������]
from dbo.PULPIT plpt inner join dbo.FACULTY fclt
on fclt.FACULTY = plpt.FACULTY
group by FACULTY_NAME

go
select*from [���������� ������]

go
drop view [���������� ������]

--3
go
create view [���������]
as select AUDITORIUM[���],
		  AUDITORIUM_NAME[������������ ���������]
from AUDITORIUM
where AUDITORIUM_TYPE like '%��%'

go 
select*from [���������]

go 
drop view [���������]

--4
go
create view [����������_���������]
as select AUDITORIUM[���],
		  AUDITORIUM_NAME[������������ ���������]
from AUDITORIUM
where AUDITORIUM_TYPE like '%��%' with check option

go
select*from [����������_���������]

go
drop view [����������_���������]

--5
go
create view [����������]
as select TOP 10 SUBJECT[���],
	      SUBJECT_NAME[������������ ����������],
		  PULPIT[���_�������]
from SUBJECT order by [������������ ����������]

go
select*from [����������]

go
drop view [����������]


