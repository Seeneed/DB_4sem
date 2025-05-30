use MD_MyBase;

DROP TABLE IF EXISTS КРЕДИТ;
DROP TABLE IF EXISTS КЛИЕНТ;
DROP TABLE IF EXISTS ДОГОВОР;

CREATE TABLE КРЕДИТ(
ID_кредита int NOT NULL,
Вид_кредита nvarchar(50) NULL,
Ставка real NULL,
CONSTRAINT PR_КРЕДИТ PRIMARY KEY(ID_кредита)
);

CREATE TABLE КЛИЕНТ(
ID_клиента int NOT NULL,
Фирма_клиент nvarchar(50) NULL,
Вид_собственности nvarchar(50) NULL,
Адрес nvarchar(50) NULL,
Телефон nvarchar(15) NULL,
Контактное_лицо nvarchar(50) NULL,
CONSTRAINT PR_КЛИЕНТ PRIMARY KEY(ID_клиента)
);

CREATE TABLE ДОГОВОР(
ID_договора int NOT NULL,
Сумма int NULL,
Дата_выдачи date NULL,
Дата_возврата date NULL,
ID_кредита int NULL foreign key references КРЕДИТ(ID_кредита),
ID_клиента int NULL foreign key references КЛИЕНТ(ID_клиента),
CONSTRAINT PR_ДОГОВОР PRIMARY KEY(ID_договора)
);
