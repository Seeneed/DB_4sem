use UNIVER;

--1.1
go
create function COUNT_STUDENTS(@faculty varchar(20)) returns int
as begin declare @rc int = 0;
set @rc = (select count(STUDENT.NAME) from STUDENT join GROUPS on STUDENT.IDGROUP = GROUPS.IDGROUP
inner join FACULTY on FACULTY.FACULTY = GROUPS.FACULTY 
where FACULTY.FACULTY = @faculty);
return @rc;
end;

go
declare @faculty varchar(20) = dbo.COUNT_STUDENTS('ИДиП');
print 'Количество студентов на факультете ИДиП: ' + cast(@faculty as varchar(3));

drop function COUNT_STUDENTS;

--1.2
go
alter function COUNT_STUDENTS(@faculty varchar(20), @prof varchar(20) = NULL) returns int
as begin declare @rc int = 0;
set @rc = (select count(STUDENT.NAME) from STUDENT join GROUPS on STUDENT.IDGROUP = GROUPS.IDGROUP
join FACULTY on FACULTY.FACULTY = GROUPS.FACULTY
join PROFESSION on PROFESSION.FACULTY = FACULTY.FACULTY
where FACULTY.FACULTY = @faculty and PROFESSION.QUALIFICATION = @prof);
return @rc;
end;

go
select dbo.COUNT_STUDENTS('ИЭФ', 'экономист')

--2
go
create function FSUBJECTS(@p varchar(20)) returns char(300)
as
begin
declare @tv char(20);
declare @t varchar(300) = 'Дисциплины';
declare firstCursor cursor local static
for select SUBJECT.SUBJECT from SUBJECT where SUBJECT.PULPIT = @p;
open firstCursor;
fetch firstCursor into @tv;
while @@FETCH_STATUS = 0
begin
set @t = @t + ',' + RTRIM(@tv);
fetch firstCursor into @tv;
end
close firstCursor;
deallocate firstCursor;
return @t;
end;

go
select PULPIT, dbo.FSUBJECTS(PULPIT) from PULPIT;
drop function FSUBJECTS;

--3
go
create function FFACPUL(@faculty varchar(20), @pulpit varchar(20)) returns table
as return
select FACULTY.FACULTY, PULPIT.PULPIT from FACULTY left outer join PULPIT on FACULTY.FACULTY = PULPIT.FACULTY
where FACULTY.FACULTY = isnull(@faculty, FACULTY.FACULTY) and PULPIT.PULPIT = isnull(@pulpit, PULPIT.PULPIT);

go
select * from dbo.FFACPUL(null, null);
select * from dbo.FFACPUL('ЛХФ', null);
select * from dbo.FFACPUL(null, 'ИВД');
drop function FFACPUL;

--4
go
create function FCTEACHER(@p varchar(50)) returns int
as begin
declare @rc int = (select count(TEACHER.TEACHER_NAME) from TEACHER
inner join PULPIT on TEACHER.PULPIT = PULPIT.PULPIT
where PULPIT.PULPIT = isnull(@p, PULPIT.PULPIT));
return @rc;
end;

go
select PULPIT, dbo.FCTEACHER(PULPIT) from PULPIT;
drop function FCTEACHER;

--6
go
create function COUNT_PULPITS(@pulpit varchar(20)) returns int
as begin declare @rc int = 0;
set @rc = (select count(PROFESSION.PROFESSION) from STUDENT inner join GROUPS on STUDENT.IDGROUP = GROUPS.IDGROUP
inner join FACULTY on FACULTY.FACULTY = GROUPS.FACULTY
inner join PROFESSION on PROFESSION.FACULTY = FACULTY.FACULTY
inner join PULPIT on PULPIT.FACULTY = FACULTY.FACULTY
where FACULTY.FACULTY = @pulpit);
return @rc;
end;

go
create function COUNT_GROUPS(@group varchar(20)) returns int
as begin declare @rc int = 0;
set @rc = (select count(GROUPS.IDGROUP) from STUDENT inner join GROUPS on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join FACULTY on FACULTY.FACULTY = GROUPS.FACULTY
inner join PROFESSION on PROFESSION.FACULTY = FACULTY.FACULTY
where FACULTY.FACULTY = @group);
return @rc;
end;

go
create function COUNT_PROFESSIONS(@prof varchar(20)) returns int
as begin declare @rc int = 0;
set @rc = (select count(PROFESSION.PROFESSION) from STUDENT inner join GROUPS on GROUPS.IDGROUP = STUDENT.IDGROUP
inner join FACULTY on FACULTY.FACULTY = GROUPS.FACULTY
inner join PROFESSION on PROFESSION.FACULTY = FACULTY.FACULTY
where FACULTY.FACULTY = @prof);
return @rc;
end;

go
		create function FACULTY_REPORT(@c int) returns @fr table
	                    ( [Факультет] varchar(50), [Количество кафедр] int, [Количество групп]  int, 
	                                                                [Количество студентов] int, [Количество специальностей] int )
as begin 
                declare cc CURSOR static for 
	    select FACULTY from FACULTY 
                where dbo.COUNT_STUDENTS(FACULTY) > @c; 
	    declare @f varchar(30);
	    open cc;  
        fetch cc into @f;
	    while @@fetch_status = 0
	    begin
		insert @fr values(
		@f,
		dbo.COUNT_GROUPS(@f),
		dbo.COUNT_PROFESSIONS(@f),
		dbo.COUNT_PULPITS(@f),
		dbo.COUNT_STUDENTS(@f));
		fetch cc into @f;
		end;
		close cc;
		deallocate cc;
		return;
		end;

go
select * from dbo.FACULTY_REPORT(0)

drop function COUNT_PULPITS;
drop function COUNT_GROUPS;
drop function COUNT_PROFESSIONS;
drop function FACULTY_REPORT;




