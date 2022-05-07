-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`province`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`province` (
  `id` INT NOT NULL,
  `province_name` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`city` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `city_name` VARCHAR(25) NOT NULL,
  `province_index` INT NOT NULL,
  PRIMARY KEY (`id`, `province_index`),
  INDEX `fk_province_index_idx` (`province_index` ASC),
  CONSTRAINT `fk_province_index`
    FOREIGN KEY (`province_index`)
    REFERENCES `mydb`.`province` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`customer` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `last_name` VARCHAR(25) NOT NULL,
  `first_name` VARCHAR(15) NOT NULL,
  `street` VARCHAR(25) NOT NULL,
  `building` INT NOT NULL,
  `entrance` INT NOT NULL,
  `floor` INT NULL,
  `apartment` INT NULL,
  `zip` INT(6) NOT NULL,
  `city_index` INT NOT NULL,
  PRIMARY KEY (`id`, `city_index`),
  CONSTRAINT `fk_city_index`
    FOREIGN KEY (`id` , `city_index`)
    REFERENCES `mydb`.`city` (`id` , `id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = ndbcluster;


-- -----------------------------------------------------
-- Table `mydb`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`order` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order_time` DATETIME NOT NULL,
  `delivery(1)/pickup(0)` BIT NULL DEFAULT 0,
  `total_price` DECIMAL(5,2) NOT NULL DEFAULT 0,
  `customer_id` INT NOT NULL,
  PRIMARY KEY (`id`, `customer_id`),
  INDEX `fk_customer_id_idx` (`customer_id` ASC) ,
  CONSTRAINT `fk_customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mydb`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = ndbcluster;


-- -----------------------------------------------------
-- Table `mydb`.`pizza_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pizza_category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(25) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`burger`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`burger` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `burger_name` VARCHAR(25) NOT NULL,
  `burger_description` VARCHAR(65) NOT NULL,
  `burger_price` DECIMAL(4,2) NULL,
  `burger_image_link` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`drink`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`drink` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `drink_name` VARCHAR(25) NOT NULL,
  `drink_description` VARCHAR(65) NOT NULL,
  `drink_price` DECIMAL(4,2) NULL,
  `drink_image_link` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`pizza_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`pizza_type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pizza_type` VARCHAR(25) NOT NULL,
  `pizza_description` VARCHAR(45) NOT NULL,
  `pizza_price` DECIMAL(4,2) NOT NULL,
  `pizza_image_link` VARCHAR(45) NOT NULL,
  `pizza_category_id` INT NOT NULL,
  PRIMARY KEY (`id`, `pizza_category_id`),
  INDEX `fk_pizza_type_pizza_category1_idx` (`pizza_category_id` ASC) ,
  CONSTRAINT `fk_pizza_type_pizza_category1`
    FOREIGN KEY (`pizza_category_id`)
    REFERENCES `mydb`.`pizza_category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`order_selection_pizza`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`order_selection_pizza` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantity` INT(3) NOT NULL,
  `pizza_id` INT NOT NULL,
  `order_id` INT NOT NULL,
  INDEX `fk_table1_pizza1_idx` (`pizza_id` ASC) ,
  PRIMARY KEY (`id`, `order_id`),
  INDEX `fk_order_selection_order1_idx` (`order_id` ASC) ,
  CONSTRAINT `fk_table1_pizza1`
    FOREIGN KEY (`pizza_id`)
    REFERENCES `mydb`.`pizza_category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_selection_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `mydb`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`store`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`store` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `store_name` VARCHAR(20) NOT NULL,
  `street` VARCHAR(25) NOT NULL,
  `street_number` VARCHAR(10) NOT NULL,
  `zip` INT(6) NOT NULL,
  `city_id` INT NOT NULL,
  PRIMARY KEY (`id`, `city_id`),
  INDEX `fk_store_city1_idx` (`city_id` ASC) ,
  CONSTRAINT `fk_store_city1`
    FOREIGN KEY (`city_id`)
    REFERENCES `mydb`.`city` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`employee` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `last_name` VARCHAR(25) NOT NULL,
  `first_name` VARCHAR(15) NOT NULL,
  `nif` VARCHAR(9) NOT NULL,
  `phone` VARCHAR(12) NOT NULL,
  `cook(0)\sales(1)` BIT NOT NULL,
  `store_id` INT NOT NULL,
  PRIMARY KEY (`id`, `store_id`),
  INDEX `fk_employee_store1_idx` (`store_id` ASC) ,
  CONSTRAINT `fk_employee_store1`
    FOREIGN KEY (`store_id`)
    REFERENCES `mydb`.`store` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`delivery` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `delivery_time` DATETIME NULL,
  `order_id` INT NOT NULL,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`id`, `employee_id`),
  INDEX `fk_delivery_order1_idx` (`order_id` ASC) ,
  INDEX `fk_delivery_employee1_idx` (`employee_id` ASC) ,
  CONSTRAINT `fk_delivery_order1`
    FOREIGN KEY (`order_id`)
    REFERENCES `mydb`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_delivery_employee1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `mydb`.`employee` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`order_selection_burger`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`order_selection_burger` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantity` INT(3) NOT NULL,
  `order_id` INT NOT NULL,
  `burger_id` INT NOT NULL,
  PRIMARY KEY (`id`, `order_id`),
  INDEX `fk_order_selection_order1_idx` (`order_id` ASC) ,
  INDEX `fk_order_selection_burger_burger1_idx` (`burger_id` ASC) ,
  CONSTRAINT `fk_order_selection_order10`
    FOREIGN KEY (`order_id`)
    REFERENCES `mydb`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_selection_burger_burger1`
    FOREIGN KEY (`burger_id`)
    REFERENCES `mydb`.`burger` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`order_selection_drink`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`order_selection_drink` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `quantity` INT(3) NOT NULL,
  `order_id` INT NOT NULL,
  `drink_id` INT NOT NULL,
  PRIMARY KEY (`id`, `order_id`),
  INDEX `fk_order_selection_order1_idx` (`order_id` ASC) ,
  INDEX `fk_order_selection_drink_drink1_idx` (`drink_id` ASC) ,
  CONSTRAINT `fk_order_selection_order100`
    FOREIGN KEY (`order_id`)
    REFERENCES `mydb`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_selection_drink_drink1`
    FOREIGN KEY (`drink_id`)
    REFERENCES `mydb`.`drink` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
