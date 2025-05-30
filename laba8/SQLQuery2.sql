use MD_MyBase;

--1
go
create view [������_�����]
as select ID_�������[ID],
		  ���_�������[��� �������],
		  ������[������]
from ������

go
select*from [������_�����]

go
drop view [������_�����]

--2
go
create view [���������� ����� �������������]
as select ���_�������[��� �������],
		  COUNT(���_�������������)[��� �������������]
from ������ inner join �������
on ������.ID_������� = �������.ID_�������
inner join ������
on ������.ID_������� = �������.ID_�������
group by ���_�������

--6
go
alter view [���������� ����� �������������] with schemabinding
as select crdt.���_�������[��� �������],
		  COUNT(clnt.���_�������������)[��� �������������]
from dbo.������ crdt inner join dbo.������� dgv
on crdt.ID_������� = dgv.ID_�������
inner join dbo.������ clnt
on clnt.ID_������� = dgv.ID_�������
group by ���_�������

go
select*from [���������� ����� �������������]

go
drop view [���������� ����� �������������]

--3
go
create view [����_��������]
as select ID_�������[ID],
		  ���_�������[��� �������],
		  ������[������]
from ������
where ���_������� like '%�������%'

go
select*from [����_��������]

go
drop view [����_��������]

--4
go
create view [����_��������]
as select ID_�������[ID],
		  ���_�������[��� �������],
		  ������[������]
from ������
where ���_������� like '%�������%' with check option

go
select*from [����_��������]

go
drop view [����_��������]

--5
go
create view [����_��������]
as select top 10 ID_�������[ID],
				 ���_�������[��� �������],
				 ������[������]
from ������ order by [��� �������]

go
select*from [����_��������]

go
drop view [����_��������]
