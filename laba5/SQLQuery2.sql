use MD_MyBase;

--1
select distinct ������.�����_������
from �������, ������, ������
where ������.ID_������� = �������.ID_�������
and �������.ID_������� in (select ������.ID_������� from ������
where ���_������� like '%�������������%'
or ���_������� like '%������������%')

--2
select distinct ������.�����_������
from ������ inner join �������
on ������.ID_������� = �������.ID_�������
and �������.ID_������� in (select ������.ID_������� from ������
where ���_������� like '%�������������%'
or ���_������� like '%������������%')

--3 
select distinct ������.�����_������
from ������ inner join �������
on ������.ID_������� = �������.ID_�������
inner join ������
on ������.ID_������� = �������.ID_�������
where ���_������� like '%�������������%'
or ���_������� like '%������������%'

--4
select ID_��������, �����
from ������� d
where ����� = (select top(1) ����� from ������� dd
where dd.ID_�������� = d.ID_��������
order by ����� desc)
order by ����� desc

--5
select ID_�������� from �������
where not exists (select*from ������
where ������.ID_������� = �������.ID_�������)

--6
select top 1
(select avg(�����) from �������
where ����_�������� like '2022-06-24')[���� 1],
(select avg(�����) from �������
where ����_�������� like '2025-05-12')[���� 2]

--7
select ID_��������, ����� from �������
where ����� >=all(select ����� from ������� where ID_�������� like '0%')

--8
select ID_��������, ����� from �������
where ID_�������� > any(select ID_�������� from ������� where ����� > 40000)