use UNIVER;

-- B --
begin transaction
-- t1 --
update SUBJECT set PULPIT = '»—Ë“' where PULPIT = 'À”'
commit;
-- t2 --
update SUBJECT set PULPIT = 'À”' where SUBJECT.SUBJECT = '»√'