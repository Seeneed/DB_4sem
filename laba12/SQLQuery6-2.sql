use UNIVER;
-- B --
begin transaction
-- t1 --
insert SUBJECT values('����','���������� ���������������� � ��������','��');
commit;
-- t2 --
delete SUBJECT where SUBJECT = '����';