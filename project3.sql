/*********************************************************************************/
/*                                                                               */
/*  Date        Programmer     Description                                       */
/* ------------ -------------- --------------------------------------------------*/
/* 10-9-2020    Tfoes     Initial implementation of the disk inventory db.  */
/* 10-17-2020   Tfoes     Added Project3/Inserted new tables                     */
/* 10-28-2020   Tfoes     Add inserts, updates, deletes                                                          */
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
    ,(16,20)
    ,(17,17)
    ,(18,18)
    ,(19,19)
    ,(20,20)
;

SELECT renter_id, disk_id, rent_date, returned_date
FROM disk_has_renter
WHERE returned_date IS NULL;

--Project 4 starts here
--3. Show the disks in your database and any associated Individual artists only. 
SELECT disk_name, release_date, firstname, lastname 					--See specs for columns page 93 shows how to override name
FROM artist
JOIN disk_has_artist 
ON disk_has_artist.artist_id = artist.artist_id			 --Join to disk_has_artist - See Ch 4 for join info
JOIN disk ON disk.disk_id = disk_has_artist.disk_id						     --Join to disk - Page 137 for explicit join
WHERE artist_type_id = 1
ORDER BY disk_name DESC	;				

--4. Create a view called View_Individual_Artist that shows the artists� names and not group names. Include the artist id in the view definition but do not display the id in your output.
USE disk_inventoryTF
GO
DROP VIEW IF EXISTS View_Individual_Artist 
GO
CREATE VIEW View_Individual_Artist 
AS 
SELECT firstname, lastname, artist_id, artist_type_id
FROM artist
WHERE artist_type_id = 1
							                  --See output for other specifications
GO
SELECT firstname, lastname 
FROM View_Individual_Artist
go					                  --See report output

--5. Show the disks in your database and any associated Group artists only. Use the View_Individual_Artist view. 
ALTER VIEW View_Individual_Artist
AS
SELECT disk_name AS DiskName, release_date AS ReleaseDate, firstname AS ArtistFirstName
FROM artist
JOIN disk_has_artist ON disk_has_artist.artist_id = artist.artist_id
JOIN disk ON disk.disk_id = disk_has_artist.disk_id
WHERE artist_type_id = 2
go

SELECT *
FROM View_Individual_Artist
ORDER BY DiskName DESC;
go
--6. Show the borrowed disks and who borrowed them.
SELECT firstname AS First, lastname AS Last, disk_name AS DiskName, rent_date AS BorrowedDate, release_date AS ReturnedDate
FROM renter
JOIN disk_has_renter ON disk_has_renter.renter_id = renter.renter_id
JOIN disk ON disk.disk_id = disk_has_renter.disk_id
WHERE status_id = 2

SELECT *
FROM renter
JOIN disk_has_renter ON disk_has_renter.renter_id = renter.renter_id
JOIN disk ON disk.disk_id = disk_has_renter.disk_id
--7. Show the number of times a disk has been borrowed.
SELECT disk.disk_id AS Diskid, disk_name AS DiskName,COUNT(*) AS 'Times Borrowed'
FROM disk
join disk_has_renter on disk.disk_id = disk_has_renter.disk_id
group by disk.disk_id, disk_name
order by disk.disk_id
go

--8. Show the disks outstanding or on-loan and who has each disk. 
SELECT disk_name, rent_date AS Borowed, returned_date AS Returned, lastname			--See output
FROM disk
JOIN disk_has_renter on disk_has_renter.disk_id = disk.disk_id
JOIN renter on disk_has_renter.renter_id = renter.renter_id						--Join disk_has_borrower
							--Join borrower
WHERE returned_date IS NULL;
GO
							--See output for other specifications

--Project 5
DROP PROC IF EXISTS sp_ins_disk;
GO
CREATE PROC sp_ins_disk
	@disk_name nvarchar(60), @release_date date, @genre_id int, @status_id int, @disk_type_id int
AS
BEGIN TRY
	INSERT disk (disk_name, release_date, genre_id, status_id, disk_type_id)
	VALUES (@disk_name, @release_date, @genre_id, @status_id, @disk_type_id);
	END TRY
	BEGIN CATCH
		PRINT 'An error occured.';
		PRINT 'Message: ' + CONVERT(varchar(200), ERROR_MESSAGE());
	END CATCH
GO
GRANT EXECUTE ON sp_ins_disk to diskUserTF
EXEC sp_ins_disk 'Blender2', '1/29/2000', 4, 1, 1;
GO
EXEC sp_ins_disk 'Blender3', '1/29/2000', 4, 1, NULL;
GO
--Create update disk stored procedure

USE [disk_inventoryTF]
GO
--Update procedure 
DROP PROC IF EXISTS sp_upd_disk;
GO
CREATE PROC sp_upd_disk
	@disk_id int, @disk_name nvarchar(60), @release_date date, @genre_id int, @status_id int, @disk_type_id int
AS
BEGIN TRY
UPDATE [dbo].[disk]
   SET [disk_name] = @disk_name
      ,[release_date] = @release_date
      ,[genre_id] = @genre_id
      ,[status_id] = @status_id
      ,[disk_type_id] = @disk_type_id
 WHERE disk_id = @disk_id;
 END TRY
	BEGIN CATCH
		PRINT 'An error occured.';
		PRINT 'Message: ' + CONVERT(varchar(200), ERROR_MESSAGE());
	END CATCH
GO
GRANT EXECUTE ON sp_upd_disk to diskUserTF
EXEC sp_upd_disk 44, 'Blender2', '09/15/2001', 4, 2, 1;
GO
EXEC sp_upd_disk 47, 'Blender3', '09/15/2001', 4, 2, NULL;
GO

--Create delete disk procedure. Delete accepts 
DROP PROC IF EXISTS sp_del_disk;
GO
CREATE PROC sp_del_disk
@disk_id int
AS
BEGIN TRY 
DELETE FROM [dbo].[disk]
WHERE disk_id = @disk_id;
 END TRY
	BEGIN CATCH
		PRINT 'An error occured.';
		PRINT 'Message: ' + CONVERT(varchar(200), ERROR_MESSAGE());
	END CATCH
GO
GRANT EXECUTE ON sp_del_disk to diskUserTF
EXEC sp_del_disk 44;
GO
EXEC sp_del_disk 47;
GO
--Insert procedure for artists
DROP PROC IF EXISTS sp_ins_artist;
GO
CREATE PROC sp_ins_artist
--add artist parameters
@fistname nvarchar(60), @lastname nvarchar(60), @artist_type_id int
AS
	BEGIN TRY
--Add insert to artist
INSERT Artist
VALUES (@fistname, @lastname, @artist_type_id);
	END TRY
	BEGIN CATCH
	PRINT 'An error occured.';
		PRINT 'Message: ' + CONVERT(varchar(200), ERROR_MESSAGE());
	END CATCH
GO
GRANT EXECUTE ON sp_ins_artist TO diskUserTF
GO
EXEC sp_ins_artist 'Jar', 'Leto', 1
GO
EXEC sp_ins_artist 'Cher', NULL, 1
GO
EXEC sp_ins_artist 'Cher', NULL, NULL
GO

--Update procedure for artist
DROP PROC IF EXISTS sp_upd_artist;
GO
CREATE PROC sp_upd_artist
--add artist parameters
@artist_id int, @fistname nvarchar(60), @lastname nvarchar(60), @artist_type_id int
AS
	BEGIN TRY
--Add update to artist
UPDATE Artist
SET firstname = @fistname, lastname = @lastname, artist_type_id = @artist_type_id
WHERE artist_id = @artist_id;
	END TRY
	BEGIN CATCH
	PRINT 'An error occured.';
		PRINT 'Message: ' + CONVERT(varchar(200), ERROR_MESSAGE());
	END CATCH
GO
GRANT EXECUTE ON sp_upd_artist TO diskUserTF
GO
EXEC sp_upd_artist 21, 'Jar', 'Leto', 2
GO
EXEC sp_upd_artist 22, 'Cher', NULL, 2
GO
EXEC sp_upd_artist 23, 'Cher', NULL, 11
GO

--Delete procedure for artist
DROP PROC IF EXISTS sp_del_artist;
GO
CREATE PROC sp_del_artist
--Delete accepts a primary key value for delete 
@artist_id int
AS
	BEGIN TRY
--add delete statement to artist
DELETE Artist
WHERE artist_id = @artist_id;
	END TRY
	BEGIN CATCH
	PRINT 'An error occured.';
		PRINT 'Message: ' + CONVERT(varchar(200), ERROR_MESSAGE());
	END CATCH
GO
GRANT EXECUTE ON sp_upd_artist TO diskUserTF
GO
EXEC sp_del_artist 21
GO
EXEC sp_del_artist 22
GO
EXEC sp_del_artist 23
GO

--Create insert procedure for renter
DROP PROC IF EXISTS sp_ins_renter;
GO
CREATE PROC sp_ins_renter
--add renter parameters
@firstname nvarchar(60), @lastname nvarchar(60), @phone_num varchar(15)
AS
	BEGIN TRY
--Insert accepts all colums as input parameters exept for identity fields
INSERT renter (firstname, lastname, phone_num)
VALUES (@firstname, @lastname, @phone_num)
	END TRY
	BEGIN CATCH
	PRINT 'An error occured.';
		PRINT 'Message: ' + CONVERT(varchar(200), ERROR_MESSAGE());
	END CATCH
GO
GRANT EXECUTE ON sp_ins_renter TO diskUserTF
GO
EXEC sp_ins_renter 'Mickey', 'Mouse', '123-123-1234';
GO
EXEC sp_ins_renter 'Minnie', '', '222-222-2345';
GO
EXEC sp_ins_renter 'Daisy', ' ', '333-123-4567';
GO
EXEC sp_ins_renter 'Daffy', NULL, '444-123-4567';
GO

--Creat update procedure for renter
DROP PROC IF EXISTS sp_upd_renter;
GO
CREATE PROC sp_upd_renter
--add renter parameters
@renter_id int, @firstname nvarchar(60), @lastname nvarchar(60), @phone_num varchar(15)
AS
	BEGIN TRY
--Insert accepts all colums as input parameters exept for identity fields
UPDATE renter
SET firstname = @firstname, lastname = @lastname, phone_num = @phone_num
WHERE renter_id = @renter_id;
	END TRY
	BEGIN CATCH
	PRINT 'An error occured.';
		PRINT 'Message: ' + CONVERT(varchar(200), ERROR_MESSAGE());
	END CATCH
GO
GRANT EXECUTE ON sp_ins_renter TO diskUserTF
GO
EXEC sp_upd_renter 23, 'Mickey', 'Mouseee', '123-123-2222';
GO
EXEC sp_upd_renter 24, 'Minnie', 'Bennet', '222-211-2345';
GO
EXEC sp_upd_renter 25, 'Daisy', 'Flower', '333-563-4567';
GO
EXEC sp_upd_renter 25, 'Daffy', NULL, '444-123-4567';
GO

--Creat delete procedure for renter
DROP PROC IF EXISTS sp_del_renter;
GO
CREATE PROC sp_del_renter
--add renter parameters
@renter_id int
AS
	BEGIN TRY
--Insert accepts all colums as input parameters exept for identity fields
DELETE renter
WHERE renter_id = @renter_id;
	END TRY
	BEGIN CATCH
	PRINT 'An error occured.';
		PRINT 'Message: ' + CONVERT(varchar(200), ERROR_MESSAGE());
	END CATCH
GO
GRANT EXECUTE ON sp_ins_renter TO diskUserTF
GO
EXEC sp_del_renter 23;
GO
EXEC sp_del_renter 24;
GO
EXEC sp_del_renter 25;
GO
EXEC sp_del_renter 25;
GO




