-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema GlobalSuperStore
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema GlobalSuperStore
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `GlobalSuperStore` DEFAULT CHARACTER SET utf8 ;
USE `GlobalSuperStore` ;

-- -----------------------------------------------------
-- Table `GlobalSuperStore`.`dim_products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GlobalSuperStore`.`dim_products` (
  `productKey` INT NOT NULL,
  `productName` VARCHAR(255) NOT NULL,
  `category` VARCHAR(255) NOT NULL,
  `sub_category` VARCHAR(255) NOT NULL,
  `product_description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`productKey`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GlobalSuperStore`.`dim_location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GlobalSuperStore`.`dim_location` (
  `locationKey` INT NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `continent` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`locationKey`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GlobalSuperStore`.`dim_time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GlobalSuperStore`.`dim_time` (
  `timeKey` INT NOT NULL,
  `fullDate` DATE NOT NULL,
  `year` INT NOT NULL,
  `quarter` VARCHAR(45) NOT NULL,
  `month` INT NOT NULL,
  `event` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`timeKey`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GlobalSuperStore`.`fact_sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GlobalSuperStore`.`fact_sales` (
  `salesKey` INT NOT NULL,
  `price` DECIMAL NOT NULL,
  `cost` DECIMAL NOT NULL,
  `shippingCost` DECIMAL NOT NULL,
  `locationKey` INT NOT NULL,
  `productKey` INT NOT NULL,
  `timeKey` INT NOT NULL,
  PRIMARY KEY (`salesKey`),
  INDEX `productKey_fk_idx` (`productKey` ASC) VISIBLE,
  INDEX `locationKey_fk_idx` (`locationKey` ASC) VISIBLE,
  INDEX `timeKey_fk_idx` (`timeKey` ASC) VISIBLE,
  CONSTRAINT `productKey_fk`
    FOREIGN KEY (`productKey`)
    REFERENCES `GlobalSuperStore`.`dim_products` (`productKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `locationKey_fk`
    FOREIGN KEY (`locationKey`)
    REFERENCES `GlobalSuperStore`.`dim_location` (`locationKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `timeKey_fk`
    FOREIGN KEY (`timeKey`)
    REFERENCES `GlobalSuperStore`.`dim_time` (`timeKey`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
