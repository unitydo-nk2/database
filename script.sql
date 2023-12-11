create database IF NOT EXISTS unityDoDB DEFAULT CHARACTER SET utf8;
use unityDoDB;
-- -----------------------------------------------------
-- Table `unityDoDB`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unityDoDB`.`User` ;

CREATE TABLE IF NOT EXISTS `unityDoDB`.`User` (
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
DROP TABLE IF EXISTS `unityDoDB`.`Location` ;

CREATE TABLE IF NOT EXISTS `unityDoDB`.`Location` (
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
DROP TABLE IF EXISTS `unity
DoDB`.`mainCategory` ;

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
-- Table `unityDoDB`.`Activity`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unityDoDB`.`Activity` ;

CREATE TABLE IF NOT EXISTS `unityDoDB`.`Activity` (
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
    REFERENCES `unityDoDB`.`Location` (`locationId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Activity_Category1`
    FOREIGN KEY (`categoryId`)
    REFERENCES `unityDoDB`.`category` (`categoryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Activity_User1`
    FOREIGN KEY (`activityOwner`)
    REFERENCES `unityDoDB`.`User` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `unityDoDB`.`Registration`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unityDoDB`.`Registration` ;

CREATE TABLE IF NOT EXISTS `unityDoDB`.`Registration` (
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
    REFERENCES `unityDoDB`.`User` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Registration_Activity1`
    FOREIGN KEY (`activityId`)
    REFERENCES `unityDoDB`.`Activity` (`activityId`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `unityDoDB`.`QuestionTitle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unityDoDB`.`QuestionTitle` ;

CREATE TABLE IF NOT EXISTS `unityDoDB`.`QuestionTitle` (
  `questionId` INT NOT NULL,
  `Question` VARCHAR(100) NOT NULL,
  `activityId` INT NULL,
  PRIMARY KEY (`questionId`),
  INDEX `fk_questionTitle_Activity1_idx` (`activityId` ASC) VISIBLE,
  CONSTRAINT `fk_questionTitle_Activity1`
    FOREIGN KEY (`activityId`)
    REFERENCES `unityDoDB`.`Activity` (`activityId`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `unityDoDB`.`Answer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unityDoDB`.`Answer` ;

CREATE TABLE IF NOT EXISTS `unityDoDB`.`Answer` (
  `answerId` INT NOT NULL auto_increment,
  `registrationId` INT NULL,
  `questionId` INT NOT NULL,
  `answer` VARCHAR(400) NOT NULL,
  PRIMARY KEY (`answerId`),
  INDEX `fk_answer_Registration1_idx` (`registrationId` ASC) VISIBLE,
  INDEX `fk_Answer_QuestionTitle1_idx` (`questionId` ASC) VISIBLE,
  CONSTRAINT `fk_answer_Registration1`
    FOREIGN KEY (`registrationId`)
    REFERENCES `unityDoDB`.`Registration` (`registrationId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Answer_QuestionTitle1`
    FOREIGN KEY (`questionId`)
    REFERENCES `unityDoDB`.`QuestionTitle` (`questionId`)
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
    REFERENCES `unityDoDB`.`User` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_activityHistory_Activity1`
    FOREIGN KEY (`activityId`)
    REFERENCES `unityDoDB`.`Activity` (`activityId`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `unityDoDB`.`ActivityReview`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unityDoDB`.`ActivityReview` ;

CREATE TABLE IF NOT EXISTS `unityDoDB`.`ActivityReview` (
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
    REFERENCES `unityDoDB`.`Activity` (`activityId`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_activityReview_Users1`
    FOREIGN KEY (`userId`)
    REFERENCES `unityDoDB`.`User` (`userId`)
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
    REFERENCES `unityDoDB`.`User` (`userId`)
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
    REFERENCES `unityDoDB`.`Activity` (`activityId`)
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
  `activityFavoriteID` INT NOT NULL auto_increment,
  `activityHistoryId` INT NOT NULL,
  `isFavorite` TINYINT NOT NULL,
  PRIMARY KEY (`activityFavoriteID`),
  INDEX `fk_activityFavorite_ActivityHistory1_idx` (`activityHistoryId` ASC) VISIBLE,
  CONSTRAINT `fk_activityFavorite_ActivityHistory1`
    FOREIGN KEY (`activityHistoryId`)
    REFERENCES `unityDoDB`.`userActivityHistory` (`activityHistoryId`)
    ON DELETE NO ACTION
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
    REFERENCES `unityDoDB`.`Activity` (`activityId`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `unityDoDB`.`Validation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `unityDoDB`.`Validation` ;

CREATE TABLE IF NOT EXISTS `unityDoDB`.`Validation` (
  `validationId` INT NOT NULL auto_increment,
  `activityId` INT NOT NULL,
  `validationType` ENUM('QRCode', 'stepCounter', 'GPS', 'heartRate', 'distanceCal'),
  `validationRule` DOUBLE NOT NULL,
  PRIMARY KEY (`validationId`),
  INDEX `fk_Validation_Activity1_idx` (`activityId` ASC) VISIBLE,
  CONSTRAINT `fk_Validation_Activity1`
    FOREIGN KEY (`activityId`)
    REFERENCES `unityDoDB`.`Activity` (`activityId`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

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
    User (
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
    (
        'user1',
        'password123',
        'John',
        'Doe',
        'JD123',
        'john.doe@email.com',
        'Male',
        '1990-05-15',
        'Christian',
        '+1234567890',
        '123 Main St, City, Country',
        'user',
        '+0987654321',
        'profile1.jpg',
        'john_doe_line',
        'john_doe_instagram',
        'john_doe_x',
        '2023-10-09 14:50:00',
        '2023-10-09 14:50:00'
    ),
    (
        'user2',
        'password456',
        'Jane',
        'Smith',
        'JS456',
        'jane.smith@email.com',
        'Female',
        '1985-08-20',
        'Buddhist',
        '+9876543210',
        '456 Elm St, City, Country',
        'activityOwner',
        '+1234509876',
        'profile2.jpg',
        'jane_smith_line',
        'jane_smith_instagram',
        'jane_smith_x',
        '2023-10-09 14:50:00',
        '2023-10-09 14:50:00'
    ),
    (
        'admin1',
        'adminpassword',
        'Admin',
        'User',
        'Admin123',
        'admin@email.com',
        'Other',
        '1970-01-01',
        'None',
        '+1111111111',
        '789 Oak St, City, Country',
        'admin',
        '+2222222222',
        'admin_profile.jpg',
        'admin_line',
        'admin_instagram',
        'admin_x',
        '2023-10-09 14:50:00',
        '2023-10-09 14:50:00'
    ),
    (
        'user3',
        'userpass123',
        'Alice',
        'Johnson',
        'AJ123',
        'alice@email.com',
        'Female',
        '1995-03-10',
        'Hindu',
        '+3333333333',
        '789 Elm St, City, Country',
        'user',
        '+3333333333',
        'alice_profile.jpg',
        'alice_line',
        'alice_instagram',
        'alice_x',
        '2023-01-15 12:30:00',
        '2023-01-15 12:30:00'
    ),
    (
        'user4',
        'userpass456',
        'Bob',
        'Williams',
        'BW456',
        'bob@email.com',
        'Male',
        '1988-11-25',
        'Atheist',
        '+4444444444',
        '123 Oak St, City, Country',
        'user',
        '+4444444444',
        'bob_profile.jpg',
        'bob_line',
        'bob_instagram',
        'bob_x',
        '2023-01-16 09:45:00',
        '2023-01-16 09:45:00'
    ),
    (
        'activityOwner1',
        'activitypass123',
        'Sarah',
        'Miller',
        'SM123',
        'sarah@email.com',
        'Female',
        '1980-07-05',
        'Jewish',
        '+5555555555',
        '456 Pine St, City, Country',
        'activityOwner',
        '+5555555555',
        'sarah_profile.jpg',
        'sarah_line',
        'sarah_instagram',
        'sarah_x',
        '2023-01-17 14:20:00',
        '2023-01-17 14:20:00'
    ),
    (
        'activityOwner2',
        'activitypass456',
        'Michael',
        'Brown',
        'MB456',
        'michael@email.com',
        'Male',
        '1982-04-12',
        'Christian',
        '+6666666666',
        '789 Maple St, City, Country',
        'activityOwner',
        '+6666666666',
        'michael_profile.jpg',
        'michael_line',
        'michael_instagram',
        'michael_x',
        '2023-01-18 18:10:00',
        '2023-01-18 18:10:00'
    ),
    (
        'admin2',
        'adminpassword2',
        'Admin',
        'User2',
        'Admin234',
        'admin2@email.com',
        'Other',
        '1975-02-15',
        'None',
        '+7777777777',
        '456 Cedar St, City, Country',
        'admin',
        '+7777777777',
        'admin2_profile.jpg',
        'admin2_line',
        'admin2_instagram',
        'admin2_x',
        '2023-01-19 21:05:00',
        '2023-01-19 21:05:00'
    );

-- Insert more data into the Location table for places in Thailand
INSERT INTO
    `unityDoDB`.`Location` (
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
    );



	-- Insert data into the Activity table with activityEndDate and activityFormat columns
INSERT INTO
    `unityDoDB`.`Activity` (
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
    );