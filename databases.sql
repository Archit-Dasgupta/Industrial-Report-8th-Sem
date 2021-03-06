CREATE DATABASE misc DEFAULT CHARACTER SET utf8 ;

GRANT ALL ON misc.* TO 'fred'@'localhost' IDENTIFIED BY 'zap';
GRANT ALL ON misc.* TO 'fred'@'127.0.0.1' IDENTIFIED BY 'zap';

USE misc; (If in the command line)
#user table
CREATE TABLE users (
  user_id INTEGER NOT NULL AUTO_INCREMENT,
  name VARCHAR(128),
  email VARCHAR(128),
  password VARCHAR(128),
  PRIMARY KEY(user_id),
  INDEX(email)
) ENGINE=InnoDB CHARSET=utf8;

ALTER TABLE users ADD INDEX(email);
ALTER TABLE users ADD INDEX(password);

INSERT INTO users (name,email,password) 
VALUES ('Chuck','csev@umich.edu','1a52e17fa899cf40fb04cfc42e6352f1');

INSERT INTO users (name,email,password) 
VALUES ('UMSI','umsi@umich.edu','1a52e17fa899cf40fb04cfc42e6352f1');

##Position table
CREATE TABLE Position (
  position_id INTEGER NOT NULL AUTO_INCREMENT,
  profile_id INTEGER,
  rank INTEGER,
  year INTEGER,
  description TEXT,
  PRIMARY KEY(position_id),
  CONSTRAINT position_ibfk_1
    FOREIGN KEY (profile_id)
    REFERENCES Profile (profile_id)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
#institution and education
CREATE TABLE Institution (
  institution_id INTEGER NOT NULL KEY AUTO_INCREMENT,
  name VARCHAR(255),
  UNIQUE(name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE Education (
  profile_id INTEGER,
  institution_id INTEGER,
  rank INTEGER,
  year INTEGER,
  CONSTRAINT education_ibfk_1
    FOREIGN KEY (profile_id)
    REFERENCES Profile (profile_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT education_ibfk_2
    FOREIGN KEY (institution_id)
    REFERENCES Institution (institution_id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  PRIMARY KEY(profile_id, institution_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
