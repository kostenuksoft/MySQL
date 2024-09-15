SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='';

CREATE SCHEMA IF NOT EXISTS `example_1` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
USE `example_1` ;

-- Fell free to experement !
CREATE TABLE IF NOT EXISTS `example_1`.`User` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(50) NULL DEFAULT NULL,
  `middleName` VARCHAR(50) NULL DEFAULT NULL,
  `lastName` VARCHAR(50) NULL DEFAULT NULL,
  `mobile` VARCHAR(15) NULL DEFAULT NULL,
  `email` VARCHAR(50) NULL DEFAULT NULL,
  `passwordHash` VARCHAR(32) NOT NULL,
  `onlytext` TINYINT(1) NULL DEFAULT NULL,
  `onlyheading` TINYINT(1) NULL DEFAULT NULL,
  `entire` TINYINT(1) NULL DEFAULT NULL,
  `admin` TINYINT(1) NOT NULL DEFAULT '0',
  `customer` TINYINT(1) NOT NULL DEFAULT '0',
  `registeredAt` DATETIME NOT NULL,
  `profile` TEXT NULL DEFAULT NULL,
  `intro` TINYTEXT NULL DEFAULT NULL,
  `lastLogin` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uq_mobile` (`mobile` ASC),
  UNIQUE INDEX `uq_email` (`email` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `example_1`.`Newsletter` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `userId` BIGINT(20) NOT NULL,
  `title` VARCHAR(75) NOT NULL,
  `descritpion` VARCHAR(2048) NULL DEFAULT NULL,
  `type` SMALLINT(6) NOT NULL DEFAULT '0',
  `multiple` TINYINT(1) NOT NULL DEFAULT '0',
  `global` TINYINT(1) NOT NULL DEFAULT '0',
  `status` SMALLINT(6) NOT NULL DEFAULT '0',
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  `publishedAt` DATETIME NULL DEFAULT NULL,
  `content` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_newsletter_user` (`userId` ASC),
  CONSTRAINT `fk_newsletter_user`
    FOREIGN KEY (`userId`)
    REFERENCES `repetovsky`.`User` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `example_1`.`Publisher` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `newsletterId` BIGINT(20) NOT NULL,
  `title` VARCHAR(100) NOT NULL,
  `description` VARCHAR(2048) NULL DEFAULT NULL,
  `status` SMALLINT(6) NOT NULL DEFAULT '0',
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  `publishedAt` DATETIME NULL DEFAULT NULL,
  `content` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_edition_newsletter` (`newsletterId` ASC),
  CONSTRAINT `fk_edition_newsletter`
    FOREIGN KEY (`newsletterId`)
    REFERENCES `repetovsky`.`Newsletter` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `example_1`.`Subscriber` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `customerId` BIGINT(20) NULL DEFAULT NULL,
  `firstName` VARCHAR(100) NOT NULL,
  `middleName` VARCHAR(100) NULL DEFAULT NULL,
  `lastName` VARCHAR(100) NULL DEFAULT NULL,
  `email` VARCHAR(100) NOT NULL,
  `mobile` VARCHAR(50) NULL DEFAULT NULL,
  `active` TINYINT(1) NOT NULL DEFAULT '1',
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `uq_sub_cust_email` (`customerId` ASC, `email` ASC),
  INDEX `idx_subscriber_customer` (`customerId` ASC),
  CONSTRAINT `fk_subscriber_customer`
    FOREIGN KEY (`customerId`)
    REFERENCES `repetovsky`.`User` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `example_1`.`MailingList` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `newsletterId` BIGINT(20) NOT NULL,
  `subscriberId` BIGINT(20) NOT NULL,
  `active` TINYINT(1) NOT NULL DEFAULT '1',
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_mlist_newsletter` (`newsletterId` ASC),
  INDEX `idx_mlist_subscriber` (`subscriberId` ASC),
  CONSTRAINT `fk_mlist_newsletter`
    FOREIGN KEY (`newsletterId`)
    REFERENCES `repetovsky`.`Newsletter` (`id`)
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_mlist_subscriber`
    FOREIGN KEY (`subscriberId`)
    REFERENCES `repetovsky`.`Subscriber` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `example_1`.`NewsletterMeta` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `newsletterId` BIGINT(20) NOT NULL,
  `type` VARCHAR(50) NOT NULL,
  `key` VARCHAR(160) NOT NULL,
  `content` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_meta_newsletter` (`newsletterId` ASC),
  CONSTRAINT `fk_meta_newsletter`
    FOREIGN KEY (`newsletterId`)
    REFERENCES `repetovsky`.`Newsletter` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `example_1`.`NewsletterTrigger` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `newsletterId` BIGINT(20) NOT NULL,
  `editionId` BIGINT(20) NULL DEFAULT NULL,
  `subscriberId` BIGINT(20) NOT NULL,
  `sent` TINYINT(1) NOT NULL DEFAULT '1',
  `delivered` TINYINT(1) NOT NULL DEFAULT '1',
  `mode` SMALLINT(6) NOT NULL DEFAULT '0',
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  `sentAt` DATETIME NULL DEFAULT NULL,
  `deliveredAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `idx_trigger_newsletter` (`newsletterId` ASC),
  INDEX `idx_trigger_subscriber` (`subscriberId` ASC),
  INDEX `idx_trigger_edition` (`editionId` ASC),
  CONSTRAINT `fk_trigger_newsletter`
    FOREIGN KEY (`newsletterId`)
    REFERENCES `repetovsky`.`Newsletter` (`id`),
  CONSTRAINT `fk_trigger_subscriber`
    FOREIGN KEY (`subscriberId`)
    REFERENCES `repetovsky`.`Subscriber` (`id`),
  CONSTRAINT `fk_trigger_edition`
    FOREIGN KEY (`editionId`)
    REFERENCES `repetovsky`.`Publisher` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `example_1`.`Country` (
  `idCountry` INT NOT NULL,
  `Name` CHAR(60) NOT NULL,
  `Capital` CHAR(50) NOT NULL,
  `Continent` CHAR(60) NOT NULL,
  `Region` CHAR(50) NOT NULL,
  `SurfaceArea` DECIMAL(10,2) NULL,
  `IndeptYear` SMALLINT NOT NULL,
  `Population` INT NOT NULL,
  `LifeExpectancy` DECIMAL(3,1) NOT NULL,
  `GDP` DECIMAL(10,2) NULL DEFAULT NULL,
  `LocalName` CHAR(50) NOT NULL,
  `GovernmentForm` CHAR(60) NOT NULL,
  `PoliticalSystem` CHAR(60) NULL DEFAULT NULL,
  `GCR` DECIMAL(10,2) NULL DEFAULT NULL,
  `CodeISO` CHAR(2) NOT NULL,
  PRIMARY KEY (`idCountry`));

CREATE TABLE IF NOT EXISTS `example_1`.`City` (
  `idCity` INT(11) NOT NULL AUTO_INCREMENT,
  `idCountry` INT NOT NULL,
  `NameCity` CHAR(30) NOT NULL,
  `District` CHAR(30) NOT NULL,
  `PopulationCity` INT(11) NOT NULL,
  PRIMARY KEY (`idCity`),
  INDEX `fk_City_Country2_idx` (`idCountry` ASC),
  CONSTRAINT `fk_City_Country2`
    FOREIGN KEY (`idCountry`)
    REFERENCES `repetovsky`.`Country` (`idCountry`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 41
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `example_1`.`CountryLanguage` (
  `idLanguage` INT(11) NOT NULL AUTO_INCREMENT,
  `idCountry` INT NOT NULL,
  `Language` CHAR(30) NOT NULL,
  `IsOfficial` ENUM('T', 'F') NOT NULL,
  `Percentage` DECIMAL(4,1) NOT NULL,
  PRIMARY KEY (`idLanguage`, `idCountry`),
  INDEX `fk_CountryLanguage_Country2_idx` (`idCountry` ASC),
  CONSTRAINT `fk_CountryLanguage_Country2`
    FOREIGN KEY (`idCountry`)
    REFERENCES `repetovsky`.`Country` (`idCountry`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 53
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
