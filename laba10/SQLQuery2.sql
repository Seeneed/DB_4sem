use MD_MyBase; 
exec sp_helpindex'�������'
exec sp_helpindex'������'
exec sp_helpindex'������'

--1
checkpoint;
DBCC DROPCLEANBUFFERS;
select*from ������� where ����� between 10000 and 100000 order by �����;

--2
select count(*)[���������� ��������] from ������;
select*from ������;
create index index1 on ������(���_�������, ������);

select*from ������ where ���_������� like '%�������������%' and ������ < 0.25
select*from ������ order by ���_�������, ������
select*from ������ where ((���_������� like '%�������������%' or ���_������� like '%������������%') and ������ < 0.15)

drop index index1 on ������;

--3
create index index2 on ������(���_�������) include (������)
select ������ from ������ where ���_������� like '%�������%'
drop index index2 on ������;

--4
select ����� from ������� where ����� = 10000
select ����� from ������� where ����� >= 15000 and ����� <= 50000
select ����� from ������� where ����� >= 55000 and ����� <= 90000
create index index3 on �������(�����) where (����� >= 15000 and ����� <= 50000)
drop index index3 on �������;

--5-6
create index index4 on �������(�����);
select name[������], avg_fragmentation_in_percent[������������ (%)]
from sys.dm_db_index_physical_stats(DB_ID(),
OBJECT_ID('�������'), null, null, null) ss
join sys.indexes ii
on ss.object_id = ii.object_id
and ss.index_id = ii.index_id
where name is not null;

alter index index4 on ������� reorganize;

alter index index4 on ������� rebuild with (online = off);

drop index index4 on �������;

create index index5 on �������(�����) with (fillfactor = 65);
select name[������], avg_fragmentation_in_percent[������������ (%)]
from sys.dm_db_index_physical_stats(DB_ID(),
OBJECT_ID('�������'), null, null, null) ss
join sys.indexes ii
on ss.object_id = ii.object_id
and ss.index_id = ii.index_id
where name is not null;

drop index index5 on �������;
