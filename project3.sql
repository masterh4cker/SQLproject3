/*********************************************************************************/
/*                                                                               */
/*  Date        Programmer     Description                                       */
/* ------------ -------------- --------------------------------------------------*/
/* 10-9-2020    Tfoes     Initial implementation of the disk inventory db.  */
/* 10-17-2020   Tfoes     Added Project3/Inserted new tables                     */
/*                                                                               */
/*                                                                               */
/*********************************************************************************/
USE master;
DROP DATABASE IF EXISTS disk_inventoryTF;
GO
CREATE DATABASE disk_inventoryTF;
GO

USE disk_inventoryTF;

--Create server login & database user
IF SUSER_ID ('diskUsertf') IS NULL
CREATE LOGIN diskUserTF WITH PASSWORD = 'Pa$$w0rd', DEFAULT_DATABASE = disk_inventoryTF;

DROP USER IF EXISTS diskUsertf;
CREATE USER diskUsertf;
ALTER ROLE db_datareader
ADD MEMBER diskUsertf;

--Create tables
CREATE TABLE artist_type (
artist_type_id INT NOT NULL PRIMARY KEY IDENTITY,
description NVARCHAR(60) NOT NULL
);

CREATE TABLE disk_type (
disk_type_id INT NOT NULL PRIMARY KEY IDENTITY,
description NVARCHAR(60) NOT NULL
);

CREATE TABLE status (
status_id INT NOT NULL PRIMARY KEY IDENTITY,
description NVARCHAR(60) NOT NULL
);

CREATE TABLE genre (
genre_id INT NOT NULL PRIMARY KEY IDENTITY,
description NVARCHAR(60) NOT NULL
);

CREATE TABLE renter (
renter_id INT NOT NULL PRIMARY KEY IDENTITY,
firstname NVARCHAR(60) NOT NULL,
lastname NVARCHAR(60) NOT NULL,
phone_num VARCHAR(15) NOT NULL
);

CREATE TABLE artist (
artist_id INT NOT NULL PRIMARY KEY IDENTITY,
firstname NVARCHAR(60) NOT NULL,
lastname NVARCHAR(60) NULL,
artist_type_id INT NOT NULL REFERENCES artist_type(artist_type_id)
);

CREATE TABLE disk (
disk_id INT NOT NULL PRIMARY KEY IDENTITY,
disk_name NVARCHAR(60) NOT NULL,
release_date DATE NOT NULL,
genre_id INT NOT NULL REFERENCES genre(genre_id),
status_id INT NOT NULL REFERENCES status(status_id),
disk_type_id INT NOT NULL REFERENCES disk_type(disk_type_id)
);

CREATE TABLE disk_has_renter (
renter_id INT NOT NULL REFERENCES renter(renter_id),
disk_id INT NOT NULL REFERENCES disk(disk_id),
rent_date DATETIME2 NOT NULL, 
returned_date DATETIME2 NULL
PRIMARY KEY (renter_id, disk_id)		
);

CREATE TABLE disk_has_artist (
	disk_id INT NOT NULL REFERENCES disk(disk_id),
	artist_id INT NOT NULL REFERENCES artist(artist_id),
	PRIMARY KEY (disk_id, artist_id)
);

/*******************************PROJECT 3**************************************/

--Inserts for artist_type -See ch 7 slide 12 or 13
INSERT INTO artist_type (description)
VALUES ('SOLO');
INSERT INTO artist_type (description)
VALUES ('Group');

--Inserts for disk_type - See ch 7 slide 12 or 13
INSERT INTO disk_type (description)
VALUES 
('CD'),
('Vinyl'),
('Strack'),
('Cassette'),
('DVD');

--Inserts for genre - See ch 7 slide 12 or 13
INSERT INTO genre (description)
VALUES 
('Classic Rock')
,('Country')
,('Jazz')
,('AltRock')
,('HipHop')
;

--Inserts for status 
INSERT status 
VALUES ('Avalable');
INSERT status
VALUES ('On loan');
INSERT status
VALUES ('Damaged');
INSERT status
VALUES ('Missing');

--Inserts for Renter
INSERT renter (firstname, lastname, phone_num)
VALUES ('Mickey', 'Mouse', '123-123-1234')
		,('Minie', 'Mouse', '222-222-2345')
		,('Daisy', 'Duck', '333-123-4567')
		,('Daffy', 'Duck', '444-123-4567')
		,('Donald', 'Duck', '556-333-4567')
		,('Huey', 'Duck', '552-123-4577')
		,('Dewey', 'Duck', '334-353-6789')
		,('Louie', 'Duck', '333-123-2156')
		,('Elmer', 'Joe', '679-123-4567')
		,('Buzz', 'Lightyear', '800-123-4567')
		,('Sheriff', 'Woody', '742-123-4567')
		,('Bo', 'Duck', '333-123-9024')
		,('Barb', 'Shaw', '333-903-4567')
		,('Santa', 'Clause', '908-123-4567')
		,('Flower', 'Duck', '333-123-4788')
		,('Race', 'Car', '208-459-4567')
		,('Mel', 'Row', '333-689-4567')
		,('Spooky', 'Season', '686-123-4567')
		,('T', 'Rex', '933-123-4447')
		,('Cool', 'Kid', '908-113-4567')
		;
--Delete 1 row. See ch 7 slide 23.
DELETE renter
WHERE renter_id = 20;

--Insert artist rows. Artist table:
INSERT Artist
VALUES ('Ozzy', 'Osbourne', 1);
INSERT Artist
VALUES ('Shinedown', NULL, 2);
INSERT Artist
VALUES ('Prince', NULL, 1);
INSERT Artist
VALUES ('Five Finger Death Punch', NULL, 2);
INSERT Artist
VALUES ('Willie', 'Nelson', 1);
INSERT Artist
VALUES ('Taylor', 'Swift', 1);
INSERT Artist
VALUES ('Alanis', 'Morrisette', 1);
INSERT Artist
VALUES ('Chris', 'Daughtry', 1);
INSERT Artist
VALUES ('The Cars', NULL, 2);
INSERT Artist
VALUES ('Black Sabbath', NULL, 2);
INSERT Artist
VALUES ('The Eagles', NULL, 2);
INSERT Artist
VALUES ('Lil', 'Peep', 1);
INSERT Artist
VALUES ('Pearl Jam', NULL, 2);
INSERT Artist
VALUES ('Collective Soul', NULL, 2);
INSERT Artist
VALUES ('Disturbed', NULL, 2);
INSERT Artist
VALUES ('Stone Temple Pilots', NULL, 2);
INSERT Artist
VALUES ('Breaking Benjamin', NULL, 2);
INSERT Artist
VALUES ('Audioslave', NULL, 2);
INSERT Artist
VALUES ('Temple of the Dog', NULL, 2);
INSERT Artist
VALUES ('Alice in Chains', NULL, 2);

--Disk Table Inserts
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Crazy Train', '1/1/1995', 1, 1, 1);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('No More Tears', '11/21/1995', 1, 1, 1);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Red', '11/13/2008', 2, 2, 1);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Jagged Little Pill', '1/15/1995', 1, 2, 1);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Candy-O', '10/10/1991', 1, 2, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Hotel California', '11/1/1977', 1, 2, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('One of These Nights', '4/11/1975', 1, 2, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('The Long Run', '10/21/1979', 1, 2, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Hints, Allegations, and Things Left Unsaid', '1/21/1979', 4, 2, 1);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Blender', '1/29/2000', 4, 1, 1);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Dirt', '1/27/1992', 4, 1, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Unplugged', '5/23/1996', 4, 1, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Facelift', '8/22/1990', 4, 1, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Black Give Way to Blue', '11/21/2009', 4, 1, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Live', '11/11/1979', 4, 3, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Ten', '12/1/1991', 4, 4, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Vitalogy', '3/22/1994', 4, 3, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('No Code', '4/2/1996', 4, 1, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('BackSpacer', '5/21/2009', 4, 1, 2);
INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES ('Home', '1/19/1995', 1, 2, 1);

--Update 1 Disk row - Ch 7 Slide 19
UPDATE disk
SET release_date = '6/21/2009'
WHERE disk_name = 'BackSpacer'
;

--Inserts to disk_has_borrower
INSERT disk_has_renter(renter_id, disk_id, rent_date, returned_date)
VALUES 
(2,4, '1-2-2012', '2-20-2012'),
(1,4, '1-4-2013', '2-10-2012'),
(3,4, '4-2-2012', '8-25-2012'),
(11,3, '1-2-2012', '8-20-2012'),
(2,2, '1-4-2012', NULL),
(14,4, '1-2-2012', '8-16-2012'),
(10,1, '1-2-2012', '2-20-2012'),
(5,4, '2-6-2013', '4-20-2013'),
(4,1, '3-2-2013', NULL),
(16,2, '4-12-2014', '9-25-2014'),
(19,6, '6-2-2015', '8-20-2015'),
(3,1, '6-2-2015', '6-10-2015'),
(5,3, '7-2-2015', '7-20-2015'),
(4,2, '9-2-2016', '10-11-2016'),
(3,2, '9-8-2016', '11-23-2016'),
(4,3, '10-24-2017', '11-19-2017'),
(6,3, '11-7-2018', '12-20-2018'),
(2,5, '1-2-2019', '2-20-2019'),
(1,6, '4-7-2019', '7-9-2019'),
(3,5, '8-2-2019', '10-13-2019')
;

--Inserts to disk_has_artist
INSERT disk_has_artist (artist_id, disk_id)
VALUES 
     (1,1)
    ,(2,2)
    ,(3,3)
    ,(4,4)
    ,(5,5)
    ,(6,6)
    ,(6,4)
    ,(7,7)
    ,(8,8)
    ,(9,9)
    ,(10,10)
    ,(11,11)
    ,(12,12)
    ,(13,13)
    ,(14,14)
    ,(15,15)
    ,(16,16)
    ,(16,21)
    ,(17,17)
    ,(18,18)
    ,(19,19)
    ,(20,20)
;

SELECT renter_id, disk_id, rent_date, returned_date
FROM disk_has_renter
WHERE returned_date IS NULL;


