use UNIVER;

create table FACULTY(
FACULTY char(10) constraint FACULTY_PK primary key,
FACULTY_NAME varchar(50) default '???'
)

create table PROFESSION(
PROFESSION char(20) primary key,
FACULTY char(10) foreign key references FACULTY(FACULTY),
PROFESSION_NAME varchar(100),    
QUALIFICATION varchar(50)  
)  

create table PULPIT (
PULPIT char(20) primary key,
PULPIT_NAME varchar(100), 
FACULTY char(10) foreign key references FACULTY(FACULTY) 
)

create table TEACHER(
TEACHER char(10) primary key,
TEACHER_NAME varchar(100), 
GENDER char(1) check (GENDER in ('ì', 'æ')),
PULPIT char(20) foreign key references PULPIT(PULPIT) 
)

create table SUBJECT( 
SUBJECT char(10) primary key, 
SUBJECT_NAME varchar(100) unique,
PULPIT char(20) foreign key references PULPIT(PULPIT)   
)

create table AUDITORIUM_TYPE (
AUDITORIUM_TYPE char(10) primary key,  
AUDITORIUM_TYPENAME varchar(30)       
)

create table AUDITORIUM (
AUDITORIUM char(20) primary key,              
AUDITORIUM_TYPE char(10) foreign key references AUDITORIUM_TYPE(AUDITORIUM_TYPE), 
AUDITORIUM_CAPACITY integer default 1 check (AUDITORIUM_CAPACITY between 1 and 300),  
AUDITORIUM_NAME varchar(50)                                     
)

create table GROUPS (
IDGROUP integer identity(1,1) constraint GROUP_PK primary key,              
FACULTY char(10) foreign key references FACULTY(FACULTY), 
PROFESSION char(20) foreign key references PROFESSION(PROFESSION),
YEAR_FIRST smallint check (YEAR_FIRST<=YEAR(GETDATE())),                  
)

create table STUDENT (
IDSTUDENT integer  identity(1000,1) constraint STUDENT_PK  primary key,
IDGROUP integer   foreign key references GROUPS(IDGROUP),        
NAME nvarchar(100), 
BDAY date,
STAMP timestamp,
INFO xml,
FOTO varbinary
) 

create table PROGRESS(
SUBJECT char(10) foreign key references SUBJECT(SUBJECT),                
IDSTUDENT integer foreign key references STUDENT(IDSTUDENT),        
PDATE date, 
NOTE integer check (NOTE between 1 and 10)
)
