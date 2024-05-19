IF NOT EXISTS(
	SELECT name FROM sys.databases
	WHERE name = 'dbFoto'
)
CREATE DATABASE dbFoto;

USE dbFoto;

-- Tabela Cliente
CREATE TABLE Cliente (
    idCliente INT IDENTITY (1,1),
    nomeCliente VARCHAR(100) NOT NULL,
    telefoneResidencial VARCHAR(10),
    telefoneComercial VARCHAR(11),
    telefoneCelular VARCHAR(11),
    numeroEndereco INT NOT NULL,
    complemento VARCHAR(20),

	CONSTRAINT PkCliente PRIMARY KEY (idCliente)
);

-- Inserindo dados na tabela Cliente
INSERT INTO Cliente (nomeCliente, telefoneResidencial, telefoneComercial, telefoneCelular, numeroEndereco, complemento) 
VALUES
	('Maria Silva', '1234567890', '1122334455', '11987654321', 1, 'Apto 101'),
	('João Santos', '0987654321', '9988776655', '11912345678', 2, 'Sala 702'),
	('Ana Pereira', NULL, NULL, '11923456789', 3, 'Casa');


-- Tabela Funcionarios
CREATE TABLE Funcionario (
    idFuncionario INT IDENTITY (1,1),
    nomeFuncionario VARCHAR(100) NOT NULL,
    telefoneResidencial VARCHAR(10),
	telefoneComercial VARCHAR (11),
	telefoneCelular VARCHAR (11),
	numeroEndereco INT NOT NULL,
	complemento VARCHAR (20),

	CONSTRAINT PkFuncionario PRIMARY KEY (idFuncionario)
);

-- Inserindo dados na tabela Funcionario
INSERT INTO Funcionario (nomeFuncionario, telefoneResidencial, telefoneComercial, telefoneCelular, numeroEndereco, complemento) 
VALUES
	('Carlos Souza', '1234509876', '9988665544', '11999887766', 4, 'Apto 303'),
	('Fernanda Lima', '1122334455', '9977554433', '11988776655', 5, 'Casa 2');


-- Tabela Enderecos
CREATE TABLE Endereco (
    idEndereco INT IDENTITY (1,1),
    logradouro VARCHAR(80) NOT NULL,
    numero VARCHAR(5) NOT NULL,
    complemento VARCHAR(50),
    bairro VARCHAR(30) NOT NULL,
    cidade VARCHAR(30) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    cep VARCHAR(8) NOT NULL,

	CONSTRAINT PkEndereco PRIMARY KEY (idEndereco)
);

-- Inserindo dados na tabela Endereco
INSERT INTO Endereco (logradouro, numero, complemento, bairro, cidade, estado, cep) 
VALUES
	('Rua das Flores', '123', 'Apto 101', 'Centro', 'São Paulo', 'SP', '01001000'),
	('Avenida Paulista', '2000', 'Sala 702', 'Bela Vista', 'São Paulo', 'SP', '01310100'),
	('Rua Amazonas', '50', 'Casa', 'Jardim das Palmeiras', 'Belo Horizonte', 'MG', '30140120'),
	('Rua Bahia', '150', 'Apto 303', 'Savassi', 'Belo Horizonte', 'MG', '30140150'),
	('Rua Ceará', '300', 'Casa 2', 'Funcionários', 'Belo Horizonte', 'MG', '30140200');


-- Tabela ClienteEndereco (Relacionamento Muitos-para-Muitos)
CREATE TABLE ClienteEndereco (
    idCliente INT,
    idEndereco INT,
    tipoEndereco VARCHAR(20),

    CONSTRAINT PkClienteEndereco PRIMARY KEY (idCliente, idEndereco),
    CONSTRAINT FkCliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
    CONSTRAINT FkEndereco FOREIGN KEY (idEndereco) REFERENCES Endereco(idEndereco)
);

-- Inserindo dados na tabela ClienteEndereco
INSERT INTO ClienteEndereco (idCliente, idEndereco, tipoEndereco) 
VALUES
	(1, 1, 'Residencial'),
	(2, 2, 'Comercial'),
	(3, 3, 'Residencial');


-- Tabela FuncionarioEndereco (Relacionamento Muitos-para-Muitos)
CREATE TABLE FuncionarioEndereco (
    idFuncionario INT,
    idEndereco INT,
    tipoEndereco VARCHAR(20),

    CONSTRAINT PkFuncionarioEndereco PRIMARY KEY (idFuncionario, idEndereco),
    CONSTRAINT FkFuncionario FOREIGN KEY (idFuncionario) REFERENCES Funcionario(idFuncionario),
    CONSTRAINT FkEndereco FOREIGN KEY (idEndereco) REFERENCES Endereco(idEndereco)
);

-- Inserindo dados na tabela FuncionarioEndereco
INSERT INTO FuncionarioEndereco (idFuncionario, idEndereco, tipoEndereco) 
VALUES
	(1, 4, 'Residencial'),
	(2, 5, 'Comercial');


-- Tabela PessoaFisica (Herda de Clientes)
CREATE TABLE PessoaFisica (
    idCliente INT NOT NULL,
    cpf VARCHAR(11) NOT NULL UNIQUE,
	rg VARCHAR(9) NOT NULL UNIQUE,
    dataNascimento DATE NOT NULL,
	sexo CHAR,

	CONSTRAINT PkPessoaFisica PRIMARY KEY (idCliente, cpf),
    CONSTRAINT FkCliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- Inserindo dados na tabela PessoaFisica
INSERT INTO PessoaFisica (idCliente, cpf, rg, dataNascimento, sexo) 
VALUES
	(1, '12345678901', 'MG1234567', '1980-01-01', 'F'),
	(2, '98765432100', 'SP7654321', '1975-05-15', 'M');


-- Tabela PessoaJuridica (Herda de Clientes)
CREATE TABLE PessoaJuridica (
    idCliente INT NOT NULL,
    cnpj VARCHAR(14) NOT NULL UNIQUE,
    razaoSocial VARCHAR(100) NOT NULL,
	inscEstadual VARCHAR(14) NOT NULL,
	nomeResponsavel VARCHAR (100) NOT NULL,

	CONSTRAINT PkPessoaJuridica PRIMARY KEY (idCliente, cnpj),
    CONSTRAINT FkCliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- Inserindo dados na tabela PessoaJuridica
INSERT INTO PessoaJuridica (idCliente, cnpj, razaoSocial, inscEstadual, nomeResponsavel) 
VALUES
	(3, '12345678000190', 'Empresa X Ltda', 'IS1234567890', 'Ana Pereira');


-- Tabela Produtos
CREATE TABLE Produto (
    idProduto INT IDENTITY (1,1),
    nomeProduto VARCHAR(100) NOT NULL,
    descricaoProduto VARCHAR(200),
    precoCusto DECIMAL(10, 2) NOT NULL,
	precoVenda DECIMAL (10,2) NOT NULL,
    estoqueProduto INT NOT NULL,
	quantidadeMinima INT NOT NULL,

	CONSTRAINT PkProduto PRIMARY KEY (idProduto)
);

-- Inserindo dados na tabela Produto
INSERT INTO Produto (nomeProduto, descricaoProduto, precoCusto, precoVenda, estoqueProduto, quantidadeMinima) 
VALUES
	('Câmera DSLR', 'Câmera profissional de alta qualidade', 2500.00, 3000.00, 10, 2),
	('Lente 50mm', 'Lente fixa para retratos', 500.00, 700.00, 20, 5);


-- Tabela Categorias
CREATE TABLE Categoria (
    idCategoria INT IDENTITY (1,1),
    nomeCategoria VARCHAR(100) NOT NULL,

	CONSTRAINT PkCategoria PRIMARY KEY (idCategoria)
);

-- Inserindo dados na tabela Categoria
INSERT INTO Categoria (nomeCategoria) 
VALUES
	('Câmeras'),
	('Lentes');


-- Tabela ProdutoCategorias (Relacionamento Muitos-para-Muitos)
CREATE TABLE ProdutoCategoria (
    idProduto INT,
    idCategoria INT,

    CONSTRAINT PkProdutoCategoria PRIMARY KEY (idProduto, idCategoria),
    CONSTRAINT FkProduto FOREIGN KEY (idProduto) REFERENCES Produto(idProduto),
    CONSTRAINT FkCategoria FOREIGN KEY (idCategoria) REFERENCES Categoria(idCategoria)
);

-- Inserindo dados na tabela ProdutoCategoria
INSERT INTO ProdutoCategoria (idProduto, idCategoria) 
VALUES
	(1, 1), -- Câmera DSLR na categoria Câmeras
	(2, 2); -- Lente 50mm na categoria Lentes


-- Tabela Vendas
CREATE TABLE Venda (
    idVenda INT IDENTITY (1,1),
    idCliente INT NOT NULL,
	idFuncionario INT NOT NULL,
    dataVenda DATE NOT NULL,
    totalVenda DECIMAL(10, 2) NOT NULL,
	condicaoVenda VARCHAR (10) NOT NULL,

	CONSTRAINT PkVenda PRIMARY KEY (idVenda),
    CONSTRAINT FkCliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
	CONSTRAINT FkFuncionario FOREIGN KEY (idFuncionario) REFERENCES Funcionario(idFuncionario)
);

-- Inserindo dados na tabela Venda
INSERT INTO Venda (idCliente, idFuncionario, dataVenda, totalVenda, condicaoVenda) 
VALUES
	(1, 1, '2023-05-01', 3500.00, 'À vista'),
	(2, 2, '2023-05-02', 700.00, 'Parcelado');


-- Tabela ItensVenda (Relaionamento Muitos-para-Muitos)
CREATE TABLE ItemVenda (
    idVenda INT,
    idProduto INT,
    quantidade INT NOT NULL,
    totalItem DECIMAL(10, 2) NOT NULL,

	CONSTRAINT PkItemVenda PRIMARY KEY (idVenda, idProduto),
    CONSTRAINT FkVenda FOREIGN KEY (idVenda) REFERENCES Venda(idVenda),
    CONSTRAINT FkProduto FOREIGN KEY (idProduto) REFERENCES Produto(idProduto)
);

-- Inserindo dados na tabela ItemVenda
INSERT INTO ItemVenda (idVenda, idProduto, quantidade, totalItem) 
VALUES
	(1, 1, 1, 3000.00), -- Venda de 1 Câmera DSLR
	(1, 2, 1, 500.00), -- Venda de 1 Lente 50mm
	(2, 2, 1, 700.00); -- Venda de 1 Lente 50mm





SELECT * FROM Cliente;
SELECT * FROM Funcionario;
SELECT * FROM Endereco;
SELECT * FROM ClienteEndereco;
SELECT * FROM FuncionarioEndereco;
SELECT * FROM PessoaFisica;
SELECT * FROM PessoaJuridica;
SELECT * FROM Produto;
SELECT * FROM Categoria;
SELECT * FROM ProdutoCategoria;
SELECT * FROM Venda;
SELECT * FROM ItemVenda;