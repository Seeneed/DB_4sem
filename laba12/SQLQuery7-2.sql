use UNIVER;
-- B --
begin transaction
delete SUBJECT where SUBJECT = '����';
insert SUBJECT values('����','���������� ���������������� � ��������','����');
update SUBJECT set SUBJECT_NAME = '���������� ����������������' where SUBJECT = '����';
select SUBJECT_NAME from SUBJECT where PULPIT = '����';
-- t1 --
commit;
select SUBJECT_NAME from SUBJECT where PULPIT = '����';
-- t2 --
delete SUBJECT where SUBJECT = '����';