use MD_MyBase;

ALTER Table КРЕДИТ ADD ФИО_сотрудника nvarchar(100);
Go
ALTER Table КРЕДИТ ADD CONSTRAINT c_ФИО_сотрудника CHECK(ФИО_сотрудника = 'Гулецкий Прохор Олегович');
Go
