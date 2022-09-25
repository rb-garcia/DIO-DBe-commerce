-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema DIODBe-commerce
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema DIODBe-commerce
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `DIODBe-commerce` DEFAULT CHARACTER SET utf8 ;
USE `DIODBe-commerce` ;

-- -----------------------------------------------------
-- Table `DIODBe-commerce`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DIODBe-commerce`.`Produto` (
  `idProduto` INT NOT NULL,
  `Categoria` VARCHAR(45) NULL,
  `Descricao` VARCHAR(45) NULL,
  `Valor` FLOAT NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DIODBe-commerce`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DIODBe-commerce`.`Cliente` (
  `idCliente` INT NOT NULL,
  `Tipo_cliente` CHAR(1) NULL COMMENT 'Tipo do cliente (F - Pessoa fisica/J - Pessoa juridica)',
  `Nome` VARCHAR(45) NULL,
  `Identificacao_CPF_CNPJ` VARCHAR(45) NULL,
  `Endereco` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DIODBe-commerce`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DIODBe-commerce`.`Fornecedor` (
  `idFornecedor` INT NOT NULL,
  `Razao_social` VARCHAR(45) NULL,
  `CNPJ` VARCHAR(45) NULL,
  PRIMARY KEY (`idFornecedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DIODBe-commerce`.`Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DIODBe-commerce`.`Estoque` (
  `idEstoque` INT NOT NULL,
  `Local` VARCHAR(45) NULL,
  PRIMARY KEY (`idEstoque`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DIODBe-commerce`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DIODBe-commerce`.`Pedido` (
  `idPedido` INT NOT NULL,
  `Status_pedido` VARCHAR(45) NULL,
  `Descricao` VARCHAR(45) NULL,
  `Cliente_idCliente` INT NOT NULL,
  `Frete` FLOAT NULL,
  PRIMARY KEY (`idPedido`, `Cliente_idCliente`),
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `DIODBe-commerce`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DIODBe-commerce`.`Disponibilizando_produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DIODBe-commerce`.`Disponibilizando_produto` (
  `Fornecedor_idFornecedor` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  PRIMARY KEY (`Fornecedor_idFornecedor`, `Produto_idProduto`),
  INDEX `fk_Fornecedor_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Fornecedor_has_Produto_Fornecedor_idx` (`Fornecedor_idFornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_Fornecedor_has_Produto_Fornecedor`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `DIODBe-commerce`.`Fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fornecedor_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `DIODBe-commerce`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DIODBe-commerce`.`Produto_has_Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DIODBe-commerce`.`Produto_has_Estoque` (
  `Produto_idProduto` INT NOT NULL,
  `Estoque_idEstoque` INT NOT NULL,
  `Quantidade` INT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Estoque_idEstoque`),
  INDEX `fk_Produto_has_Estoque_Estoque1_idx` (`Estoque_idEstoque` ASC) VISIBLE,
  INDEX `fk_Produto_has_Estoque_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Estoque_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `DIODBe-commerce`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Estoque_Estoque1`
    FOREIGN KEY (`Estoque_idEstoque`)
    REFERENCES `DIODBe-commerce`.`Estoque` (`idEstoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DIODBe-commerce`.`Relacao_produto_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DIODBe-commerce`.`Relacao_produto_pedido` (
  `Produto_idProduto` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Quantidade` INT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Pedido_idPedido`),
  INDEX `fk_Produto_has_Pedido_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  INDEX `fk_Produto_has_Pedido_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Pedido_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `DIODBe-commerce`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Pedido_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `DIODBe-commerce`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DIODBe-commerce`.`Terceiro_Vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DIODBe-commerce`.`Terceiro_Vendedor` (
  `idTerceiro_Vendedor` INT NOT NULL,
  `Razao_Social` VARCHAR(45) NULL,
  `Local` VARCHAR(45) NULL,
  PRIMARY KEY (`idTerceiro_Vendedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DIODBe-commerce`.`Produtos_vendedor_terceiro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DIODBe-commerce`.`Produtos_vendedor_terceiro` (
  `Terceiro_Vendedor_idTerceiro_Vendedor` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `Quantidade` INT NULL,
  PRIMARY KEY (`Terceiro_Vendedor_idTerceiro_Vendedor`, `Produto_idProduto`),
  INDEX `fk_Terceiro_Vendedor_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Terceiro_Vendedor_has_Produto_Terceiro_Vendedor1_idx` (`Terceiro_Vendedor_idTerceiro_Vendedor` ASC) VISIBLE,
  CONSTRAINT `fk_Terceiro_Vendedor_has_Produto_Terceiro_Vendedor1`
    FOREIGN KEY (`Terceiro_Vendedor_idTerceiro_Vendedor`)
    REFERENCES `DIODBe-commerce`.`Terceiro_Vendedor` (`idTerceiro_Vendedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Terceiro_Vendedor_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `DIODBe-commerce`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DIODBe-commerce`.`Forma_pagamento_cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DIODBe-commerce`.`Forma_pagamento_cliente` (
  `idForma_pagamento_cliente` INT NOT NULL,
  `Bandeira_cartao` VARCHAR(45) NULL,
  `Numero_cartao` VARCHAR(45) NULL,
  `Vencimento_cartao` DATE NULL,
  `Nome_impresso_cartao` VARCHAR(45) NULL,
  `Codigo_seguranca_cartao` CHAR(3) NULL,
  `Dia_vencimento_cartao` SMALLINT NULL,
  `Observacao` VARCHAR(128) NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idForma_pagamento_cliente`, `Cliente_idCliente`),
  INDEX `fk_Forma_pagamento_cliente_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Forma_pagamento_cliente_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `DIODBe-commerce`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DIODBe-commerce`.`Entrega`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DIODBe-commerce`.`Entrega` (
  `idEntrega` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  `Status_entrega` VARCHAR(45) NULL,
  `Data` DATE NULL,
  `Codigo_rastreio` VARCHAR(45) NULL,
  PRIMARY KEY (`idEntrega`, `Pedido_idPedido`),
  INDEX `fk_Entrega_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Entrega_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `DIODBe-commerce`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
