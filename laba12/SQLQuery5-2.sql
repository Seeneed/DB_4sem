use UNIVER;

-- B --
begin transaction
-- t1 --
update SUBJECT set PULPIT = '����' where PULPIT = '��'
commit;
-- t2 --
update SUBJECT set PULPIT = '��' where SUBJECT.SUBJECT = '��'