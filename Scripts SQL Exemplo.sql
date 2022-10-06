INSERT INTO `diodbe-commerce`.`cliente` (`idCliente`,`Tipo_cliente`,`Nome`,`Identificacao_CPF_CNPJ`,`Endereco`)
VALUES (1, 'F', 'João de Almeida', '000.000.000-00', 'Rua Amazonas, 105');
INSERT INTO `diodbe-commerce`.`cliente` (`idCliente`,`Tipo_cliente`,`Nome`,`Identificacao_CPF_CNPJ`,`Endereco`)
VALUES (2, 'J', 'Empresa Modelo', '000.000.000/0001-00', 'Rua Manaus, 115');
SELECT * FROM `diodbe-commerce`.cliente WHERE Tipo_cliente = 'J';
SELECT * FROM `diodbe-commerce`.cliente WHERE Tipo_cliente = 'F';
SELECT * FROM `diodbe-commerce`.cliente WHERE Tipo_cliente IN ('J', 'F');

INSERT INTO `diodbe-commerce`.`fornecedor` (`idFornecedor`,`Razao_social`,`CNPJ`)
VALUES (1,'Fornecedor Modelo 01', '000.000.000/0001-00');
INSERT INTO `diodbe-commerce`.`fornecedor` (`idFornecedor`,`Razao_social`,`CNPJ`)
VALUES (2,'Fornecedor Modelo 02', '000.000.000/0001-01');
SELECT * FROM `diodbe-commerce`.fornecedor;

INSERT INTO `diodbe-commerce`.`produto` (`idProduto`,`Categoria`,`Descricao`,`Valor`)
VALUES (1,'Categoria 01','Produto 01', 100.00);
INSERT INTO `diodbe-commerce`.`produto` (`idProduto`,`Categoria`,`Descricao`,`Valor`)
VALUES (2,'Categoria 01','Produto 02', 130.00);
INSERT INTO `diodbe-commerce`.`produto` (`idProduto`,`Categoria`,`Descricao`,`Valor`)
VALUES (3,'Categoria 02','Produto 03', 110.00);
INSERT INTO `diodbe-commerce`.`produto` (`idProduto`,`Categoria`,`Descricao`,`Valor`)
VALUES (4,'Categoria 02','Produto 04', 170.00);
SELECT * FROM `diodbe-commerce`.produto;
SELECT * FROM `diodbe-commerce`.produto WHERE Categoria = 'Categoria 01';
SELECT * FROM `diodbe-commerce`.produto WHERE Categoria = 'Categoria 02';
SELECT * FROM `diodbe-commerce`.produto WHERE Categoria IN ('Categoria 01', 'Categoria 02');
SELECT * FROM `diodbe-commerce`.produto WHERE Categoria LIKE 'Categoria%';
SELECT * FROM `diodbe-commerce`.produto WHERE idProduto = 1;
SELECT Categoria, SUM(Valor) AS Total  FROM `diodbe-commerce`.produto GROUP BY Categoria ORDER BY Categoria;
SELECT Categoria, SUM(Valor) AS Total  FROM `diodbe-commerce`.produto GROUP BY Categoria HAVING SUM(Valor) > 230 ORDER BY Categoria;

/* Relação cliente -> pedidos */
SELECT c.idCliente, c.Nome, c.Identificacao_CPF_CNPJ AS Identificacao, p.idPedido, p.Status_pedido, p.Descricao, p.Frete
FROM `diodbe-commerce`.cliente AS c
INNER JOIN `diodbe-commerce`.Pedido p ON p.Cliente_idCliente = c.idCliente;

/* Relação pedido -> itens pedido (produtos) -> cliente */
SELECT p.idPedido, r.Produto_idProduto, d.Categoria 
FROM `diodbe-commerce`.Pedido p
INNER JOIN `diodbe-commerce`.Relacao_produto_pedido r ON r.Pedido_idPedido = p.idPedido
INNER JOIN `diodbe-commerce`.Produto d ON d.idProduto = r.Produto_idProduto;