use File_Group

CREATE TABLE ������(
ID_������� int NOT NULL,
���_������� nvarchar(50) NULL,
������ real NULL,
CONSTRAINT PR_������ PRIMARY KEY(ID_�������)
) on FG1;

CREATE TABLE ������(
ID_������� int NOT NULL,
�����_������ nvarchar(50) NULL,
���_������������� nvarchar(50) NULL,
����� nvarchar(50) NULL,
������� nvarchar(15) NULL,
����������_���� nvarchar(50) NULL,
CONSTRAINT PR_������ PRIMARY KEY(ID_�������)
) on FG1;

CREATE TABLE �������(
ID_�������� int NOT NULL,
����� int NULL,
����_������ date NULL,
����_�������� date NULL,
ID_������� int NULL foreign key references ������(ID_�������),
ID_������� int NULL foreign key references ������(ID_�������),
CONSTRAINT PR_������� PRIMARY KEY(ID_��������)
) on FG1;
