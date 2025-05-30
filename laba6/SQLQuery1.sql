use UNIVER;

--1
select AUDITORIUM_TYPE.AUDITORIUM_TYPE[Тип аудитории],
max(AUDITORIUM_CAPACITY)[Максимальная вместимость],
min(AUDITORIUM_CAPACITY)[Минимальная вместимость],
avg(AUDITORIUM_CAPACITY)[Средняя вместимость],
sum(AUDITORIUM_CAPACITY)[Сумма всех вместимостей],
count(AUDITORIUM_CAPACITY)[Количество аудиторий]
from AUDITORIUM inner join AUDITORIUM_TYPE
on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
group by AUDITORIUM_TYPE.AUDITORIUM_TYPE

--2
select*
from(select Case when PROGRESS.NOTE between 4 and 5 then '4-5'
				 when PROGRESS.NOTE between 6 and 7 then '6-7'
				 when PROGRESS.NOTE between 8 and 9 then '8-9'
				 else '10'
				 end[Экзаменационные оценки],COUNT(*)[Количество]
from PROGRESS group by Case when PROGRESS.NOTE between 4 and 5 then '4-5'
							when PROGRESS.NOTE between 6 and 7 then '6-7'
							when PROGRESS.NOTE between 8 and 9 then '8-9'
							else '10'
							end) as T
							order by case[Экзаменационные оценки]
							when '4-5' then 3
							when '6-7' then 2
							when '8-9' then 1
							else 0
							end

--3
select GROUPS.PROFESSION[Специальность], FACULTY.FACULTY_NAME[Факультет], 
round(avg(cast(PROGRESS.NOTE as float)),2) [Средняя оценка], (2014 - GROUPS.YEAR_FIRST) [Курс]
from FACULTY
	inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
	inner join STUDENT on STUDENT.IDGROUP = GROUPS.IDGROUP
	inner join PROGRESS on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
group by
	GROUPS.PROFESSION, FACULTY.FACULTY_NAME, GROUPS.YEAR_FIRST
order by [Средняя оценка] desc

--4
select GROUPS.PROFESSION[Специальность], FACULTY.FACULTY_NAME[Факультет],
round(avg(cast(PROGRESS.NOTE as float)), 2)[Средняя оценка], (2014 - GROUPS.YEAR_FIRST)[Курс]
from FACULTY
	inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
	inner join STUDENT on STUDENT.IDGROUP = GROUPS.IDGROUP
	inner join PROGRESS on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where
	PROGRESS.SUBJECT = 'ОАиП' or PROGRESS.SUBJECT = 'БД'
group by
	GROUPS.PROFESSION, FACULTY.FACULTY_NAME, GROUPS.YEAR_FIRST
order by [Средняя оценка] desc

--5
select GROUPS.PROFESSION[Специальность], PROGRESS.SUBJECT[Дисциплина],
round(avg(cast(PROGRESS.NOTE as float)), 2) as [Средняя оценка]
from FACULTY
inner join GROUPS on FACULTY.FACULTY = GROUPS.FACULTY
inner join STUDENT on STUDENT.IDGROUP = GROUPS.IDGROUP
inner join PROGRESS on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where FACULTY.FACULTY like 'ИДиП'
group by GROUPS.PROFESSION, PROGRESS.SUBJECT, FACULTY.FACULTY

--6
select PROGRESS.SUBJECT[Дисциплина], COUNT(*)[Количество студентов]
from PROGRESS
	group by PROGRESS.SUBJECT, PROGRESS.NOTE
	having PROGRESS.NOTE = '8' or PROGRESS.NOTE = '9'
