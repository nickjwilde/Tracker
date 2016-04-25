DROP TABLE IF EXISTS Builder;
DROP TABLE IF EXISTS Photographer;
--DROP TABLE IF EXISTS Package;
DROP TABLE IF EXISTS Parade;
DROP TABLE IF EXISTS user_table;
DROP TABLE IF EXISTS Home;
DROP TABLE IF EXISTS Order_table;

DROP USER IF EXISTS test_person;

CREATE TABLE Builder(
    builder_id		  SERIAL 	PRIMARY KEY
    , name_of_builder     VARCHAR(100)	NOT NULL
    --, phone_number	  VARCHAR(14)
    --, email_address       VARCHAR(100)
    , time_stamp          TIMESTAMP     DEFAULT      current_timestamp     NOT NULL
    --, contact             VARCHAR(100)
);

CREATE TABLE Photographer(
	photographer_id		          SERIAL 	   PRIMARY KEY
	, name_of_photographer		  VARCHAR(100)	   NOT NULL
	, email_of_photographer           VARCHAR(100)
	, phone_number_of_photographer    VARCHAR(14)
	, notes_of_photographer           VARCHAR(1000)
	, time_stamp                      TIMESTAMP        DEFAULT      current_timestamp     NOT NULL
	, swag                            VARCHAR(2)
);

-- CREATE TABLE Package(
    -- package_id		              SERIAL 		      PRIMARY KEY
    -- , number_of_photos                INTEGER
    -- , notes_of_package                VARCHAR(10000)
    -- , time_stamp                      TIMESTAMP        DEFAULT      current_timestamp     NOT NULL
    -- , name                            VARCHAR(1000)
-- );

CREATE TABLE Parade(
    parade_id	                  SERIAL 	   PRIMARY KEY
    , name_of_parade		  VARCHAR(1000)	   NOT NULL
    , city_of_parade              VARCHAR(100)
    , state_of_parade             VARCHAR(100)
    , start_date_of_parade        TIMESTAMP
    , end_date_of_parade          TIMESTAMP
    , parade_notes                VARCHAR(10000)
    , time_stamp                  TIMESTAMP        DEFAULT      current_timestamp     NOT NULL
);

CREATE TABLE Home(
    home_id		                        SERIAL 		        PRIMARY KEY
    , home_name     		              VARCHAR(100)
    , home_address                    VARCHAR(100)
    , city                            VARCHAR(100)
    , state                           VARCHAR(100)
    , notes                           VARCHAR(10000)
    , parade_id                       INTEGER
    , builder_id                      INTEGER
    , time_stamp                      TIMESTAMP         DEFAULT         current_timestamp     NOT NULL
);

CREATE TABLE Order_table(
	order_id		                      SERIAL 		        PRIMARY KEY
	, raw_photos	                    INTEGER
	, raw_photos_date                 TIMESTAMP
	, estimated_photos                INTEGER
	, photos_approved                  VARCHAR(2)
	, photos_approved_date            TIMESTAMP
	, photographer_paid               VARCHAR(2)
	, photographer_paid_date          TIMESTAMP
	, quick_edit_upload               VARCHAR(2)
	, quick_edit_upload_date          TIMESTAMP
	, assigned_to_editor              VARCHAR(2)
	, assigned_to_editor_date         TIMESTAMP
	, final_edits_approve             VARCHAR(2)
	, final_edits_approve_date        TIMESTAMP
	, final_photos_num                INTEGER
	, final_cropping                  VARCHAR(2)
	, final_cropping_date             TIMESTAMP
	, final_edit_upload               VARCHAR(2)
	, final_edit_upload_date          TIMESTAMP
	, home_id                         INTEGER
	, photographer_id                 INTEGER
	, package_id                      INTEGER
	, time_stamp                      TIMESTAMP         DEFAULT         current_timestamp     NOT NULL
);

CREATE TABLE user_table(
	first_name      VARCHAR(100)
	, last_name       VARCHAR(100)
	, email           VARCHAR(1000)
	, user_id         VARCHAR(1000)
	, time_stamp      TIMESTAMP         DEFAULT         current_timestamp     NOT NULL
);


--CREATE USER test_person WITH PASSWORD '1234AbCd';
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE Order_table TO paradecraze;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE Home TO paradecraze;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE Parade TO paradecraze;
--GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE Package TO test_person;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE Photographer TO paradecraze;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE user_table TO paradecraze;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE Builder TO paradecraze;

GRANT USAGE, SELECT ON SEQUENCE Photographer_photographer_id_seq TO paradecraze;
GRANT USAGE, SELECT ON SEQUENCE builder_builder_id_seq TO paradecraze;
GRANT USAGE, SELECT ON SEQUENCE Order_table_order_id_seq TO paradecraze;
GRANT USAGE, SELECT ON SEQUENCE Home_home_id_seq TO paradecraze;
--GRANT USAGE, SELECT ON SEQUENCE Package_package_id_seq TO test_person;
GRANT USAGE, SELECT ON SEQUENCE Parade_parade_id_seq TO paradecraze;

--INSERT INTO user_table VALUES ('Curious','George','werid@email2.com','103164061673108730915');
--INSERT INTO user_table VALUES ('Ricky','Martin','1234@go.com','116875225766964555030');