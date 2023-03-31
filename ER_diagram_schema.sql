-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Data_Modeling
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Data_Modeling
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Data_Modeling` DEFAULT CHARACTER SET utf8 ;
USE `Data_Modeling` ;

-- -----------------------------------------------------
-- Table `Data_Modeling`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Data_Modeling`.`customers` (
  `customerID` INT NOT NULL,
  `fullName` VARCHAR(255) NOT NULL,
  `contactNumber` INT NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`customerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Data_Modeling`.`deliveryAddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Data_Modeling`.`deliveryAddress` (
  `shippingAddress` VARCHAR(255) NOT NULL,
  `street` VARCHAR(255) NOT NULL,
  `postCode` VARCHAR(255) NOT NULL,
  `state` VARCHAR(255) NOT NULL,
  `country` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`shippingAddress`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Data_Modeling`.`shipping`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Data_Modeling`.`shipping` (
  `shippingID` INT NOT NULL,
  `shippingDate` DATE NOT NULL,
  `shippingMode` VARCHAR(255) NOT NULL,
  `shippingAddress` VARCHAR(255) NOT NULL,
  `shippingCost` DECIMAL NOT NULL,
  PRIMARY KEY (`shippingID`),
  INDEX `shippingAddress_fk_idx` (`shippingAddress` ASC) VISIBLE,
  CONSTRAINT `shippingAddress_fk`
    FOREIGN KEY (`shippingAddress`)
    REFERENCES `Data_Modeling`.`deliveryAddress` (`shippingAddress`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Data_Modeling`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Data_Modeling`.`products` (
  `productID` INT NOT NULL,
  `productName` VARCHAR(255) NOT NULL,
  `stockAmount` INT NOT NULL,
  `price` DECIMAL NOT NULL,
  `category` VARCHAR(255) NOT NULL,
  `sub_category` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`productID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Data_Modeling`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Data_Modeling`.`orders` (
  `orderID` INT NOT NULL,
  `customerID` INT NOT NULL,
  `productID` INT NOT NULL,
  `shippingID` INT NOT NULL,
  `quantity` INT NOT NULL,
  `discount` DECIMAL NOT NULL,
  `totalCost` DECIMAL NOT NULL,
  PRIMARY KEY (`orderID`),
  INDEX `customer_id_fk_idx` (`customerID` ASC) VISIBLE,
  INDEX `product_id_fk_idx` (`productID` ASC) VISIBLE,
  INDEX `shipping_id_fk_idx` (`shippingID` ASC) VISIBLE,
  CONSTRAINT `customer_id_fk`
    FOREIGN KEY (`customerID`)
    REFERENCES `Data_Modeling`.`customers` (`customerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `product_id_fk`
    FOREIGN KEY (`productID`)
    REFERENCES `Data_Modeling`.`products` (`productID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `shipping_id_fk`
    FOREIGN KEY (`shippingID`)
    REFERENCES `Data_Modeling`.`shipping` (`shippingID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
