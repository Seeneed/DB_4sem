use MD_MyBase;

ALTER Table ������ ADD ���_���������� nvarchar(100);
Go
ALTER Table ������ ADD CONSTRAINT c_���_���������� CHECK(���_���������� = '�������� ������ ��������');
Go
