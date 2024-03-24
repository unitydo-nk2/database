create database IF NOT EXISTS unityDoDB DEFAULT CHARACTER SET utf8;
use unityDoDB;

SET GLOBAL max_allowed_packet = 536870912;

-- -----------------------------------------------------
-- Table `unityDoDB`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unityDoDB`.`user` ;

CREATE TABLE IF NOT EXISTS `unityDoDB`.`user` (
  `userId` INT NOT NULL auto_increment,
  `username` VARCHAR(100) NOT NULL,
  `password` VARCHAR(250) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `surName` VARCHAR(100) NOT NULL,
  `nickName` VARCHAR(70) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `gender` VARCHAR(50) NOT NULL,
  `dateOfBirth` DATE NOT NULL,
  `religion` VARCHAR(50) NOT NULL,
  `telephoneNumber` VARCHAR(50) NOT NULL,
  `address` VARCHAR(400) NOT NULL,
  `role` ENUM('user', 'activityOwner', 'admin') NOT NULL,
  `emergencyPhoneNumber` VARCHAR(45) NOT NULL,
  `profileImg` VARCHAR(300) NULL,
  `line` VARCHAR(100) NULL,
  `instagram` VARCHAR(100) NULL,
  `x` VARCHAR(100) NULL,
  `createTime` TIMESTAMP NOT NULL,
  `updateTime` TIMESTAMP NOT NULL,
  PRIMARY KEY (`userId`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `unityDoDB`.`Location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unityDoDB`.`location` ;

CREATE TABLE IF NOT EXISTS `unityDoDB`.`location` (
  `locationId` INT NOT NULL auto_increment,
  `locationName` VARCHAR(150) NOT NULL,
  `googleMapLink` VARCHAR(300) NOT NULL,
  `locationLongitude` DOUBLE NOT NULL,
  `locationLatitude` DOUBLE NOT NULL,
  PRIMARY KEY (`locationId`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `unityDoDB`.`mainCategory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unityDoDB`.`mainCategory` ;

CREATE TABLE IF NOT EXISTS `unityDoDB`.`mainCategory` (
  `mainCategoryId` INT NOT NULL auto_increment,
  `mainCategory` VARCHAR(100) NOT NULL,
  `description` VARCHAR(300) NULL,
  PRIMARY KEY (`mainCategoryId`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `unityDoDB`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unityDoDB`.`category` ;

CREATE TABLE IF NOT EXISTS `unityDoDB`.`category` (
  `categoryId` INT NOT NULL auto_increment,
  `category` VARCHAR(100) NOT NULL,
  `mainCategory` INT NOT NULL,
  PRIMARY KEY (`categoryId`),
  INDEX `fk_Category_subCategory1_idx` (`mainCategory` ASC) VISIBLE,
  CONSTRAINT `fk_Category_subCategory1`
    FOREIGN KEY (`mainCategory`)
    REFERENCES `unityDoDB`.`mainCategory` (`mainCategoryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `unityDoDB`.`activity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unityDoDB`.`activity` ;

CREATE TABLE IF NOT EXISTS `unityDoDB`.`activity` (
  `activityId` INT NOT NULL auto_increment,
  `activityOwner` INT NOT NULL,
  `activityName` VARCHAR(150) NOT NULL,
  `activityBriefDescription` VARCHAR(100) NOT NULL,
  `activityDescription` VARCHAR(300) NOT NULL,
  `activityDate` TIMESTAMP NOT NULL,
  `activityEndDate` TIMESTAMP NOT NULL,
  `registerStartDate` TIMESTAMP NOT NULL,
  `registerEndDate` TIMESTAMP NOT NULL,
  `amount` INT NOT NULL,
  `locationId` INT,
  `announcementDate` TIMESTAMP NOT NULL,
  `activityStatus` ENUM('Active', 'Done') NOT NULL,
  `isGamification` TINYINT NOT NULL,
  `suggestionNotes` VARCHAR(500) NULL,
  `categoryId` INT NOT NULL,
  `lastUpdate` TIMESTAMP NOT NULL,
  `createTime` TIMESTAMP NOT NULL,
  `activityFormat` ENUM('online', 'onsite' ,'onsiteOverNight') NOT NULL,
  PRIMARY KEY (`activityId`),
  UNIQUE INDEX `activityId_UNIQUE` (`activityId` ASC) VISIBLE,
  INDEX `fk_Activity_location1_idx` (`locationId` ASC) VISIBLE,
  INDEX `fk_Activity_Category1_idx` (`categoryId` ASC) VISIBLE,
  INDEX `fk_Activity_User1_idx` (`activityOwner` ASC) VISIBLE,
  CONSTRAINT `fk_Activity_location1`
    FOREIGN KEY (`locationId`)
    REFERENCES `unityDoDB`.`location` (`locationId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Activity_Category1`
    FOREIGN KEY (`categoryId`)
    REFERENCES `unityDoDB`.`category` (`categoryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Activity_User1`
    FOREIGN KEY (`activityOwner`)
    REFERENCES `unityDoDB`.`user` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `unityDoDB`.`Registration`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unityDoDB`.`registration` ;

CREATE TABLE IF NOT EXISTS `unityDoDB`.`registration` (
  `registrationId` INT NOT NULL auto_increment,
  `userId` INT NOT NULL,
  `registrationDate` DATETIME NOT NULL,
  `status` ENUM('registered','selected','confirmed','success','review') NOT NULL,
  `activityId` INT NOT NULL,
  PRIMARY KEY (`registrationId`),
  UNIQUE INDEX `registrationId_UNIQUE` (`registrationId` ASC) VISIBLE,
  INDEX `fk_Registration_Users1_idx` (`userId` ASC) VISIBLE,
  INDEX `fk_Registration_Activity1_idx` (`activityId` ASC) VISIBLE,
  CONSTRAINT `fk_Registration_Users1`
    FOREIGN KEY (`userId`)
    REFERENCES `unityDoDB`.`user` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Registration_Activity1`
    FOREIGN KEY (`activityId`)
    REFERENCES `unityDoDB`.`activity` (`activityId`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `unityDoDB`.`QuestionTitle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unityDoDB`.`questionTitle` ;

CREATE TABLE IF NOT EXISTS `unityDoDB`.`questionTitle` (
  `questionId` INT NOT NULL,
  `Question` VARCHAR(100) NOT NULL,
  `activityId` INT NULL,
  PRIMARY KEY (`questionId`),
  INDEX `fk_questionTitle_Activity1_idx` (`activityId` ASC) VISIBLE,
  CONSTRAINT `fk_questionTitle_Activity1`
    FOREIGN KEY (`activityId`)
    REFERENCES `unityDoDB`.`activity` (`activityId`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `unityDoDB`.`Answer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unityDoDB`.`answer` ;

CREATE TABLE IF NOT EXISTS `unityDoDB`.`answer` (
  `answerId` INT NOT NULL auto_increment,
  `registrationId` INT NULL,
  `questionId` INT NOT NULL,
  `answer` VARCHAR(400) NOT NULL,
  PRIMARY KEY (`answerId`),
  INDEX `fk_answer_Registration1_idx` (`registrationId` ASC) VISIBLE,
  INDEX `fk_Answer_QuestionTitle1_idx` (`questionId` ASC) VISIBLE,
  CONSTRAINT `fk_answer_Registration1`
    FOREIGN KEY (`registrationId`)
    REFERENCES `unityDoDB`.`registration` (`registrationId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Answer_QuestionTitle1`
    FOREIGN KEY (`questionId`)
    REFERENCES `unityDoDB`.`questionTitle` (`questionId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `unityDoDB`.`userActivityHistory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unityDoDB`.`userActivityHistory` ;

CREATE TABLE IF NOT EXISTS `unityDoDB`.`userActivityHistory` (
  `activityHistoryId` INT NOT NULL auto_increment,
  `userId` INT NOT NULL,
  `activityId` INT NOT NULL,
  PRIMARY KEY (`activityHistoryId`),
  INDEX `fk_activityHistory_Users1_idx` (`userId` ASC) VISIBLE,
  INDEX `fk_activityHistory_Activity1_idx` (`activityId` ASC) VISIBLE,
  CONSTRAINT `fk_activityHistory_Users1`
    FOREIGN KEY (`userId`)
    REFERENCES `unityDoDB`.`user` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_activityHistory_Activity1`
    FOREIGN KEY (`activityId`)
    REFERENCES `unityDoDB`.`activity` (`activityId`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `unityDoDB`.`ActivityReview`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unityDoDB`.`activityReview` ;

CREATE TABLE IF NOT EXISTS `unityDoDB`.`activityReview` (
  `activityReviewId` INT NOT NULL auto_increment,
  `activityId` INT NOT NULL,
  `userId` INT NOT NULL,
  `score` INT NOT NULL,
  `reviewDescription` VARCHAR(500) NOT NULL,
  PRIMARY KEY (`activityReviewId`),
  INDEX `fk_activityReview_Activity1_idx` (`activityId` ASC) VISIBLE,
  INDEX `fk_activityReview_Users1_idx` (`userId` ASC) VISIBLE,
  CONSTRAINT `fk_activityReview_Activity1`
    FOREIGN KEY (`activityId`)
    REFERENCES `unityDoDB`.`activity` (`activityId`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_activityReview_Users1`
    FOREIGN KEY (`userId`)
    REFERENCES `unityDoDB`.`user` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `unityDoDB`.`medicalInfomation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unityDoDB`.`medicalInfomation` ;

CREATE TABLE IF NOT EXISTS `unityDoDB`.`medicalInfomation` (
  `idmedicalInfomation` INT NOT NULL auto_increment,
  `type` ENUM('Amedicalinfomation', 'D', 'I') NOT NULL,
  `name` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`idmedicalInfomation`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `unityDoDB`.`userMedicalInfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unityDoDB`.`userMedicalInfo` ;

CREATE TABLE IF NOT EXISTS `unityDoDB`.`userMedicalInfo` (
  `congenitalDiseasesID` INT NOT NULL auto_increment,
  `userId` INT NULL,
  `medicalInfomation` INT NOT NULL,
  PRIMARY KEY (`congenitalDiseasesID`),
  INDEX `fk_congenitalDiseases_Users1_idx` (`userId` ASC) VISIBLE,
  INDEX `fk_CongenitalDiseases_medicalInfomation1_idx` (`medicalInfomation` ASC) VISIBLE,
  CONSTRAINT `fk_congenitalDiseases_Users1`
    FOREIGN KEY (`userId`)
    REFERENCES `unityDoDB`.`user` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CongenitalDiseases_medicalInfomation1`
    FOREIGN KEY (`medicalInfomation`)
    REFERENCES `unityDoDB`.`medicalInfomation` (`idmedicalInfomation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `unityDoDB`.`requirements`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unityDoDB`.`requirements` ;

CREATE TABLE IF NOT EXISTS `unityDoDB`.`requirements` (
  `requirementId` INT NOT NULL auto_increment,
  `activityId` INT NOT NULL,
  `medicalInfomation` INT NOT NULL,
  PRIMARY KEY (`requirementId`),
  INDEX `fk_requirements_Activity1_idx` (`activityId` ASC) VISIBLE,
  INDEX `fk_requirements_medicalInfomation1_idx` (`medicalInfomation` ASC) VISIBLE,
  CONSTRAINT `fk_requirements_Activity1`
    FOREIGN KEY (`activityId`)
    REFERENCES `unityDoDB`.`activity` (`activityId`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_requirements_medicalInfomation1`
    FOREIGN KEY (`medicalInfomation`)
    REFERENCES `unityDoDB`.`medicalInfomation` (`idmedicalInfomation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `unityDoDB`.`activityFavorite`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `unityDoDB`.`activityFavorite` ;

CREATE TABLE IF NOT EXISTS `unityDoDB`.`activityFavorite` (
  `activityFavoriteId` INT NOT NULL auto_increment,
  `userId` INT NOT NULL,
  `activityId` INT NOT NULL,
  PRIMARY KEY (`activityFavoriteId`),
  INDEX `fk_activityFavorite_Users1_idx` (`userId` ASC) VISIBLE,
  INDEX `fk_activityFavorite_Activity1_idx` (`activityId` ASC) VISIBLE,
  CONSTRAINT `fk_activityFavorite_Users1`
    FOREIGN KEY (`userId`)
    REFERENCES `unityDoDB`.`user` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_activityFavorite_Activity1`
    FOREIGN KEY (`activityId`)
    REFERENCES `unityDoDB`.`activity` (`activityId`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `unityDoDB`.`image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unityDoDB`.`image` ;

CREATE TABLE IF NOT EXISTS `unityDoDB`.`image` (
  `imageId` INT NOT NULL auto_increment,
  `activityId` INT NULL,
  `label` VARCHAR(100) NOT NULL,
  `alt` VARCHAR(100) NOT NULL,
  `imagepath` VARCHAR(300) NOT NULL,
  PRIMARY KEY (`imageId`),
  INDEX `fk_image_Activity1_idx` (`activityId` ASC) VISIBLE,
  CONSTRAINT `fk_image_Activity1`
    FOREIGN KEY (`activityId`)
    REFERENCES `unityDoDB`.`activity` (`activityId`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `unityDoDB`.`Validation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unityDoDB`.`validation` ;

CREATE TABLE IF NOT EXISTS `unityDoDB`.`validation` (
  `validationId` INT NOT NULL auto_increment,
  `activityId` INT NOT NULL,
  `validationType` ENUM('QRCode', 'stepCounter', 'GPS', 'heartRate', 'distanceCal'),
  `validationRule` DOUBLE NOT NULL,
  PRIMARY KEY (`validationId`),
  INDEX `fk_Validation_Activity1_idx` (`activityId` ASC) VISIBLE,
  CONSTRAINT `fk_Validation_Activity1`
    FOREIGN KEY (`activityId`)
    REFERENCES `unityDoDB`.`activity` (`activityId`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `unityDoDB`.`favoriteCategory`
-- -----------------------------------------------------

DROP TABLE IF EXISTS `unityDoDB`.`favoriteCategory` ;

CREATE TABLE favoriteCategory (
  favoriteCategoryId int NOT NULL AUTO_INCREMENT,
  userId int NOT NULL,
  mainCategoryId int NOT NULL,
  categoryRank int NOT NULL,
  PRIMARY KEY (`favoriteCategoryId`),
  KEY fk_categoryInterested_User1_idx (`userId`),
  KEY fk_categoryInterested_mainCategory1_idx (`mainCategoryId`),
  CONSTRAINT fk_categoryInterested_mainCategory1 FOREIGN KEY (`mainCategoryId`) REFERENCES mainCategory (`mainCategoryId`),
  CONSTRAINT fk_categoryInterested_User1 FOREIGN KEY (`userId`) REFERENCES user (`userId`)
);

-- user
DROP USER IF EXISTS 'nk2'@'%';
-- Create the user 'nk2' and grant privileges
CREATE USER 'nk2'@'%' IDENTIFIED BY 'dreamtongphop';
GRANT ALL PRIVILEGES ON unityDoDB.* TO 'nk2'@'%';
FLUSH PRIVILEGES;

INSERT INTO
    mainCategory (mainCategory)
VALUES
    ('Volunteers'),
    ('Education'),
    ('Exercises'),
    ('Dance'),
    ('Art & Music'),
    ('Business'),
    ('Others');

INSERT INTO
    category (category, maincategory)
VALUES
    ('Animal care', 1),
    ('Social services', 1),
    ('Healthcare', 1),
    ('Leisure and sporting', 1),
    ('Environmental', 1),
    ('Creative', 1),
    ('Others', 1),
    ('Science & Technology', 2),
    ('Mathematics', 2),
    ('Art', 2),
    ('Music', 2),
    ('Others', 2),
    ('Boxing', 3),
    ('Hiking', 3),
    ('Running', 3),
    ('Walking', 3),
    ('Swimming', 3),
    ('Football', 3),
    ('Basketball', 3),
    ('Volleyball', 3),
    ('Others', 3),
    ('Aerobics', 4),
    ('Yoga', 4),
    ('Cover Dance', 4),
    ('Gymnastics', 4),
    ('Others', 4),
    ('Painting', 5),
    ('Drawing', 5),
    ('Sculpture', 5),
    ('Music', 5),
    ('Singing', 5),
    ('Dancing', 5),
    ('Writing', 5),
    ('Poetry', 5),
    ('Literature', 5),
    ('Others', 5),
    ('Start-up', 6),
    ('Marketing', 6),
    ('Financial', 6),
    ('E-commerce', 6),
    ('Logistics', 6),
    ('Others', 6),
    ('Others', 7);

INSERT INTO
    user (
        username,
        password,
        name,
        surName,
        nickName,
        email,
        gender,
        dateOfBirth,
        religion,
        telephoneNumber,
        address,
        role,
        emergencyPhoneNumber,
        profileImg,
        line,
        instagram,
        x,
        createTime,
        updateTime
    )
VALUES
('user1','$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI','John','Doe','JD123','john.doe@email.com','Male','1990-05-15','Christian','+1234567890','123 Main St, City, Country','user','+0987654321','profile1.jpg','john_doe_line','john_doe_instagram','john_doe_x','2023-10-09 14:50:00','2023-10-09 14:50:00'),
('user2','$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI','Jane','Smith','JS456','jane.smith@email.com','Female','1985-08-20','Buddhist','+9876543210','456 Elm St, City, Country','activityOwner','+1234509876','profile2.jpg','jane_smith_line','jane_smith_instagram','jane_smith_x','2023-10-09 14:50:00','2023-10-09 14:50:00'),
('admin1','$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI','Admin','User','Admin123','admin@email.com','Other','1970-01-01','None','+1111111111','789 Oak St, City, Country','admin','+2222222222','admin_profile.jpg','admin_line','admin_instagram','admin_x','2023-10-09 14:50:00','2023-10-09 14:50:00'),
('user3','$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI','Alice','Johnson','AJ123','alice@email.com','Female','1995-03-10','Hindu','+3333333333','789 Elm St, City, Country','user','+3333333333','alice_profile.jpg','alice_line','alice_instagram','alice_x','2023-01-15 12:30:00','2023-01-15 12:30:00'),
('user4','$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI','Bob','Williams','BW456','bob@email.com','Male','1988-11-25','Atheist','+4444444444','123 Oak St, City, Country','user','+4444444444','bob_profile.jpg','bob_line','bob_instagram','bob_x','2023-01-16 09:45:00','2023-01-16 09:45:00'),
('activityOwner1','$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI','Sarah','Miller','SM123','sarah@email.com','Female','1980-07-05','Jewish','+5555555555','456 Pine St, City, Country','activityOwner','+5555555555','sarah_profile.jpg','sarah_line','sarah_instagram','sarah_x','2023-01-17 14:20:00','2023-01-17 14:20:00'),
('activityOwner2','$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI','Michael','Brown','MB456','michael@email.com','Male','1982-04-12','Christian','+6666666666','789 Maple St, City, Country','activityOwner','+6666666666','michael_profile.jpg','michael_line','michael_instagram','michael_x','2023-01-18 18:10:00','2023-01-18 18:10:00'),
('admin2','$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI','Admin','User2','Admin234','admin2@email.com','Other','1975-02-15','None','+7777777777','456 Cedar St, City, Country','admin','+7777777777','admin2_profile.jpg','admin2_line','admin2_instagram','admin2_x','2023-01-19 21:05:00','2023-01-19 21:05:00'),
('emma','$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Emma', 'Johnson','Em','emma.johnson@example.com', 'Female', '2002-03-14', 'Buddhism', '080-1234567', '123 Main St, City', 'user', '081-2345678', 'image1.jpg', 'lineuser001', 'InstaGenius198', 'InstaGenius198', '2019-08-10 15:23:00', '2019-09-10 15:23:00'),
('liam','$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI','Liam', 'Smith', 'Lee','liam.smith@example.com', 'Male','1999-07-25', 'Christianity', '081-2345678', '456 Elm St, Town','user', '082-3456789','image2.jpg', 'lineuser002', 'TrendyTiger198', 'TrendyTiger198', '2019-02-27 08:44:00','2019-03-27 08:44:00'),
('mia', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Mia', 'Patel', 'Mimi', 'mia.patel@example.com', 'Female', '2003-11-18', 'Hinduism', '082-3456789', '789 Oak Ave, Village', 'user', '083-4567890', 'image1.jpg', 'lineuser003', 'ExploreCharm198', 'ExploreCharm198',  '2020-11-18 20:17:00', '2021-11-18 20:17:00'),
('noah', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Noah', 'Nguyen', 'Nono', 'noah.nguyen@example.com', 'Male', '1998-09-10', 'Islam', '083-4567890', '1010 Pine Ln, City', 'user', '084-5678901', 'image2.jpg', 'lineuser004', 'DreamyDazzle198', 'DreamyDazzle198',  '2019-10-05 12:59:00', '2019-11-05 12:59:00'),
('ava', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Ava', 'Kim', 'Avi', 'ava.kim@example.com', 'Female', '2004-05-21', 'Buddhism', '084-5678901', '1313 Cedar St, Town', 'user', '085-6789012', 'image1.jpg', 'lineuser005', 'VibingVoyage198', 'VibingVoyage198',  '2019-04-19 03:32:00', '2019-05-19 03:32:00'),
('oliver', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Oliver', 'Martinez', 'Ollie', 'oliver.martinez@example.com', 'Male', '1997-02-28', 'Sikhism', '085-6789012', '1515 Maple Dr, Village', 'user', '086-7890123', 'image2.jpg', 'lineuser006', 'MysticMarvel198', 'MysticMarvel198', '2020-06-22 18:05:00', '2021-06-22 18:05:00'),
('amelia', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Amelia', 'Gupta', 'Amy', 'amelia.gupta@example.com', 'Female', '2000-12-03', 'Judaism', '086-7890123', '1717 Oak Ave, City', 'user', '087-8901234', 'image1.jpg', 'lineuser007', 'GlitterGuru198', 'GlitterGuru198',  '2019-12-30 09:48:00', '2020-12-30 09:48:00'),
('james', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'James', 'Rodriguez', 'Jay', 'james.rodriguez@example.com', 'Male', '1996-10-30', 'Christianity', '087-8901234', '1818 Pine Ln, Town', 'user', '088-9012345', 'image2.jpg', 'lineuser008', 'CosmicCraze198', 'CosmicCraze198', '2020-03-15 14:21:00', '2020-04-15 14:21:00'),
('CreativeMinds', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Charlotte', 'Wong', 'Charlie', 'charlotte.wong@example.com', 'Female', '1995-04-05', 'Buddhism', '088-9012345', '1919 Elm St, Village', 'activityOwner', '089-0123456', 'image1.jpg', 'lineuser009', 'WanderWhiz198', 'WanderWhiz198',  '2019-09-04 23:54:00', '2019-10-04 23:54:00'),
('elijah', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Elijah', 'Garcia', 'Eli', 'elijah.garcia@example.com', 'Male', '2001-07-17', 'Hinduism', '089-0123456', '2020 Cedar St, City', 'user', '090-1234567', 'image2.jpg', 'lineuser010', 'BlissfulBlaze198', 'BlissfulBlaze198',  '2019-07-08 06:27:00', '2019-08-08 06:27:00'),
('zoe', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Zoe', 'Brown', 'Zo', 'zoe.brown@example.com', 'Female', '2003-08-29', 'Islam', '090-1234567', '4343 Oak Ave, Town', 'user', '091-2345678', 'image1.jpg', 'lineuser011', 'FlareFusion198', 'FlareFusion198', '2020-01-12 17:00:00', '2021-01-12 17:00:00');

INSERT INTO
    user (
        username,
        password,
        name,
        surName,
        nickName,
        email,
        gender,
        dateOfBirth,
        religion,
        telephoneNumber,
        address,
        role,
        emergencyPhoneNumber,
        profileImg,
        line,
        instagram,
        x,
        createTime,
        updateTime
    )
VALUES
('BlueSky Adventures', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Benjamin', 'Liu', 'Ben', 'benjamin.liu@example.com', 'Male', '1977-12-12', 'Sikhism', '091-2345678', '4444 Maple Dr, Village', 'activityOwner', '092-3456789', 'image2.jpg', 'lineuser012', 'SparkleSpectra198', 'SparkleSpectra198', '2019-11-25 21:33:00', '2019-12-25 21:33:00'),
('mila', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Mila', 'Thompson', 'Mi', 'mila.thompson@example.com', 'Female', '1998-03-18', 'Christianity', '092-3456789', '4545 Pine Ln, City', 'user', '093-4567890', 'image1.jpg', 'lineuser013', 'NovaNexus198', 'NovaNexus198', '2020-05-07 04:06:00', '2021-05-07 04:06:00'),
('ethan', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Ethan', 'Kumar', 'E', 'ethan.kumar@example.com', 'Male', '1985-05-24', 'Buddhism', '093-4567890', '4646 Elm St, Town', 'user', '094-5678901', 'image2.jpg', 'lineuser014', 'LunaLuxe198', 'LunaLuxe198', '2019-03-01 11:39:00', '2019-04-01 11:39:00'),
('emily', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Emily', 'Kim', 'Emi', 'emily.kim@example.com', 'Female', '1973-08-07', 'Hinduism', '094-5678901', '4747 Cedar St, Village', 'user', '095-6789012', 'image1.jpg', 'lineuser015', 'SereneSiren198', 'SereneSiren198', '2019-05-18 20:12:00', '2019-06-18 20:12:00'),
('alexander', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Alexander', 'Garcia', 'Alex', 'alexander.garcia@example.com', 'Male', '1958-11-11', 'Judaism', '095-6789012', '4848 Oak Ave, City', 'user', '096-7890123', 'image2.jpg', 'lineuser016', 'BlissfulBloom198', 'BlissfulBloom198', '2020-10-10 12:45:00', '2021-10-10 12:45:00'),
('sophia', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Sophia', 'Wong', 'Soph', 'sophia.wong@example.com', 'Female', '2002-01-02', 'Sikhism', '096-7890123', '4949 Maple Dr, Town', 'user', '097-8901234', 'image1.jpg', 'lineuser017', 'WhisperWonder198', 'WhisperWonder198', '2020-02-28 03:18:00', '2021-02-28 03:18:00'),
('olivia', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Olivia', 'Nguyen', 'Liv', 'olivia.nguyen@example.com', 'Female', '1994-06-08', 'Christianity', '097-8901234', '5050 Pine Ln, Village', 'user', '098-9012345', 'image1.jpg', 'lineuser018', 'CelestialCharm198', 'CelestialCharm198', '2019-01-03 14:51:00', '2019-02-03 14:51:00'),
('william', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'William', 'Rodriguez', 'Will', 'william.rodriguez@example.com', 'Male', '1970-09-15', 'Buddhism', '098-9012345', '5151 Elm St, City', 'user', '099-0123456', 'image2.jpg', 'lineuser019', 'RadiantRipple198', 'RadiantRipple198', '2020-08-14 23:24:00', '2021-08-14 23:24:00'),
('alice', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Ava', 'Patel', 'Avi', 'ava.patel@example.com', 'Female', '1991-12-20', 'Hinduism', '099-0123456', '5252 Cedar St, Town', 'user', '080-2345678', 'image1.jpg', 'lineuser020', 'GleamGrove198', 'GleamGrove198', '2019-06-25 10:57:00', '2019-07-25 10:57:00'),
('noah123', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Noah', 'Lee', 'Nono', 'noah.lee@example.com', 'Male', '1986-03-04', 'Islam', '080-1234567', '5353 Oak Ave, Village', 'user', '081-3456789', 'image2.jpg', 'lineuser021', 'EnigmaEcho198', 'EnigmaEcho198', '2020-09-19 19:30:00', '2021-09-19 19:30:00'),
('isabella123', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Isabella', 'Kim', 'Bella', 'isabella.kim@example.com', 'Female', '1955-05-31', 'Sikhism', '081-2345678', '5454 Maple Dr, City', 'user', '082-4567890', 'image1.jpg', 'lineuser022', 'InspireInstinct198', 'InspireInstinct198', '2020-07-31 08:03:00', '2021-07-31 08:03:00'),
('oliver123', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Oliver', 'Garcia', 'Ollie', 'oliver.garcia@example.com', 'Male', '1948-08-16', 'Judaism', '082-3456789', '5555 Pine Ln, Village', 'user', '083-5678901', 'image2.jpg', 'lineuser023', 'DelightDiva198', 'DelightDiva198', '2019-11-15 03:36:00', '2019-12-15 03:36:00'),
('sophia123', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Sophia', 'Wong', 'Sophy', 'sophia.wong@example.com', 'Female', '1940-11-22', 'Christianity', '083-4567890', '5656 Elm St, City', 'user', '084-6789012', 'image1.jpg', 'lineuser024', 'MarvelMystique198', 'MarvelMystique198', '2020-04-07 14:09:00', '2021-05-07 14:09:00'),
('liam123', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Liam', 'Martinez', 'Lee', 'liam.martinez@example.com', 'Male', '1977-02-09', 'Buddhism', '084-5678901', '5757 Cedar St, Town', 'user', '085-7890123', 'image2.jpg', 'lineuser025', 'VibrantVista198', 'VibrantVista198', '2019-02-10 22:42:00', '2019-03-10 22:42:00'),
('Event Horizon', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Emma', 'Gupta', 'Em', 'emma.gupta@example.com', 'Female', '1963-04-17', 'Hinduism', '085-6789012', '5858 Oak Ave, Village', 'activityOwner', '086-8901234', 'image1.jpg', 'lineuser026', 'RainbowRhythm198', 'RainbowRhythm198', '2019-08-22 07:15:00', '2019-09-22 07:15:00'),
('benjamin123', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Benjamin', 'Brown', 'Ben', 'benjamin.brown@example.com', 'Male', '1952-07-03', 'Islam', '086-7890123', '5959 Maple Dr, City', 'user', '084-7890123', 'image2.jpg', 'lineuser027', 'SparkleShine198', 'SparkleShine198', '2019-04-25 15:48:00', '2019-05-25 15:48:00'),
('mia123', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Mia', 'Thompson', 'Mi', 'mia.thompson@example.com', 'Female', '1990-10-12', 'Christianity', '087-8901234', '6060 Pine Ln, Village', 'user', '085-8901234', 'image1.jpg', 'lineuser028', 'EnchantedEmbrace198', 'EnchantedEmbrace198', '2020-12-20 00:21:00', '2021-12-20 00:21:00'),
('lucas123', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Lucas', 'Kumar', 'Luke', 'lucas.kumar@example.com', 'Male', '1974-12-28', 'Buddhism', '088-9012345', '6161 Elm St, City', 'user', '086-9012345', 'image2.jpg', 'lineuser029', 'BlissBurst198', 'BlissBurst198', '2020-06-01 09:54:00', '2021-06-01 09:54:00'),
('Harmony Events', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Harper', 'Lee', 'Harp', 'harper.lee@example.com', 'Female', '1982-03-21', 'Hinduism', '089-0123456', '6262 Cedar St, Town', 'activityOwner', '087-0123456', 'image1.jpg', 'lineuser030', 'TwilightTwist198', 'TwilightTwist198', '2019-10-14 18:27:00', '2019-11-14 18:27:00'),
('ethan123', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Ethan', 'Kim', 'E', 'ethan.kim@example.com', 'Male', '1956-06-05', 'Islam', '090-1234567', '6363 Oak Ave, Village', 'user', '088-1234567', 'image2.jpg', 'lineuser031', 'CosmicCascade198', 'CosmicCascade198', '2019-01-17 03:00:00', '2019-02-17 03:00:00');

INSERT INTO
    user (
        username,
        password,
        name,
        surName,
        nickName,
        email,
        gender,
        dateOfBirth,
        religion,
        telephoneNumber,
        address,
        role,
        emergencyPhoneNumber,
        profileImg,
        line,
        instagram,
        x,
        createTime,
        updateTime
    )
VALUES
('evelyn123', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Evelyn', 'Rodriguez', 'Evie', 'evelyn.rodriguez@example.com', 'Female', '1943-09-14', 'Sikhism', '091-2345678', '6464 Maple Dr, City', 'user', '089-2345678', 'image1.jpg', 'lineuser032', 'PrismPulse198', 'PrismPulse198', '2020-07-05 12:33:00', '2021-07-05 12:33:00'),
('daniel123', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Daniel', 'Gupta', 'Danny', 'daniel.gupta@example.com', 'Male', '1932-07-30', 'Judaism', '092-3456789', '6565 Pine Ln, Village', 'user', '080-1234567', 'image2.jpg', 'lineuser033', 'WanderWhirl198', 'WanderWhirl198', '2019-05-29 21:06:00', '2019-06-29 21:06:00'),
('william123', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'William', 'Garcia', 'Will', 'william.garcia@example.com', 'Male', '1918-04-07', 'Buddhism', '094-5678901', '6767 Cedar St, Town', 'user', '082-3456789', 'image1.jpg', 'lineuser034', 'DreamyDusk198', 'DreamyDusk198', '2020-11-23 05:39:00', '2021-11-23 05:39:00'),
('grace123', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Grace', 'Brown', 'Gracie', 'grace.brown@example.com', 'Female', '1903-12-19', 'Hinduism', '095-6789012', '6868 Oak Ave, Village', 'user', '083-4567890', 'image1.jpg', 'lineuser035', 'EtherealElixir198', 'EtherealElixir198', '2020-09-26 14:12:00', '2021-09-26 14:12:00'),
('samuel123', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Samuel', 'Kim', 'Sam', 'samuel.kim@example.com', 'Male', '1889-09-25', 'Islam', '096-7890123', '6969 Maple Dr, City', 'user', '084-5678901', 'image2.jpg', 'lineuser036', 'GleamGlow198', 'GleamGlow198', '2019-12-09 22:45:00', '2019-12-09 22:45:00'),
('amelia123', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Amelia', 'Martinez', 'Amy', 'amelia.martinez@example.com', 'Female', '1989-06-14', 'Christianity', '097-8901234', '7070 Pine Ln, Village', 'user', '085-6789012', 'image1.jpg', 'lineuser037', 'RadiantRise198', 'RadiantRise198', '2019-02-14 07:18:00', '2019-03-14 07:18:00'),
('michael123', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Michael', 'Patel', 'Mike', 'michael.patel@example.com', 'Male', '1985-03-08', 'Buddhism', '098-9012345', '7171 Elm St, City', 'user', '086-7890123', 'image2.jpg', 'lineuser038', 'EnigmaEssence198', 'EnigmaEssence198', '2020-10-18 15:51:00', '2021-10-18 15:51:00'),
('alexander123', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Sophia', 'Nguyen', 'Sophy', 'sophia.nguyen@example.com', 'Female', '1980-08-27', 'Hinduism', '099-0123456', '7272 Cedar St, Town', 'user', '081-3456789', 'image1.jpg', 'lineuser039', 'WhisperWhims198', 'WhisperWhims198', '2020-03-02 00:24:00', '2020-03-02 00:24:00'),
('olivia123', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Benjamin', 'Lee', 'Ben', 'benjamin.lee@example.com', 'Male', '1976-12-10', 'Islam', '080-1234567', '7373 Oak Ave, Village', 'user', '082-4567890', 'image2.jpg', 'lineuser040', 'MysticMirage198', 'MysticMirage198', '2019-07-16 08:57:00', '2019-08-16 08:57:00'),
('james123', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Olivia', 'Kim', 'Liv', 'olivia.kim@example.com', 'Female', '1973-05-05', 'Sikhism', '081-2345678', '7474 Maple Dr, City', 'user', '083-5678901', 'image1.jpg', 'lineuser041', 'NovaNebula198', 'NovaNebula198', '2019-03-20 17:30:00', '2020-03-20 17:30:00'),
('charlotte123', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'James', 'Garcia', 'Jay', 'james.garcia@example.com', 'Male', '1968-10-20', 'Judaism', '082-3456789', '7575 Pine Ln, Village', 'user', '084-6789012', 'image2.jpg', 'lineuser042', 'BlissBlush198', 'BlissBlush198', '2019-11-03 02:03:00', '2019-12-03 02:03:00'),
('elijah123', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Emma', 'Gupta', 'Em', 'emma.gupta@example.com', 'Female', '1965-04-18', 'Christianity', '083-4567890', '7676 Elm St, City', 'user', '085-7890123', 'image1.jpg', 'lineuser043', 'CelestialCrest198', 'CelestialCrest198', '2020-05-16 10:36:00', '2021-06-16 10:36:00'),
('w_will', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'William', 'Wong', 'Will', 'william.wong@example.com', 'Male', '1959-11-22', 'Buddhism', '084-5678901', '7777 Cedar St, Town', 'user', '086-8901234', 'image2.jpg', 'lineuser044', 'VibrantVerve198', 'VibrantVerve198', '2020-01-28 19:09:00', '2021-02-28 19:09:00'),
('a_ava', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Ava', 'Brown', 'Avi', 'ava.brown@example.com', 'Female', '1952-02-14', 'Hinduism', '085-6789012', '7878 Oak Ave, Village', 'user', '087-9012345', 'image1.jpg', 'lineuser045', 'GleamGlisten198', 'GleamGlisten198', '2019-08-06 03:42:00', '2019-09-06 03:42:00'),
('n_noah', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Noah', 'Kim', 'Nono', 'noah.kim@example.com', 'Male', '1947-07-06', 'Islam', '086-7890123', '7979 Maple Dr, City', 'user', '088-0123456', 'image2.jpg', 'lineuser046', 'DreamyDaze198', 'DreamyDaze198', '2020-12-03 12:15:00', '2021-12-03 12:15:00'),
('s_sophia', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Sophia', 'Rodriguez', 'Sophy', 'sophia.rodriguez@example.com', 'Female', '1942-04-12', 'Christianity', '087-8901234', '8080 Pine Ln, Village', 'user', '089-1234567', 'image1.jpg', 'lineuser047', 'WonderWhisper198', 'WonderWhisper198', '2019-04-14 20:48:00', '2019-05-14 20:48:00'),
('a_alexander', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Alexander', 'Patel', 'Alex', 'alexander.patel@example.com', 'Male', '1938-09-29', 'Buddhism', '088-9012345', '8181 Elm St, City', 'user', '090-2345678', 'image2.jpg', 'lineuser048', 'CosmicCrest198', 'CosmicCrest198', '2020-08-26 05:21:00', '2021-08-26 05:21:00'),
('a_amelia', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Amelia', 'Kim', 'Amy', 'amelia.kim@example.com', 'Female', '1932-12-05', 'Hinduism', '089-0123456', '8282 Cedar St, Town', 'user', '091-3456789', 'image1.jpg', 'lineuser049', 'RainbowRadiance198', 'RainbowRadiance198', '2019-10-30 13:54:00', '2019-11-30 13:54:00'),
('b_benjamin', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Benjamin', 'Martinez', 'Ben', 'benjamin.martinez@example.com', 'Male', '1927-11-17', 'Islam', '090-1234567', '8383 Oak Ave, Village', 'user', '092-4567890', 'image2.jpg', 'lineuser050', 'RadiantRipple198', 'RadiantRipple198', '2019-02-03 22:27:00', '2019-03-03 22:27:00'),
('e_emma', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Emma', 'Garcia', 'Em', 'emma.garcia@example.com', 'Female', '1921-08-02', 'Sikhism', '091-2345678', '8484 Maple Dr, City', 'user', '093-5678901', 'image1.jpg', 'lineuser051', 'SparkleSpire198', 'SparkleSpire198','2020-06-15 07:00:00', '2021-07-15 07:00:00'),
('Infinity Events', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Liam', 'Gupta', 'Lee', 'liam.gupta@example.com', 'Male', '1916-03-23', 'Judaism', '092-3456789', '8585 Pine Ln, Village', 'activityOwner', '094-6789012', 'image1.jpg', 'lineuser052', 'EnigmaEmbrace198', 'EnigmaEmbrace198', '2019-12-17 15:33:00', '2020-01-17 15:33:00');


INSERT INTO
    user (
        username,
        password,
        name,
        surName,
        nickName,
        email,
        gender,
        dateOfBirth,
        religion,
        telephoneNumber,
        address,
        role,
        emergencyPhoneNumber,
        profileImg,
        line,
        instagram,
        x,
        createTime,
        updateTime
    )
VALUES
('o_olivia', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Olivia', 'Wong', 'Liv', 'olivia.wong@example.com', 'Female', '1910-05-15', 'Christianity', '093-4567890', '8686 Elm St, City', 'user', '095-7890123', 'image2.jpg', 'lineuser053', 'DreamyDrift198','DreamyDrift198', '2020-04-30 00:06:00', '2021-05-30 00:06:00'),
('william123', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'William', 'Brown', 'Will', 'william.brown@example.com', 'Male', '1904-09-08', 'Buddhism', '094-5678901', '8787 Cedar St, Town', 'user', '096-8901234', 'image1.jpg', 'lineuser054', 'MysticMingle198','MysticMingle198', '2019-01-09 08:39:00', '2019-02-09 08:39:00'),
('ava456', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Ava', 'Kim', 'Avi', 'ava.kim@example.com', 'Female', '1899-01-19', 'Hinduism', '095-6789012', '8888 Oak Ave, Village', 'user', '097-9012345', 'image2.jpg', 'lineuser055', 'CelestialCraze198','CelestialCraze198', '2020-11-09 17:12:00', '2021-12-09 17:12:00'),
('noah789', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Noah', 'Garcia', 'Nono', 'noah.garcia@example.com', 'Male', '1893-10-27', 'Islam', '096-7890123', '8989 Maple Dr, City', 'user', '098-0123456', 'image1.jpg', 'lineuser056', 'EtherealEcho198','EtherealEcho198', '2019-05-22 01:45:00', '2019-06-22 01:45:00'),
('oliver012', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Oliver', 'Patel', 'Ollie', 'oliver.patel@example.com', 'Male', '1888-12-10', 'Christianity', '097-8901234', '9090 Pine Ln, Village', 'user', '099-1234567', 'image2.jpg', 'lineuser057', 'BlissfulBliss198','BlissfulBliss198', '2019-09-06 10:18:00', '2019-10-06 10:18:00'),
('charlotte345', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Charlotte', 'Kim', 'Char', 'charlotte.kim@example.com', 'Female', '1882-02-05', 'Buddhism', '098-9012345', '9191 Elm St, City', 'user', '080-2345678', 'image1.jpg', 'lineuser058', 'NovaNurture198','NovaNurture198', '2020-01-19 18:51:00', '2020-02-19 18:51:00'),
('elijah678', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Elijah', 'Martinez', 'Eli', 'elijah.martinez@example.com', 'Male', '1877-05-25', 'Hinduism', '099-0123456', '9292 Cedar St, Town', 'user', '081-3456789', 'image2.jpg', 'lineuser059', 'VibrantVortex198','VibrantVortex198', '2020-07-21 03:24:00', '2021-08-21 03:24:00'),
('Momentum Productions', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Mia', 'Garcia', 'Mi', 'mia.garcia@example.com', 'Female', '1872-07-12', 'Islam', '080-2345678', '9393 Oak Ave, Village', 'activityOwner', '082-4567890', 'image1.jpg', 'lineuser060', 'DreamyDelight198','DreamyDelight198', '2019-03-05 12:57:00', '2019-04-05 12:57:00'),
('sophia234', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Sophia', 'Wong', 'Sophy', 'sophia.wong@example.com', 'Female', '1861-11-16', 'Judaism', '082-4567890', '9595 Pine Ln, Village', 'user', '084-6789012', 'image2.jpg', 'lineuser061', 'EnchantedEssence198','EnchantedEssence198', '2020-09-29 21:30:00', '2021-10-29 21:30:00'),
('benjamin567', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Benjamin', 'Brown', 'Ben', 'benjamin.brown@example.com', 'Male', '1857-03-01', 'Christianity', '083-5678901', '9696 Elm St, City', 'user', '085-7890123', 'image1.jpg', 'lineuser062', 'PrismParadise198','PrismParadise198', '2019-11-11 06:03:00', '2019-12-11 06:03:00'),
('olivia890', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Olivia', 'Kim', 'Liv', 'olivia.kim@example.com', 'Female', '1852-04-18', 'Buddhism', '084-6789012', '9797 Cedar St, Town', 'user', '086-8901234', 'image2.jpg', 'lineuser063', 'WonderWhisper198','WonderWhisper198', '2019-07-25 14:36:00', '2019-08-25 14:36:00'),
('liam123', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Liam', 'Garcia', 'Lee', 'liam.garcia@example.com', 'Male', '1847-06-05', 'Hinduism', '085-7890123', '9898 Oak Ave, Village', 'user', '087-9012345', 'image1.jpg', 'lineuser064', 'CelestialCelebrate198','CelestialCelebrate198', '2020-12-22 23:09:00', '2021-12-22 23:09:00'),
('ava456', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Ava', 'Martinez', 'Avi', 'ava.martinez@example.com', 'Female', '1842-08-20', 'Islam', '086-8901234', '9999 Maple Dr, City', 'user', '088-0123456', 'image2.jpg', 'lineuser065', 'GleamGlide198','GleamGlide198', '2019-04-28 12:22:00', '2019-05-28 12:22:00'),
('oliver012', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Oliver', 'Nguyen', 'Ollie', 'oliver.nguyen@example.com', 'Male', '1837-10-12', 'Christianity', '087-9012345', '10000 Pine Ln, Village', 'user', '089-1234567', 'image1.jpg', 'lineuser066', 'RadiantRhapsody198','RadiantRhapsody198', '2020-06-10 07:59:00', '2021-06-10 07:59:00'),
('emma345', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Emma', 'Patel', 'Em', 'emma.patel@example.com', 'Female', '1832-12-15', 'Buddhism', '088-0123456', '10101 Elm St, City', 'user', '080-3456789', 'image2.jpg', 'lineuser067', 'DreamyDawn198','DreamyDawn198', '2019-02-12 15:36:00', '2019-02-12 15:36:00'),
('william678', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'William', 'Rodriguez', 'Will', 'william.rodriguez@example.com', 'Male', '1827-04-28', 'Hinduism', '089-1234567', '10202 Cedar St, Town', 'user', '081-4567890', 'image1.jpg', 'lineuser068', 'MysticMagic198','MysticMagic198', '2019-08-25 00:09:00', '2019-08-25 00:09:00'),
('ava901', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Ava', 'Kim', 'Avi', 'ava.kim@example.com', 'Female', '1822-06-20', 'Islam', '090-2345678', '10303 Oak Ave, Village', 'user', '082-5678901', 'image1.jpg', 'lineuser069', 'BlissfulBlaze198','BlissfulBlaze198', '2020-10-27 08:42:00', '2021-10-27 08:42:00'),
('noah234', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Noah', 'Martinez', 'No', 'noah.martinez@example.com', 'Male', '1817-08-14', 'Sikhism', '091-3456789', '10404 Maple Dr, City', 'user', '083-6789012', 'image2.jpg', 'lineuser070', 'VibrantVibes198','VibrantVibes198', '2019-12-20 17:15:00', '2019-12-20 17:15:00'),
('sophia567', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Sophia', 'Garcia', 'Sophy', 'sophia.garcia@example.com', 'Female', '1812-10-25', 'Judaism', '092-4567890', '10505 Pine Ln, Village', 'user', '084-7890123', 'image1.jpg', 'lineuser071', 'CelestialCharm198','CelestialCharm198', '2020-04-12 01:48:00', '2021-04-12 01:48:00'),
('benjamin890', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Benjamin', 'Gupta', 'Ben', 'benjamin.gupta@example.com', 'Male', '1807-12-30', 'Christianity', '093-5678901', '10606 Elm St, City', 'user', '085-8901234', 'image2.jpg', 'lineuser072', 'EtherealElation198','EtherealElation198', '2019-01-25 10:21:00', '2019-02-25 10:21:00');

INSERT INTO
    user (
        username,
        password,
        name,
        surName,
        nickName,
        email,
        gender,
        dateOfBirth,
        religion,
        telephoneNumber,
        address,
        role,
        emergencyPhoneNumber,
        profileImg,
        line,
        instagram,
        x,
        createTime,
        updateTime
    )
VALUES
('olivia123', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Olivia', 'Wong', 'Liv', 'olivia.wong@example.com', 'Female', '1803-02-02', 'Buddhism', '094-6789012', '10707 Cedar St, Town', 'user', '086-9012345', 'image1.jpg', 'lineuser073', 'DreamyDazzle198','DreamyDazzle198', '2019-11-05 18:54:00', '2019-12-05 18:54:00'),
('liam456', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Liam', 'Brown', 'Lee', 'liam.brown@example.com', 'Male', '1798-04-05', 'Hinduism', '095-7890123', '10808 Oak Ave, Village', 'user', '087-0123456', 'image2.jpg', 'lineuser074', 'EnchantedEcho198','EnchantedEcho198', '2020-03-19 03:27:00', '2020-04-19 03:27:00'),
('ava789', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Ava', 'Kim', 'Avi', 'ava.kim@example.com', 'Female', '1793-06-10', 'Islam', '096-8901234', '10909 Maple Dr, City', 'user', '088-1234567', 'image1.jpg', 'lineuser075', 'WhisperWhiz198','WhisperWhiz198', '2019-07-02 12:00:00', '2019-08-02 12:00:00'),
('oliver012', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Oliver', 'Patel', 'Ollie', 'oliver.patel@example.com', 'Male', '1788-10-12', 'Christianity', '097-9012345', '11010 Pine Ln, Village', 'user', '089-2345678', 'image2.jpg', 'lineuser076', 'NovaNurture198','NovaNurture198', '2019-03-09 20:33:00', '2019-04-09 20:33:00'),
('emma345', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Emma', 'Nguyen', 'Em', 'emma.nguyen@example.com', 'Female', '1783-12-15', 'Buddhism', '098-0123456', '11111 Elm St, City', 'user', '090-3456789', 'image1.jpg', 'lineuser077', 'GleamGrove198','GleamGrove198', '2020-11-10 06:06:00', '2021-12-10 06:06:00'),
('william678', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'William', 'Rodriguez', 'Will', 'william.rodriguez@example.com', 'Male', '1778-04-28', 'Hinduism', '099-1234567', '11212 Cedar St, Town', 'user', '091-4567890', 'image2.jpg', 'lineuser078', 'RadiantRadiance198','RadiantRadiance198', '2020-09-14 14:39:00', '2021-10-14 14:39:00'),
('ava001', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Ava', 'Kim', 'Avi', 'ava.kim@example.com', 'Female', '1773-06-20', 'Islam', '080-2345678', '11313 Oak Ave, Village', 'user', '092-5678901', 'image1.jpg', 'lineuser079', 'SparkleSpectrum198','SparkleSpectrum198', '2019-05-17 23:12:00', '2019-06-17 23:12:00'),
('noah002', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Noah', 'Martinez', 'No', 'noah.martinez@example.com', 'Male', '1768-08-14', 'Sikhism', '081-3456789', '11414 Maple Dr, City', 'user', '093-6789012', 'image2.jpg', 'lineuser080', 'DreamyDrift198','DreamyDrift198', '2020-01-31 07:45:00', '2021-02-28 07:45:00'),
('sophia003', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Sophia', 'Garcia', 'Sophy', 'sophia.garcia@example.com', 'Female', '1763-10-25', 'Judaism', '082-4567890', '11515 Pine Ln, Village', 'user', '094-7890123', 'image1.jpg', 'lineuser081', 'CelestialCascade198','CelestialCascade198', '2020-07-04 16:18:00', '2021-08-15 14:27:00'),
('benjamin004', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Benjamin', 'Gupta', 'Ben', 'benjamin.gupta@example.com', 'Male', '1758-12-30', 'Christianity', '083-5678901', '11616 Elm St, City', 'user', '095-8901234', 'image2.jpg', 'lineuser082', 'EtherealEclipse198','EtherealEclipse198', '2019-09-08 00:51:00', '2019-11-06 23:00:00'),
('olivia005', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Olivia', 'Wong', 'Liv', 'olivia.wong@example.com', 'Female', '1754-02-02', 'Buddhism', '084-6789012', '11717 Cedar St, Town', 'user', '083-4567890', 'image1.jpg', 'lineuser083', 'BlissfulBurst198','BlissfulBurst198', '2019-06-17 09:24:00', '2020-03-19 07:33:00'),
('liam006', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Liam', 'Brown', 'Lee', 'liam.brown@example.com', 'Male', '1749-04-05', 'Hinduism', '085-7890123', '11818 Oak Ave, Village', 'user', '084-5678901', 'image2.jpg', 'lineuser084', 'NovaNexus198','NovaNexus198', '2020-02-20 17:57:00', '2019-07-03 16:06:00'),
('ava007', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Ava', 'Kim', 'Avi', 'ava.kim@example.com', 'Female', '1744-06-10', 'Islam', '086-8901234', '11919 Maple Dr, City', 'activityOwner', '085-6789012', 'image1.jpg', 'lineuser085', 'VibrantVista198','VibrantVista198', '2019-10-24 02:30:00', '2019-03-15 00:09:00'),
('oliver008', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Oliver', 'Patel', 'Ollie', 'oliver.patel@example.com', 'Male', '1738-10-12', 'Christianity', '087-9012345', '12020 Pine Ln, Village', 'user', '086-7890123', 'image1.jpg', 'lineuser086','WonderWhisper198', 'WonderWhisper198', '2019-04-02 11:03:00', '2021-12-16 13:42:00'),
('emma009', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Emma', 'Nguyen', 'Em', 'emma.nguyen@example.com', 'Female', '1733-12-15', 'Buddhism', '088-0123456', '12121 Elm St, City', 'user', '087-8901234', 'image2.jpg', 'lineuser087', 'MysticMarvel198','MysticMarvel198', '2020-08-15 19:36:00', '2019-06-25 22:15:00'),
('william010', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'William', 'Rodriguez', 'Will', 'william.rodriguez@example.com', 'Male', '1728-04-28', 'Hinduism', '089-1234567', '12222 Cedar St, Town', 'user', '088-9012345', 'image1.jpg', 'lineuser088', 'CelestialCharm198','CelestialCharm198', '2019-12-29 04:09:00', '2020-01-06 06:48:00'),
('ava011', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Ava', 'Kim', 'Avi', 'ava.kim@example.com', 'Female', '1723-06-20', 'Islam', '080-3456789', '12323 Oak Ave, Village', 'user', '089-0123456', 'image2.jpg', 'lineuser089', 'RadiantRipple198','RadiantRipple198', '2020-06-30 12:42:00', '2020-07-09 15:21:00'),
('noah012', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Noah', 'Martinez', 'No', 'noah.martinez@example.com', 'Male', '1718-08-14', 'Sikhism', '081-4567890', '12424 Maple Dr, City', 'user', '090-1234567', 'image1.jpg', 'lineuser090', 'EnigmaEcho198','EnigmaEcho198', '2019-02-04 21:15:00', '2019-10-13 00:54:00'),
('sophia013', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Sophia', 'Garcia', 'Sophy', 'sophia.garcia@example.com', 'Female', '1713-10-25', 'Judaism', '082-5678901', '12525 Pine Ln, Village', 'user', '091-2345678', 'image2.jpg', 'lineuser091', 'DreamyDazzle198','DreamyDazzle198', '2019-08-18 05:48:00', '2019-07-21 09:27:00'),
('benjamin014', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Benjamin', 'Gupta', 'Ben', 'benjamin.gupta@example.com', 'Male', '1708-12-30', 'Christianity', '083-6789012', '12626 Elm St, City', 'user', '092-3456789', 'image1.jpg', 'lineuser092', 'BlissfulBlaze198','BlissfulBlaze198', '2020-10-11 14:21:00', '2021-03-25 18:00:00');

INSERT INTO
    user (
        username,
        password,
        name,
        surName,
        nickName,
        email,
        gender,
        dateOfBirth,
        religion,
        telephoneNumber,
        address,
        role,
        emergencyPhoneNumber,
        profileImg,
        line,
        instagram,
        x,
        createTime,
        updateTime
    )
VALUES
('olivia015', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Olivia', 'Wong', 'Liv', 'olivia.wong@example.com', 'Female', '1704-02-02', 'Buddhism', '084-7890123', '12727 Cedar St, Town', 'activityOwner', '093-4567890', 'image2.jpg', 'lineuser093', 'CosmicCraze198','CosmicCraze198', '2019-01-14 23:54:00', '2019-12-03 03:33:00'),
('liam016', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Liam', 'Brown', 'Lee', 'liam.brown@example.com', 'Male', '1699-04-05', 'Hinduism', '085-8901234', '12828 Oak Ave, Village', 'user', '094-5678901', 'image1.jpg', 'lineuser094', 'VibrantVoyage198','VibrantVoyage198', '2019-11-25 08:27:00', '2020-05-27 12:06:00'),
('ava017', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Ava', 'Kim', 'Avi', 'ava.kim@example.com', 'Female', '1694-06-10', 'Islam', '086-9012345', '12929 Maple Dr, City', 'user', '095-6789012', 'image2.jpg', 'lineuser095', 'NovaNurture198','NovaNurture198', '2020-03-29 17:00:00', '2019-02-09 18:39:00'),
('alice018', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Alice', 'Smith', 'Ally', 'alice.smith@example.com', 'Female', '2002-05-17', 'Christianity', '087-0123456', '123 Main St, City', 'user', '096-7890123', 'image1.jpg', 'lineuser096', 'GleamGlimmer198','GleamGlimmer198', '2019-07-12 01:33:00', '2021-12-08 01:12:00'),
('muhammad019', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Muhammad', 'Khan', 'Momo', 'muhammad.khan@example.com', 'Male', '1996-10-03', 'Islam', '088-1234567', '456 Elm St, Town', 'user', '097-8901234', 'image2.jpg', 'lineuser097', 'CelestialCherish198','CelestialCherish198', '2019-03-15 10:06:00', '2019-06-22 07:45:00'),
('priya020', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Priya', 'Patel', 'Pri', 'priya.patel@example.com', 'Female', '2000-08-22', 'Hinduism', '089-2345678', '789 Oak St, Village', 'user', '098-9012345', 'image1.jpg', 'lineuser098', 'MysticMingle198','MysticMingle198', '2020-11-16 18:39:00', '2019-09-05 16:18:00'),
('wei021', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Wei', 'Chen', 'Wei Wei', 'wei.chen@example.com', 'Rather not say', '1988-03-11', 'Buddhism', '090-3456789', '101 Pine St, Suburb', 'user', '099-0123456', 'image2.jpg', 'lineuser099', 'EtherealEssence198','EtherealEssence198', '2020-09-20 03:12:00', '2021-11-17 00:51:00'),
('amarjeet022', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Amarjeet', 'Singh', 'Amar', 'amarjeet.singh@example.com', 'Male', '1975-12-07', 'Sikhism', '091-4567890', '234 Cedar St, District', 'user', '080-1234567', 'image1.jpg', 'lineuser100', 'DreamyDaze198','DreamyDaze198', '2019-05-24 11:45:00', '2020-01-20 09:24:00'),
('rachel023', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Rachel', 'Cohen', 'Rachie', 'rachel.cohen@example.com', 'Female', '1956-07-29', 'Judaism', '092-5678901', '567 Maple St, Province', 'user', '081-2345678', 'image2.jpg', 'lineuser101', 'RadiantRipple198','RadiantRipple198', '2020-01-05 20:18:00', '2021-05-02 17:57:00'),
('david024', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'David', 'Johnson', 'Dave', 'david.johnson@example.com', 'Male', '1949-02-14', 'Christianity', '093-6789012', '890 Walnut St, County', 'user', '082-3456789', 'image1.jpg', 'lineuser102', 'SparkleShine198','SparkleShine198', '2020-07-08 04:51:00', '2019-03-08 02:30:00'),
('aisha025', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Aisha', 'Ali', 'Ash', 'aisha.ali@example.com', 'Female', '1985-11-03', 'Islam', '094-7890123', '012 Birch St, State', 'user', '083-4567890', 'image1.jpg', 'lineuser103', 'NovaNurture198','NovaNurture198', '2019-09-12 13:24:00', '2021-08-25 11:03:00'),
('vikram026', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Vikram', 'Sharma', 'Vicky', 'vikram.sharma@example.com', 'Male', '1978-09-18', 'Hinduism', '095-8901234', '345 Sycamore St, Region', 'user', '084-5678901', 'image2.jpg', 'lineuser104', 'GleamGlow198','GleamGlow198', '2019-06-21 21:57:00', '2019-10-29 19:36:00'),
('mei027', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Mei', 'Wong', 'Mei Mei', 'mei.wong@example.com', 'Female', '1967-04-26', 'Buddhism', '096-9012345', '678 Cedar St, Area', 'user', '085-6789012', 'image1.jpg', 'lineuser105', 'BlissfulBloom198','BlissfulBloom198', '2020-02-25 06:30:00', '2019-07-08 08:09:00'),
('john028', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'John', 'Smith', 'Jsmith', 'jsmith@example.com', 'Male', '1990-05-15', 'Christianity', '097-0123456', '123 Main St', 'user', '086-7890123', 'image2.jpg', 'lineuser106', 'CelestialCharm198','CelestialCharm198', '2019-11-02 15:03:00', '2021-03-10 13:42:00'),
('emma029', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Emma', 'Johnson', 'EJ', 'emmaj@example.com', 'Female', '2002-09-22', 'Buddhism', '098-1234567', '456 Elm St', 'user', '084-6789012', 'image1.jpg', 'lineuser107', 'MysticMarvel198','MysticMarvel198', '2020-04-26 23:36:00', '2019-11-15 20:15:00'),
('ahmed030', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Ahmed', 'Khan', 'AK', 'ahmedk@example.com', 'Male', '1975-11-30', 'Islam', '099-2345678', '789 Oak St', 'user', '085-7890123', 'image2.jpg', 'lineuser108', 'VibrantVibes198','VibrantVibes198', '2019-01-09 08:09:00', '2020-07-18 01:48:00'),
('priya031', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Priya', 'Patel', 'Priya', 'priyap@example.com', 'Female', '1988-03-10', 'Hinduism', '080-3456789', '101 Pine St', 'user', '086-8901234', 'image1.jpg', 'lineuser109', 'WonderWhisper198','WonderWhisper198', '2020-11-08 16:42:00', '2019-05-27 07:21:00'),
('david032', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'David', 'Lee', 'Dlee', 'davidl@example.com', 'Rather not say', '1956-07-05', 'Christianity', '081-4567890', '202 Maple St', 'user', '084-7890123', 'image2.jpg', 'lineuser110', 'EtherealEmbrace198','EtherealEmbrace198', '2019-05-22 01:15:00', '2020-02-08 13:54:00'),
('wei033', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Wei', 'Wang', 'WW', 'wei.wang@example.com', 'LGBTQ+', '1998-12-18', 'Buddhism', '082-5678901', '303 Cedar St', 'user', '085-8901234', 'image1.jpg', 'lineuser111', 'DreamyDrift198','DreamyDrift198', '2019-08-04 09:48:00', '2021-08-11 22:27:00'),
('sarah034', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Sarah', 'Cohen', 'SarahC', 'sarah.c@example.com', 'Female', '2005-04-02', 'Judaism', '083-6789012', '404 Birch St', 'user', '086-9012345', 'image2.jpg', 'lineuser112', 'RadiantRipple198','RadiantRipple198', '2020-10-17 18:21:00', '2019-10-16 04:00:00');

INSERT INTO
    user (
        username,
        password,
        name,
        surName,
        nickName,
        email,
        gender,
        dateOfBirth,
        religion,
        telephoneNumber,
        address,
        role,
        emergencyPhoneNumber,
        profileImg,
        line,
        instagram,
        x,
        createTime,
        updateTime
    )
VALUES
('muhammad035', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Muhammad', 'Ali', 'MAli', 'malim@example.com', 'Male', '1978-09-14', 'Islam', '084-7890123', '505 Spruce St', 'user', '087-0123456', 'image1.jpg', 'lineuser113', 'NovaNebula198','NovaNebula198', '2019-12-20 02:54:00', '2019-12-07 10:33:00'),
('ananya036', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Ananya', 'Gupta', 'Ananya', 'ananyag@example.com', 'Female', '1993-08-25', 'Hinduism', '085-8901234', '606 Oakwood St', 'user', '088-1234567', 'image2.jpg', 'lineuser114', 'GleamGlide198','GleamGlide198', '2020-04-01 11:27:00', '2020-05-20 19:06:00'),
('ethan037', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Ethan', 'Brown', 'EBrown', 'ethan.b@example.com', 'Male', '1963-02-12', 'Christianity', '086-9012345', '707 Elmwood St', 'user', '089-2345678', 'image1.jpg', 'lineuser115', 'CelestialCharm198','CelestialCharm198', '2019-02-06 20:00:00', '2019-03-20 00:39:00'),
('emily038', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Emily', 'Anderson', 'EmiA', 'emily.and@example.com', 'Female', '1997-06-08', 'Christianity', '087-0123456', '808 Willow St', 'user', '080-1234567', 'image2.jpg', 'lineuser116', 'MysticMagic198','MysticMagic198', '2020-07-25 04:33:00', '2021-09-03 07:12:00'),
('amir039', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Amir', 'Rahman', 'ARahman', 'amir.rah@example.com', 'Male', '1985-11-17', 'Islam', '088-1234567', '909 Magnolia St', 'user', '081-2345678', 'image1.jpg', 'lineuser117', 'VibrantVoyage198','VibrantVoyage198', '2019-09-28 13:06:00', '2019-11-07 14:45:00'),
('aarav040', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Aarav', 'Singh', 'AaravS', 'aarav.s@example.com', 'Rather not say', '2003-03-25', 'Sikhism', '089-2345678', '1010 Pinehurst St', 'user', '082-3456789', 'image2.jpg', 'lineuser118', 'DreamyDusk198','DreamyDusk198', '2019-06-07 21:39:00', '2019-06-18 23:18:00'),
('sofia041', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Sofia', 'Garcia', 'SGarcia', 'sofia.garc@example.com', 'Female', '1971-08-30', 'Christianity', '080-1234567', '1111 Oakridge St', 'user', '083-4567890', 'image1.jpg', 'lineuser119', 'RadiantRipple198','RadiantRipple198', '2020-02-10 06:12:00', '2021-05-02 17:57:00'),
('ali042', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Ali', 'Ahmed', 'AliAhmed', 'ali.ahmed@example.com', 'Male', '2000-12-14', 'Islam', '081-2345678', '1212 Maplewood St', 'user', '084-5678901', 'image1.jpg', 'lineuser120', 'SparkleSpectrum198','SparkleSpectrum198', '2019-10-15 14:45:00', '2021-08-04 12:24:00'),
('maya043', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Maya', 'Patel', 'MPatel', 'maya.patel@example.com', 'Female', '1969-04-19', 'Hinduism', '082-3456789', '1313 Brookside St', 'user', '085-6789012', 'image2.jpg', 'lineuser121', 'NovaNexus198','NovaNexus198', '2020-06-18 23:18:00', '2019-09-15 19:57:00'),
('jackson044', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Jackson', 'Wilson', 'JWilson', 'jackson.w@example.com', 'Male', '1979-10-03', 'Christianity', '083-4567890', '1414 Chestnut St', 'user', '086-7890123', 'image1.jpg', 'lineuser122', 'GleamGrove198','GleamGrove198', '2019-04-27 07:51:00', '2019-11-06 02:30:00'),
('aisha045', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Aisha', 'Khan', 'AishaK', 'aisha.khan@example.com', 'Female', '1983-07-27', 'Islam', '084-5678901', '1515 Park Ave', 'user', '081-4567890', 'image2.jpg', 'lineuser123', 'CelestialCharm198','CelestialCharm198', '2020-01-08 16:24:00', '2020-03-20 11:03:00'),
('lucas046', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Lucas', 'Nguyen', 'LNguyen', 'lucas.nguyen@example.com', 'Male', '2002-02-09', 'Buddhism', '085-6789012', '1616 Sunnyside St', 'user', '082-5678901', 'image1.jpg', 'lineuser124', 'MysticMingle198','MysticMingle198', '2020-07-11 00:57:00', '2019-07-03 20:36:00'),
('fatima047', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Fatima', 'Ali', 'FAli', 'fatima.ali@example.com', 'Female', '1976-12-05', 'Islam', '086-7890123', '1717 River Rd', 'user', '083-6789012', 'image2.jpg', 'lineuser125', 'EtherealEssence198','EtherealEssence198', '2019-09-15 09:30:00', '2019-03-16 06:09:00'),
('sofia048', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Sofia', 'Rodriguez', 'SRodriguez', 'sofia.rodr@example.com', 'Female', '1988-05-22', 'Christianity', '087-8901234', '1818 Willowbrook St', 'user', '084-7890123', 'image1.jpg', 'lineuser126','lineuser126', 'DreamyDelight198', '2019-12-06 18:03:00', '2022-01-16 13:42:00'),
('leo049', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Leo', 'Martinez', 'LeoM', 'leo.martinez@example.com', 'Male', '1999-08-18', 'Christianity', '088-9012345', '1919 Ridge Ave', 'user', '085-8901234', 'image2.jpg', 'lineuser127', 'RadiantRipple198','RadiantRipple198', '2020-04-19 02:36:00', '2019-06-25 22:15:00'),
('aria050', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Aria', 'Gupta', 'AriaG', 'aria.gupta@example.com', 'Female', '2001-11-11', 'Hinduism', '089-0123456', '2020 Elmwood Ave', 'user', '086-9012345', 'image1.jpg', 'lineuser128', 'BlissfulBlaze198','BlissfulBlaze198', '2019-02-20 11:09:00', '2020-01-06 06:48:00'),
('muhammad001', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Muhammad', 'Khan', 'MKhan', 'muhammad.k@example.com', 'Male', '1974-03-01', 'Islam', '090-1234567', '2121 Oak Hill Dr', 'user', '087-0123456', 'image2.jpg', 'lineuser129', 'CelestialCascade198','CelestialCascade198', '2020-08-03 19:42:00', '2020-07-09 15:21:00'),
('ava002', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Ava', 'Brown', 'ABrown', 'ava.brown@example.com', 'Female', '1973-09-12', 'Christianity', '091-2345678', '2222 Maple Lane', 'user', '088-1234567', 'image1.jpg', 'lineuser130', 'NovaNurture198','NovaNurture198', '2019-10-06 04:15:00', '2019-10-13 00:54:00'),
('liam003', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Liam', 'Wilson', 'LiamW', 'liam.wilson@example.com', 'Male', '2004-02-27', 'Christianity', '092-3456789', '2323 Cherry St', 'user', '089-2345678', 'image2.jpg', 'lineuser131', 'VibrantVista198','VibrantVista198', '2019-05-17 12:48:00', '2019-07-21 09:27:00'),
('zoe004', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Zoe', 'Lee', 'ZoeL', 'zoe.lee@example.com', 'Female', '1995-07-14', 'Buddhism', '093-4567890', '2424 Laurel Dr', 'user', '080-1234567', 'image1.jpg', 'lineuser132', 'WonderWhisper198','WonderWhisper198', '2020-01-29 21:21:00', '2021-03-25 18:00:00');

INSERT INTO
    user (
        username,
        password,
        name,
        surName,
        nickName,
        email,
        gender,
        dateOfBirth,
        religion,
        telephoneNumber,
        address,
        role,
        emergencyPhoneNumber,
        profileImg,
        line,
        instagram,
        x,
        createTime,
        updateTime
    )
VALUES
('noah005', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Noah', 'Smith', 'NoahS', 'noah.smith@example.com', 'Male', '1982-04-08', 'Christianity', '094-5678901', '2525 Pine Lane', 'user', '093-4567890', 'image2.jpg', 'lineuser133', 'MysticMarvel198','MysticMarvel198', '2020-07-03 05:54:00', '2019-12-03 03:33:00'),
('olivia006', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Olivia', 'Patel', 'OPatel', 'olivia.patel@example.com', 'Female', '1987-10-29', 'Hinduism', '095-6789012', '2626 Cedar Dr', 'user', '094-5678901', 'image1.jpg', 'lineuser134', 'CelestialCharm198','CelestialCharm198', '2019-08-15 14:27:00', '2020-05-27 12:06:00'),
('ethan007', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Ethan', 'Brown', 'EBrown', 'ethan.b@example.com', 'Male', '1955-01-23', 'Christianity', '096-7890123', '2727 Elm St', 'user', '083-4567890', 'image2.jpg', 'lineuser135', 'RadiantRipple198','RadiantRipple198', '2019-11-05 23:00:00', '2019-02-09 18:39:00'),
('mia008', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Mia', 'Johnson', 'MiaJ', 'mia.johnson@example.com', 'Female', '1961-06-07', 'Christianity', '097-8901234', '2828 Oak Ave', 'user', '084-5678901', 'image1.jpg', 'lineuser136', 'DreamyDazzle198','DreamyDazzle198', '2020-03-19 07:33:00', '2021-12-08 01:12:00'),
('lucas009', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Lucas', 'Garcia', 'LGarcia', 'lucas.garc@example.com', 'Male', '1950-12-14', 'Christianity', '098-9012345', '2929 Walnut Dr', 'user', '085-6789012', 'image1.jpg', 'lineuser137', 'BlissfulBlaze198','BlissfulBlaze198', '2019-07-02 16:06:00', '2019-06-22 07:45:00'),
('isabella010', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Isabella', 'Nguyen', 'IsabN', 'isabella.nguyen@example.com', 'Female', '1953-08-21', 'Buddhism', '099-0123456', '3030 Maple Rd', 'user', '086-7890123', 'image2.jpg', 'lineuser138', 'CosmicCraze198','CosmicCraze198', '2019-03-15 00:09:00', '2019-09-05 16:18:00'),
('liam011', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Liam', 'Rodriguez', 'LRodriguez', 'liam.rodr@example.com', 'Male', '1970-05-18', 'Christianity', '080-1234567', '3131 Pine Dr', 'user', '087-8901234', 'image1.jpg', 'lineuser139', 'VibrantVoyage198','VibrantVoyage198', '2020-11-16 08:42:00', '2021-11-17 00:51:00'),
('sophia012', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Sophia', 'Martinez', 'SophiaM', 'sophia.m@example.com', 'Female', '1955-01-23', 'Christianity', '081-2345678', '1212 Meadow Ln', 'user', '088-9012345', 'image2.jpg', 'lineuser140', 'NovaNurture198','NovaNurture198', '2019-05-24 17:15:00', '2020-01-20 09:24:00'),
('michael013', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Michael', 'Nguyen', 'MikeN', 'michael.nguyen@example.com', 'Male', '1999-08-03', 'Christianity', '082-3456789', '808 Lakeview Dr', 'user', '095-6789012', 'image1.jpg', 'lineuser141', 'GleamGlimmer198','GleamGlimmer198', '2020-01-05 01:48:00', '2021-05-02 17:57:00'),
('sophia014', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Sophia', 'Kim', 'Soph', 'sophia.kim@example.com', 'Female', '2001-12-10', 'Buddhism', '083-4567890', '909 Forest Ave', 'user', '096-7890123', 'image2.jpg', 'lineuser142', 'CelestialCherish198','CelestialCherish198', '2020-07-08 10:21:00', '2019-03-08 02:30:00'),
('aisha015', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Aisha', 'Rahman', 'ARahman', 'aisha.rahman@example.com', 'Female', '1985-06-18', 'Islam', '084-5678901', '1010 Park Blvd', 'user', '097-8901234', 'image1.jpg', 'lineuser143', 'MysticMingle198','MysticMingle198', '2019-09-12 18:54:00', '2021-08-25 11:03:00'),
('arjun016', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Arjun', 'Sharma', 'ArjunS', 'arjun.sharma@example.com', 'Male', '1973-04-25', 'Hinduism', '085-6789012', '1111 Grove St', 'user', '098-9012345', 'image2.jpg', 'lineuser144', 'EtherealEssence198','EtherealEssence198', '2019-06-21 03:27:00', '2019-10-29 19:36:00'),
('rachel017', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Rachel', 'Cohen', 'RCo', 'rachel.cohen@example.com', 'Female', '1967-10-08', 'Judaism', '086-7890123', '1212 Meadow Ln', 'user', '080-3456789', 'image1.jpg', 'lineuser145', 'DreamyDaze198','DreamyDaze198', '2020-02-25 12:00:00', '2019-07-08 08:09:00'),
('muhammad018', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Muhammad', 'Patel', 'MPatel', 'muhammad.p@example.com', 'Male', '1958-11-15', 'Islam', '087-8901234', '1313 Sunset Blvd', 'user', '081-4567890', 'image2.jpg', 'lineuser146', 'RadiantRipple198','RadiantRipple198', '2019-11-02 20:33:00', '2021-03-10 13:42:00'),
('priya019', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Priya', 'Gupta', 'PGupta', 'priya.g@example.com', 'Female', '1979-07-23', 'Hinduism', '088-9012345', '1414 Sunrise Ave', 'user', '082-5678901', 'image1.jpg', 'lineuser147', 'SparkleShine198','SparkleShine198', '2020-04-26 06:06:00', '2019-11-15 20:15:00'),
('noah020', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Noah', 'Lee', 'NoahL', 'noah.lee@example.com', 'Rather not say', '1946-03-29', 'Christianity', '081-2345678', '1515 Mountain Rd', 'user', '083-6789012', 'image2.jpg', 'lineuser148', 'NovaNurture198','NovaNurture198', '2019-01-09 13:39:00', '2020-07-18 01:48:00'),
('ava021', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Ava', 'Patel', 'AvaP', 'ava.p@example.com', 'Female', '1996-09-01', 'Buddhism', '082-3456789', '1616 River Dr', 'user', '084-7890123', 'image1.jpg', 'lineuser149', 'GleamGlow198','GleamGlow198', '2020-11-08 19:12:00', '2019-05-27 07:21:00'),
('ali022', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Ali', 'Singh', 'AliS', 'ali.s@example.com', 'Rather not say', '1951-05-14', 'Sikhism', '083-4567890', '1717 Ocean Ave', 'user', '085-8901234', 'image2.jpg', 'lineuser150', 'BlissfulBloom198','BlissfulBloom198', '2019-05-22 00:45:00', '2020-02-08 13:54:00'),
('olivia023', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Olivia', 'Chen', 'OliviaC', 'olivia.chen@example.com', 'Female', '1984-12-07', 'Buddhism', '084-5678901', '1818 Lake St', 'user', '086-9012345', 'image1.jpg', 'lineuser151', 'CelestialCharm198','CelestialCharm198', '2019-08-04 06:18:00', '2021-08-11 22:27:00'),
('liam024', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Liam', 'Kim', 'LiamK', 'liam.k@example.com', 'Male', '1994-02-20', 'Christianity', '085-6789012', '1919 Hillside Dr', 'user', '087-0123456', 'image2.jpg', 'lineuser152', 'MysticMarvel198','MysticMarvel198', '2020-10-17 12:51:00', '2019-10-16 04:00:00');

INSERT INTO
    user (
        username,
        password,
        name,
        surName,
        nickName,
        email,
        gender,
        dateOfBirth,
        religion,
        telephoneNumber,
        address,
        role,
        emergencyPhoneNumber,
        profileImg,
        line,
        instagram,
        x,
        createTime,
        updateTime
    )
VALUES
('emma025', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Emma', 'Yamamoto', 'EmmaY', 'emma.y@example.com', 'LGBTQ+', '1970-08-11', 'Buddhism', '086-7890123', '2020 Hillcrest Dr', 'user', '088-1234567', 'image1.jpg', 'lineuser153', 'VibrantVibes198','VibrantVibes198', '2019-12-20 21:24:00', '2019-12-07 10:33:00'),
('sophia026', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Sophia', 'Tan', 'SophiaT', 'sophia.t@example.com', 'Female', '1998-06-17', 'Christianity', '087-8901234', '2121 Highland Rd', 'user', '089-2345678', 'image1.jpg', 'lineuser154', 'WonderWhisper198','WonderWhisper198', '2020-04-01 03:57:00', '2020-05-20 19:06:00'),
('ethan027', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Ethan', 'Wong', 'EthanW', 'ethan.w@example.com', 'Male', '1989-04-03', 'Christianity', '088-9012345', '2222 Highland Ave', 'user', '090-3456789', 'image2.jpg', 'lineuser155', 'EtherealEmbrace198', 'EtherealEmbrace198','2019-02-06 10:30:00', '2019-03-20 00:39:00'),
('mia028', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Mia', 'Patel', 'MiaP', 'mia.p@example.com', 'Female', '2004-11-26', 'Hinduism', '089-0123456', '2323 Maplewood Ln', 'user', '091-4567890', 'image1.jpg', 'lineuser156', 'DreamyDrift198', 'DreamyDrift198','2020-07-25 18:03:00', '2021-09-03 07:12:00'),
('elijah029', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Elijah', 'Kim', 'ElijahK', 'elijah.k@example.com', 'Rather not say', '1959-07-02', 'Christianity', '090-1234567', '2424 Oakwood Dr', 'user', '092-5678901', 'image2.jpg', 'lineuser157', 'RadiantRipple198','RadiantRipple198','2019-09-28 01:36:00', '2019-11-07 14:45:00'),
('charlotte030', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Charlotte', 'Nguyen', 'CharlotteN', 'charlotte.n@example.com', 'Female', '2000-03-15', 'Christianity', '091-2345678', '2525 Pine St', 'user', '093-6789012', 'image1.jpg', 'lineuser158', 'NovaNebula198','NovaNebula198', '2019-06-07 08:09:00', '2019-06-18 23:18:00'),
('daniel031', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Daniel', 'Li', 'DanLi', 'daniel.li@example.com', 'Male', '1976-09-09', 'Buddhism', '092-3456789', '2626 Pine Ave', 'user', '094-7890123', 'image2.jpg', 'lineuser159', 'GleamGlide198','GleamGlide198','2020-02-10 13:42:00', '2021-05-02 17:57:00'),
('james037', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'James', 'Patel', 'JamesP', 'james.p@example.com', 'Male', '1977-04-04', 'Christianity', '098-9012345', '3232 Maple Blvd', 'user', '080-3456789', 'image2.jpg', 'lineuser165', 'SparkleSpectrum198','SparkleSpectrum198', '2019-09-15 04:00:00', '2019-03-16 06:09:00'),
('emma038', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Emma', 'Singh', 'EmmaS', 'emma.s@example.com', 'Female', '2003-09-08', 'Sikhism', '099-0123456', '3333 Pine St', 'user', '081-4567890', 'image1.jpg', 'lineuser166', 'NovaNexus198','NovaNexus198','2019-12-06 10:33:00', '2022-01-16 13:42:00'),
('ethan039', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Ethan', 'Tan', 'EthanT', 'ethan.t@example.com', 'Male', '1978-05-27', 'Buddhism', '080-2345678', '3434 Cedar Ln', 'user', '082-5678901', 'image2.jpg', 'lineuser167', 'GleamGrove198','GleamGrove198', '2020-04-19 19:06:00', '2019-06-25 22:15:00'),
('mia040', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Mia', 'Wong', 'MiaW', 'mia.w@example.com', 'Female', '1999-02-14', 'Christianity', '081-3456789', '3535 Elm Ave', 'user', '083-6789012', 'image1.jpg', 'lineuser168', 'CelestialCharm198','CelestialCharm198','2019-02-20 00:39:00', '2020-01-06 06:48:00'),
('noah041', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Noah', 'Kim', 'NoahK', 'noah.k@example.com', 'Rather not say', '1961-10-31', 'Christianity', '082-4567890', '3636 Maplewood Dr', 'user', '084-7890123', 'image2.jpg', 'lineuser169', 'MysticMingle198','MysticMingle198','2020-08-03 07:12:00', '2020-07-09 15:21:00'),
('ava042', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Ava', 'Patel', 'AvaP', 'ava.p@example.com', 'Female', '1982-07-16', 'Buddhism', '083-5678901', '3737 Oakwood Ave', 'user', '085-8901234', 'image1.jpg', 'lineuser170', 'EtherealEssence198','EtherealEssence198','2019-10-06 14:45:00', '2019-10-13 00:54:00'),
('liam043', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Liam', 'Thakur', 'LiamT', 'liam.t@example.com', 'Male', '1955-12-24', 'Hinduism', '084-6789012', '3838 Cedar St', 'user', '086-9012345', 'image1.jpg', 'lineuser171', 'DreamyDelight198','DreamyDelight198','2019-05-17 23:18:00', '2019-07-21 09:27:00'),
('olivia044', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Olivia', 'Gupta', 'OliviaG', 'olivia.g@example.com', 'Female', '1974-04-11', 'Hinduism', '085-7890123', '3939 Pine Blvd', 'user', '087-0123456', 'image2.jpg', 'lineuser172', 'RadiantRipple198','RadiantRipple198','2020-01-29 05:51:00', '2021-03-25 18:00:00'),
('elijah045', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Elijah', 'Patel', 'ElijahP', 'elijah.p@example.com', 'Rather not say', '1968-01-28', 'Christianity', '086-8901234', '4040 Oak Ave', 'user', '088-1234567', 'image1.jpg', 'lineuser173', 'BlissfulBlaze198','BlissfulBlaze198','2020-07-03 12:24:00', '2019-12-03 03:33:00'),
('charlotte046', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Charlotte', 'Kim', 'CharlotteK', 'charlotte.k@example.com', 'Female', '1995-06-05', 'Buddhism', '084-7890123', '4141 Maple Ln', 'user', '089-2345678', 'image2.jpg', 'lineuser174', 'CelestialCascade198','CelestialCascade198','2019-08-15 19:57:00', '2020-05-27 12:06:00'),
('william047', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'William', 'Singh', 'WilliamS', 'william.s@example.com', 'Rather not say', '1971-03-19', 'Sikhism', '085-8901234', '4242 Cedar Dr', 'user', '080-1234567', 'image1.jpg', 'lineuser175', 'NovaNurture198', 'NovaNurture198','2019-11-05 02:30:00', '2019-02-09 18:39:00'),
('harper048', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Harper', 'Tan', 'HarperT', 'harper.t@example.com', 'Female', '2000-08-12', 'Buddhism', '086-9012345', '4343 Elmwood St', 'user', '081-2345678', 'image2.jpg', 'lineuser176', 'VibrantVista198','VibrantVista198','2020-03-19 11:03:00', '2021-12-08 01:12:00'),
('alexander049', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Alexander', 'Wong', 'AlexW', 'alexander.w@example.com', 'Male', '1967-09-07', 'Christianity', '087-0123456', '4444 Oakwood Blvd', 'user', '082-3456789', 'image1.jpg', 'lineuser177', 'WonderWhisper198','WonderWhisper198', '2019-07-02 20:36:00', '2019-10-22 07:45:00');

INSERT INTO
    user (
        username,
        password,
        name,
        surName,
        nickName,
        email,
        gender,
        dateOfBirth,
        religion,
        telephoneNumber,
        address,
        role,
        emergencyPhoneNumber,
        profileImg,
        line,
        instagram,
        x,
        createTime,
        updateTime
    )
VALUES
('evelyn050', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Evelyn', 'Kim', 'EvelynK', 'evelyn.k@example.com', 'Female', '1988-07-23', 'Buddhism', '088-1234567', '4545 Pine Ave', 'user', '083-4567890', 'image2.jpg', 'lineuser178', 'MysticMarvel198','MysticMarvel198', '2019-03-15 06:09:00', '2019-09-05 16:18:00'),
('daniel051', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Daniel', 'Thakur', 'DanT', 'daniel.t@example.com', 'Male', '1979-12-10', 'Hinduism', '089-2345678', '4646 Cedar St', 'user', '084-5678901', 'image1.jpg', 'lineuser179', 'CelestialCharm198','CelestialCharm198', '2020-11-16 13:42:00', '2021-11-17 00:51:00'),
('mia052', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Mia', 'Gupta', 'MiaG', 'mia.g@example.com', 'Female', '1990-05-15', 'Hinduism', '080-1234567', '4747 Elm Ln', 'user', '085-6789012', 'image2.jpg', 'lineuser180', 'RadiantRipple198','RadiantRipple198', '2019-05-24 22:15:00', '2020-01-20 09:24:00'),
('james053', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'James', 'Patel', 'JamesP', 'james.p@example.com', 'Male', '1956-02-29', 'Christianity', '081-2345678', '4848 Oak Ave', 'user', '086-7890123', 'image1.jpg', 'lineuser181', 'DreamyDazzle198','DreamyDazzle198', '2020-01-05 06:48:00', '2021-05-02 17:57:00'),
('emma054', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Emma', 'Singh', 'EmmaS', 'emma.s@example.com', 'Female', '1978-08-03', 'Sikhism', '082-3456789', '4949 Cedar Dr', 'user', '087-8901234', 'image2.jpg', 'lineuser182', 'BlissfulBlaze198','BlissfulBlaze198', '2020-07-08 15:21:00', '2019-03-08 02:30:00'),
('ethan055', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Ethan', 'Tan', 'EthanT', 'ethan.t@example.com', 'Male', '1965-11-22', 'Buddhism', '083-4567890', '5050 Pine St', 'user', '088-9012345', 'image1.jpg', 'lineuser183', 'CosmicCraze198','CosmicCraze198', '2019-09-12 00:54:00', '2021-08-25 11:03:00'),
('mia056', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Mia', 'Wong', 'MiaW', 'mia.w@example.com', 'Female', '1977-07-19', 'Christianity', '084-5678901', '5151 Elm Ave', 'user', '089-0123456', 'image2.jpg', 'lineuser184', 'VibrantVoyage198','VibrantVoyage198', '2019-06-21 09:27:00', '2019-10-29 19:36:00'),
('noah057', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Noah', 'Kim', 'NoahK', 'noah.k@example.com', 'Rather not say', '1960-04-10', 'Christianity', '085-6789012', '5252 Oakwood Blvd', 'user', '090-1234567', 'image1.jpg', 'lineuser185', 'NovaNurture198','NovaNurture198', '2020-02-25 18:00:00', '2019-07-08 08:09:00'),
('ava058', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Ava', 'Patel', 'AvaP', 'ava.p@example.com', 'Female', '1973-01-05', 'Buddhism', '086-7890123', '5353 Cedar St', 'user', '091-2345678', 'image2.jpg', 'lineuser186', 'GleamGlimmer198','GleamGlimmer198', '2019-11-02 03:33:00', '2021-03-10 13:42:00'),
('liam059', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Liam', 'Thakur', 'LiamT', 'liam.t@example.com', 'Male', '1984-12-17', 'Hinduism', '081-4567890', '5454 Pine Ave', 'user', '092-3456789', 'image1.jpg', 'lineuser187', 'CelestialCherish198','CelestialCherish198', '2020-04-26 12:06:00', '2019-11-15 20:15:00'),
('olivia060', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Olivia', 'Gupta', 'OliviaG', 'olivia.g@example.com', 'Female', '1997-10-28', 'Hinduism', '082-5678901', '5555 Elm Ln', 'user', '093-4567890', 'image1.jpg', 'lineuser188', 'MysticMingle198','MysticMingle198', '2019-01-09 18:39:00', '2020-07-18 01:48:00'),
('elijah061', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Elijah', 'Patel', 'ElijahP', 'elijah.p@example.com', 'Rather not say', '1954-06-03', 'Christianity', '083-6789012', '5656 Oak Ave', 'user', '094-5678901', 'image2.jpg', 'lineuser189', 'EtherealEssence198','EtherealEssence198', '2020-11-08 01:12:00', '2019-05-27 07:21:00'),
('charlotte062', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Charlotte', 'Kim', 'CharlotteK', 'charlotte.k@example.com', 'Female', '1969-02-14', 'Buddhism', '084-7890123', '5757 Maple Ln', 'user', '095-6789012', 'image1.jpg', 'lineuser190', 'DreamyDaze198','DreamyDaze198', '2019-05-22 07:45:00', '2020-02-08 13:54:00'),
('william063', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'William', 'Singh', 'WilliamS', 'william.s@example.com', 'Rather not say', '1971-03-19', 'Sikhism', '085-8901234', '4242 Cedar Dr', 'user', '096-7890123', 'image2.jpg', 'lineuser191', 'RadiantRipple198','RadiantRipple198', '2019-08-04 16:18:00', '2021-08-11 22:27:00'),
('harper064', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Harper', 'Tan', 'HarperT', 'harper.t@example.com', 'Female', '2000-08-12', 'Buddhism', '086-9012345', '4343 Elmwood St', 'user', '097-8901234', 'image1.jpg', 'lineuser192', 'SparkleShine198','SparkleShine198', '2020-10-17 00:51:00', '2019-10-16 04:00:00'),
('alexander065', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Alexander', 'Wong', 'AlexW', 'alexander.w@example.com', 'Male', '1967-09-07', 'Christianity', '087-0123456', '4444 Oakwood Blvd', 'user', '098-9012345', 'image2.jpg', 'lineuser193','lineuser193', 'Nova', '2019-12-20 09:24:00', '2019-12-07 10:33:00'),
('evelyn066', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Evelyn', 'Kim', 'EvelynK', 'evelyn.k@example.com', 'Female', '1988-07-23', 'Buddhism', '088-1234567', '4545 Pine Ave', 'user', '099-0123456', 'image1.jpg', 'lineuser194', 'Idfun1234','Idfun1234', '2020-04-01 17:57:00', '2020-05-20 19:06:00'),
('daniel067', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Daniel', 'Thakur', 'DanT', 'daniel.t@example.com', 'Male', '1979-12-10', 'Hinduism', '089-2345678', '4646 Cedar St', 'user', '080-1234567', 'image2.jpg', 'lineuser195', 'deneeeeeeee','deneeeeeeee', '2019-02-06 02:30:00', '2019-03-20 00:39:00'),
('mia068', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'Mia', 'Gupta', 'MiaG', 'mia.g@example.com', 'Female', '1990-05-15', 'Hinduism', '080-1234567', '4747 Elm Ln', 'user', '081-2345678', 'image1.jpg', 'lineuser196', 'fansaiiiiiii','fansaiiiiiii', '2020-07-25 11:03:00', '2021-09-03 07:12:00'),
('Thrive Events', '$argon2id$v=19$m=16,t=2,p=1$/6upZgEMnLivZLNFCxLNgA$vUysSJZlMDdB5ef1BM1UEOkndTIX+CruEsk3ggI', 'James', 'Patel', 'JamesP', 'james.p@example.com', 'Male', '1956-02-29', 'Christianity', '081-2345678', '4848 Oak Ave', 'activityOwner', '082-3456789', 'image2.jpg', 'lineuser197', 'daramaiiii','daramaiiii', '2019-09-28 19:36:00', '2019-11-07 14:45:00');


-- Insert more data into the Location table for places in Thailand
INSERT INTO
    `unityDoDB`.`location` (
        `locationName`,
        `googleMapLink`,
        `locationLongitude`,
        `locationLatitude`
    )
VALUES
   (
        'Doi Suthep Temple',
        'https://maps.google.com/maps?q=Doi+Suthep+Temple,Chiang+Mai,Thailand',
        98.842499,
        18.804388
    ),
    (
        'James Bond Island',
        'https://maps.google.com/maps?q=James+Bond+Island,Phang+Nga,Thailand',
        98.529864,
        8.269304
    ),
    (
        'Hua Hin Beach',
        'https://maps.google.com/maps?q=Hua+Hin+Beach,Prachuap+Khiri+Khan,Thailand',
        99.956897,
        12.561806
    ),
    (
        'Pai Canyon',
        'https://maps.google.com/maps?q=Pai+Canyon,Mae+Hong+Son,Thailand',
        98.440406,
        19.365791
    ),
    (
        'Ko Phi Phi Leh',
        'https://maps.google.com/maps?q=Ko+Phi+Phi+Leh,Krabi,Thailand',
        98.764579,
        7.681415
    ),
    (
        'Erawan National Park',
        'https://maps.google.com/maps?q=Erawan+National+Park,Kanchanaburi,Thailand',
        99.213200,
        14.402426
    ),
    (
        'Similan Islands',
        'https://maps.google.com/maps?q=Similan+Islands,Phang+Nga,Thailand',
        97.645233,
        8.655676
    ),
    (
        'Ko Samui',
        'https://maps.google.com/maps?q=Ko+Samui,Surat+Thani,Thailand',
        100.063160,
        9.512017
    ),
    (
        'Wat Rong Khun (White Temple)',
        'https://maps.google.com/maps?q=Wat+Rong+Khun,Chiang+Rai,Thailand',
        99.779937,
        19.824280
    ),
    (
        'Ko Tao',
        'https://maps.google.com/maps?q=Ko+Tao,Surat+Thani,Thailand',
        99.840411,
        10.100359
    ),
    (
        'Wat Pho',
        'https://maps.google.com/maps?q=Wat+Pho,Bangkok,Thailand',
        100.493941,
        13.746703
    ),
    (
        'Phuket Beach',
        'https://maps.google.com/maps?q=Patong+Beach,Phuket,Thailand',
        98.293087,
        7.895680
    ),
    (
        'Chiang Mai Old City',
        'https://maps.google.com/maps?q=Chiang+Mai+Old+City,Chiang+Mai,Thailand',
        98.993685,
        18.785124
    ),
    (
        'Krabi Railay Beach',
        'https://maps.google.com/maps?q=Railay+Beach,Krabi,Thailand',
        98.838603,
        8.010108
    ),
    (
        'Ayutthaya Historical Park',
        'https://maps.google.com/maps?q=Ayutthaya,Historical+Park,Ayutthaya,Thailand',
        100.552113,
        14.361914
    ),
    (
        'ZOOM',
        'https://demo-zoomlink.com/',
        00.00,
        00.00
    ),
	(
		'The Grand Palace', 
		'https://maps.app.goo.gl/p9x1rFE94t7hid5k9', 
		00.00, 
		00.00
    ),
    (
		'The Temple of the Emerald Buddha', 
		'https://maps.app.goo.gl/jgvigvUySCfCQEFy7', 
		00.00, 
		00.00
    ),
    (
		'Khao Sok National Park', 
		'https://maps.app.goo.gl/6x8SWXJZKMSeiuw38', 
		00.00, 
		00.00
    ),
    (
		'Phra Sumen Fort', 
		'https://maps.app.goo.gl/ZM2b2ACM4oUC96Wn9', 
		00.00, 
		00.00),
    (
		'Wat Suthat Thepwararam Ratchaworamahawihan', 
		'https://maps.app.goo.gl/wQEZgbXRZv8394mSA', 
		00.00, 
		00.00
    ),
    (
		'Asiatique Sky', 
		'https://maps.app.goo.gl/xV2dL2M9sUQF8kSSA', 
		00.00, 
		00.00
    ),
    (
		'SEA LIFE Bangkok Ocean World', 
		'https://maps.app.goo.gl/DkofsrPbR3JP9ncL9', 
		00.00, 
		00.00
    ),
    (
		'The Ancient City', 
		'https://maps.app.goo.gl/cRdjoNzpPScFUnEw9', 
		00.00, 
		00.00
    ),
    (
		'Phimai Historical Park', 
		'https://maps.app.goo.gl/tVeXAVWNHzpUiH3Z6', 
		00.00, 
		00.00
    ),
    (
		'Siam Amazing Park', 
		'https://maps.app.goo.gl/khHpfhXwaqdfkuXW9', 
		00.00, 
		00.00
    ),
    (
		'OneSiam Skywalk', 
		'https://maps.app.goo.gl/k2DtFvb1TpDtyAQg7', 
		00.00, 
		00.00
	),
    (
		'Chao Phraya River', 
		'https://maps.app.goo.gl/mLEKu183By9ADUAK9', 
		00.00, 
		00.00
    ),
    (
		'King Prajadhipok Museum', 
		'https://maps.app.goo.gl/ebZQu1zNmyM7zNfr6', 
		00.00, 
		00.00
    ),
    (
		'Norwich International School Bangkok', 
		'https://maps.app.goo.gl/YrVuRCZs5xHuePXx5', 
		00.00, 
		00.00
    ),
    (
		'Thailand Experiences', 
		'https://maps.app.goo.gl/jjuc8avx49m4kj1W8', 
		00.00, 
		00.00
    ),
    (
		'The Camping Ground', 
		'https://maps.app.goo.gl/ViknhsdZ99yBhJCUA', 
		00.00, 
		00.00
    ),
    (
		'Queen Sirikit Museum of Textiles', 
		'https://maps.app.goo.gl/iYtUfok4GUAFQvL48', 
		00.00, 
		00.00
    ),
    (
		'Lhong 1919', 
		'https://maps.app.goo.gl/3SBwunavgva8X4Nc6', 
		00.00, 
		00.00
    ),
    (
		'Pak Khlong Talat (Flower Market)', 
		'https://maps.app.goo.gl/ywQppC8nPw7Ngqg56', 
		00.00, 
		00.00
    ),
    (
		'Phra Sumen Fort', 
		'https://maps.app.goo.gl/jwtYE95GJ8BBbzcLA', 
		00.00, 
		00.00
    ),
    (
		'Statue of King Rama III', 
		'https://maps.app.goo.gl/G2bGyf3JX5DK9Sr69', 
		00.00, 
		00.00
    ),
    (
		'Tha Tian Market', 
		'https://maps.app.goo.gl/MsZJo75vXVgPEyKp8', 
		00.00, 
		00.00
    ),
    (
		'Museum Siam', 
		'https://maps.app.goo.gl/2xFvVNUbfwwhvSUH8', 
		00.00,
		00.00
    ),
    (
		'Chaloemla Park (Graffiti Park)', 
		'https://maps.app.goo.gl/wMv93XsYGWdhgfQNA',
		00.00, 
		00.00
    ),
    (
		'Wat Mangkon Kamalawat (Wat Leng Noei Yi)',
		'https://maps.app.goo.gl/QHBqDNVeXiL2S2Cu9', 
		00.00, 
		00.00
    ),
    (
		'Khao Sam Roi Yot National Park', 
		'https://maps.app.goo.gl/kxUPepaj51A3stKt5', 
		00.00, 
		00.00
    ),
    (
		'Suan Luang Rama IX', 
		'https://maps.app.goo.gl/zR7D1xfBhEuKaUGh8', 
		00.00,
		00.00
    ),
    (
		'Ong Ang Canal',
		'https://maps.app.goo.gl/gtRGDNF6GTPaBuD38', 
		00.00, 
		00.00
    ),
    (
		'Alangkarn waterfall at Icon Siam', 
		'https://maps.app.goo.gl/PmWH1PT7EXaotosK6',
		00.00,
		00.00
    ),
    (
		'Wat Pathum Wanaram Rachaworawihan', 
		'https://maps.app.goo.gl/GsnehbJpcVhTobcv7',
		00.00, 
		00.00
    ),
    (
		'Bangkok Butterfly Garden and Insectarium', 
		'https://maps.app.goo.gl/pgrg6csuys7KwF8J8', 
		00.00,
		00.00
	),
    (
		'Benchasiri Park', 
		'https://maps.app.goo.gl/8vThmRV8X612RPrEA', 
		00.00, 
		00.00
     ),
    (
		'Princess Mother Memorial Park', 
		'https://maps.app.goo.gl/DFiUbQrvprEzFM6x5', 
		00.00, 
		00.00
    ),
    (
		'Rommaninat Park', 
		'https://maps.app.goo.gl/QKuTwinN4yRTiAzF6',
		00.00,
		00.00
    ),
    (
		'Chaloemla Gardens', 
		'https://maps.app.goo.gl/hLQpmKn5QaGf74xh9',
		00.00,
		00.00
    ),
    (
		'Chulalongkorn University Centenary Park',
		'https://maps.app.goo.gl/zeenK8B15L5y1m256',
		00.00, 
		00.00
    ),
    (
		'King Rama IX Memorial Park', 
		'https://maps.app.goo.gl/pJiiFXbdaVrju', 
		00.00, 
		00.00
    );

	-- Insert data into the Activity table with activityEndDate and activityFormat columns
INSERT INTO
    `unityDoDB`.`activity` (
        `activityOwner`,
        `activityName`,
        `activityBriefDescription`,
        `activityDescription`,
        `activityDate`,
        `activityEndDate`,
        `registerStartDate`,
        `registerEndDate`,
        `amount`,
        `locationId`,
        `announcementDate`,
        `activityStatus`,
        `isGamification`,
        `suggestionNotes`,
        `categoryId`,
        `lastUpdate`,
        `createTime`,
        `activityFormat`
    )
VALUES
         (
        7,
        'Paint and Sip Night',
        'Artistic expression with a twist',
        'Join us for a creative evening of painting and sipping your favorite drinks.',
        '2024-01-15 18:00:00',
        '2024-01-15 22:00:00',
        '2023-12-25 15:00:00',
        '2024-01-10 18:00:00',
        20,
        10,
        '2023-12-15 10:00:00',
        'Active',
        1,
        'Unleash your inner artist while enjoying a social atmosphere!',
        29,
        '2023-12-25 15:00:00',
        '2023-12-25 15:00:00',
        'onsite'
    ),
    (
        2,
        'Photography Expedition',
        'Capture the beauty of nature',
        'Embark on a photography expedition to capture stunning landscapes and wildlife.',
        '2024-02-20 08:00:00',
        '2024-02-21 18:00:00',
        '2024-02-01 14:00:00',
        '2024-02-15 18:00:00',
        15,
        12,
        '2024-01-25 09:00:00',
        'Active',
        1,
        'Discover the art of photography in the great outdoors!',
        24,
        '2024-02-01 14:00:00',
        '2024-02-01 14:00:00',
        'onsiteOverNight'
    ),
    (
        6,
        'Cooking Masterclass',
        'Culinary delights for everyone',
        'Join our cooking masterclass to enhance your culinary skills and enjoy delicious dishes.',
        '2024-03-10 16:30:00',
        '2024-03-10 20:30:00',
        '2024-02-20 10:00:00',
        '2024-03-05 18:00:00',
        25,
        15,
        '2024-02-10 14:00:00',
        'Active',
        1,
        'Become a master chef with our expert chefs!',
        30,
        '2024-02-20 10:00:00',
        '2024-02-20 10:00:00',
        'onsite'
    ),
    (
        7,
        'Gardening Workshop',
        'Connect with nature through gardening',
        'Learn the art of gardening and cultivate your own green space at home.',
        '2024-04-05 10:00:00',
        '2024-04-05 15:00:00',
        '2024-03-15 09:00:00',
        '2024-03-30 18:00:00',
        0,
        14,
        '2024-03-01 14:00:00',
        'Active',
        1,
        'Create your own garden oasis with our gardening experts!',
        23,
        '2024-03-15 09:00:00',
        '2024-03-15 09:00:00',
        'onsite'
    ),
    (
        2,
        'Fitness Bootcamp',
        'Get fit and stay active',
        'Join our fitness bootcamp for a high-energy workout to achieve your fitness goals.',
        '2024-05-15 07:00:00',
        '2024-05-15 09:30:00',
        '2024-04-01 06:00:00',
        '2024-05-10 18:00:00',
        10,
        5,
        '2024-04-10 10:00:00',
        'Active',
        1,
        'Transform your body with our dynamic fitness program!',
        15,
        '2024-04-01 06:00:00',
        '2024-04-01 06:00:00',
        'onsite'
    ),
    (
        2,
        'Swimming Challenge',
        'Dive into the fun',
        'Join our swimming challenge for a day of aquatic excitement.',
        '2023-04-20 14:00:00',
        '2023-04-20 18:00:00',
        '2023-03-10 09:00:00',
        '2023-04-15 18:00:00',
        15,
        4,
        '2023-03-20 11:00:00',
        'Active',
        1,
        'Compete and win prizes in our swimming contest!',
        17,
        '2023-03-10 09:00:00',
        '2023-03-10 09:00:00',
        'onsite'
    ),
    (
        6,
        'Online Coding Bootcamp',
        'Enhance your coding skills',
        'Join our online coding bootcamp to boost your programming knowledge.',
        '2023-06-01 18:00:00',
        '2023-06-10 20:00:00',
        '2023-05-15 10:00:00',
        '2023-05-30 18:00:00',
        0,
        16, 
        '2023-05-01 14:00:00',
        'Active',
        1,
        'Level up your coding game with us!',
        12,
        '2023-05-15 10:00:00',
        '2023-05-15 10:00:00',
        'online'
    ),
    (
        7,
        'Campfire and Stargazing',
        'Experience the night sky',
        'Join us for an overnight adventure with campfire and stargazing.',
        '2023-07-15 19:00:00',
        '2023-07-16 08:00:00',
        '2023-06-25 15:00:00',
        '2023-07-10 18:00:00',
        12,
        7,
        '2023-06-30 10:00:00',
        'Active',
        1,
        'Connect with nature under the stars!',
        21,
        '2023-06-25 15:00:00',
        '2023-06-25 15:00:00',
        'onsiteOverNight'
    ),
    (
        2,
        'Salsa Dance Workshop',
        'Feel the rhythm',
        'Join our one-day salsa dance workshop to spice up your dance moves.',
        '2023-11-15 14:30:00',
        '2023-11-15 18:00:00',
        '2023-10-25 12:30:00',
        '2023-11-10 18:00:00',
        10,
        6,
        '2023-11-01 10:00:00',
        'Active',
        1,
        'Learn to dance to the vibrant beats!',
        28,
        '2023-10-25 12:30:00',
        '2023-10-25 12:30:00',
        'onsite'
    ),
    (
        6,
        'Digital Art Webinar',
        'Unleash your creativity',
        'Participate in our online webinar to explore the world of digital art.',
        '2023-12-05 16:00:00',
        '2023-12-05 18:30:00',
        '2023-11-20 14:00:00',
        '2023-12-01 18:00:00',
        0,
        16,
        '2023-11-10 09:00:00',
        'Active',
        1,
        'Discover the magic of digital art!',
        33,
        '2023-11-20 14:00:00',
        '2023-11-20 14:00:00',
        'online'
    ),
	(
        6,
        'Digital Art Webinar',
        'Unleash your creativity',
        'Participate in our online webinar to explore the world of digital art.',
        '2023-12-05 16:00:00',
        '2023-12-05 18:30:00',
        '2023-11-20 14:00:00',
        '2023-12-01 18:00:00',
        0,
        16,
        '2023-11-10 09:00:00',
        'Active',
        1,
        'Discover the magic of digital art!',
        33,
        '2023-11-20 14:00:00',
        '2023-11-20 14:00:00',
        'online'
    ),
    (
	    38,
	    'Animal Shelter Assistance', 
	    'Animal Shelter Assistance: Assist in caring for animals at the shelter by feeding, cleaning, and providing socialization.', 
	    'Assist in caring for animals at the shelter by feeding, grooming, and providing companionship, helping to improve their well-being and chances of adoption.',
	    '2020-06-15 4:00:00', 
	    '2020-06-18 4:00:00',
	    '2020-06-01 4:00:00', 
	    '2020-06-06 4:00:00', 
	    50,
	    16,
	    '2020-06-07 4:00:00', 
	    'Active',
	    0, 
     'Come to join',
	    1, 
	    '2024-04-01 6:00:00', 
	    '2023-03-10 9:00:00', 
	    'Online'
    ),
    (
        20, 
        'BlueSky Adventures', 
         'Community Soup Kitchen', 
         'Volunteer at a local soup kitchen, preparing and serving meals to those in need, fostering community connections and providing nourishment for vulnerable populations.', 
        '2024-10-30 17:00:00', 
        '2024-11-01 17:00:00',
        '2024-10-16 17:00:00', 
        '2024-10-21 17:00:00', 
        95,
        17,
        '2024-10-26 17:00:00',
        'Active',
        0,
        'Join us for a thrilling hike through the wilderness!',
        2, 
        '2024-04-01 06:00:00', 
        '2023-03-11 09:00:00', 
        'On-site'
    ),
(205, 'Thrive Events', 'Healthcare Clinic Support', 'Support healthcare professionals at clinics by assisting with administrative tasks, patient intake, and providing comfort and assistance to patients.', '2022-08-03 02:00:00', '2022-08-06 03:00:00', '2022-07-20 02:00:00', '2022-07-25 02:00:00', 185, 16, '2022-07-30 02:00:00', 'Active', 0, 'Love books? Come join our monthly book club!', 3, '2024-04-02 06:00:00', '2023-03-12 09:00:00', 'Online'),
(93, 'Nexus Productions', 'Adaptive Sports Coaching', 'Coach individuals with disabilities in adaptive sports such as wheelchair basketball or para-swimming, promoting inclusivity and physical activity for all.', '2023-05-07 09:00:00', '2023-05-11 10:00:00', '2023-04-23 09:00:00', '2023-04-28 09:00:00', 120, 16, '2023-05-03 09:00:00', 'Active', 0, 'Lets gather for a relaxing yoga session in the park.', 4, '2024-04-03 06:00:00', '2023-03-13 09:00:00', 'Online'),
(101, 'Sparkle Events', 'Beach Cleanup', 'Participate in beach cleanup efforts, collecting litter and debris to protect marine life and preserve coastal ecosystems for future generations.', '2023-11-14 01:00:00', '2023-11-29 02:00:00', '2023-10-31 01:00:00', '2023-11-05 01:00:00', 25, 18, '2023-11-09 01:00:00', 'Active', 0, 'Calling all music enthusiasts! Jam session at my place!', 5, '2024-04-04 06:00:00', '2023-03-14 09:00:00', 'On-site'),
(60, 'Infinity Events', 'Art Therapy Sessions', 'Lead art therapy sessions for individuals facing mental health challenges, using creative expression as a tool for healing and self-discovery.', '2024-01-22 10:00:00', '2024-02-06 11:00:00', '2024-01-08 10:00:00', '2024-01-13 10:00:00', 40, 19, '2024-01-18 10:00:00', 'Active', 0, 'Experience the thrill of rock climbing with us!', 6, '2024-04-05 06:00:00', '2023-03-15 09:00:00', 'On-site'),
(17, 'Animal Sanctuary Volunteering', 'Animal Sanctuary Volunteering: Volunteer at an animal sanctuary to help care for rescued animals and maintain facilities.', 'Volunteer at an animal sanctuary, assisting with feeding, cleaning, and providing enrichment activities for rescued animals, ensuring their well-being and happiness.', '2021-12-03 23:00:00', '2021-12-14 0:00:00', '2021-11-19 23:00:00', '2021-11-24 23:00:00', 105, 36, '2021-11-29 23:00:00', 'Active', 0, 'Dive into the world of painting at our art workshop!', 1, '2024-04-06 6:00:00', '2023-03-16 9:00:00', 'On-site'),
(34, 'Homeless Shelter Support', 'Homeless Shelter Support: Provide assistance and support to individuals experiencing homelessness at a shelter.', 'Volunteer at a homeless shelter, offering support services such as meal distribution, clothing donations, and companionship to individuals experiencing homelessness.', '2023-09-10 13:00:00', '2023-09-14 14:00:00', '2023-08-26 13:00:00', '2023-08-31 13:00:00', 70, 21, '2023-09-05 13:00:00', 'Active', 0, 'Calling all foodies! Lets explore new restaurants together!', 2, '2024-04-07 6:00:00', '2023-03-17 9:00:00', 'On-site'),
(68, 'Hospital Visitation Program', 'Hospital Visitation Program: Visit patients in hospitals to provide companionship, support, and encouragement.', 'Visit patients in hospitals to provide companionship, emotional support, and a listening ear, helping to alleviate feelings of loneliness and isolation.', '2021-02-06 15:00:00', '2021-02-12 16:00:00', '2021-01-24 15:00:00', '2021-01-29 15:00:00', 130, 22, '2021-02-03 15:00:00', 'Active', 0, 'Love to dance? Join us for a fun salsa class!', 3, '2024-04-08 6:00:00', '2023-03-18 9:00:00', 'On-site'),
(93, 'Community Sports Event Assistance', 'Community Sports Event Assistance: Assist with organizing and running community sports events to promote physical activity and community engagement.', 'Assist in organizing and facilitating community sports events, ensuring smooth operations and an enjoyable experience for participants and spectators alike.', '2022-02-11 3:00:00', '2022-02-17 4:00:00', '2022-01-24 3:00:00', '2022-01-29 3:00:00', 165, 23, '2022-02-03 3:00:00', 'Active', 0, 'Embrace your inner chef at our cooking class!', 4, '2024-04-09 6:00:00', '2023-03-19 9:00:00', 'On-site'),
(101, 'Tree Planting', 'Tree Planting: Participate in tree planting initiatives to contribute to environmental conservation and reforestation efforts.', 'Participate in tree planting initiatives to combat deforestation, mitigate climate change, and restore green spaces in urban and rural areas.', '2020-07-03 22:00:00', '2020-07-09 23:00:00', '2020-06-19 22:00:00', '2020-06-24 22:00:00', 135, 16, '2020-06-29 22:00:00', 'Active', 0, 'Lets hit the waves together for a surfing adventure!', 5, '2024-04-10 6:00:00', '2023-03-20 9:00:00', 'Online'),
(20, 'Creative Writing Workshops', 'Creative Writing Workshops: Attend workshops to develop creative writing skills and explore storytelling techniques.', 'Lead creative writing workshops for aspiring writers, providing guidance, feedback, and inspiration to foster their literary talents and storytelling skills.', '2022-10-26 20:00:00', '2022-11-09 21:00:00', '2022-10-12 20:00:00', '2022-10-17 20:00:00', 175, 16, '2022-10-22 20:00:00', 'Active', 0, 'Join us for a friendly soccer match at the park!', 6, '2024-04-11 6:00:00', '2023-03-21 9:00:00', 'Online'),
(38, 'Wildlife Rehabilitation', 'Wildlife Rehabilitation: Assist in caring for injured or orphaned wildlife and preparing them for release back into the wild.', 'Aid in the rehabilitation of injured or orphaned wildlife, assisting with feeding, medical care, and habitat maintenance to prepare them for release back into the wild.', '2024-04-12 8:00:00', '2024-04-21 9:00:00', '2024-03-28 8:00:00', '2024-04-02 8:00:00', 145, 24, '2024-04-07 8:00:00', 'Active', 0, 'Feel the burn with our group fitness class!', 1, '2024-04-12 6:00:00', '2023-03-22 9:00:00', 'On-site'),
(205, 'Medical Mission Trips', 'Medical Mission Trips: Join medical mission trips to provide healthcare services to underserved communities.', 'Join medical mission trips to underserved communities, providing essential healthcare services, screenings, and treatments to improve health outcomes.', '2021-11-28 6:00:00', '2021-12-11 7:00:00', '2021-11-13 6:00:00', '2021-11-18 6:00:00', 80, 26, '2021-11-23 6:00:00', 'Active', 0, 'Join us for a scenic bike ride along the coast!', 3, '2024-04-14 6:00:00', '2023-03-24 9:00:00', 'On-site'),
(68, 'Outdoor Adventure Guiding', 'Outdoor Adventure Guiding: Lead outdoor adventure activities such as hiking, camping, and rock climbing.', 'Lead outdoor adventure activities such as hiking, kayaking, or rock climbing for individuals or groups, promoting outdoor recreation and appreciation for nature.', '2023-01-20 16:00:00', '2023-01-21 17:00:00', '2023-01-06 16:00:00', '2023-01-11 16:00:00', 145, 27, '2023-01-17 16:00:00', 'Active', 0, 'Unleash your creativity at our DIY craft workshop!', 4, '2024-04-15 6:00:00', '2023-03-25 9:00:00', 'On-site'),
(60, 'River Cleanup', 'River Cleanup: Participate in cleaning up rivers and waterways to protect aquatic habitats and wildlife.', 'Participate in river cleanup initiatives, removing trash and debris to protect water quality, aquatic habitats, and the health of ecosystems downstream.', '2021-09-06 14:00:00', '2021-09-07 15:00:00', '2021-08-23 14:00:00', '2021-08-28 14:00:00', 170, 28, '2021-09-02 14:00:00', 'Active', 0, 'Love photography? Lets explore the city together and capture its beauty!', 5, '2024-04-16 6:00:00', '2023-03-26 9:00:00', 'On-site'),
(34, 'Performing Arts Workshops', 'Performing Arts Workshops: Attend workshops to learn performing arts skills such as acting, singing, and dancing.', 'Conduct performing arts workshops for youth, teaching acting, dancing, or music skills to foster creativity, confidence, and self-expression.', '2024-12-12 19:00:00', '2024-12-18 20:00:00', '2024-11-25 19:00:00', '2024-12-02 19:00:00', 125, 29, '2024-12-07 19:00:00', 'Active', 0, 'Embark on a thrilling whitewater rafting adventure with us!', 6, '2024-04-17 6:00:00', '2023-03-27 9:00:00', 'On-site'),
(38, 'Robotics Workshop', 'Robotics Workshop: Learn about robotics technology and participate in building and programming robots.', 'Engage in hands-on activities to design, build, and program robots, exploring principles of engineering and computer science in a fun and interactive environment.', '2020-02-18 0:00:00', '2020-02-23 1:00:00', '2020-02-07 0:00:00', '2020-02-12 0:00:00', 65, 30, '2020-02-13 0:00:00', 'Active', 0, 'Join our nature walk to discover the beauty of the local flora and fauna!', 8, '2024-04-18 6:00:00', '2023-03-28 9:00:00', 'On-site'),
(17, 'Math Olympiad Training', 'Math Olympiad Training: Receive training and practice sessions to prepare for math olympiad competitions.', 'Receive coaching and practice sessions to prepare for math competitions, solving challenging problems and developing problem-solving skills in various math disciplines.', '2023-08-11 21:00:00', '2023-08-17 22:00:00', '2023-07-30 21:00:00', '2023-08-05 21:00:00', 100, 31, '2023-08-08 21:00:00', 'Active', 0, 'Lets gather for a picnic in the park and enjoy some good food and company!', 9, '2024-04-19 6:00:00', '2023-03-29 9:00:00', 'On-site'),
(101, 'Fine Arts Painting Class', 'Fine Arts Painting Class: Take classes to learn painting techniques and create original artworks.', 'Learn painting techniques and artistic expression through guided lessons, exploring various mediums and styles to unleash creativity and develop artistic skills.', '2020-10-17 7:00:00', '2020-10-25 8:00:00', '2020-10-10 7:00:00', '2020-10-15 7:00:00', 90, 16, '2020-10-16 7:00:00', 'Active', 0, 'Join us for a friendly game of basketball at the court!', 10, '2024-04-20 6:00:00', '2023-03-30 9:00:00', 'Online'),
(20, 'Music Theory Workshop', 'Music Theory Workshop: Attend workshops to learn music theory concepts and improve musical knowledge.', 'Study music theory concepts such as notation, harmony, and rhythm, applying theoretical knowledge to practice through exercises and musical compositions.', '2023-04-08 12:00:00', '2023-04-12 13:00:00', '2023-03-31 12:00:00', '2023-04-05 12:00:00', 130, 16, '2023-04-06 12:00:00', 'Active', 0, 'Dive into the world of mindfulness with our meditation session!', 11, '2024-04-21 6:00:00', '2023-03-31 9:00:00', 'Online'),
(60, 'Outdoor Biology Field Trip', 'Outdoor Biology Field Trip: Explore nature and learn about biology through outdoor field trips and hands-on activities.', 'Embark on a field trip to explore local ecosystems, observing wildlife, conducting experiments, and learning about biodiversity and ecological principles in nature.', '2021-02-09 11:00:00', '2021-02-15 12:00:00', '2021-01-24 11:00:00', '2021-01-29 11:00:00', 140, 16, '2021-02-03 11:00:00', 'Active', 0, 'Explore the night sky with us at our stargazing event!', 12, '2024-04-22 6:00:00', '2023-04-01 9:00:00', 'Online'),
(93, 'Math Games Day', 'Math Games Day: Participate in math games and activities to improve mathematical skills and problem-solving abilities.', 'Participate in math games and puzzles designed to make learning fun and engaging, reinforcing mathematical concepts and promoting friendly competition among peers.', '2022-11-10 18:00:00', '2022-11-24 19:00:00', '2022-10-27 18:00:00', '2022-11-03 18:00:00', 35, 32, '2022-11-08 18:00:00', 'Active', 0, 'Lets hit the trails for a refreshing morning run together!', 9, '2024-04-23 6:00:00', '2023-04-02 9:00:00', 'On-site'),
(205, 'Sculpture Sculpting Class', 'Sculpture Sculpting Class: Learn sculpting techniques and create sculptures using various materials.', 'Attend sculpture classes to learn techniques for sculpting with clay, stone, or other materials, exploring form, texture, and composition in three-dimensional art.', '2024-06-28 3:00:00', '2024-06-29 4:00:00', '2024-06-14 3:00:00', '2024-06-19 3:00:00', 75, 16, '2024-06-23 3:00:00', 'Active', 0, 'Join us for a pottery class and unleash your creativity on clay!', 10, '2024-04-24 6:00:00', '2023-04-03 9:00:00', 'Online'),
(34, 'Instrumental Music Ensemble', 'Instrumental Music Ensemble: Join a music ensemble to play instruments and perform music with others.', 'Join a music ensemble to rehearse and perform instrumental pieces, honing musical skills, ensemble playing, and appreciation for different genres of music.', '2023-05-10 0:00:00', '2023-05-25 1:00:00', '2023-04-26 0:00:00', '2023-05-01 0:00:00', 145, 33, '2023-05-02 0:00:00', 'Active', 0, 'Love to sing? Join our choir and harmonize with fellow music lovers!', 11, '2024-04-25 6:00:00', '2023-04-04 9:00:00', 'On-site'),
(68, 'Coding Camp', 'Coding Camp: Attend coding camps to learn programming languages and develop coding skills.', 'Learn programming languages and coding skills through hands-on projects and challenges, developing problem-solving abilities and computational thinking skills.', '2020-08-27 8:00:00', '2020-08-28 9:00:00', '2020-08-20 8:00:00', '2020-08-25 8:00:00', 180, 34, '2020-08-26 8:00:00', 'Active', 0, 'Calling all adventure seekers! Lets go zip-lining!', 8, '2024-04-26 6:00:00', '2023-04-05 9:00:00', 'On-site'),
(101, 'Math Tutoring Sessions', 'Math Tutoring Sessions: Receive one-on-one tutoring to improve math skills and understanding.', 'Receive personalized tutoring in math subjects, addressing individual learning needs and reinforcing concepts through practice problems and guided instruction.', '2023-06-19 22:00:00', '2023-06-22 23:00:00', '2023-06-12 22:00:00', '2023-06-17 22:00:00', 175, 35, '2023-06-18 22:00:00', 'Active', 0, 'Discover the joy of gardening at our community garden event!', 9, '2024-04-27 6:00:00', '2023-04-06 9:00:00', 'On-site'),
(20, 'Mixed Media Art Workshop', 'Mixed Media Art Workshop: Explore different art mediums and techniques to create mixed media artworks.', 'Explore mixed media art techniques combining various materials such as collage, paint, and found objects to create expressive and layered works of art.', '2021-12-24 16:00:00', '2021-12-30 17:00:00', '2021-12-10 16:00:00', '2021-12-15 16:00:00', 70, 29, '2021-12-16 16:00:00', 'Active', 0, 'Join us for a thrilling skydiving experience and feel the rush of adrenaline!', 10, '2024-04-28 6:00:00', '2023-04-07 9:00:00', 'On-site'),
(205, 'Vocal Choir', 'Vocal Choir: Join a choir to sing and perform vocal music in a group setting.', 'Join a vocal choir to rehearse and perform choral music, learning vocal techniques, harmonization, and teamwork while sharing the joy of singing with others.', '2022-03-07 5:00:00', '2022-03-21 6:00:00', '2022-02-21 5:00:00', '2022-02-26 5:00:00', 185, 36, '2022-02-27 5:00:00', 'Active', 0, 'Lets gather for a beach bonfire and enjoy some mores under the stars!', 11, '2024-04-29 6:00:00', '2023-04-08 9:00:00', 'On-site'),
(60, 'Science Experiment Club', 'Science Experiment Club: Participate in science experiments and hands-on activities to explore scientific concepts.', 'Participate in science experiments and demonstrations, exploring scientific concepts and principles through hands-on activities and inquiry-based learning approaches.', '2021-01-07 7:00:00', '2021-01-08 8:00:00', '2021-01-23 7:00:00', '2021-01-28 7:00:00', 145, 36, '2021-01-29 7:00:00', 'Active', 0, 'Join our wildlife photography expedition and capture stunning shots of nature!', 8, '2024-04-30 6:00:00', '2023-04-09 9:00:00', 'On-site'),
(17, 'Math Problem Solving Circle', 'Math Problem Solving Circle: Collaborate with others to solve challenging math problems and puzzles.', 'Collaborate with peers to solve challenging math problems, discussing strategies, sharing insights, and developing critical thinking and problem-solving skills.', '2020-10-31 2:00:00', '2020-11-03 3:00:00', '2020-10-17 2:00:00', '2020-10-22 2:00:00', 95, 38, '2020-10-23 2:00:00', 'Active', 0, 'Love to solve puzzles? Join our escape room challenge!', 9, '2024-05-01 6:00:00', '2023-04-10 9:00:00', 'On-site'),
(38, 'Pottery Making Workshop', 'Pottery Making Workshop: Learn pottery making techniques and create ceramic artworks.', 'Learn pottery techniques such as wheel throwing and hand-building, creating functional and decorative pottery pieces while exploring clay as an artistic medium.', '2022-09-15 1:00:00', '2022-09-16 2:00:00', '2022-09-08 1:00:00', '2022-09-13 1:00:00', 105, 17, '2022-09-14 1:00:00', 'Active', 0, 'Lets explore the local farmer market together and support local vendors!', 10, '2024-05-02 6:00:00', '2023-04-11 9:00:00', 'On-site'),
(93, 'Music Composition Class', 'Music Composition Class: Take classes to learn music composition and create original music pieces.', 'Study the fundamentals of music composition, including melody, harmony, and structure, composing original pieces and exploring creativity in music composition.', '2023-07-18 19:00:00', '2023-07-24 20:00:00', '2023-07-04 19:00:00', '2023-07-09 19:00:00', 150, 16, '2023-07-10 19:00:00', 'Active', 0, 'Join us for a scenic boat tour and discover hidden gems along the coastline!', 11, '2024-05-03 6:00:00', '2023-04-12 9:00:00', 'Online'),
(34, 'Astronomy Observation Night', 'Astronomy Observation Night: Observe celestial objects and learn about astronomy during night sky observation sessions.', 'Attend astronomy observation sessions to learn about celestial objects, star gazing, and astronomical phenomena through telescope observations and guided discussions.', '2024-02-02 4:00:00', '2024-02-03 5:00:00', '2024-01-19 4:00:00', '2024-01-24 4:00:00', 155, 16, '2024-01-25 4:00:00', 'Active', 0, 'Embrace your inner artist at our pottery painting workshop!', 12, '2024-05-04 6:00:00', 'Online'),
(68, 'Math Club', 'Math Club: Join a math club to engage in math-related activities and discussions.', 'Join a math club to explore mathematical concepts beyond the curriculum, engaging in problem-solving challenges, discussions, and exploration of mathematical topics.', '2023-04-04 18:00:00', '2023-04-07 19:00:00', '2023-03-27 18:00:00', '2023-04-02 18:00:00', 20, 16, '2023-04-03 18:00:00', 'Active', 0, 'Calling all history buffs! Join our guided tour of the citys historical landmarks!', 9, '2024-05-05 6:00:00', 'Online'),
(60, 'Digital Art Design Studio', 'Digital Art Design Studio: Learn digital art creation using software tools and techniques.', 'Explore digital art creation using software tools, learning techniques for digital painting, graphic design, and illustration to create visually stunning artworks.', '2020-12-08 10:00:00', '2020-12-23 11:00:00', '2020-11-30 10:00:00', '2020-12-05 10:00:00', 150, 16, '2020-12-06 10:00:00', 'Active', 0, 'Lets gather for a game night and have some friendly competition!', 10, '2024-05-06 6:00:00', 'Online'),
(20, 'Music Appreciation Course', 'Music Appreciation Course: Attend courses to learn about different styles of music and music appreciation.', 'Study the history, theory, and cultural context of music through listening, analysis, and discussion, gaining a deeper understanding and appreciation for music.', '2021-04-25 13:00:00', '2021-04-28 14:00:00', '2021-04-11 13:00:00', '2021-04-16 13:00:00', 5, 39, '2021-04-17 13:00:00', 'Active', 0, 'Join us for a day of volunteering and make a positive impact in our community!', 11, '2024-05-07 6:00:00', 'On-site'),
(101, 'Boxing Fitness Class', 'Boxing Fitness Class: Participate in boxing-inspired fitness classes to improve strength and endurance.', 'Join a high-intensity boxing fitness class to improve strength, agility, and cardiovascular fitness through boxing drills, exercises, and sparring techniques.', '2023-02-22 23:00:00', '2023-03-07 0:00:00', '2022-09-08 23:00:00', '2022-09-13 23:00:00', 160, 40, '2022-09-14 23:00:00', 'Active', 0, 'Love to explore new cuisines? Join our international cooking class!', 13, '2024-05-08 6:00:00', 'On-site'),
(205, 'Mountain Hiking', 'Mountain Hiking: Explore mountain trails and enjoy outdoor hiking adventures.', 'Embark on a challenging mountain hiking adventure, traversing rugged trails, and summiting peaks to enjoy breathtaking views and connect with nature.', '2024-11-12 21:00:00', '2024-11-13 22:00:00', '2024-11-05 21:00:00', '2024-11-10 21:00:00', 150, 41, '2024-11-11 21:00:00', 'Active', 0, 'Lets hit the slopes for a skiing and snowboarding adventure!', 14, '2024-05-09 6:00:00', 'On-site'),
(17, 'Morning Jogging', 'Morning Jogging: Start the day with jogging sessions for cardiovascular fitness and mental well-being.', 'Start your day with a brisk morning jog, enjoying the fresh air and peaceful surroundings while boosting your energy levels and improving overall fitness.', '2022-03-31 8:00:00', '2022-03-16 9:00:00', '2022-03-24 8:00:00', '2022-03-29 8:00:00', 155, 42, '2022-03-30 8:00:00', 'Active', 0, 'Join our birdwatching expedition and spot beautiful avian species in their habitat!', 15, '2024-05-10 6:00:00', 'On-site'),
(38, 'Nature Walk', 'Nature Walk: Take leisurely walks in nature to observe wildlife and enjoy the outdoors.', 'Take a leisurely stroll through scenic nature trails, immersing yourself in the beauty of the outdoors and experiencing the calming benefits of walking in nature.', '2021-08-15 20:00:00', '2021-08-28 21:00:00', '2021-07-31 20:00:00', '2021-08-05 20:00:00', 145, 43, '2021-08-06 20:00:00', 'Active', 0, 'Explore the wonders of marine life with us on a snorkeling excursion!', 16, '2024-05-11 6:00:00', 'On-site'),
(34, 'Swim Training', 'Swim Training: Receive swim training and instruction to improve swimming skills and technique.', 'Dive into the pool for swim training sessions, improving technique, endurance, and speed through drills, laps, and coached workouts in the water.', '2022-05-29 4:00:00', '2022-06-12 5:00:00', '2022-05-15 4:00:00', '2022-05-20 4:00:00', 175, 44, '2022-05-21 4:00:00', 'Active', 0, 'Lets gather for a sunset photography session and capture the golden hour!', 17, '2024-05-12 6:00:00', 'On-site'),
(93, 'Football Practice', 'Football Practice: Participate in football training sessions to improve skills and teamwork.', 'Participate in football practice sessions, honing skills such as passing, dribbling, and shooting while improving teamwork and strategy on the field.', '2024-06-15 6:00:00', '2024-06-29 7:00:00', '2024-05-29 6:00:00', '2024-06-03 6:00:00', 135, 45, '2024-06-04 6:00:00', 'Active', 0, 'Join us for a cultural festival celebrating diversity and inclusivity!', 18, '2024-05-13 6:00:00', 'On-site'),
(101, 'Basketball Workout', 'Basketball Workout: Engage in basketball drills and exercises to enhance basketball skills.', 'Engage in basketball drills and scrimmages to enhance shooting, dribbling, and defensive skills while enjoying the fast-paced action on the court.', '2021-09-26 17:00:00', '2021-10-11 18:00:00', '2021-09-12 17:00:00', '2021-09-17 17:00:00', 60, 46, '2021-09-18 17:00:00', 'Active', 0, 'Love to write? Join our creative writing workshop and unleash your imagination!', 19, '2024-05-14 6:00:00', 'On-site'),
(60, 'Beach Volleyball', 'Beach Volleyball: Play volleyball on the beach with friends and enjoy beach sports.', 'Play beach volleyball on sandy shores, spiking, blocking, and diving to set up rallies and score points while enjoying the sun, sand, and sea breeze.', '2020-01-29 9:00:00', '2020-02-09 10:00:00', '2020-01-22 9:00:00', '2020-01-27 9:00:00', 125, 47, '2020-01-28 9:00:00', 'Active', 0, 'Lets gather for a wine tasting event and savor exquisite wines together!', 20, '2024-05-15 6:00:00', 'On-site'),
(205, 'Outdoor Bootcamp', 'Outdoor Bootcamp: Participate in outdoor fitness bootcamp sessions for full-body workouts.', 'Join an outdoor bootcamp class for a total-body workout incorporating strength training, cardio exercises, and agility drills in a motivating group setting.', '2024-08-04 14:00:00', '2024-08-05 15:00:00', '2024-07-28 14:00:00', '2024-08-02 14:00:00', 160, 33, '2024-08-03 14:00:00', 'Active', 0, 'Join our language exchange meetup and practice speaking new languages!', 21, '2024-05-16 6:00:00', 'On-site'),
(68, 'Boxing Sparring', 'Boxing Sparring: Engage in boxing sparring sessions to practice techniques and improve boxing skills.', 'Step into the ring for boxing sparring sessions, practicing defensive techniques, footwork, and combinations while sharpening reflexes and strategy in combat.', '2022-01-14 1:00:00', '2022-01-17 2:00:00', '2021-12-31 1:00:00', '2022-01-06 1:00:00', 160, 48, '2022-01-07 1:00:00', 'Active', 0, 'Discover the art of bonsai at our gardening workshop!', 13, '2024-05-17 6:00:00', 'On-site'),
(17, 'Forest Hiking', 'Forest Hiking: Explore forest trails and experience nature hiking adventures.', 'Explore lush forest trails on a hiking excursion, immersing yourself in natures beauty, spotting wildlife, and discovering hidden gems off the beaten path.', '2022-07-05 10:00:00', '2022-07-08 11:00:00', '2022-06-21 10:00:00', '2022-06-26 10:00:00', 15, 48, '2022-07-27 10:00:00', 'Active', 0, 'Lets gather for a group meditation session and find inner peace together!', 14, '2024-05-18 6:00:00', '2023-04-27 9:00:00', 'On-site'),
(20, 'Interval Running', 'Interval Running: Alternate between periods of high-intensity running and rest for cardio fitness.', 'Incorporate interval training into your running routine, alternating between bursts of high-intensity sprints and recovery periods to boost endurance and speed.', '2024-12-21 0:00:00', '2024-12-22 1:00:00', '2024-12-07 0:00:00', '2024-12-12 0:00:00', 60, 49, '2024-12-13 0:00:00', 'Active', 0, 'Join us for a wildlife safari and observe majestic animals in their natural habitat!', 15, '2024-05-19 6:00:00', '2023-04-28 9:00:00', 'On-site'),
(38, 'Urban Walking', 'Urban Walking: Take walks in urban areas to explore city streets and architecture.', 'Take a brisk walk through city streets and urban parks, exploring local landmarks, architecture, and culture while getting in your daily dose of exercise.', '2021-04-08 5:00:00', '2021-04-23 6:00:00', '2021-03-31 5:00:00', '2021-04-05 5:00:00', 105, 50, '2021-04-06 5:00:00', 'Active', 0, 'Love to cook? Join our gourmet cooking class and master culinary skills!', 16, '2024-05-20 6:00:00', '2023-04-29 9:00:00', 'On-site'),
(93, 'Open Water Swimming', 'Open Water Swimming: Swim in open water settings such as lakes or oceans for swimming challenges.', 'Swim in open water settings such as lakes or oceans, enjoying the freedom and challenges of swimming in natural environments while building endurance and confidence.', '2023-06-07 23:00:00', '2023-07-23 0:00:00', '2023-05-25 23:00:00', '2023-06-29 23:00:00', 135, 51, '2023-07-01 23:00:00', 'Active', 0, 'Lets hit the dance floor for a night of salsa, bachata, and merengue!', 17, '2024-05-21 6:00:00', '2023-04-30 9:00:00', 'On-site'),
(101, 'Soccer Match', 'Soccer Match: Play soccer matches with teams for friendly competition and sportsmanship.', 'Play in a friendly soccer match with friends or teammates, showcasing skills, teamwork, and strategy while enjoying the excitement and camaraderie of the game.', '2022-08-25 12:00:00', '2022-09-03 13:00:00', '2022-07-11 12:00:00', '2022-07-16 12:00:00', 55, 52, '2022-07-18 12:00:00', 'Active', 0, 'Join our outdoor painting session and capture the beauty of nature on canvas!', 18, '2024-05-22 6:00:00', '2023-05-01 9:00:00', 'On-site'),
(60, 'Three-Point Shootout', 'Three-Point Shootout: Compete in basketball shooting competitions to score three-pointers.', 'Participate in a three-point shootout competition, testing your shooting accuracy and precision from beyond the arc in a fun and competitive basketball challenge.', '2023-03-02 3:00:00', '2023-03-17 4:00:00', '2023-02-17 3:00:00', '2023-02-22 3:00:00', 80, 53, '2023-02-23 3:00:00', 'Active', 0, 'Embark on a thrilling hot air balloon ride and enjoy breathtaking views!', 19, '2024-05-23 6:00:00', '2023-05-02 9:00:00', 'On-site'),
(205, 'Indoor Volleyball', 'Indoor Volleyball: Play volleyball indoors with friends or teammates for fun and exercise.', 'Play indoor volleyball games in a gymnasium, spiking, setting, and blocking to score points and outmaneuver opponents while enjoying fast-paced, dynamic gameplay.', '2020-11-03 16:00:00', '2020-11-12 17:00:00', '2020-10-27 16:00:00', '2020-11-01 16:00:00', 85, 54, '2020-11-02 16:00:00', 'Active', 0, 'Lets gather for a board game marathon and have hours of fun!', 20, '2024-05-24 6:00:00', '2023-05-03 9:00:00', 'On-site'),
(34, 'CrossFit Workout', 'CrossFit Workout: Engage in CrossFit-style workouts for strength, conditioning, and endurance.', 'Experience a CrossFit workout combining functional movements, Olympic lifting, and high-intensity interval training to build strength, endurance, and fitness.', '2023-11-21 4:00:00', '2023-11-26 5:00:00', '2023-11-07 4:00:00', '2023-11-12 4:00:00', 50, 16, '2023-11-13 4:00:00', 'Active', 0, 'Join our photography club and learn new techniques from fellow enthusiasts!', 21, '2024-05-25 6:00:00', '2023-05-04 9:00:00', 'Online'),
(68, 'Kickboxing Class', 'Kickboxing Class: Take kickboxing classes to learn striking techniques and improve fitness.', 'Join a kickboxing class to learn striking techniques, kicks, and punches while burning calories and improving cardiovascular health in an energetic group environment.', '2024-02-05 22:00:00', '2024-02-11 23:00:00', '2024-01-22 22:00:00', '2024-01-27 22:00:00', 150, 16, '2024-01-28 22:00:00', 'Active', 0, 'Dive into the world of science fiction at our book discussion group!', 13, '2024-05-26 6:00:00', '2023-05-05 9:00:00', 'Online'),
(17, 'Aerobics Dance Class', 'Aerobics Dance Class: Participate in dance-based aerobics classes for cardio fitness and fun.', 'Join an energetic aerobics dance class combining dance routines with cardio exercises to improve fitness, coordination, and stamina in a fun and motivating atmosphere.', '2020-07-15 18:00:00', '2020-07-21 19:00:00', '2020-06-28 18:00:00', '2020-07-03 18:00:00', 105, 16, '2020-07-04 18:00:00', 'Active', 0, 'Lets gather for a beach clean-up and protect our coastal environment!', 22, '2024-05-27 6:00:00', '2023-05-06 9:00:00', 'Online'),
(20, 'Yoga Dance Fusion', 'Yoga Dance Fusion: Combine yoga and dance movements for flexibility, strength, and mindfulness.', 'Experience a unique blend of yoga and dance, flowing through yoga poses and sequences with fluid movements and rhythmic expression to enhance body awareness and relaxation.', '2022-06-11 21:00:00', '2022-06-22 22:00:00', '2022-05-28 21:00:00', '2022-06-02 21:00:00', 150, 16, '2022-06-03 21:00:00', 'Active', 0, 'Join us for a pottery throwing workshop and create unique ceramic pieces!', 23, '2024-05-28 6:00:00', '2023-05-07 9:00:00', 'Online'),
(38, 'K-Pop Dance Workshop', 'K-Pop Dance Workshop: Learn K-pop dance choreography and perform K-pop routines.', 'Learn popular K-Pop dance choreographies and routines, mastering precise movements, synchronization, and performance techniques while grooving to catchy K-Pop beats.', '2021-03-24 15:00:00', '2021-04-08 16:00:00', '2021-03-10 15:00:00', '2021-03-15 15:00:00', 155, 55, '2021-03-16 15:00:00', 'Active', 0, 'Explore the local art scene with us on a gallery hopping tour!', 24, '2024-05-29 6:00:00', '2023-05-08 9:00:00', 'On-site'),
(60, 'Gymnastics Dance Routine', 'Gymnastics Dance Routine: Practice gymnastics-inspired dance routines for coordination and grace.', 'Practice gymnastics-inspired dance routines incorporating flips, jumps, and acrobatic movements, combining athleticism with artistic expression in dynamic performances.', '2023-09-09 8:00:00', '2023-09-16 9:00:00', '2023-08-02 8:00:00', '2023-08-07 8:00:00', 85, 56, '2023-08-08 8:00:00', 'Active', 0, 'Lets gather for a group hike and explore scenic trails together!', 25, '2024-05-30 6:00:00', '2023-05-09 9:00:00', 'On-site'),
(101, 'Latin Dance Party', 'Latin Dance Party: Dance to Latin music rhythms such as salsa, merengue, and bachata.', 'Join a Latin dance party featuring salsa, bachata, and merengue dances, learning basic steps, partner work, and styling while enjoying the vibrant rhythms of Latin music.', '2020-02-24 7:00:00', '2020-02-25 8:00:00', '2020-02-17 7:00:00', '2020-02-22 7:00:00', 110, 16, '2020-02-23 7:00:00', 'Active', 0, 'Join our mindfulness retreat and recharge your mind, body, and soul!', 26, '2024-05-31 6:00:00', '2023-05-10 9:00:00', 'Online'),
(93, 'Bollywood Dance Class', 'Bollywood Dance Class: Learn Bollywood dance styles and perform energetic Bollywood routines.', 'Enroll in a Bollywood dance class to learn energetic and expressive dance styles from Indian cinema, mastering intricate footwork, gestures, and storytelling through dance.', '2022-12-20 2:00:00', '2023-01-04 3:00:00', '2022-12-13 2:00:00', '2022-12-18 2:00:00', 45, 57, '2022-12-19 2:00:00', 'Active', 0, 'Discover the art of origami at our paper folding workshop!', 24, '2024-06-01 6:00:00', '2023-05-11 9:00:00', 'On-site'),
(34, 'AcroYoga Workshop', 'AcroYoga Workshop: Combine acrobatics and yoga for partner-based balance and strength exercises.', 'Explore AcroYoga, a blend of acrobatics, yoga, and Thai massage, practicing partner poses, lifts, and balances to cultivate trust, strength, and connection with others.', '2023-10-01 3:00:00', '2023-10-16 4:00:00', '2023-09-17 3:00:00', '2023-09-22 3:00:00', 175, 58, '2023-09-23 3:00:00', 'Active', 0, 'Lets gather for a karaoke night and sing our hearts out!', 23, '2024-06-02 6:00:00', '2023-05-12 9:00:00', 'On-site'),
(205, 'Hip Hop Dance Crew', 'Hip Hop Dance Crew: Join a hip hop dance crew to learn hip hop dance styles and perform routines.', 'Join a hip hop dance crew to learn urban dance styles such as breaking, locking, and popping, mastering choreography and freestyle techniques while expressing personal style.', '2021-08-21 1:00:00', '2021-08-25 2:00:00', '2021-08-14 1:00:00', '2021-08-19 1:00:00', 145, 59, '2021-08-20 1:00:00', 'Active', 0, 'Join us for a historical reenactment event and step back in time!', 24, '2024-06-03 6:00:00', '2023-05-13 9:00:00', 'On-site'),
(17, 'Ballet Dance Training', 'Ballet Dance Training: Receive training in classical ballet technique and perform ballet choreography.', 'Attend ballet dance training sessions to refine technique, posture, and grace, mastering classical ballet movements and sequences while developing strength and flexibility.', '2024-05-10 14:00:00', '2024-05-25 15:00:00', '2024-04-26 14:00:00', '2024-05-01 14:00:00', 65, 60, '2024-05-02 14:00:00', 'Active', 0, 'Explore the world of astronomy with us at our telescope viewing party!', 26, '2024-06-04 6:00:00', '2023-05-14 9:00:00', 'On-site'),
(20, 'Zumba Fitness Party', 'Zumba Fitness Party: Dance to Latin and international music in a high-energy Zumba fitness class.', 'Join a Zumba fitness party to dance to upbeat rhythms and international music, burning calories, and boosting energy levels while having fun and sweating it out on the dance floor.', '2022-04-01 9:00:00', '2022-04-15 10:00:00', '2022-03-17 9:00:00', '2022-03-22 9:00:00', 155, 61, '2022-03-23 9:00:00', 'Active', 0, 'Lets gather for a bike repair workshop and learn basic maintenance skills!', 22, '2024-06-05 6:00:00', '2023-05-15 9:00:00', 'On-site'),
(68, 'Vinyasa Flow Dance', 'Vinyasa Flow Dance: Flow through yoga-inspired dance movements for flexibility and mindfulness.', 'Flow through a Vinyasa yoga-inspired dance practice, synchronizing breath with movement to create fluid sequences and transitions, promoting mindfulness and inner harmony.', '2021-01-02 19:00:00', '2021-01-16 20:00:00', '2020-12-14 19:00:00', '2020-12-19 19:00:00', 45, 62, '2020-12-20 19:00:00', 'Active', 0, 'Join our book swap event and exchange your favorite reads with others!', 23, '2024-06-06 6:00:00', '2023-05-16 9:00:00', 'On-site'),
(38, 'K-Pop Cover Dance Group', 'K-Pop Cover Dance Group: Form a K-pop cover dance group and perform K-pop song covers.', 'Form a K-Pop cover dance group with friends to learn and perform K-Pop music video choreographies, showcasing precision, creativity, and passion for Korean pop culture.', '2022-09-10 4:00:00', '2022-09-25 5:00:00', '2021-07-10 11:00:00', '2021-07-15 11:00:00', 110, 63, '2021-07-16 11:00:00', 'Active', 0, 'Discover the art of calligraphy at our handwriting improvement workshop!', 24, '2024-06-07 6:00:00', '2023-05-17 9:00:00', 'On-site'),
(101, 'Aerial Silk Dance', 'Aerial Silk Dance: Learn aerial silk techniques and perform aerial dance routines suspended in the air.', 'Experience the beauty and grace of aerial silk dance, performing stunning aerial maneuvers, wraps, and drops while suspended from silks, expressing creativity in the air.', '2023-01-27 20:00:00', '2023-01-30 20:00:00', '2023-01-17 5:00:00', '2023-01-22 5:00:00', 135, 62, '2023-01-23 5:00:00', 'Active', 0, 'Lets gather for a photography walk and capture the beauty of the city!', 25, '2024-06-08 6:00:00', '2023-05-18 9:00:00', 'On-site'),
(60, 'Salsa Dance Workshop', 'Salsa Dance Workshop: Learn salsa dance steps and techniques in a fun and social workshop setting.', 'Attend a salsa dance workshop to learn the fundamentals of salsa footwork, turns, and partnering techniques, mastering the rhythm and style of salsa dancing with confidence.', '2023-01-16 0:00:00', '2023-01-30 0:00:00', '2022-06-04 16:00:00', '2022-06-09 16:00:00', 160, 64, '2022-06-10 16:00:00', 'Active', 0, 'Join us for a pottery glazing workshop and add the finishing touches to your creations!', 26, '2024-06-09 6:00:00', '2023-05-19 9:00:00', 'On-site'),
(34, 'Contemporary Dance Class', 'Contemporary Dance Class: Take contemporary dance classes to explore modern dance styles and techniques.', 'Take a contemporary dance class to explore expressive movement, improvisation, and artistic interpretation, blending elements of ballet, jazz, and modern dance styles.', '2024-06-27 16:00:00', '2024-06-30 16:00:00', '2024-06-18 22:00:00', '2024-06-23 22:00:00', 70, 65, '2024-06-25 22:00:00', 'Active', 0, 'Dive into the world of robotics at our DIY robot building workshop!', 26, '2024-06-10 6:00:00', '2023-05-20 9:00:00', 'On-site'),
(93, 'Bhangra Dance Workshop', 'Bhangra Dance Workshop: Learn Bhangra dance moves and rhythms in a lively and cultural workshop.', 'Join a Bhangra dance workshop to learn energetic and vibrant Punjabi folk dance movements, celebrating culture, and community through rhythmic footwork and joyful expressions.', '2023-03-10 18:00:00', '2023-03-12 19:00:00', '2023-02-28 18:00:00', '2023-03-05 18:00:00', 120, 63, '2023-03-06 18:00:00', 'Active', 0, 'Lets gather for a potluck dinner and enjoy a variety of homemade dishes!', 24, '2024-06-11 6:00:00', '2023-05-21 9:00:00', 'On-site'),
(205, 'Partner Yoga Dance', 'Partner Yoga Dance: Practice partner yoga poses and movements for strength, balance, and connection.', 'Practice partner yoga poses and flows with a dance-inspired approach, deepening connections, and trust while exploring balance, flexibility, and alignment in synchronized movement.', '2022-09-12 10:00:00', '2022-09-19 11:00:00', '2021-08-31 3:00:00', '2021-09-05 3:00:00', 110, 65, '2021-09-06 3:00:00', 'Active', 0, 'Join our mindful eating workshop and cultivate a healthier relationship with food!', 23, '2024-06-12 6:00:00', '2023-05-22 9:00:00', 'On-site'),
(17, 'Jazz Funk Dance Class', 'Jazz Funk Dance Class: Explore jazz funk dance styles with upbeat and dynamic choreography.', 'Enroll in a jazz funk dance class to learn dynamic and high-energy dance routines, fusing jazz technique with street dance elements such as hip hop, funk, and urban dance styles.', '2024-01-28 13:00:00', '2024-01-30 1:00:00', '2024-01-20 13:00:00', '2024-01-25 13:00:00', 155, 65, '2024-01-26 13:00:00', 'Active', 0, 'Explore the world of virtual reality with us at our VR gaming night!', 24, '2024-06-13 6:00:00', '2023-05-23 9:00:00', 'On-site'),
(20, 'Pole Dance Fitness', 'Pole Dance Fitness: Learn pole dance fitness moves and routines for strength and flexibility.', 'Try pole dance fitness classes to build strength, flexibility, and confidence while learning pole tricks, spins, and choreography in a supportive and empowering environment.', '2023-05-29 6:00:00', '2023-06-14 7:00:00', '2023-04-08 1:00:00', '2023-04-13 1:00:00', 30, 64, '2023-04-14 1:00:00', 'Active', 0, 'Lets gather for a DIY home decor workshop and revamp our living spaces!', 22, '2024-06-14 6:00:00', '2023-05-24 9:00:00', 'On-site'),
(68, 'Oil Painting Class', 'Oil Painting Class: Take classes to learn oil painting techniques and create oil paintings.', 'Join an oil painting class to learn traditional oil painting techniques, exploring color mixing, brushwork, and composition to create stunning and expressive artworks.', '2020-07-26 3:00:00', '2020-08-11 4:00:00', '2020-07-08 18:00:00', '2020-07-13 18:00:00', 65, 66, '2020-07-18 18:00:00', 'Active', 0, 'Join us for a beach volleyball tournament and showcase your skills!', 27, '2024-06-15 6:00:00', '2023-05-25 9:00:00', 'On-site'),
(38, 'Sketching Workshop', 'Sketching Workshop: Improve sketching skills and techniques in drawing workshops.', 'Attend a sketching workshop to practice drawing fundamentals such as line, form, and shading, mastering observational drawing techniques and developing sketching skills.', '2022-11-25 20:00:00', '2022-12-12 21:00:00', '2022-05-05 6:00:00', '2022-05-10 6:00:00', 145, 67, '2022-05-15 6:00:00', 'Active', 0, 'Discover the art of glassblowing at our glass fusion workshop!', 28, '2024-06-16 6:00:00', '2023-05-26 9:00:00', 'On-site'),
(101, 'Clay Sculpture Class', 'Clay Sculpture Class: Learn clay sculpting techniques and create clay sculptures.', 'Take a clay sculpture class to learn hand-building techniques, sculpting forms, and textures in clay, expressing creativity and imagination through three-dimensional art.', '2020-11-28 20:00:00', '2020-11-30 20:00:00', '2020-11-11 20:00:00', '2020-11-16 20:00:00', 75, 67, '2020-11-22 20:00:00', 'Active', 0, 'Lets gather for a creative writing circle and share our stories!', 29, '2024-06-17 6:00:00', '2023-05-27 9:00:00', 'On-site'),
(60, 'Guitar Lessons', 'Guitar Lessons: Receive instruction in playing guitar and learning guitar techniques.', 'Learn to play the guitar with expert instruction, mastering chords, scales, and songs while developing technique, musicality, and appreciation for the art of guitar playing.', '2023-08-27 7:00:00', '2023-08-29 7:00:00', '2023-08-10 7:00:00', '2023-08-15 7:00:00', 90, 67, '2023-08-21 7:00:00', 'Active', 0, 'Join our gardening club and learn how to cultivate a beautiful garden!', 30, '2024-06-18 6:00:00', '2023-05-28 9:00:00', 'On-site'),
(101, 'Stone Carving Workshop', 'Stone Carving Workshop: Learn stone carving techniques and create stone sculptures.', 'Participate in a stone carving workshop to learn carving techniques, tools, and safety practices, sculpting stone into sculptures and exploring the tactile art of stone carving.', '2022-02-17 11:00:00', '2022-02-30 11:00:00', '2021-12-26 11:00:00', '2022-01-05 11:00:00', 40, 71, '2022-01-06 11:00:00', 'Active', 0, 'Lets gather for a knitting circle and work on our latest projects together!', 29, '2024-06-26 6:00:00', '2023-06-05 9:00:00', 'On-site'),
(93, 'Piano Recital Practice', 'Piano Recital Practice: Practice piano repertoire and prepare for piano recitals and performances.', 'Prepare for a piano recital with focused practice sessions, mastering pieces, technique, and musical expression to deliver a polished and captivating performance on the piano.', '2023-01-24 5:00:00', '2023-01-29 5:00:00', '2022-12-16 20:00:00', '2022-12-25 20:00:00', 75, 73, '2022-12-26 20:00:00', 'Active', 0, 'Join us for a sushi making class and learn the art of Japanese cuisine!', 30, '2024-06-27 6:00:00', '2023-06-06 9:00:00', 'On-site'),
(34, 'Choir Rehearsals', 'Choir Rehearsals: Rehearse vocal music pieces and choral arrangements with a choir group.', 'Rehearse with a choir to learn vocal harmonies, blend, and dynamics, preparing repertoire for performances and enjoying the camaraderie and joy of singing with others.', '2023-06-18 0:00:00', '2023-06-20 0:00:00', '2023-05-31 0:00:00', '2023-06-05 0:00:00', 115, 74, '2023-06-06 0:00:00', 'Active', 0, 'Discover the art of mixology at our cocktail crafting workshop!', 31, '2024-06-28 6:00:00', '2023-06-07 9:00:00', 'On-site'),
(68, 'Fiction Writing Group', 'Fiction Writing Group: Join a group to share and critique fiction writing works with other writers.', 'Join a fiction writing group to share and critique original works of fiction, receiving feedback, support, and inspiration from fellow writers in a collaborative writing community.', '2021-03-30 16:00:00', '2021-04-05 16:00:00', '2021-03-20 16:00:00', '2021-03-25 16:00:00', 40, 75, '2021-03-26 16:00:00', 'Active', 0, 'Lets gather for a DIY flower arrangement workshop and create beautiful bouquets!', 33, '2024-06-29 6:00:00', '2023-06-08 9:00:00', 'On-site'),
(205, 'Spoken Word Poetry Slam', 'Spoken Word Poetry Slam: Perform spoken word poetry in poetry slam events and competitions.', 'Participate in a spoken word poetry slam, performing original spoken word poetry in a competitive or open-mic setting, expressing emotion, and sharing stories through spoken word.', '2023-11-13 18:00:00', '2023-11-20 18:00:00', '2023-10-24 18:00:00', '2023-10-29 18:00:00', 180, 76, '2023-10-30 18:00:00', 'Active', 0, 'Join our hiking club and explore new trails every weekend!', 34, '2024-06-30 6:00:00', '2023-06-09 9:00:00', 'On-site'),
(17, 'Book Club Discussions', 'Book Club Discussions: Engage in discussions about books and literature with book club members.', 'Engage in book club discussions to explore and analyze literature, sharing insights, opinions, and reflections on selected books while connecting with fellow book enthusiasts.', '2021-09-09 3:00:00', '2021-09-11 3:00:00', '2021-08-05 10:00:00', '2021-08-10 10:00:00', 40, 73, '2021-08-11 10:00:00', 'Active', 0, 'Dive into the world of quantum physics at our science lecture series!', 35, '2024-07-01 6:00:00', '2023-06-10 9:00:00', 'On-site'),
(20, 'Mixed Media Art Class', 'Mixed Media Art Class: Explore mixed media art techniques and create mixed media artworks.', 'Experiment with mixed media techniques combining various materials such as paint, collage, and found objects to create eclectic and textured artworks in a mixed media art class.', '2024-06-06 13:00:00', '2024-06-11 14:00:00', '2024-05-12 0:00:00', '2024-05-17 0:00:00', 170, 76, '2024-05-18 0:00:00', 'Active', 0, 'Lets gather for a DIY perfume making workshop and create personalized scents!', 36, '2024-07-02 6:00:00', '2023-06-11 9:00:00', 'On-site'),
(38, 'Acrylic Painting Workshops', 'Acrylic Painting Workshops: Learn acrylic painting techniques and create acrylic paintings.', 'Learn acrylic painting techniques such as layering, blending, and texture effects in workshops focusing on creating vibrant and expressive acrylic paintings on canvas.', '2021-06-18 6:00:00', '2021-06-20 6:00:00', '2021-05-22 6:00:00', '2021-05-27 6:00:00', 5, 75, '2021-05-28 6:00:00', 'Active', 0, 'Join us for a paddleboarding adventure and glide across the water!', 27, '2024-07-03 6:00:00', '2023-06-12 9:00:00', 'On-site'),
(60, 'Start-up Incubator Program', 'Start-up Incubator Program: Join an incubator program to develop and launch startup business ideas.', 'Participate in a start-up incubator program designed to support aspiring entrepreneurs in developing and launching their business ideas, providing mentorship, resources, and networking opportunities.', '2022-04-22 3:00:00', '2022-04-23 3:00:00', '2022-04-12 3:00:00', '2022-04-17 3:00:00', 145, 77, '2022-04-18 3:00:00', 'Active', 0, 'Discover the art of pottery hand-building at our clay sculpting workshop!', 37, '2024-07-04 6:00:00', '2023-06-13 9:00:00', 'On-site'),
(101, 'Digital Marketing Workshop', 'Digital Marketing Workshop: Learn digital marketing strategies and techniques for promoting businesses online.', 'Attend a digital marketing workshop to learn strategies and techniques for online marketing, including social media marketing, SEO, and content marketing, to promote businesses and reach target audiences.', '2020-11-22 13:00:00', '2020-11-25 13:00:00', '2020-11-11 13:00:00', '2020-11-16 13:00:00', 165, 78, '2020-11-17 13:00:00', 'Active', 0, 'Lets gather for a DIY jewelry making workshop and craft unique accessories!', 38, '2024-07-05 6:00:00', '2023-06-14 9:00:00', 'On-site'),
(93, 'Financial Planning Seminar', 'Financial Planning Seminar: Attend seminars to learn about financial planning, budgeting, and investment strategies.', 'Join a financial planning seminar to learn about budgeting, investing, retirement planning, and wealth management, gaining essential knowledge and skills for personal and business financial success.', '2023-08-27 0:00:00', '2022-08-30 11:00:00', '2023-08-10 0:00:00', '2023-08-15 0:00:00', 65, 79, '2023-08-16 0:00:00', 'Active', 0, 'Join our storytelling circle and share your favorite tales!', 39, '2024-07-06 6:00:00', '2023-06-15 9:00:00', 'On-site'),
(34, 'E-commerce Website Development', 'E-commerce Website Development: Learn to develop and manage e-commerce websites for online businesses.', 'Learn to develop and manage e-commerce websites, including design, product listings, payment gateways, and customer experience optimization, to establish an online presence and drive sales for businesses.', '2024-09-23 15:00:00', '2024-09-26 16:00:00', '2024-03-20 9:00:00', '2024-03-25 9:00:00', 160, 80, '2024-03-26 9:00:00', 'Active', 0, 'Lets gather for a DIY woodworking workshop and create handmade furniture!', 40, '2024-07-07 6:00:00', '2023-06-16 9:00:00', 'On-site'),
(68, 'Supply Chain Management Course', 'Supply Chain Management Course: Learn about logistics and supply chain management strategies for business operations.', 'Enroll in a supply chain management course to learn about logistics, inventory management, transportation, and procurement strategies, optimizing supply chain operations for efficiency and cost-effectiveness.', '2023-02-20 6:00:00', '2023-02-23 7:00:00', '2022-12-22 16:00:00', '2023-01-27 16:00:00', 105, 81, '2023-01-28 16:00:00', 'Active', 0, 'Join us for a day of outdoor rock climbing and conquer new heights!', 41, '2024-07-08 6:00:00', '2023-06-17 9:00:00', 'On-site'),
(205, 'Business Idea Pitch Competition', 'Business Idea Pitch Competition: Pitch business ideas to a panel of judges in a competition format.', 'Participate in a business idea pitch competition to present innovative business ideas to a panel of judges, receiving feedback, and potentially securing funding or support to turn ideas into viable businesses.', '2023-11-01 5:00:00', '2023-11-09 6:00:00', '2023-09-24 4:00:00', '2023-10-29 4:00:00', 55, 79, '2023-10-30 4:00:00', 'Active', 0, 'Discover the art of fermentation at our kombucha brewing workshop!', 42, '2024-07-09 6:00:00', '2023-06-18 9:00:00', 'On-site'),
(17, 'Entrepreneurship Bootcamp', 'Entrepreneurship Bootcamp: Attend bootcamp sessions to develop entrepreneurial skills and mindset.', 'Join an entrepreneurship bootcamp to learn essential skills for starting and running a business, including idea generation, market research, business planning, and pitching, in an immersive and hands-on learning environment.', '2024-09-15 20:00:00', '2024-09-16 21:00:00', '2024-08-26 16:00:00', '2024-09-03 16:00:00', 25, 82, '2024-09-04 16:00:00', 'Active', 0, 'Lets gather for a DIY herb gardening workshop and grow fresh herbs at home!', 37, '2024-07-10 6:00:00', '2023-06-19 9:00:00', 'On-site'),
(20, 'Social Media Marketing Course', 'Social Media Marketing Course: Learn social media marketing strategies for business promotion and engagement.', 'Enroll in a social media marketing course to learn how to leverage social media platforms for business growth, including advertising, engagement strategies, and analytics, to reach and engage target audiences effectively.', '2020-05-17 12:00:00', '2020-05-26 13:00:00', '2020-04-17 18:00:00', '2020-04-27 18:00:00', 95, 83, '2020-04-28 18:00:00', 'Active', 0, 'Join our astronomy club and explore the mysteries of the universe!', 38, '2024-07-11 6:00:00', '2023-06-20 9:00:00', 'On-site'),
(38, 'Financial Analysis Workshop', 'Financial Analysis Workshop: Learn financial analysis techniques for assessing business performance and making decisions.', 'Attend a financial analysis workshop to learn how to analyze financial statements, assess business performance, and make informed financial decisions, enhancing financial literacy and management skills for businesses.', '2023-12-09 9:00:00', '2023-12-24 10:00:00', '2023-11-21 22:00:00', '2023-11-26 22:00:00', 180, 80, '2023-11-27 22:00:00', 'Active', 0, 'Embark on a thrilling scuba diving adventure and discover underwater wonders!', 39, '2024-07-12 6:00:00', '2023-06-21 9:00:00', 'On-site'),
(68, 'Content Marketing Strategy Seminar', 'Content Marketing Strategy Seminar: Learn content marketing strategies for attracting and engaging target audiences.', 'Join a content marketing strategy seminar to learn how to create and execute content marketing plans, including content creation, distribution, and measurement, to attract and engage audiences and drive business growth.', '2024-12-30 23:00:00', '2025-01-14 0:00:00', '2024-09-04 16:00:00', '2024-09-09 16:00:00', 50, 16, '2024-09-10 16:00:00', 'Active', 0, 'Join our bookbinding workshop and learn to bind your own books!', 38, '2024-07-17 6:00:00', '2023-06-26 9:00:00', 'Online'),
(205, 'Financial Risk Management Course', 'Financial Risk Management Course: Learn risk management techniques for financial stability and resilience.', 'Enroll in a financial risk management course to learn how to identify, assess, and mitigate financial risks such as market risk, credit risk, and operational risk, ensuring the stability and resilience of businesses.', '2024-09-20 20:00:00', '2024-09-28 21:00:00', '2024-06-17 22:00:00', '2024-06-22 22:00:00', 130, 16, '2024-06-23 22:00:00', 'Active', 0, 'Discover the art of Thai cooking at our authentic cooking class!', 39, '2024-07-18 6:00:00', '2023-06-27 9:00:00', 'Online'),
(17, 'Online Retail Business Development', 'Online Retail Business Development: Develop and grow online retail businesses with market research and strategies.', 'Learn strategies for developing and growing online retail businesses, including market research, product sourcing, branding, and customer acquisition, to establish successful e-commerce ventures.', '2023-03-09 16:00:00', '2023-03-11 17:00:00', '2023-02-28 18:00:00', '2023-03-05 18:00:00', 165, 16, '2023-03-06 18:00:00', 'Active', 0, 'Lets gather for a DIY succulent planting workshop and create beautiful arrangements!', 40, '2024-07-19 6:00:00', '2023-06-28 9:00:00', 'Online'),
(20, 'Distribution Logistics Optimization', 'Distribution Logistics Optimization: Optimize distribution logistics for efficient supply chain operations.', 'Explore techniques for optimizing distribution logistics, including route planning, warehouse location, and inventory management, to streamline operations and enhance efficiency in the supply chain.', '2022-01-06 19:00:00', '2022-01-21 19:00:00', '2021-08-31 3:00:00', '2021-09-08 3:00:00', 125, 16, '2021-09-09 3:00:00', 'Active', 0, 'Join us for a photography scavenger hunt and capture unique shots around the city!', 41, '2024-07-20 6:00:00', '2023-06-29 9:00:00', 'Online'),
(38, 'Business Pitch Practice Sessions', 'Business Pitch Practice Sessions: Practice pitching business ideas and receiving feedback from peers and mentors.', 'Participate in business pitch practice sessions to refine presentation skills, storytelling, and delivery, preparing for pitching opportunities such as investor meetings, competitions, or networking events.', '2023-04-01 8:00:00', '2023-04-04 8:00:00', '2022-01-20 13:00:00', '2022-01-27 13:00:00', 75, 16, '2022-01-28 13:00:00', 'Active', 0, 'Explore the world of marine biology at our aquarium behind-the-scenes tour!', 42, '2024-07-21 6:00:00', '2023-06-30 9:00:00', 'Online'),
(60, 'Lean Startup Methodology Workshop', 'Lean Startup Methodology Workshop: Learn lean startup principles for building and growing businesses efficiently.', 'Join a workshop on lean startup methodology to learn how to build and grow businesses efficiently, using iterative experimentation, validated learning, and agile principles to develop products and services.', '2024-02-14 18:00:00', '2024-02-18 18:00:00', '2023-04-08 1:00:00', '2023-04-13 1:00:00', 185, 16, '2023-04-14 1:00:00', 'Active', 0, 'Lets gather for a DIY terrarium building workshop and create miniature ecosystems!', 37, '2024-07-22 6:00:00', '2023-07-01 9:00:00', 'Online'),
(101, 'Outdoor Adventure Expedition', 'Outdoor Adventure Expedition: Embark on outdoor adventure trips such as camping, hiking, and backpacking.', 'Embark on an outdoor adventure expedition, such as camping, hiking, or backpacking, to explore nature, build resilience, and develop outdoor survival skills in rugged environments.', '2021-07-06 3:00:00', '2021-07-19 4:00:00', '2020-07-01 18:00:00', '2020-07-13 18:00:00', 50, 16, '2020-07-18 18:00:00', 'Active', 0, 'Join our pottery glazing masterclass and perfect your glazing techniques!', 43, '2024-07-23 6:00:00', '2023-07-02 9:00:00', 'Online'),
(93, 'Cultural Exchange Program', 'Cultural Exchange Program: Immerse in different cultures and traditions through cultural exchange activities.', 'Participate in a cultural exchange program to immerse yourself in different cultures, traditions, and languages, fostering intercultural understanding and global citizenship.', '2023-04-19 15:00:00', '2023-04-25 16:00:00', '2021-03-24 23:00:00', '2022-05-12 6:00:00', 120, 16, '2022-05-13 6:00:00', 'Active', 0, 'Discover the art of macrame at our knot tying workshop!', 43, '2024-07-24 6:00:00', '2023-07-03 9:00:00', 'Online'),
(34, 'Leadership Development Retreat', 'Leadership Development Retreat: Enhance leadership skills and teamwork through retreats and workshops.', 'Attend a leadership development retreat to enhance leadership skills, teamwork, and communication abilities through experiential activities, workshops, and group discussions.', '2023-12-19 11:00:00', '2023-12-25 12:00:00', '2023-12-04 11:00:00', '2023-12-15 20:00:00', 145, 84, '2023-12-16 20:00:00', 'Active', 0, 'Lets gather for a DIY screen printing workshop and design custom shirts!', 43, '2024-07-25 6:00:00', '2023-07-04 9:00:00', 'On-site'),
(68, 'Community Service Initiative', 'Community Service Initiative: Engage in community service activities to give back and make a positive impact.', 'Engage in community service initiatives such as volunteering at local shelters, organizing environmental cleanups, or assisting with social welfare programs to give back to the community.', '2023-09-07 14:00:00', '2023-09-20 15:00:00', '2023-08-01 14:00:00', '2023-08-20 7:00:00', 90, 85, '2023-08-21 7:00:00', 'Active', 0, 'Join us for a chocolate making class and indulge in sweet creations!', 43, '2024-07-26 6:00:00', '2023-07-05 9:00:00', 'On-site'),
(205, 'Personal Growth Workshop', 'Personal Growth Workshop: Explore self-discovery and personal development through workshops and activities.', 'Join a personal growth workshop to explore self-discovery, goal-setting, and mindfulness practices, fostering personal development, resilience, and well-being.', '2024-10-17 1:00:00', '2024-10-22 2:00:00', '2023-09-30 1:00:00', '2024-03-30 9:00:00', 115, 86, '2024-03-31 9:00:00', 'Active', 0, 'Embark on a scenic hot air balloon ride and admire breathtaking views from above!', 43, '2024-07-27 6:00:00', '2023-07-06 9:00:00', 'On-site'),
(17, 'Creative Expression Retreat', 'Creative Expression Retreat: Retreat into creative expression through art, music, and writing activities.', 'Retreat into creative expression through art, music, writing, or other mediums, allowing for self-expression, reflection, and rejuvenation in a supportive and inspiring environment.', '2021-08-23 10:00:00', '2021-08-31 11:00:00', '2020-08-16 10:00:00', '2020-12-25 16:00:00', 120, 87, '2021-01-26 16:00:00', 'Active', 0, 'Lets gather for a DIY kombucha tasting workshop and sample homemade brews!', 43, '2024-07-28 6:00:00', '2023-07-07 9:00:00', 'On-site'),
(20, 'Team Building Challenge Course', 'Team Building Challenge Course: Navigate through challenge courses for team building and cooperation.', 'Navigate through a team-building challenge course featuring high ropes, obstacle courses, and cooperative activities, fostering teamwork, trust, and problem-solving skills.', '2024-07-18 7:00:00', '2024-07-21 8:00:00', '2024-07-11 7:00:00', '2023-07-15 4:00:00', 85, 86, '2023-07-16 4:00:00', 'Active', 0, 'Join our jewelry making workshop and craft unique pieces to treasure!', 43, '2024-07-29 6:00:00', '2023-07-08 9:00:00', 'On-site'),
(38, 'Mindfulness Meditation Retreat', 'Mindfulness Meditation Retreat: Cultivate mindfulness and relaxation through meditation retreats.', 'Experience a mindfulness meditation retreat to cultivate presence, relaxation, and inner peace through guided meditation, yoga, and mindfulness practices in a tranquil setting.', '2022-05-31 17:00:00', '2022-06-01 18:00:00', '2022-05-17 17:00:00', '2022-05-28 16:00:00', 155, 86, '2022-05-30 16:00:00', 'Active', 0, 'Discover the art of watercolor painting at our beginners workshop!', 43, '2024-07-30 6:00:00', '2023-07-09 9:00:00', 'On-site'),
(60, 'Innovation and Design Thinking Workshop', 'Innovation and Design Thinking Workshop: Explore innovation and design thinking for creative problem-solving.', 'Participate in an innovation and design thinking workshop to cultivate creativity, problem-solving, and innovation skills through brainstorming, prototyping, and user-centric design methods.', '2021-03-14 23:00:00', '2021-03-17 0:00:00', '2021-03-07 23:00:00', '2021-05-01 8:00:00', 5, 86, '2021-05-02 8:00:00', 'Active', 0, 'Lets gather for a DIY fermentation workshop and make homemade pickles!', 43, '2024-07-31 6:00:00', '2023-07-10 9:00:00', 'On-site'),
(101, 'Wellness and Self-Care Retreat', 'Wellness and Self-Care Retreat: Retreat into wellness and self-care with yoga, meditation, and spa treatments.', 'Retreat into wellness and self-care with activities such as yoga, meditation, spa treatments, and nature walks, prioritizing self-care, relaxation, and holistic well-being.', '2024-01-06 22:00:00', '2024-01-12 22:00:00', '2023-10-30 15:00:00', '2023-12-15 21:00:00', 40, 87, '2023-12-16 21:00:00', 'Active', 0, 'Join us for a guided horseback riding tour through picturesque landscapes!', 43, '2024-08-01 6:00:00', '2023-07-11 9:00:00', 'On-site');

INSERT INTO `unityDoDB`.`image` (`activityId`, `label`, `alt`, `imagepath`) VALUES
(11, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA1%2FArt%26MusicA01-1.jpg?alt=media&token=2b8ee897-f572-44c4-b186-844d9d7698ad'),
(11, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA1%2FArt%26MusicA01-2.jpg?alt=media&token=e793c895-8b4c-42dc-8745-7c19ca9248ef'),
(11, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA1%2FArt%26MusicA01-3.jpg?alt=media&token=d5186102-8396-4217-b14f-8893765c90d5'),
(11, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA1%2FArt%26MusicA01-4.jpg?alt=media&token=c44f8c1a-74fc-4b59-923c-3e152d9d67e5'),
(11, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA1%2FArt%26MusicA01-5.jpg?alt=media&token=26bfcb29-bd4f-40b1-9c2c-99098497806a'),
(12, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA2%2Fpexels-rdne-stock-project-6646918.jpg?alt=media&token=67a5aec3-d96a-46bf-9965-450129c7595a'),
(12, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA2%2Fpexels-rdne-stock-project-6646967.jpg?alt=media&token=a1cf6471-3436-4eee-9fee-0368dbbebb08'),
(12, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA2%2Fpexels-rdne-stock-project-6646992.jpg?alt=media&token=30adcb5f-3220-4679-9d87-23db58bebdfe'),
(12, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA2%2Fpexels-rdne-stock-project-6647037.jpg?alt=media&token=a1b09fef-4cd8-475c-a449-00409aadd6fe'),
(12, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA2%2Fpexels-rdne-stock-project-6647110.jpg?alt=media&token=2431517d-56c7-405b-a18e-f72740ebf0a2'),
(13, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA3%2Fpexels-cottonbro-studio-6590920.jpg?alt=media&token=e7806c5e-16e0-4a04-a45e-c9ab138cd23b'),
(13, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA3%2Fpexels-julia-m-cameron-6994982.jpg?alt=media&token=18ea7f59-a70b-48dc-8a9a-bdcfc12186d2'),
(13, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA3%2Fpexels-julia-m-cameron-6994992.jpg?alt=media&token=32e13e1d-9d19-4209-8d18-128c823ccda3'),
(13, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA3%2Fpexels-julia-m-cameron-6995201.jpg?alt=media&token=3ed85c54-6dba-4b3b-a9d6-2eee2a167ecf'),
(14, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA5%2Fpexels-julia-m-cameron-6994855.jpg?alt=media&token=4c02d096-030f-40dc-b483-b1bca54db33a'),
(14, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA4%2Fpexels-lara-jameson-9324313.jpg?alt=media&token=df7e7c70-f07b-4584-ac39-e0c5b3298d77'),
(14, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA4%2Fpexels-rdne-stock-project-6646907.jpg?alt=media&token=6f8567b7-0804-43b0-9c40-88b43e2c4768'),
(14, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA4%2Fpexels-rdne-stock-project-6647115.jpg?alt=media&token=ae448495-e513-49f9-a28e-9dec752679be'),
(15, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA6%2Fpexels-rdne-stock-project-6646903.jpg?alt=media&token=d7acc511-cf0d-4d43-90d3-9d3c3ade1db2'),
(15, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA5%2Fpexels-julia-m-cameron-6995201.jpg?alt=media&token=5c262bc0-2902-4782-965e-40d5f0fb2158'),
(15, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA5%2Fpexels-julia-m-cameron-6995244.jpg?alt=media&token=c58a5c2b-145e-47aa-b673-314b39485a08'),
(16, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA7%2Fpexels-anna-shvets-5029923.jpg?alt=media&token=8c126891-15f4-42b0-afe5-632fdd04a711'),
(16, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA6%2Fpexels-rdne-stock-project-6646904.jpg?alt=media&token=262ddedf-e007-413f-b8fe-c143629b18ee'),
(16, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA6%2Fpexels-rdne-stock-project-6647121.jpg?alt=media&token=dd091642-7bdc-456e-80bc-1f3cfd731894'),
(17, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA8%2Fpexels-cottonbro-studio-6565744.jpg?alt=media&token=d2710a62-3854-4826-acfa-226e00c9b36c'),
(17, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA7%2Fpexels-cottonbro-studio-6591161.jpg?alt=media&token=e0b447d8-4d8b-4eb5-ba91-caa91a76bb2c'),
(18, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA9%2Fpexels-rdne-stock-project-6646948.jpg?alt=media&token=60eb688d-5ff6-4375-862e-6e91410daa87'),
(18, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA8%2Fpexels-cottonbro-studio-6565746.jpg?alt=media&token=4fed93b0-6505-433a-a77e-c3b70d9a4198'),
(18, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA8%2Fpexels-cottonbro-studio-6565752.jpg?alt=media&token=44dd0a7a-dac6-4bd7-b9a2-1ba5e8a6e86f'),
(19, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA10%2Fpexels-ron-lach-9543399.jpg?alt=media&token=6a6794bc-b0b0-4886-9faf-468872392d33'),
(19, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA9%2Fpexels-rdne-stock-project-6646987.jpg?alt=media&token=899a6b8c-9bbd-45f9-add4-4391d7f21da5'),
(19, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA9%2Fpexels-rdne-stock-project-6647004.jpg?alt=media&token=d485ec91-98e0-4479-9fd7-8b0639f95089'),
(19, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA9%2Fpexels-rdne-stock-project-6647013.jpg?alt=media&token=3fccb90f-b85b-426f-971d-8ed3f9cf32c0'),
(19, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA9%2Fpexels-rdne-stock-project-6647016.jpg?alt=media&token=9bb87648-79c7-4fd5-8f18-2a1723419ee0'),
(20, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA11%2Fpexels-julia-m-cameron-6995212.jpg?alt=media&token=a23c2039-306e-4b09-8642-86bde90de7ff'),
(20, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA10%2Fpexels-ron-lach-9543402.jpg?alt=media&token=451b2304-1109-46f5-b439-7d185fb7f14f'),
(21, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA12%2Fpexels-julia-m-cameron-6994965.jpg?alt=media&token=578ce6cd-8704-448e-b24e-d0c41a94fd5c'),
(21, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA11%2Fpexels-julia-m-cameron-6995235.jpg?alt=media&token=d1930b56-b724-42c0-802c-4e0927df4ca9'),
(21, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA11%2Fpexels-julia-m-cameron-6995298.jpg?alt=media&token=ba7e72d8-871f-4cff-860e-8be8b2cbc7f4'),
(22, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA13%2Fpexels-ron-lach-8989994.jpg?alt=media&token=0c5d1420-3c6a-4a36-bf90-37a54958ffec'),
(22, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA12%2Fpexels-julia-m-cameron-6994994.jpg?alt=media&token=5e7e55b7-dab0-4fdd-8ffb-bda4e79e193e'),
(23, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA14%2Fpexels-antoni-shkraba-7345482.jpg?alt=media&token=51244107-74c6-48ea-b1a3-542507dfa4f8'),
(23, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA13%2Fpexels-ron-lach-9034660.jpg?alt=media&token=c6112aff-3f5a-4402-ad63-cd8acb4f7cbc'),
(24, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA15%2Fpexels-mikhail-nilov-8543576.jpg?alt=media&token=1da1560b-5e2b-4385-b0d0-d0b7542e8b03'),
(24, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA14%2Fpexels-lara-jameson-9324334.jpg?alt=media&token=0c250aec-e5a7-4cbc-ba5c-1b6784963cfa'),
(25, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA16%2Fpexels-anna-shvets-5029811.jpg?alt=media&token=49fac7b8-a309-4646-8489-0a96f3c60c20'),
(25, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA15%2Fpexels-thirdman-7655649.jpg?alt=media&token=cd309aa5-3155-4c3f-b1c6-06a3c481c20b'),
(25, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA15%2Fpexels-thirdman-7656748.jpg?alt=media&token=c92becdd-db1f-4709-85ae-219f8a415e84'),
(26, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA17%2Fpexels-kampus-production-7551580.jpg?alt=media&token=81f18a91-5a12-4fef-9c00-531d13303619'),
(26, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA16%2Fpexels-anna-shvets-5029862.jpg?alt=media&token=0e8c53cd-035d-414f-9270-cc142f0453c6'),
(26, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA16%2Fpexels-anna-shvets-5029864.jpg?alt=media&token=09139528-9df6-4519-bb4e-bdc450437585'),
(27, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA18%2Fpexels-cottonbro-studio-6590931.jpg?alt=media&token=f41f8dcc-e9db-44a5-bed2-e21d2db376f5'),
(27, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA17%2Fpexels-kampus-production-7551587.jpg?alt=media&token=3229f793-9944-4a8b-bce8-816bfd645bb6'),
(28, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA1%2Fpexels-andrea-piacquadio-864994.jpg?alt=media&token=b1c292cd-dcd0-47c4-931a-f9bd584ee9b3'),
(28, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA18%2Fpexels-cottonbro-studio-6591152.jpg?alt=media&token=8111113f-4e23-4743-a020-33f1aa1de0af'),
(28, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Volunteer%2FA18%2Fpexels-cottonbro-studio-6591166.jpg?alt=media&token=ce80aedb-8309-4acf-9dc2-7b7450e7821b'),
(29, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA2%2Fpexels-christina-morillo-1181474.jpg?alt=media&token=6a686bd9-bcee-465f-9c19-13a41d0a1247'),
(29, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA1%2Fpexels-anthony-%F0%9F%99%82-157526.jpg?alt=media&token=5883ed91-23af-4e00-a19e-b487a82ff133'),
(29, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA1%2Fpexels-buro-millennial-1438081.jpg?alt=media&token=2cf5cf91-2d85-4555-b364-83d207c61f76'),
(29, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA1%2Fpexels-christina-morillo-1181233.jpg?alt=media&token=23858ff5-17fb-42cc-be3e-59c156c86638'),
(30, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA3%2Fpexels-element-digital-1370298.jpg?alt=media&token=efc64bac-e8f8-48f4-895d-ae8575f671fa'),
(30, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA2%2Fpexels-christina-morillo-1181534.jpg?alt=media&token=bf3b95dc-7d89-4bc6-9053-a865079c3855'),
(30, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA2%2Fpexels-christina-morillo-1181677.jpg?alt=media&token=b71d58e8-ce54-4dca-84ea-2c3f2e2fe536'),
(30, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA2%2Fpexels-element-digital-1370296.jpg?alt=media&token=384bcd15-4983-4470-9a9b-8ae05394277d'),
(31, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA4%2Fpexels-emily-ranquist-1205651.jpg?alt=media&token=07f91cb2-5ac8-41e8-bff6-e10f7433bdb1'),
(31, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA3%2Fpexels-emily-ranquist-1205651.jpg?alt=media&token=80aa01e5-14a9-4b98-ad21-fe56676d6223'),
(31, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA3%2Fpexels-fox-1595385.jpg?alt=media&token=b2a7af3b-f9a1-4d4f-b803-43ac7fb2aecd'),
(31, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA3%2Fpexels-fox-1595391.jpg?alt=media&token=862b6dba-9014-4423-a56d-c548e4b72673'),
(31, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA3%2Fpexels-frans-van-heerden-632470.jpg?alt=media&token=f69cde11-2f00-49a5-9b10-c54867ca13c0'),
(31, 'activityDetail5', 'activityDetail5', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA2%2Fpexels-christina-morillo-1181677.jpg?alt=media&token=b71d58e8-ce54-4dca-84ea-2c3f2e2fe536'),
(32, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA5%2Fpexels-george-dolgikh-1326947.jpg?alt=media&token=dbeffeef-7bc8-48f6-b310-8fe2c0f75734'),
(32, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA4%2Fpexels-fox-1595385.jpg?alt=media&token=5be94e8b-0b81-4f30-a2d6-2574c94dfe3b'),
(32, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA4%2Fpexels-fox-1595391.jpg?alt=media&token=1484ee44-20d2-4730-aef5-5aec76f8212a'),
(33, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA6%2Fpexels-jens-mahnke-1090941.jpg?alt=media&token=21a9bf11-d565-4361-9fd6-4481775f3adb'),
(33, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA5%2Fpexels-helena-lopes-1015568.jpg?alt=media&token=eed46bdc-e0cc-402f-b2c9-115d67e4c45d'),
(33, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA5%2Fpexels-helena-lopes-933964.jpg?alt=media&token=d6908a3a-ef58-44a9-904c-39b1e6ee3d39'),
(34, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA7%2Fpexels-julia-m-cameron-4144527.jpg?alt=media&token=010859fa-7f20-466d-9035-fb3b8093f1b4'),
(34, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA6%2Fpexels-julia-m-cameron-4144101.jpg?alt=media&token=a5510123-e0e2-4b5b-9d47-7edb584dd542'),
(35, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA8%2Fpexels-min-an-1313809.jpg?alt=media&token=b96bd844-d0c1-4814-983f-672c4fe9917d'),
(35, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA7%2Fpexels-julia-m-cameron-4144923.jpg?alt=media&token=2966eeec-0f1e-458a-a12a-7bb9968064fe'),
(35, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA7%2Fpexels-julia-m-cameron-4145153.jpg?alt=media&token=0d2229e9-b1bd-49ed-82f7-d1182b9b0f72'),
(35, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA7%2Fpexels-max-fischer-5212345.jpg?alt=media&token=b7be557f-1cf7-404a-800b-bfd6f202e79d'),
(36, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA8%2Fpexels-min-an-1313809.jpg?alt=media&token=b96bd844-d0c1-4814-983f-672c4fe9917d'),
(36, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA8%2Fpexels-naomi-shi-1001914.jpg?alt=media&token=b33e6491-d223-48ce-a64e-7bf0945eb6e3'),
(36, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA8%2Fpexels-nubia-navarro-(nubikini)-1110355.jpg?alt=media&token=3ff79b0c-3ed2-4434-ae0e-2e305d51a977'),
(37, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA9%2Fpexels-oleksandr-p-2781814.jpg?alt=media&token=c64fc3df-b166-4e51-a5ea-2259a5970f1f'),
(37, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA8%2Fpexels-naomi-shi-1001914.jpg?alt=media&token=b33e6491-d223-48ce-a64e-7bf0945eb6e3'),
(37, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA8%2Fpexels-nubia-navarro-(nubikini)-1110355.jpg?alt=media&token=3ff79b0c-3ed2-4434-ae0e-2e305d51a977'),
(38, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA10%2Fpexels-olia-danilevich-5088017.jpg?alt=media&token=8f4b9eeb-a733-439e-b197-caced63faa89'),
(38, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA9%2Fpexels-olia-danilevich-5088008.jpg?alt=media&token=417f3ab4-27ad-470a-b2b2-f8e727a608ca'),
(39, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA11%2Fpexels-pixabay-159711.jpg?alt=media&token=3ee945f7-2e0e-40e6-aaaf-0f6eeee29e49'),
(39, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA10%2Fpexels-perfecto-capucine-1329571.jpg?alt=media&token=5793ebe2-6f6e-44a0-a1c8-488d130a3e70'),
(39, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA10%2Fpexels-pixabay-159213.jpg?alt=media&token=aefb380c-92ea-49a3-8102-22223cf09509'),
(40, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA12%2Fpexels-pixabay-159866.jpg?alt=media&token=5406362b-6466-4767-b1c8-29a6252127e2'),
(40, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA11%2Fpexels-pixabay-159751.jpg?alt=media&token=031cc95f-2216-4d3f-b1bc-4ddc106cd60c'),
(40, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA11%2Fpexels-pixabay-159775.jpg?alt=media&token=32707ce7-2327-47e5-915e-ef708d17d5ba'),
(40, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA11%2Fpexels-pixabay-159844.jpg?alt=media&token=ed9ecdb0-77e7-46be-a320-ec36f2a040e9'),
(41, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA13%2Fpexels-pixabay-256417.jpg?alt=media&token=752c62ca-b965-4727-bbc5-2fd17ef82484'),
(41, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA12%2Fpexels-pixabay-163064.jpg?alt=media&token=299547ae-50e1-4932-8726-637f807d7c15'),
(41, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA12%2Fpexels-pixabay-207732.jpg?alt=media&token=fcad0549-ba7a-4266-806a-f9c94a9e23df'),
(41, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA12%2Fpexels-pixabay-256417.jpg?alt=media&token=58408361-9900-4fe0-8dc1-5ceadaacc90e'),
(41, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA12%2Fpexels-pixabay-256455.jpg?alt=media&token=fd951266-fc54-4046-83b5-903104213723'),
(41, 'activityDetail5', 'activityDetail5', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA11%2Fpexels-pixabay-159751.jpg?alt=media&token=031cc95f-2216-4d3f-b1bc-4ddc106cd60c'),
(42, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA15%2Fpexels-pixabay-267885.jpg?alt=media&token=d810a9d5-c967-4981-a90d-c021eeb5d567'),
(42, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA13%2Fpexels-pixabay-256455.jpg?alt=media&token=11466864-0b0d-471d-b781-1715f752a1f3'),
(43, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA16%2Fpexels-pixabay-433333.jpg?alt=media&token=f3ad5e30-8159-4491-8d10-7c2a746a14d6'),
(43, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA15%2Fpexels-pixabay-270640.jpg?alt=media&token=b70330f6-9082-45e4-9f2e-3da420c2387a'),
(43, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA15%2Fpexels-pixabay-289737.jpg?alt=media&token=5453b5a2-9441-4e17-9aeb-5465210b8198'),
(44, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA17%2Fpexels-pixabay-261719.jpg?alt=media&token=235f66cd-933f-4158-941f-76558daaa452'),
(44, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA16%2Fpexels-te-lensfix-1083728.jpg?alt=media&token=c1fd71e2-6bed-4044-a728-ffc74f2cebcc'),
(44, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA16%2Fpexels-thisisengineering-3862130.jpg?alt=media&token=364437bf-b361-4be9-b169-d9c0aaf06536'),
(45, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA18%2Fpexels-tim-gouw-175658.jpg?alt=media&token=4aa35d96-5d10-499b-b9ca-d10f7272c249'),
(45, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA17%2Fpexels-pixabay-262034.jpg?alt=media&token=db91a014-a0dc-4a38-becb-decfb7841f1c'),
(45, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA17%2Fpexels-visual-tag-mx-2566581.jpg?alt=media&token=20a37fb2-b594-499f-9362-f2d4285f6b45'),
(45, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA17%2Fpexels-ylanite-koppens-1809340.jpg?alt=media&token=0b4d3173-9aa3-434c-9e8f-8dd0377bcc59'),
(45, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA17%2Fpexels-%D0%B0%D0%BB%D0%B5%D0%BA%D1%81%D0%B0%D0%BD%D0%B4%D0%B0%D1%80-%D1%86%D0%B2%D0%B5%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%B8%D1%9B-1422292.jpg?alt=media&token=c5c24f78-a660-4bc1-8e0a-de306229dd64'),
(45, 'activityDetail5', 'activityDetail5', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA20%2Fpexels-pixabay-256517.jpg?alt=media&token=c8e55fb0-9692-4b5e-8927-3fb6965e9142'),
(46, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA19%2Fpexels-andrea-piacquadio-3769138.jpg?alt=media&token=cf0f37ae-9b41-4e0e-a529-4805db1cdec1'),
(46, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA18%2Fpexels-wesley-davi-3622614.jpg?alt=media&token=626726c7-30d9-47c2-b840-016d6428d52c'),
(47, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA20%2Fpexels-karolina-grabowska-4498039.jpg?alt=media&token=4db21d78-02db-4e79-bec2-4d483c4b1387'),
(47, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA19%2Fpexels-burst-374820.jpg?alt=media&token=f9d2eb0f-1782-45e5-a780-1aec598d5e89'),
(47, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA19%2Fpexels-christina-morillo-1181226.jpg?alt=media&token=3c992328-46d1-49cd-8cee-57f9801cbfeb'),
(47, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA19%2Fpexels-energepiccom-313690.jpg?alt=media&token=03575c56-48e7-4c5a-9f26-e19d338a55c7'),
(47, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA19%2Fpexels-julia-m-cameron-4145190.jpg?alt=media&token=15bd3bcf-cdca-4b2b-8030-329b3f7d19fc'),
(48, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA1%2Fpexels-william-choquette-1954524.jpg?alt=media&token=eb3692af-259f-4086-bbd6-77c4d3de2582'),
(48, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA20%2Fpexels-koshevayak-4170629.jpg?alt=media&token=99db7399-92cf-4023-89f5-336ff6ebebe7'),
(48, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA20%2Fpexels-pixabay-159740.jpg?alt=media&token=282be3fa-14a3-4297-9376-952668590a2d'),
(48, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Education%2FA20%2Fpexels-pixabay-256517.jpg?alt=media&token=c8e55fb0-9692-4b5e-8927-3fb6965e9142'),
(49, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA10%2Fpexels-jonathan-borba-3076509.jpg?alt=media&token=43ea5e14-5372-41ec-b5e8-7e0165b191df'),
(49, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA1%2Fpexels-zakaria-boumliha-2827392.jpg?alt=media&token=4b5971cb-d18b-47c9-a542-a328351bd9cf'),
(50, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA11%2Fpexels-frank-cone-2291874.jpg?alt=media&token=aa67149b-f4ad-462e-8d6c-ff2e2de37f75'),
(50, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA10%2Fpexels-keiji-yoshiki-176782.jpg?alt=media&token=0223cca2-f7db-4614-bf7b-03b05e3ff00e'),
(51, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA12%2Fpexels-photo-3253501.jpeg?alt=media&token=c9c3b88a-e373-4a5d-be52-1e78a591b119'),
(51, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA11%2Fpexels-johnny-garcia-2011384.jpg?alt=media&token=8d7c0ad1-67c5-4641-8c04-a1942fba08c2'),
(52, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA13%2Fpexels-li-sun-2294362.jpg?alt=media&token=171e91a7-550d-4797-8e40-74025fd2770a'),
(52, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA12%2Fpexels-pixabay-414029.jpg?alt=media&token=60fec212-e36a-4af6-a0bf-e14b87de3a1b'),
(52, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA12%2Fpexels-victor-freitas-2261484.jpg?alt=media&token=4efd34ff-fb17-4c6d-8bff-8727ce5b9a6b'),
(53, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA14%2Fpexels-nathan-cowley-1089144.jpg?alt=media&token=b2fc41ad-db74-4499-b29b-14e23ec1d8cd'),
(53, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA13%2Fpexels-luis-quintero-1671219.jpg?alt=media&token=30e4b06d-112b-4208-8118-3dabcb038f4b'),
(53, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA13%2Fpexels-mister-mister-3490348.jpg?alt=media&token=2dacebda-c80d-4800-b737-4dbf0725b7fe'),
(54, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA15%2Fpexels-andrea-piacquadio-863926.jpg?alt=media&token=0510450f-b43b-44d5-ac3e-443d27977218'),
(54, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA14%2Fpexels-nathan-cowley-1300526.jpg?alt=media&token=6f282830-74cd-499c-8b04-f55511b6fee1'),
(54, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA15%2Fpexels-andrea-piacquadio-866021.jpg?alt=media&token=6ae92da1-cf10-4681-a60a-e59eb26aa7d2'),
(54, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA15%2Fpexels-andrea-piacquadio-868704.jpg?alt=media&token=4cbfd855-0ff9-4814-a059-7a5db5ea8dbe'),
(55, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA17%2Fpexels-andrea-piacquadio-905613.jpg?alt=media&token=cac2619b-b431-4728-8ac3-f167159009c0'),
(55, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA16%2Fpexels-karolina-grabowska-4498605.jpg?alt=media&token=fcb6b138-ab3d-43d0-b6b9-f9d46ded3419'),
(56, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA18%2Fpexels-karolina-grabowska-4498606.jpg?alt=media&token=32276ef6-2d35-47b4-a945-9d5ddec40e6a'),
(56, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA17%2Fpexels-andrea-piacquadio-917660.jpg?alt=media&token=d2172ef6-ef68-46e3-a064-2ee7aaac6085'),
(56, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA17%2Fpexels-chiara-caldarola-1257245.jpg?alt=media&token=63d97f93-e947-4906-a2f4-054635b6ba4a'),
(57, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA19%2Fpexels-andrea-piacquadio-3775566.jpg?alt=media&token=0435efac-df7d-40d8-8611-05f5463057f7'),
(57, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA18%2Fpexels-pixabay-416754.jpg?alt=media&token=c1e30b29-d93f-4a32-8974-d73097aac5d7'),
(57, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA18%2Fpexels-taco-fleur-2780318.jpg?alt=media&token=8b1e19d8-4d13-4fee-a185-edb7fbd4b4d0'),
(58, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA2%2Fpexels-tembela-bohle-2803158%20(1).jpg?alt=media&token=be1d1c7d-b2d7-4b9b-a8cd-d15447eb3213'),
(58, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA19%2Fpexels-anna-shvets-3900844.jpg?alt=media&token=63ce1570-9eef-4e69-b749-e28063229c7f'),
(58, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA19%2Fpexels-anna-tarazevich-4839736.jpg?alt=media&token=297334ff-9683-4f9e-875e-0f82c081f2ab'),
(58, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA19%2Fpexels-bruno-bueno-2204182.jpg?alt=media&token=9d468014-fe84-4b59-930c-141438eb6c7f'),
(58, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA19%2Fpexels-jonathan-borba-3066335.jpg?alt=media&token=12debc17-9aad-4efa-864b-efc606e7fd2b'),
(59, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA20%2Fpexels-lee-catherine-collins-2652236.jpg?alt=media&token=f684f608-0a9a-4f6c-bb62-08019f67d4aa'),
(59, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA2%2Fpexels-tirachard-kumtanom-601177.jpg?alt=media&token=464bb246-5bd4-4a70-bd7f-296161a645af'),
(59, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA2%2Fpexels-victor-freitas-841131.jpg?alt=media&token=54434585-fcf2-4798-945f-5c4c93820db7'),
(60, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA3%2Fpexels-ron-lach-9034669.jpg?alt=media&token=ff75ab6c-9ea9-4eb2-b1b6-5da6154ecad2'),
(60, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA20%2Fpexels-leon-ardho-1717097.jpg?alt=media&token=9b63901e-a9a6-4f28-b1f2-a8c71aa58ab4'),
(61, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA4%2Fpexels-anna-shvets-5029853.jpg?alt=media&token=a1eae127-2960-4520-8a65-33bbc329369e'),
(61, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA3%2Fpexels-ron-lach-9035242.jpg?alt=media&token=744d51c0-999e-454d-a92e-81f74aff5adf'),
(61, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA3%2Fpexels-run-ffwpu-2526878.jpg?alt=media&token=8b00e0fc-a48b-460f-b88a-c4d139e2d036'),
(61, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA3%2Fpexels-scott-webb-136404.jpg?alt=media&token=b88cac6f-7a64-4099-aba1-ae3615757f36'),
(61, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA3%2Fpexels-tembela-bohle-963697.jpg?alt=media&token=34f684fd-bbc2-4cb6-8a62-ec3a2bcd93e9'),
(62, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA5%2Fpexels-jonathan-borba-3076516.jpg?alt=media&token=7fa1c767-a5e5-477b-baaf-6b89e4607e8b'),
(62, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA4%2Fpexels-anna-shvets-5029919.jpg?alt=media&token=285a4095-d7f2-4201-a0c6-117db23376c0'),
(62, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA4%2Fpexels-photo-2158963.jpeg?alt=media&token=1fac6631-72c8-4578-a4c9-8acfd1d1ff58'),
(62, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA4%2Fpexels-pixabay-39671.jpg?alt=media&token=ac6c149b-e241-4aa4-abef-90a0e16e4ac2'),
(62, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA4%2Fpexels-pixabay-416778.jpg?alt=media&token=678b62ac-5f86-43fa-ace6-1466f0ce58e2'),
(63, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA6%2Fpexels-kuldeep-singhania-2105493.jpg?alt=media&token=b96c1e6c-ba26-4265-bd8e-f2e535ed4d4e'),
(63, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA5%2Fpexels-kate-trifo-4024914.jpg?alt=media&token=0f2e3ef4-0e4c-455d-8766-2e798a4cb993'),
(63, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA5%2Fpexels-nathan-cowley-634030.jpg?alt=media&token=26681626-7072-44ee-8296-30ecc40b5bc0'),
(64, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA7%2Fpexels-koolshooters-6246589.jpg?alt=media&token=a6ba3837-b04c-4537-bd7b-de2cfe1b720f'),
(64, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA6%2Fpexels-li-sun-2294361%20(1).jpg?alt=media&token=a05ff851-a00d-42ea-a932-a4cfe80fba72'),
(64, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA6%2Fpexels-miriam-alonso-7592307.jpg?alt=media&token=9a2b2d18-527a-4421-bfcc-9ad76f14c1d1'),
(64, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA6%2Fpexels-moe-magners-6671546.jpg?alt=media&token=2f6d6c4d-df3d-43eb-87fa-88a8caa211b6'),
(64, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA6%2Fpexels-moe-magners-6671547.jpg?alt=media&token=a108d65c-2f73-4c2d-90ce-b69501701975'),
(65, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA8%2Fpexels-andrea-piacquadio-863977.jpg?alt=media&token=4f902229-a0b2-496c-bca3-c4edf41ff543'),
(65, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA7%2Fpexels-koolshooters-6246657.jpg?alt=media&token=a328c937-efec-42c1-b0f7-5e6426b06ef0'),
(65, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA9%2Fpexels-alex-kinkate-421160.jpg?alt=media&token=7bb17eee-a7d4-480f-b9dc-3ac873cec16e'),
(66, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA1%2Fpexels-aleksandr-neplokhov-1238986.jpg?alt=media&token=465a8f09-b0da-46a0-8332-63e2b3207f47'),
(66, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA8%2Fpexels-andrea-piacquadio-903171.jpg?alt=media&token=1c084e45-3fa0-4ab5-8625-a199b0e34eb9'),
(66, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA8%2Fpexels-anna-shvets-4482936.jpg?alt=media&token=b9cf095f-50e4-4f06-90b9-c2b17dea53d5'),
(66, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Exersice%2FA9%2Fpexels-cliff-booth-4058411.jpg?alt=media&token=833ae6af-934f-421a-8bcc-08ae91f1a1f9'),
(67, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA2%2Fpexels-annam-w-1047442.jpg?alt=media&token=641242a0-da1c-4775-9d07-2a728290b544'),
(67, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA1%2Fpexels-anastasia-shuraeva-5495067.jpg?alt=media&token=3d86531c-6023-4558-afae-88c490e981ef'),
(67, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA1%2Fpexels-andrea-piacquadio-3775566.jpg?alt=media&token=3116e679-feea-492f-9701-fbc12dc4e07e'),
(67, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA1%2Fpexels-anna-shvets-3901639.jpg?alt=media&token=8061c792-9152-4677-a714-3d4e56761357'),
(67, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA1%2Fpexels-anna-shvets-3902727.jpg?alt=media&token=1bc8610b-0ce1-4979-a7f3-609d0a0adfc4'),
(67, 'activityDetail5', 'activityDetail5', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA5%2Fpexels-helena-lopes-708392.jpg?alt=media&token=87f48ed0-6531-428a-95d7-c88e74e4a59a'),
(67, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA3%2Fpexels-cottonbro-studio-10264793.jpg?alt=media&token=8af6ed76-5d47-4a21-a0df-22f31549d14c'),
(67, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA2%2Fpexels-brett-sayles-1474694.jpg?alt=media&token=f8e25060-e22c-4411-8fff-f2d84c15b8e5'),
(67, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA2%2Fpexels-cottonbro-studio-4880423.jpg?alt=media&token=1e277f65-fa1c-4929-b75e-0a4ed1956936'),
(67, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA2%2Fpexels-cottonbro-studio-7520751.jpg?alt=media&token=f51de061-b44c-4a29-8265-2f6531e3ca52'),
(68, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA4%2Fpexels-dibakar-roy-16631111.jpg?alt=media&token=7de8a6ea-d8cd-4154-a7ed-45b2652cb42f'),
(68, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA3%2Fpexels-cottonbro-studio-10265324.jpg?alt=media&token=d6191c97-91cf-4d3c-b02a-b8fc17513621'),
(68, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA3%2Fpexels-dana-tentis-315843.jpg?alt=media&token=e347c602-ae5e-4b4c-abbf-7f34ddf8085e'),
(69, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA5%2Fpexels-helena-lopes-697244.jpg?alt=media&token=bd111382-e124-4b12-a5bd-77b282deeb04'),
(69, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA4%2Fpexels-haste-leart-v-690598.jpg?alt=media&token=656fcb21-dd92-45f2-aa53-5f1aceced52b'),
(70, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA6%2Fpexels-kampus-production-5935232.jpg?alt=media&token=1c9653ee-519d-413c-9990-01f04f8b5763'),
(70, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA5%2Fpexels-helena-lopes-708392.jpg?alt=media&token=87f48ed0-6531-428a-95d7-c88e74e4a59a'),
(70, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA5%2Fpexels-ingo-joseph-1755087.jpg?alt=media&token=a00ffc9a-b270-42fa-9b28-cb7ac0b8a50e'),
(70, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA5%2Fpexels-jack-sparrow-4046265.jpg?alt=media&token=8446b7e2-b43b-402f-8b01-4f6774c628dc'),
(71, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA7%2Fpexels-kosygin-leishangthem-2888802.jpg?alt=media&token=4c3624d4-7038-4106-bd71-66206405848e'),
(71, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA6%2Fpexels-koolshooters-6982443.jpg?alt=media&token=07dc0e64-febf-4da9-9701-af64a7ebc1cc'),
(71, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA6%2Fpexels-koolshooters-7142984.jpg?alt=media&token=50a7af52-96f2-4c5f-8127-2fd1b294de43'),
(72, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA8%2Fpexels-marcus-aurelius-6788000.jpg?alt=media&token=4ef027e8-eb75-4cc1-a307-b1c63ab3c696'),
(72, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA7%2Fpexels-luis-quintero-2091375.jpg?alt=media&token=292df016-12a4-4214-b42b-b0e171faab4e'),
(73, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA9%2Fpexels-mike-1192025.jpg?alt=media&token=b0e799ab-6855-4f8e-9547-65bc5e99ba53'),
(73, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA8%2Fpexels-martin-lopez-2240763.jpg?alt=media&token=378872d2-57a0-4640-813b-3d8b1919f990'),
(73, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA8%2Fpexels-martin-lopez-2240771.jpg?alt=media&token=8d97025b-fa91-4593-bef3-4604cf18cec3'),
(73, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA8%2Fpexels-mati-mango-2480356.jpg?alt=media&token=514de596-0825-4e2f-a1f9-883a0132b7e3'),
(73, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA8%2Fpexels-meum-mare-17127851.jpg?alt=media&token=da0f4909-96a0-4897-bd85-6c3fe0d9336f'),
(73, 'activityDetail5', 'activityDetail5', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA20%2Fpexels-tim-gouw-175658.jpg?alt=media&token=c03c39f0-5bb9-4961-bdea-12905cc55ccb'),
(74, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA10%2Fpexels-rdne-stock-project-8929829.jpg?alt=media&token=36087ea1-c362-4ea7-a377-670ac774570c'),
(74, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA9%2Fpexels-pixabay-207739.jpg?alt=media&token=36d00753-d95a-4a5f-ab1a-76d166e8865c'),
(74, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA9%2Fpexels-rdne-stock-project-8929030.jpg?alt=media&token=570a37df-794a-41c8-b363-5e7f207f176b'),
(75, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA11%2Fpexels-wallace-chuck-2820894.jpg?alt=media&token=2277bd50-ebaa-4959-bc33-35502e11f4b8'),
(75, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA10%2Fpexels-ron-lach-9586536.jpg?alt=media&token=80f39cad-3580-4b60-a731-02026ca7d5fa'),
(75, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA10%2Fpexels-shelagh-murphy-1666816.jpg?alt=media&token=8c5378a3-c5e7-4ee2-81cd-dcce7520d970'),
(75, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA10%2Fpexels-tanya-satina-6558013.jpg?alt=media&token=1bf0b3dc-194b-4469-9ef6-01f6132981f1'),
(76, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA12%2Fpexels-wendy-wei-1190298.jpg?alt=media&token=5b9e89b1-b748-48fa-8f4e-7d37813b77db'),
(76, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA11%2Fpexels-wallace-chuck-2838787.jpg?alt=media&token=1a1ff3fc-bdf1-459e-9e8f-f23f6bbf8c0c'),
(77, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA20%2Fpexels-haste-leart-v-690597.jpg?alt=media&token=ba3b9a15-55cb-49be-9d37-bc15ff46cdd1'),
(77, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA12%2Fpexels-wendy-wei-1540338.jpg?alt=media&token=899ce65e-ee60-4457-a1ab-89ac58a15347'),
(77, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA12%2Fpexels-wendy-wei-3812951.jpg?alt=media&token=57d204ca-f58a-4c2b-88dd-d91fd122fb95'),
(78, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA14%2Fpexels-cottonbro-studio-4554431.jpg?alt=media&token=cb67ce02-f989-47a8-89e5-a46596e511a8'),
(78, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA20%2Fpexels-michael-zittel-12312.jpg?alt=media&token=6b4a6b5a-fe77-419c-921e-851393e37a84'),
(78, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA20%2Fpexels-tim-gouw-175658.jpg?alt=media&token=c03c39f0-5bb9-4961-bdea-12905cc55ccb'),
(79, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA15%2Fpexels-andrea-piacquadio-3768593.jpg?alt=media&token=09a4f340-84ca-4853-a983-1120232bb3a3'),
(79, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA14%2Fpexels-cottonbro-studio-7520751.jpg?alt=media&token=9466b822-d86c-4e12-ac11-a76a3e77ad62'),
(79, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA14%2Fpexels-elina-fairytale-4834133.jpg?alt=media&token=559d172f-0025-49bd-aa84-8817538aa585'),
(80, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA16%2Fpexels-julia-larson-6113635.jpg?alt=media&token=7e4ff254-45c3-4a3d-88b7-bf228316d891'),
(80, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA15%2Fpexels-barbara-olsen-7879720.jpg?alt=media&token=723143eb-d29b-4f03-b9e4-9f18b821c1bb'),
(80, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA15%2Fpexels-bruno-thethe-1958747.jpg?alt=media&token=c7918451-38e7-47b3-8f91-d442ef2ad7ae'),
(80, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA15%2Fpexels-cottonbro-studio-3171820.jpg?alt=media&token=01e50824-185a-42ce-9c44-3bd939f3237a'),
(80, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA15%2Fpexels-cottonbro-studio-3662824.jpg?alt=media&token=fb69be8d-be87-410e-b58f-8d43632c910d'),
(80, 'activityDetail5', 'activityDetail5', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA2%2Fpexels-cottonbro-studio-4880423.jpg?alt=media&token=1e277f65-fa1c-4929-b75e-0a4ed1956936'),
(81, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA17%2Fpexels-harrison-haines-3536274.jpg?alt=media&token=67fe021f-28fb-4f18-a1e7-192c2c5e79f0'),
(81, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA16%2Fpexels-kampus-production-5935240.jpg?alt=media&token=76a5ab27-c034-43d4-bbd5-049c87b25ea6'),
(81, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA16%2Fpexels-koolshooters-7142978.jpg?alt=media&token=bb446ac0-4be0-4329-a187-342511784f8e'),
(82, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA18%2Fpexels-koolshooters-7142984.jpg?alt=media&token=2ea73826-66a3-4e80-950c-bca108bc2f23'),
(82, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA17%2Fpexels-helena-lopes-697244.jpg?alt=media&token=1bae3c9d-05e3-466b-8500-f447142bf493'),
(82, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA17%2Fpexels-helena-lopes-708392.jpg?alt=media&token=395efc08-9f3a-4bff-babe-bc816ca13f14'),
(82, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA17%2Fpexels-joseph-phillips-3753820.jpg?alt=media&token=78e0911c-3b02-4941-a77f-739224a95d11'),
(82, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA17%2Fpexels-josh-hild-4606770.jpg?alt=media&token=e5fc3b72-e082-48a9-8739-b6b5dbc78d92'),
(82, 'activityDetail5', 'activityDetail5', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA18%2Fpexels-laura-stanley-2147029.jpg?alt=media&token=1637157b-942c-4b87-a5dd-5944a74c7c73'),
(83, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA19%2Fpexels-pixabay-358010.jpg?alt=media&token=4662356a-7063-434b-adc8-cb8744d990dc'),
(83, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA18%2Fpexels-laura-stanley-2147029.jpg?alt=media&token=1637157b-942c-4b87-a5dd-5944a74c7c73'),
(83, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA18%2Fpexels-martin-lopez-2240771.jpg?alt=media&token=fdbe3a2b-4620-4afc-ba78-eb8c73d98639'),
(83, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA18%2Fpexels-nikita-korchagin-10954773.jpg?alt=media&token=3e7f2e8b-a85e-4c06-8be1-333897e7dd7e'),
(83, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA18%2Fpexels-ph-dul-19577499.jpg?alt=media&token=27f8e6d3-dd5b-40e0-9d62-c4c3b83198fc'),
(84, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA1%2FArt%26MusicA01-1.jpg?alt=media&token=3a486908-70cd-40ac-aef6-34fea2ff9739'),
(84, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA19%2Fpexels-ron-lach-9586536.jpg?alt=media&token=38094a8f-f6a8-41c4-93a6-4559c224f311'),
(84, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA19%2Fpexels-sebastian-ervi-1763075.jpg?alt=media&token=32e3dc76-3e92-4862-b152-7d1546f43585'),
(84, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA19%2Fpexels-shvets-production-9050158.jpg?alt=media&token=bbc86a00-1fc4-4ab9-afc0-aaf2cf8dcb9a'),
(84, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Dance%2FA19%2Fpexels-silvio-barbosa-843256.jpg?alt=media&token=10d08f52-038d-4d12-b563-cdb248cad6de'),
(85, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA2%2FArt%26MusicA02-1.jpeg?alt=media&token=a67bb7d5-bdc5-492f-8a94-d4a95c81fad5'),
(85, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA1%2FArt%26MusicA01-2.jpg?alt=media&token=11051a22-e201-489f-9ca6-90d31b7cf7b6'),
(85, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA1%2FArt%26MusicA01-3.jpg?alt=media&token=28e07fd3-162f-44c8-af86-c3730a2b7106'),
(85, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA1%2FArt%26MusicA01-4.jpg?alt=media&token=3d29652a-dcce-4499-839e-88cf88a10911'),
(85, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA1%2FArt%26MusicA01-5.jpg?alt=media&token=b2bb875a-b80d-4429-80c0-379d6d814dfe'),
(85, 'activityDetail5', 'activityDetail5', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA20%2Fattractive-caucasian-female-posing-with-blue-cotton-candy-carnival_181624-60766.jpg?alt=media&token=cb6b6e4b-e828-4318-9fff-3062cf59a93e'),
(86, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA3%2FArt%26MusicA03-1.jpeg?alt=media&token=9ae982e0-71a7-4996-817c-4447b9b879e6'),
(86, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA2%2FArt%26MusicA02-2.jpeg?alt=media&token=8ae6463b-00e1-47b6-821a-3e2856d26d3a'),
(86, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA2%2FArt%26MusicA02-3.jpeg?alt=media&token=07ff4b9d-8823-40e4-ba37-9d26667dc39f'),
(86, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA2%2FArt%26MusicA02-4.jpeg?alt=media&token=f08f063c-eb73-4edc-8f6e-5828f883f74c'),
(86, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA2%2FArt%26MusicA02-5.jpeg?alt=media&token=2665b8fc-61d8-4bee-be3f-3523a16bdd39'),
(86, 'activityDetail5', 'activityDetail5', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA20%2Fjoyful-smiling-woman-funfair_23-2148281646.jpg?alt=media&token=2e2006a3-ba1c-4b20-88c3-055e130f15fe'),
(87, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA4%2FArt%26MusicA04-1.jpg?alt=media&token=dcf634b9-ff3f-4e6a-99aa-2292108272bb'),
(87, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA3%2FArt%26MusicA03-2.jpeg?alt=media&token=ba7b4c8d-97af-47f8-abd6-d1b0fe5c036c'),
(87, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA3%2FArt%26MusicA03-3.jpeg?alt=media&token=1f99266d-66da-4d8a-9033-7c64e3a921b2'),
(87, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA3%2FArt%26MusicA03-4.jpeg?alt=media&token=535ecd24-645d-4926-a6a9-b08faa266f42'),
(88, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA5%2FArt%26MusicA05-1.jpg?alt=media&token=834c7458-4157-4564-b7d0-2486df1d5c15'),
(88, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA4%2FArt%26MusicA04-2.jpg?alt=media&token=6a2ee124-1e7d-4af0-b15f-ab76a5a82669'),
(88, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA4%2FArt%26MusicA04-3.jpeg?alt=media&token=4bb2b441-3b57-491d-b2ec-59daab4fc09e'),
(89, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA6%2Ffull-shot-teen-with-skateboard-outside_23-2149633158.jpg?alt=media&token=259c96de-c703-4bf7-b18e-eb1fad84fb75'),
(89, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA5%2FArt%26MusicA05-2.jpg?alt=media&token=7887a5d3-1a69-427e-adff-ff5ff208df09'),
(89, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA5%2FArt%26MusicA05-3.jpg?alt=media&token=14914e88-40d8-4b8e-8520-f675dd4dea4c'),
(89, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA5%2FArt%26MusicA05-4.jpg?alt=media&token=bdd9af1f-5c37-4ba8-9474-b5602ac7d67c'),
(90, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA7%2Fmedium-shot-girl-drawing-home_23-2149438416.jpg?alt=media&token=e8188bf3-1a08-465f-a8e0-236805eefbc4'),
(90, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA6%2Flow-angle-teens-with-skateboards-outdoors_23-2149633163.jpg?alt=media&token=54f0b024-b1af-4311-8bda-4e2a63e38907'),
(90, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA6%2Fperson-using-eco-transport-new-york_23-2149219955.jpg?alt=media&token=381a48bc-2a5c-46c7-af65-dcbed532854b'),
(90, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA6%2Fteens-skateboard-outdoors-high-angle_23-2149633160.jpg?alt=media&token=496f8f49-d8fb-449c-8e7c-236c487253a9'),
(90, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA6%2Fthinking-you-text-image-city_23-2150911946.jpg?alt=media&token=71820a77-1702-43c0-bc89-f986823ec430'),
(90, 'activityDetail5', 'activityDetail5', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA20%2Fyoung-women-having-fun-amusement-park_23-2148238364.jpg?alt=media&token=28525b4d-4fb4-43f6-9e98-2b2ebbb6eea3'),
(91, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA8%2Ffull-shot-man-holding-banner_23-2149343486.jpg?alt=media&token=14a3d1e7-7fa6-43d0-a64a-4581e036cf61'),
(91, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA7%2Fpeople-education-creativity-concept-profile-young-woman-with-curly-hair-ponytail-learning-how-sketch-draw-while-taking-part-art-workshop-class_273609-334.jpg?alt=media&token=7b4d9ee1-b1fa-4aa9-bb4b-5bdc06431db8'),
(91, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA7%2Fside-view-illustrator-drawing-ipad_23-2150038502.jpg?alt=media&token=16cfa742-7bdb-4782-b679-f4925696cca2'),
(91, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA7%2Fwomen-being-creative-indoors_23-2148966938.jpg?alt=media&token=a6df89be-1583-4f0d-a24f-a4d8b866f928'),
(92, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA9%2Fside-view-man-playing-guitar-studio_23-2150232124.jpg?alt=media&token=1d5aff5f-7e9d-4a3e-b786-8df43e15413a'),
(92, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA8%2Fhappy-artist_23-2148017379.jpg?alt=media&token=191f3864-6b39-4fb8-b97c-70c7f873d058'),
(92, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA8%2Fyoung-attractive-woman-with-dark-curly-hair-from-back-dreamily-drawing-picture-canvas-by-hands-with-bright-oil-paints-while-spending-time-big-cozy-workshop_574295-484.jpg?alt=media&token=225833fd-a47c-4c95-be9e-f4aad4a138a8'),
(92, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA8%2Fyoung-children-making-diy-project-from-upcycled-materials_23-2149391043.jpg?alt=media&token=825223cd-0862-444d-8467-cfe203745875'),
(92, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA8%2Fyoung-woman-drawing-atelier_23-2147802012.jpg?alt=media&token=8fec7783-dbc5-4781-8b51-048fe45f279e'),
(93, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA10%2Fadorable-girls-enjoying-popcorn-home_23-2147768085.jpg?alt=media&token=70414e58-e74b-44da-98d8-f8c10a3327db'),
(93, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA9%2Fside-view-musician-working-studio_23-2150265014.jpg?alt=media&token=7d9471af-345f-479c-a007-17f864ebd9c8'),
(93, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA9%2Fsmiley-female-musician-playing-piano-keyboard-indoors-singing-into-microphone_23-2148890834.jpg?alt=media&token=8986f6f1-1f67-4c1f-86de-977e3fc8b4f9'),
(93, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA9%2Ftop-view-young-dj-with-headphones_23-2149739882.jpg?alt=media&token=2a59e421-f7dc-4aab-ac57-813d6bc2f147'),
(93, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA9%2Fwoman-working-with-professional-radio-equipment_23-2148815376.jpg?alt=media&token=3bd36236-5aac-4d73-8b72-d9c80f929f79e'),
(94, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA11%2Ffull-shot-couple-walking-together_23-2149241532.jpg?alt=media&token=637e7f37-f0d4-49b2-8751-5e2a45ee21c5'),
(94, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA10%2Fcouple-taking-photos-light-movie-projector_23-2149377348.jpg?alt=media&token=9b488137-8cea-4b42-9967-606ba14a30d5'),
(94, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA10%2Fcouple-taking-photos-light-movie-projector_23-2149377358.jpg?alt=media&token=6da53c5f-4307-4969-85d7-3895b1b7a6d2'),
(94, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA10%2Ftwo-men-with-microphones-headphones-running-podcast_23-2149434327.jpg?alt=media&token=b5c55ac8-7f34-4c49-bb17-f9c40d29c26f'),
(95, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA12%2Ffull-shot-girls-taking-selfie-indoors_23-2149829764.jpg?alt=media&token=5ba6751d-e14e-4853-9dcc-959ef8c4ae1f'),
(95, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA11%2Ffull-shot-woman-with-colorful-lights_23-2149679102.jpg?alt=media&token=1318051b-f5c6-4e90-8543-ad57c3b85c1c'),
(95, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA11%2Fwoman-with-colorful-lights-full-shot_23-2149679101.jpg?alt=media&token=3e7e8377-d7d3-4f2f-8c5f-d2932201c595'),
(95, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA11%2Fyoung-woman-standing-universe-texture-projection_23-2149512115.jpg?alt=media&token=b27f5cb1-3b4b-42ac-8094-2d2f217e3fa3'),
(96, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA13%2Fpeople-working-together-animation-studio_23-2149207988.jpg?alt=media&token=db614b96-3cbd-470c-ad40-e308ed013d17'),
(96, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA12%2Fgroup-teens-doing-experiments-robotics-laboratory-boys-girls-protective-vr_1268-23742.jpg?alt=media&token=c75c9a99-6c2f-458a-8276-8405e2d46fe3'),
(96, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA12%2Fwoman-dj-headphones-mixing-music-stage-during-electronic-music-concert-nightclub-african-american-musician-earphones-performing-discotheque-party-club_482257-65402.jpg?alt=media&token=084524d1-c936-4f62-82bb-48e3122336dc'),
(96, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA12%2Fwoman-taking-pictures-near-bar_23-2147771341.jpg?alt=media&token=6eb64693-a6f0-4a8e-bc86-59b9ff240879'),
(96, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA12%2Fwomen-looking-postcards_23-2147771245.jpg?alt=media&token=b49b9f29-a39a-423d-8e86-6bcdda86b07f'),
(96, 'activityDetail5', 'activityDetail5', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA11%2Ffull-shot-woman-with-colorful-lights_23-2149679102.jpg?alt=media&token=1318051b-f5c6-4e90-8543-ad57c3b85c1c'),
(97, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA14%2Fcreative-woman-practicing-music-home_23-2148924327.jpg?alt=media&token=ca5beffb-ec7f-4056-9a39-01bc74b14e44'),
(97, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA13%2Fside-view-man-with-drawing-notebook_23-2150182562.jpg?alt=media&token=0e40efe7-69ad-46b2-961f-114893c1197e'),
(97, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA13%2Fwoman-creating-their-own-vision-board_23-2150270417.jpg?alt=media&token=06ec0f3f-499c-479b-a531-2b3c5e019d28'),
(97, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA13%2Fwoman-holding-bowl-healthy-soup-yoga_23-2148185976.jpg?alt=media&token=d0ba4075-f1d0-4257-a03d-2c55242ffd4d'),
(98, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA15%2Ffull-shot-women-with-instruments-floor_23-2149130764.jpg?alt=media&token=cf6e81f0-8ebe-4d36-9747-3014dffa8f0d'),
(98, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA14%2Fhigh-angle-woman-working-radio-with-professional-equipment_23-2148815364.jpg?alt=media&token=8a0ced76-64b4-4fa4-a6cb-23feddfddbcc'),
(98, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA14%2Fprocess-recording-video-content-learning-play-piano_169016-14961.jpg?alt=media&token=50789ab6-4836-40f8-8335-bc82f31a90f6'),
(98, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA14%2Ftwo-men-with-microphones-headphones-running-podcast_23-2149434327.jpg?alt=media&token=7fe3abe1-bfb3-4f04-b0f1-a5cf383655ce'),
(99, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA16%2Fcustomer-waiter-as-helping-hand_329181-17806.jpg?alt=media&token=4b52a143-cff4-4c42-89ef-8f798589799d'),
(99, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA15%2Fside-view-family-listening-music_23-2149734974.jpg?alt=media&token=cf5b9a55-b738-434e-9f5e-0cb8b83a7be9'),
(99, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA15%2Fyoung-musicians-local-event_23-2149188139.jpg?alt=media&token=0bb7f722-c588-4b84-8a5d-a1ad02575488'),
(100, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA17%2Fpexels-wendy-wei-1540338.jpg?alt=media&token=53ea771e-1cde-4c4a-8eb2-e8260125aec2'),
(100, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA16%2Ffront-view-girl-playing-guitar_23-2149829766.jpg?alt=media&token=d015b769-972a-446c-b49f-761eada11ffe'),
(100, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA16%2Ffull-shot-senior-woman-reading-tarot_23-2150298346.jpg?alt=media&token=1321ef4c-729a-4f2f-a226-179b6e6a0d81'),
(101, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA18%2Fhigh-angle-musicians-working-studio_23-2150265030.jpg?alt=media&token=6ed8ee76-911f-48fe-994e-854c79fc9bfc'),
(101, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA17%2Fpexels-yaroslav-shuraev-4938097.jpg?alt=media&token=16b2b387-ffaa-4b59-9349-f000abfe26e4'),
(101, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA17%2Fpexels-yogendra-singh-1701195.jpg?alt=media&token=3b1c4b3b-3b21-4927-868f-41e354d6f997'),
(102, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA19%2Fgroup-fans-gathered-thge-stadium-cheering-up_1303-18617.jpg?alt=media&token=d0a4c746-d611-4a60-9f55-4f2cd71e3c3b'),
(102, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA18%2Fman-working-music-studio-with-instruments_52683-110322.jpg?alt=media&token=33a47240-27a4-4a08-91b2-2b21b36b9436'),
(102, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA18%2Fman-working-music-studio-with-instruments_52683-110323.jpg?alt=media&token=9d1102f5-9286-4bba-9373-122c91bb9b33'),
(102, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA18%2Fperson-making-music-indoors_23-2148924286.jpg?alt=media&token=94d18319-e71c-4260-baa9-079d5692f9e7'),
(102, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA18%2Fside-view-man-playing-guitar_23-2150265081.jpg?alt=media&token=410f7124-facd-4ed9-8fa7-91b0d1cadd97'),
(102, 'activityDetail5', 'activityDetail5', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA17%2Fpexels-yaroslav-shuraev-4938097.jpg?alt=media&token=16b2b387-ffaa-4b59-9349-f000abfe26e4'),
(103, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA1%2Fbeautiful-asian-woman-fashion-designer-working-office-studio-entrepreneur-sme-business-concept_74952-1885.jpg?alt=media&token=8d112a4a-1c00-41d5-b633-e835c706b329'),
(103, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA19%2Fpeople-concert-with-smoke-overlay-texture_53876-126856.jpg?alt=media&token=282b262d-f7d9-4906-bbdf-0f12d22df5f8'),
(103, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA19%2Fpeople-festival_1160-736.jpg?alt=media&token=33495b6e-2d61-44d6-8cfb-92fa016685c1'),
(103, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA19%2Fsinger-dj-band-performing-stage-while-crowd-clubbing-dance-party-club-people-having-fun-dancefloor-while-musicians-playing-electronic-music-festival-nightclub_482257-71740.jpg?alt=media&token=55776f93-3fad-4535-b818-c6e35355fae8'),
(103, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Art%26Music%2FA19%2Fwoman-holding-drink-dancing-club_482257-74669.jpg?alt=media&token=89e3dc31-4619-4c4a-9060-59b7031c6d2a'),
(104, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA2%2Fagency-asian-analyst-digital-videocall-conference-with-accountant-talking-about-revenue-documentation-businesswoman-briefing-team-leader-about-failed-strategy-unfinished-presentation_482257-41509.jpg?alt=media&token=e76b8521-838c-4ac1-a7b7-b2466e5c73ea'),
(104, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA1%2Fimport-export-shipment-truck-graphic-concept_53876-124866.jpg?alt=media&token=251fb2e6-a9ec-46dd-9136-7533ca119569'),
(104, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA1%2Fpersonal-shopper-office-with-client_23-2148929559.jpg?alt=media&token=c4abb5c7-3513-4687-8577-c454938425b5'),
(104, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA1%2Fstarting-small-businesses-sme-owners-entrepreneurs-use-tablet-receive-review-orders-online_74952-2454.jpg?alt=media&token=af1a08e8-4568-4d15-9f55-5226f19a9c3e'),
(104, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA1%2Fwoman-promoting-cloths-from-thrift-store_23-2150952332.jpg?alt=media&token=e169bf74-671c-4a60-b1d1-a8940f511424'),
(104, 'activityDetail5', 'activityDetail5', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA20%2Fpexels-christina-morillo-1181736.jpg?alt=media&token=af9e0baf-8823-48da-af0d-142d81d2a83c'),
(105, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA3%2Fmodern-equipped-computer-lab_23-2149241211.jpg?alt=media&token=533b5e97-5328-47b2-b4fc-57dc439442e4'),
(105, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA2%2Fasian-colleagues-collaborating-with-remote-employment-discussing-cv-resume-online-videocall-meeting-conference-teleconference-call-computer-screen-startup-business-office_482257-43858.jpg?alt=media&token=1b8ece99-b3c3-487b-8b9c-bd670e53e233'),
(105, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA2%2Fback-view-dark-skinned-woman-talks-with-diverse-coworkers-course-video-call-using-modern-technology-network-wireless-talking-virtual-meeting-doing-overtime_482257-9228.jpg?alt=media&token=874401f5-d04e-4b09-b0c0-0be117526620'),
(105, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA2%2Ftwo-multiethnic-designers-sitting-together-working-laptop-coworking-space_74855-10444.jpg?alt=media&token=6b3fbe02-292d-44a6-b285-1a242275b201'),
(106, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA4%2Fpexels-andrea-piacquadio-933255.jpg?alt=media&token=d3547dae-9897-4e9d-aef6-ac5f71d85185'),
(106, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA3%2Fopenart-image_LyKZ68Ei_1710242207981_raw.jpg?alt=media&token=6251133b-8fe2-4687-b067-7a55385fd86d'),
(106, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA3%2Fopenart-image_MdKCdhlD_1710242235629_raw.jpg?alt=media&token=47c919be-7a3a-4e1f-b640-304f73c5ac7a'),
(107, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA5%2Fpexels-christina-morillo-1181360.jpg?alt=media&token=089a7ad3-ca43-4f0b-826a-e11e587b30d8'),
(107, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA4%2Fpexels-christina-morillo-1181245.jpg?alt=media&token=f242af19-eaf6-45ed-829d-1f90da685d11'),
(107, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA4%2Fpexels-christina-morillo-1181329.jpg?alt=media&token=838608b3-537e-4b73-a638-fb0023d5acd8'),
(108, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA6%2Fpexels-cowomen-2041383.jpg?alt=media&token=127a1dbd-a052-436a-8285-f0d6301e7f28'),
(108, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA5%2Fpexels-christina-morillo-1181400.jpg?alt=media&token=d3944a55-4e52-4e49-b298-25ccb415f694'),
(108, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA5%2Fpexels-christina-morillo-1181408.jpg?alt=media&token=63bf7ddc-59e5-48f9-87d7-862c30c326c5'),
(108, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA5%2Fpexels-christina-morillo-1181534.jpg?alt=media&token=57d28368-4013-48ee-8202-2057f504e174'),
(109, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA7%2Fpexels-linkedin-sales-navigator-2182971.jpg?alt=media&token=edf4399a-c567-4dd7-974f-11e78340a38c'),
(109, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA6%2Fpexels-cowomen-2041627.jpg?alt=media&token=5e16c6ef-9022-4f2f-9311-ebd1e123b3b6'),
(109, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA6%2Fpexels-elevate-digital-1647919.jpg?alt=media&token=d7270733-ec5f-40e7-9114-4d2019d794f7'),
(109, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA6%2Fpexels-fox-1595388.jpg?alt=media&token=4929a9b7-deb2-4e01-b4b6-776566009dfd'),
(110, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA8%2Fpexels-fox-1595390.jpg?alt=media&token=5ef8da3f-4d80-4fff-965b-706c9c21c3c8'),
(110, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA7%2Fpexels-lisa-fotios-1666471.jpg?alt=media&token=944cb8f2-9ce9-49c9-9cd9-e188e81e5601'),
(110, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA7%2Fpexels-michaela-295826.jpg?alt=media&token=c52a6aa7-defc-40a5-9e07-4d2405f0a30a'),
(110, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA7%2Fpexels-pixabay-259239.jpg?alt=media&token=b168dc5a-b81c-49ef-9a01-28bb02a3312e'),
(110, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA7%2Fpexels-pixabay-48195.jpg?alt=media&token=4ad658f0-af41-42da-a9db-93fa46f82dbd'),
(111, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA9%2Fpexels-linkedin-sales-navigator-1251849.jpg?alt=media&token=43d06c09-ca32-453e-b8ad-5f2631db813e'),
(111, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA8%2Fpexels-helena-lopes-933964.jpg?alt=media&token=51393684-1703-4f85-a993-59e297be1cd4'),
(111, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA8%2Fpexels-joyce-toh-2912583.jpg?alt=media&token=168f682e-2e69-4afb-9450-d0031e4f72d0'),
(112, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA10%2Fpexels-christina-morillo-1181224.jpg?alt=media&token=e8a1c08e-cc77-4c4b-866f-1cecc9f04ef9'),
(112, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA9%2Fpexels-pranjal-srivastava-2403251.jpg?alt=media&token=56c73449-e91a-450f-8ce6-35f50d96fd53'),
(112, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA9%2Fpexels-the-lazy-artist-gallery-2247181.jpg?alt=media&token=ea121f54-1c6e-445f-ad5f-5ddb41a08198'),
(113, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA11%2Fpexels-cottonbro-studio-2773507.jpg?alt=media&token=2884f84e-5824-4b1d-b309-42bca2c4fc79'),
(113, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA10%2Fpexels-christina-morillo-1181405.jpg?alt=media&token=9e0624e1-d442-4bf3-a8f1-8232ee2a0428'),
(113, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA10%2Fpexels-christina-morillo-1181625.jpg?alt=media&token=2bd8dfc3-8a85-4b10-a557-3603bd5d9a04'),
(113, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA10%2Fpexels-christina-morillo-1181673.jpg?alt=media&token=15bf6db8-807d-4c28-abc7-cc6caa611d71'),
(114, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA12%2Fpexels-fauxels-3184292.jpg?alt=media&token=229d750c-5f23-48fa-8a90-4348b49fb56b'),
(114, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA11%2Fpexels-cowomen-2041393.jpg?alt=media&token=b48b2209-50e7-4f24-a0be-14cf4e002586'),
(114, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA11%2Fpexels-dominika-roseclay-977841.jpg?alt=media&token=36855241-1104-41b8-9e76-b8b1a7275434'),
(115, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA13%2Fpexels-life-of-pix-7974.jpg?alt=media&token=736e5aba-433e-43db-9a21-dc0ac4a4f6d4'),
(115, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA12%2Fpexels-fauxels-3184418.jpg?alt=media&token=ca7122b5-921d-408e-acc4-a851c23b180c'),
(115, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA20%2Fpexels-cowomen-2041629.jpg?alt=media&token=d0e67055-2a3c-4ed4-89dd-fe11d6900f16'),
(116, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA14%2Fpexels-fauxels-3183197.jpg?alt=media&token=f62a8339-b23a-4c22-b7b8-19f98548ef6f'),
(116, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA13%2Fpexels-linkedin-sales-navigator-1251833.jpg?alt=media&token=455ec3a0-dd2f-4a3e-a6c1-ae2793370c20'),
(116, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA13%2Fpexels-linkedin-sales-navigator-1251847.jpg?alt=media&token=837143da-699e-4cef-b4cc-cec2f25f0da8'),
(116, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA13%2Fpexels-linkedin-sales-navigator-1251852.jpg?alt=media&token=fbbbed93-a4b5-4149-8f48-b731f38fd67c'),
(116, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA13%2Fpexels-linkedin-sales-navigator-1251859.jpg?alt=media&token=66ceb9bd-94c8-4878-aeaf-75cfababe71e'),
(116, 'activityDetail5', 'activityDetail5', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA20%2Fpexels-christina-morillo-1181362.jpg?alt=media&token=64d8bc9d-cf7c-461b-a14a-f5d19af45ff4'),
(117, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA15%2Fpexels-lukas-296116.jpg?alt=media&token=2683eef7-612f-427a-beca-81dcfb6daa68'),
(117, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA14%2Fpexels-fox-1595386.jpg?alt=media&token=907fdb4b-496b-4448-9a3c-53d738298f8c'),
(117, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA14%2Fpexels-jopwell-2422289.jpg?alt=media&token=f16389b0-466d-4a6a-81e8-fd0ee4c878a0'),
(117, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA14%2Fpexels-julian-v-860227.jpg?alt=media&token=ff40519a-9dfb-4d1b-b8c9-e4086e4467d6'),
(118,'poster','poster','https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA16%2Fpexels-markus-spiske-92628.jpg?alt=media&token=838abf53-5b2f-4c36-b767-7d0110c7fbcd'),
(118,'activityDetail1','activityDetail1','https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA15%2Fpexels-lukas-574073.jpg?alt=media&token=8ed03b29-3266-45f4-aa41-c2c8fe960f18'),
(118,'activityDetail2','activityDetail2','https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA15%2Fpexels-malte-luk-1970801.jpg?alt=media&token=1a706c2d-95cf-4791-8e0e-3e7853d923ce'),
(119, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA17%2Fpexels-pew-nguyen-244133.jpg?alt=media&token=f655a388-7c71-4047-bd8c-b0610d6b379a'),
(119, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA16%2Fpexels-nappy-936081.jpg?alt=media&token=a2ed2d84-ec4e-4be8-b465-3b2b66cf59fb'),
(119, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA20%2Fpexels-visual-tag-mx-2566573.jpg?alt=media&token=2297f6aa-b898-4e6b-b506-7fde1c080ee8'),
(120, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA18%2Fpexels-pixabay-265072.jpg?alt=media&token=676506a5-4b4e-4e88-beb9-934036993148'),
(120, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA17%2Fpexels-pixabay-164666.jpg?alt=media&token=ed5fe23f-4f81-4df4-b6e9-fce46326c2c9'),
(120, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA17%2Fpexels-pixabay-261599.jpg?alt=media&token=5c7d9cdf-944c-4464-b206-5a2e5a69c008'),
(120, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA17%2Fpexels-pixabay-38519.jpg?alt=media&token=6b64cfc6-787c-4076-95d4-3a7c5797d5b5'),
(120, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA17%2Fpexels-pixabay-261599.jpg?alt=media&token=5c7d9cdf-944c-4464-b206-5a2e5a69c008'),
(120, 'activityDetail5', 'activityDetail5', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA20%2Fpexels-christina-morillo-1181241.jpg?alt=media&token=a6c6d2e0-b3e5-4900-9412-d22134e7ed42'),
(121, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA19%2Fpexels-jopwell-1325758.jpg?alt=media&token=08cedb88-6122-4898-9d6f-ac059d2de268'),
(121, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA18%2Fpexels-proxyclick-visitor-management-system-2451616.jpg?alt=media&token=b4f44493-5477-4647-974d-b8a14f551384'),
(121, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA18%2Fpexels-tranmautritam-326503.jpg?alt=media&token=f34a512a-8d3a-45e7-a1dc-1bf5c1a62330'),
(122, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA1%2Fpexels-must-bee-1305095.jpg?alt=media&token=ca012e3c-d67e-474f-a239-a79b0f280efd'),
(122, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA19%2Fpexels-marc-mueller-325111.jpg?alt=media&token=ec908aa9-81e6-4bf6-a6fa-a9b31e2af61a'),
(122, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA19%2Fpexels-markus-spiske-360591.jpg?alt=media&token=c753bbb4-3f13-4321-8885-7d64d3dc36c3'),
(122, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA19%2Fpexels-tranmautritam-245032.jpg?alt=media&token=031f9e51-472b-45c0-a2fc-3de072041f59'),
(122, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA19%2Fpexels-tranmautritam-948050.jpg?alt=media&token=8c861e1d-34b7-49be-b2da-e7b7554778c0'),
(122, 'activityDetail5', 'activityDetail5', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Business%2FA20%2Fpexels-christina-morillo-1181241.jpg?alt=media&token=a6c6d2e0-b3e5-4900-9412-d22134e7ed42'),
(123, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA10%2Fpexels-andrea-piacquadio-863926.jpg?alt=media&token=821470a3-4b56-4fae-83b8-ee3c8990bbb8'),
(123, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA1%2Fpexels-nina-uhlikova-287240.jpg?alt=media&token=e12e0315-71ca-42b1-8e53-48f7c00aea7f'),
(123, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA1%2Fpexels-nina-uhlikova-725255.jpg?alt=media&token=8af5f95c-34b4-4755-a5d6-a78385dfe35a'),
(123, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA1%2Fpexels-pixabay-207896.jpg?alt=media&token=17e9ac0d-0e75-45b9-9b92-51acc285373c'),
(124, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA2%2Fpexels-dibakar-roy-16631107.jpg?alt=media&token=c8a7a867-208d-4f23-8585-8a57ffde1d5d'),
(124, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA10%2Fpexels-hassan-ouajbir-1535244.jpg?alt=media&token=f43faa00-1bdc-4e94-aa42-d7d7a10fda98'),
(124, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA10%2Fpexels-valeria-ushakova-3094215.jpg?alt=media&token=8711bead-e637-4a88-9273-d736c0a1f91d'),
(125, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA3%2Fpexels-august-de-richelieu-4427430.jpg?alt=media&token=fce73813-98a4-4ede-81fb-439a1983b5eb'),
(126, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA2%2Fpexels-dibakar-roy-16631113.jpg?alt=media&token=8ee1ab42-861a-43e3-80ef-6ec8add9ff3f'),
(126, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA2%2Fpexels-dibakar-roy-16631114.jpg?alt=media&token=1197cf7a-303e-4a92-883f-d5c3f5971df7'),
(126, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA2%2Fpexels-dibakar-roy-16631116.jpg?alt=media&token=bab5d3ba-2fa7-450b-b127-92cb5d3c018a'),
(126, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA2%2Fpexels-gu%CC%88l-is%CC%A7%C4%B1k-20488463.jpg?alt=media&token=3644299c-651c-4216-8cf8-acc26eb379ab'),
(127, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA4%2Fpexels-belle-co-1000445.jpg?alt=media&token=010b30f5-37f3-4d18-8052-f105abe5bdee'),
(127, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA3%2Fpexels-august-de-richelieu-4427626.jpg?alt=media&token=85b72fac-55a7-462e-8b86-42d475544c16'),
(127, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA3%2Fpexels-fauxels-3184405.jpg?alt=media&token=7c40d74c-acf1-41c6-8fd9-c4bbcbfae564'),
(128, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA5%2Fpexels-antoni-shkraba-4348401.jpg?alt=media&token=c8091465-5e83-4a64-b1a8-61b81d5a065b'),
(128, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA4%2Fpexels-dio-hasbi-saniskoro-3280130.jpg?alt=media&token=43ca30ac-f33c-41a9-a9b0-931cd5068931'),
(128, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA4%2Fpexels-ingo-joseph-609771.jpg?alt=media&token=ec186f26-b7df-423b-ac76-56e41f8a9933'),
(128, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA4%2Fpexels-keith-wako-99820.jpg?alt=media&token=d98a6b1e-ad0a-45fb-97af-fb8fa0c29066'),
(128, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA4%2Fpexels-leah-newhouse-325521.jpg?alt=media&token=abf4b5c9-3cde-4c4e-a290-ff612a331432'),
(129, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA6%2Fpexels-alexander-grey-1174932.jpg?alt=media&token=a36af983-320b-41a1-8438-4206f66ea8e1'),
(129, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA5%2Fpexels-canva-studio-3153198.jpg?alt=media&token=c9b0f5ba-4b43-49d1-95f9-888ac0228d6e'),
(129, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA5%2Fpexels-matheus-bertelli-2608517.jpg?alt=media&token=de53eec7-5a02-48c6-a88a-6cb197ae2e9a'),
(130, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA7%2Fpexels-fauxels-3183197.jpg?alt=media&token=167688f1-c6a1-4d13-88ba-898b38bf53ba'),
(130, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA6%2Fpexels-mikechie-esparagoza-1742370.jpg?alt=media&token=fdb85c92-8b5b-475d-8c2d-f0fe97b259ee'),
(130, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA6%2Fpexels-ovan-57690.jpg?alt=media&token=7a0f34da-f34d-4a33-8cc0-ae2f83998c0f'),
(130, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA6%2Fpexels-photo-230514.jpeg?alt=media&token=b920ad2b-921d-44dd-b9d8-35510bb4fc61'),
(130, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA6%2Fpexels-this-is-zun-1253951.jpg?alt=media&token=50d71f9c-fe1b-4007-b4a6-3bd315c68077'),
(131, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA8%2Fpexels-andrea-piacquadio-712413.jpg?alt=media&token=d9ebf0a1-7521-4c11-9778-7a39ec6294ae'),
(131, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA7%2Fpexels-fauxels-3184418.jpg?alt=media&token=11fed3c3-fa5b-40eb-bf95-2a22ded028a3'),
(131, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA7%2Fpexels-fauxels-3184423.jpg?alt=media&token=a541099b-9fd1-44f7-a8b0-878ecb22a4e0'),
(131, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA7%2Fpexels-rfstudio-3810792.jpg?alt=media&token=f06bce30-b8b5-482c-bfcb-d0461ac770c7'),
(132, 'poster', 'poster', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA9%2Fpexels-andrea-piacquadio-3758105.jpg?alt=media&token=2da46cf6-43f2-404a-a5d9-2b1d3498ef27'),
(132, 'activityDetail1', 'activityDetail1', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA8%2Fpexels-oleksandr-p-1008000.jpg?alt=media&token=11c90734-c3e1-4163-8a63-4c64dffb8f45'),
(132, 'activityDetail2', 'activityDetail2', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA8%2Fpexels-pixabay-258330.jpg?alt=media&token=b13d4b4c-e0e1-46a3-a72a-b6d870510e58'),
(132, 'activityDetail3', 'activityDetail3', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA8%2Fpexels-pixabay-289586.jpg?alt=media&token=84b13844-724b-4e28-8a3f-8a8363ba4bcb'),
(132, 'activityDetail4', 'activityDetail4', 'https://firebasestorage.googleapis.com/v0/b/unitydoimage.appspot.com/o/Other%2FA8%2Fpexels-riccardo-307008.jpg?alt=media&token=dbdd96fc-437e-4a6d-94ac-638340d3e486');