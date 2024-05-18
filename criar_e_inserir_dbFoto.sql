USE dbFoto;

CREATE TABLE Endereco
(
	id_endereco INT IDENTITY (1, 1) NOT NULL,
	cep VARCHAR(8) NOT NULL,
	estado VARCHAR(2) NOT NULL,
	cidade VARCHAR(15),
	rua VARCHAR(20) NOT NULL,
	CONSTRAINT pkEndereco PRIMARY KEY (id_endereco)
)

INSERT INTO Endereco (cep, estado, cidade, rua)
VALUES
	('11111222', 'SP', 'Jau', 'Alberto augusto teixeira'),
	('22222111', 'SP', 'Matao', 'Pedro bigal'),
	('00000000', 'RP', 'Ceu', 'Rua dos injusticados')

CREATE TABLE Cliente
(
	id_cliente INT IDENTITY (1, 1) NOT NULL,
	nome VARCHAR(30) NOT NULL,
	tel_residencial VARCHAR(10),
	tel_comercial VARCHAR(11),
	tel_celular VARCHAR(11) NOT NULL,
	numero INT NOT NULL,
	complemento VARCHAR(20),
	CONSTRAINT pkCliente PRIMARY KEY (id_cliente),
);

INSERT INTO Cliente (nome, tel_residencial, tel_comercial, tel_celular, numero, complemento)
VALUES
	('Joao Mazzini', null, null, '16111112222', 11, null),
	('Gustavo Vono', '1411112222', null, '14222221111', 22, 'andar 2 sala 222'),
	('Tio Paulo', null, null, '00000000000', 00, null);