-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema diodbe-commerce_inicial
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema diodbe-commerce_inicial
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `diodbe-commerce_inicial` DEFAULT CHARACTER SET utf8 ;
USE `diodbe-commerce_inicial` ;

-- -----------------------------------------------------
-- Table `diodbe-commerce_inicial`.`Terceiro_vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `diodbe-commerce_inicial`.`Terceiro_vendedor` (
  `idTerceiro_vendedor` INT NOT NULL,
  `Razao_social` VARCHAR(45) NULL,
  `Local` VARCHAR(45) NULL,
  PRIMARY KEY (`idTerceiro_vendedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diodbe-commerce_inicial`.`Produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `diodbe-commerce_inicial`.`Produto` (
  `idProduto` INT NOT NULL,
  `Categoria` VARCHAR(45) NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diodbe-commerce_inicial`.`Produtos_por_vendedor_terceiro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `diodbe-commerce_inicial`.`Produtos_por_vendedor_terceiro` (
  `Terceiro_vendedor_idTerceiro_vendedor` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `Quantidade` INT NULL,
  PRIMARY KEY (`Terceiro_vendedor_idTerceiro_vendedor`, `Produto_idProduto`),
  INDEX `fk_Terceiro_vendedor_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Terceiro_vendedor_has_Produto_Terceiro_vendedor_idx` (`Terceiro_vendedor_idTerceiro_vendedor` ASC) VISIBLE,
  CONSTRAINT `fk_Terceiro_vendedor_has_Produto_Terceiro_vendedor`
    FOREIGN KEY (`Terceiro_vendedor_idTerceiro_vendedor`)
    REFERENCES `diodbe-commerce_inicial`.`Terceiro_vendedor` (`idTerceiro_vendedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Terceiro_vendedor_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `diodbe-commerce_inicial`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diodbe-commerce_inicial`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `diodbe-commerce_inicial`.`Fornecedor` (
  `idFornecedor` INT NOT NULL,
  `Razao_social` VARCHAR(45) NULL,
  `CNPJ` VARCHAR(45) NULL,
  PRIMARY KEY (`idFornecedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diodbe-commerce_inicial`.`Disponibilzar_produto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `diodbe-commerce_inicial`.`Disponibilzar_produto` (
  `Produto_idProduto` INT NOT NULL,
  `Fornecedor_idFornecedor` INT NOT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Fornecedor_idFornecedor`),
  INDEX `fk_Produto_has_Fornecedor_Fornecedor1_idx` (`Fornecedor_idFornecedor` ASC) VISIBLE,
  INDEX `fk_Produto_has_Fornecedor_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Fornecedor_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `diodbe-commerce_inicial`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Fornecedor_Fornecedor1`
    FOREIGN KEY (`Fornecedor_idFornecedor`)
    REFERENCES `diodbe-commerce_inicial`.`Fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diodbe-commerce_inicial`.`Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `diodbe-commerce_inicial`.`Estoque` (
  `idEstoque` INT NOT NULL,
  `Local` VARCHAR(45) NULL,
  PRIMARY KEY (`idEstoque`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diodbe-commerce_inicial`.`Produto_has_Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `diodbe-commerce_inicial`.`Produto_has_Estoque` (
  `Produto_idProduto` INT NOT NULL,
  `Estoque_idEstoque` INT NOT NULL,
  `Estoque` INT NULL,
  PRIMARY KEY (`Produto_idProduto`, `Estoque_idEstoque`),
  INDEX `fk_Produto_has_Estoque_Estoque1_idx` (`Estoque_idEstoque` ASC) VISIBLE,
  INDEX `fk_Produto_has_Estoque_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Estoque_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `diodbe-commerce_inicial`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Estoque_Estoque1`
    FOREIGN KEY (`Estoque_idEstoque`)
    REFERENCES `diodbe-commerce_inicial`.`Estoque` (`idEstoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diodbe-commerce_inicial`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `diodbe-commerce_inicial`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Nome` VARCHAR(45) NOT NULL,
  `Identificacao` VARCHAR(45) NOT NULL,
  `Endereco` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`),
  UNIQUE INDEX `Identificacao_UNIQUE` (`Identificacao` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diodbe-commerce_inicial`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `diodbe-commerce_inicial`.`Pedido` (
  `idPedido` INT NOT NULL,
  `Status_pedido` ENUM('A', 'B') NULL,
  `Descricao` VARCHAR(45) NULL,
  `Frete` FLOAT NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idPedido`, `Cliente_idCliente`),
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `diodbe-commerce_inicial`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `diodbe-commerce_inicial`.`Relacao_produto_pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `diodbe-commerce_inicial`.`Relacao_produto_pedido` (
  `Pedido_idPedido` INT NOT NULL,
  `Produto_idProduto` INT NOT NULL,
  `Quantidade` INT NULL,
  PRIMARY KEY (`Pedido_idPedido`, `Produto_idProduto`),
  INDEX `fk_Pedido_has_Produto_Produto1_idx` (`Produto_idProduto` ASC) VISIBLE,
  INDEX `fk_Pedido_has_Produto_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_has_Produto_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `diodbe-commerce_inicial`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_has_Produto_Produto1`
    FOREIGN KEY (`Produto_idProduto`)
    REFERENCES `diodbe-commerce_inicial`.`Produto` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
