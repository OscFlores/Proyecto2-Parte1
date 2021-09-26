-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema RevistaDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema RevistaDB
-- -----------------------------------------------------
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin123';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost';
CREATE SCHEMA IF NOT EXISTS `RevistaDB` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `RevistaDB` ;

-- -----------------------------------------------------
-- Table `RevistaDB`.`Anuncio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RevistaDB`.`Anuncio` (
  `Id_anuncio` INT NOT NULL,
  `Contenido` BLOB NOT NULL,
  `Activado` TINYINT NOT NULL,
  PRIMARY KEY (`Id_anuncio`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `RevistaDB`.`Pagina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RevistaDB`.`Pagina` (
  `Id_Pagina` INT NOT NULL,
  `nombre` VARCHAR(30) NOT NULL,
  `URL` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Id_Pagina`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `RevistaDB`.`Aparicion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RevistaDB`.`Aparicion` (
  `Id_Aparicion` INT NOT NULL,
  `Id_Anuncio` INT NOT NULL,
  `Id_Pagina` INT NOT NULL,
  PRIMARY KEY (`Id_Aparicion`),
  INDEX `FK_to_anuncio_idx` (`Id_Anuncio` ASC) VISIBLE,
  INDEX `FK_to_pagina_idx` (`Id_Pagina` ASC) VISIBLE,
  CONSTRAINT `FK_to_anuncio_of_aparicion`
    FOREIGN KEY (`Id_Anuncio`)
    REFERENCES `RevistaDB`.`Anuncio` (`Id_anuncio`),
  CONSTRAINT `FK_to_pagina`
    FOREIGN KEY (`Id_Pagina`)
    REFERENCES `RevistaDB`.`Pagina` (`Id_Pagina`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `RevistaDB`.`Costo_por_Dia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RevistaDB`.`Costo_por_Dia` (
  `Costo_por_Dia` DECIMAL(10,0) NOT NULL,
  `Id_Costo_por_Dia` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Id_Costo_por_Dia`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `RevistaDB`.`Revista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RevistaDB`.`Revista` (
  `Id_Revista` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Id_Costo_por_Dia` INT NOT NULL,
  `Precio_Mensual` DECIMAL(10,0) NOT NULL,
  `Precio_Anual` DECIMAL(10,0) NOT NULL,
  `esGratuita` TINYINT NOT NULL,
  `Es_Interactiva` TINYINT NOT NULL,
  `Permitir_Suscripciones` TINYINT NOT NULL,
  `Descripcion` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Id_Revista`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `RevistaDB`.`Cambio_Costo_por_Dia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RevistaDB`.`Cambio_Costo_por_Dia` (
  `Id_Costo_por_dia` INT NOT NULL,
  `Fecha_Cambio` DATE NOT NULL,
  `Id_Revista` INT NOT NULL,
  `Id_Cambio_Costo_por_Dia` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Id_Cambio_Costo_por_Dia`),
  INDEX `FK_to_cost_por_dia_idx` (`Id_Costo_por_dia` ASC) VISIBLE,
  INDEX `FK_to_revista_idx` (`Id_Revista` ASC) VISIBLE,
  CONSTRAINT `FK_to_cost_por_dia`
    FOREIGN KEY (`Id_Costo_por_dia`)
    REFERENCES `RevistaDB`.`Costo_por_Dia` (`Id_Costo_por_Dia`),
  CONSTRAINT `FK_to_revista_of_cambio_costo_por_dia`
    FOREIGN KEY (`Id_Revista`)
    REFERENCES `RevistaDB`.`Revista` (`Id_Revista`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `RevistaDB`.`Categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RevistaDB`.`Categoria` (
  `Id_Categoria` INT NOT NULL,
  `Nombre` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Id_Categoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `RevistaDB`.`Categoria_Anuncio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RevistaDB`.`Categoria_Anuncio` (
  `Id_Categoria_Anuncio` INT NOT NULL,
  `Id_Anuncio` INT NOT NULL,
  `Id_Categoria` INT NOT NULL,
  PRIMARY KEY (`Id_Categoria_Anuncio`),
  INDEX `FK_to_anuncio_idx` (`Id_Anuncio` ASC) VISIBLE,
  INDEX `FK_to_categoria_of_categoria_anuncio` (`Id_Categoria` ASC) VISIBLE,
  CONSTRAINT `FK_to_anuncio_of_categoria_anuncio`
    FOREIGN KEY (`Id_Anuncio`)
    REFERENCES `RevistaDB`.`Anuncio` (`Id_anuncio`),
  CONSTRAINT `FK_to_categoria_of_categoria_anuncio`
    FOREIGN KEY (`Id_Categoria`)
    REFERENCES `RevistaDB`.`Categoria` (`Id_Categoria`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `RevistaDB`.`Categoria_Revista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RevistaDB`.`Categoria_Revista` (
  `Id_Categoria_Revista` INT NOT NULL AUTO_INCREMENT,
  `Id_Categoria` INT NOT NULL,
  `Id_Revista` INT NOT NULL,
  PRIMARY KEY (`Id_Categoria_Revista`),
  INDEX `FK_to_revista_idx` (`Id_Revista` ASC) VISIBLE,
  INDEX `FK_to_categoria_idx` (`Id_Categoria` ASC) VISIBLE,
  CONSTRAINT `FK_to_categoria_of_categoria_revista`
    FOREIGN KEY (`Id_Categoria`)
    REFERENCES `RevistaDB`.`Categoria` (`Id_Categoria`),
  CONSTRAINT `FK_to_revista_of_categoria_revista`
    FOREIGN KEY (`Id_Revista`)
    REFERENCES `RevistaDB`.`Revista` (`Id_Revista`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `RevistaDB`.`Tipo_Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RevistaDB`.`Tipo_Usuario` (
  `Id_Tipo_Usuario` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Id_Tipo_Usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `RevistaDB`.`Usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RevistaDB`.`Usuario` (
  `Id_Usuario` INT NOT NULL AUTO_INCREMENT,
  `Password` VARCHAR(45) NOT NULL,
  `Id_Tipo_usuario` INT NOT NULL,
  `Nombre` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`Id_Usuario`),
  INDEX `FK_to_tipo_usuario_idx` (`Id_Tipo_usuario` ASC) VISIBLE,
  CONSTRAINT `FK_to_tipo_usuario`
    FOREIGN KEY (`Id_Tipo_usuario`)
    REFERENCES `RevistaDB`.`Tipo_Usuario` (`Id_Tipo_Usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `RevistaDB`.`Publicacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RevistaDB`.`Publicacion` (
  `Fecha_Publicacion` DATE NOT NULL,
  `Id_Revista` INT NOT NULL,
  `Id_Publicacion` INT NOT NULL AUTO_INCREMENT,
  `Id_Usuario` INT NOT NULL,
  PRIMARY KEY (`Id_Publicacion`),
  INDEX `FK_to_revista_idx` (`Id_Revista` ASC) VISIBLE,
  INDEX `FK_to_usuario` (`Id_Usuario` ASC) VISIBLE,
  CONSTRAINT `FK_to_revista`
    FOREIGN KEY (`Id_Revista`)
    REFERENCES `RevistaDB`.`Revista` (`Id_Revista`),
  CONSTRAINT `FK_to_usuario`
    FOREIGN KEY (`Id_Usuario`)
    REFERENCES `RevistaDB`.`Usuario` (`Id_Usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `RevistaDB`.`Comentario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RevistaDB`.`Comentario` (
  `Id_Comentario` INT NOT NULL AUTO_INCREMENT,
  `Fecha_Comentario` DATE NOT NULL,
  `Id_Usuario` INT NOT NULL,
  `Id_Publicacion` INT NOT NULL,
  PRIMARY KEY (`Id_Comentario`),
  INDEX `FK_to_usuario_idx` (`Id_Usuario` ASC) VISIBLE,
  INDEX `FK_to_publicacion_idx` (`Id_Publicacion` ASC) VISIBLE,
  CONSTRAINT `FK_to_publicacion_of_comentario`
    FOREIGN KEY (`Id_Publicacion`)
    REFERENCES `RevistaDB`.`Publicacion` (`Id_Publicacion`),
  CONSTRAINT `FK_to_usuario_of_comentario`
    FOREIGN KEY (`Id_Usuario`)
    REFERENCES `RevistaDB`.`Usuario` (`Id_Usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `RevistaDB`.`Detalle_Cobro_por_Dia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RevistaDB`.`Detalle_Cobro_por_Dia` (
  `Id_Publicacion` INT NOT NULL,
  `Id_Detalle_Cobro_por_Dia` INT NOT NULL AUTO_INCREMENT,
  `Cobro_por_Dia` DECIMAL(10,0) NOT NULL,
  PRIMARY KEY (`Id_Detalle_Cobro_por_Dia`),
  INDEX `FK_to_publicacion_idx` (`Id_Publicacion` ASC) VISIBLE,
  CONSTRAINT `FK_to_publicacion`
    FOREIGN KEY (`Id_Publicacion`)
    REFERENCES `RevistaDB`.`Publicacion` (`Id_Publicacion`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `RevistaDB`.`Empresa_Anunciante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RevistaDB`.`Empresa_Anunciante` (
  `Id_Anunciante` INT NOT NULL,
  `Nombre` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Id_Anunciante`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `RevistaDB`.`Etiqueta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RevistaDB`.`Etiqueta` (
  `Id_Etiqueta` INT NOT NULL,
  `Nombre` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Id_Etiqueta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `RevistaDB`.`Etiqueta_Anuncio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RevistaDB`.`Etiqueta_Anuncio` (
  `Id_Etiqueta_Anuncio` INT NOT NULL,
  `Id_Anuncio` INT NOT NULL,
  `Id_Etiqueta` INT NOT NULL,
  PRIMARY KEY (`Id_Etiqueta_Anuncio`),
  INDEX `FK_to_anuncio_idx` (`Id_Anuncio` ASC) VISIBLE,
  INDEX `FK_to_etiqueta_idx` (`Id_Etiqueta` ASC) VISIBLE,
  CONSTRAINT `FK_to_anuncio`
    FOREIGN KEY (`Id_Anuncio`)
    REFERENCES `RevistaDB`.`Anuncio` (`Id_anuncio`),
  CONSTRAINT `FK_to_etiqueta`
    FOREIGN KEY (`Id_Etiqueta`)
    REFERENCES `RevistaDB`.`Etiqueta` (`Id_Etiqueta`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `RevistaDB`.`Etiqueta_Revista`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RevistaDB`.`Etiqueta_Revista` (
  `Id_Etiqueta_Revista` INT NOT NULL,
  `Id_Etiqueta` INT NOT NULL,
  `Id_Revista` INT NOT NULL,
  PRIMARY KEY (`Id_Etiqueta_Revista`),
  INDEX `FK_to_etiqueta_idx` (`Id_Etiqueta` ASC) VISIBLE,
  INDEX `FK_to_revista_idx` (`Id_Revista` ASC) VISIBLE,
  CONSTRAINT `FK_to_etiqueta_of_etiqueta_revista`
    FOREIGN KEY (`Id_Etiqueta`)
    REFERENCES `RevistaDB`.`Etiqueta` (`Id_Etiqueta`),
  CONSTRAINT `FK_to_revista_of_etiqueta_revista`
    FOREIGN KEY (`Id_Revista`)
    REFERENCES `RevistaDB`.`Revista` (`Id_Revista`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `RevistaDB`.`Informacion_Extra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RevistaDB`.`Informacion_Extra` (
  `Foto` BLOB NOT NULL,
  `Id_Usuario` INT NOT NULL,
  `Hobbies` VARCHAR(255) NOT NULL,
  `Gustos` VARCHAR(255) NOT NULL,
  `Descripcion` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`Id_Usuario`),
  CONSTRAINT `FK_to_usuario_of_informacion_extra`
    FOREIGN KEY (`Id_Usuario`)
    REFERENCES `RevistaDB`.`Usuario` (`Id_Usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `RevistaDB`.`Me_Gusta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RevistaDB`.`Me_Gusta` (
  `Id_like` INT NOT NULL AUTO_INCREMENT,
  `Id_publicacion` INT NOT NULL,
  `Fecha_like` DATE NOT NULL,
  `Id_usuario` INT NOT NULL,
  PRIMARY KEY (`Id_like`),
  INDEX `FK_to_usuario_idx` (`Id_usuario` ASC) VISIBLE,
  INDEX `FK_to_publicacion_idx` (`Id_publicacion` ASC) VISIBLE,
  CONSTRAINT `FK_to_publicacion_of_like`
    FOREIGN KEY (`Id_publicacion`)
    REFERENCES `RevistaDB`.`Publicacion` (`Id_Publicacion`),
  CONSTRAINT `FK_to_usuario_of_like`
    FOREIGN KEY (`Id_usuario`)
    REFERENCES `RevistaDB`.`Usuario` (`Id_Usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `RevistaDB`.`Pago_Anuncio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RevistaDB`.`Pago_Anuncio` (
  `Id_Pago` INT NOT NULL,
  `Id_Anunciante` INT NOT NULL,
  `Fecha_Compra` DATE NOT NULL,
  `Id_Anuncio` INT NOT NULL,
  `Costo` DECIMAL(10,0) NOT NULL,
  `Fecha_Activacion` DATE NOT NULL,
  `Cantidad_Dias` INT NOT NULL,
  PRIMARY KEY (`Id_Pago`),
  INDEX `FK_to_anunciante_idx` (`Id_Anunciante` ASC) VISIBLE,
  INDEX `FK_to_anuncio_idx` (`Id_Anuncio` ASC) VISIBLE,
  CONSTRAINT `FK_to_anunciante`
    FOREIGN KEY (`Id_Anunciante`)
    REFERENCES `RevistaDB`.`Empresa_Anunciante` (`Id_Anunciante`),
  CONSTRAINT `FK_to_anuncio_of_pago_anuncio`
    FOREIGN KEY (`Id_Anuncio`)
    REFERENCES `RevistaDB`.`Anuncio` (`Id_anuncio`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `RevistaDB`.`Tipo_Pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RevistaDB`.`Tipo_Pago` (
  `id_tipo_pago` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_tipo_pago`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `RevistaDB`.`Suscripcion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RevistaDB`.`Suscripcion` (
  `Id_Tipo_Pago` INT NOT NULL,
  `Id_Revista` INT NOT NULL,
  `Fecha_Suscripcion` DATE NOT NULL,
  `Id_Usuario` INT NOT NULL,
  `Costo` DECIMAL(10,0) NOT NULL,
  `Ganancia` DECIMAL(10,0) NOT NULL,
  `Costo_por_Servicio` DECIMAL(10,0) NOT NULL,
  PRIMARY KEY (`Id_Revista`, `Id_Usuario`),
  INDEX `FK_to_tipo_pago_idx` (`Id_Tipo_Pago` ASC) VISIBLE,
  INDEX `FK_to_revista_idx` (`Id_Revista` ASC) VISIBLE,
  INDEX `FK_to_usuario_idx` (`Id_Usuario` ASC) VISIBLE,
  CONSTRAINT `FK_to_revista_of_suscripcion`
    FOREIGN KEY (`Id_Revista`)
    REFERENCES `RevistaDB`.`Revista` (`Id_Revista`),
  CONSTRAINT `FK_to_tipo_pago`
    FOREIGN KEY (`Id_Tipo_Pago`)
    REFERENCES `RevistaDB`.`Tipo_Pago` (`id_tipo_pago`),
  CONSTRAINT `FK_to_usuario_of_suscripcion`
    FOREIGN KEY (`Id_Usuario`)
    REFERENCES `RevistaDB`.`Usuario` (`Id_Usuario`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
