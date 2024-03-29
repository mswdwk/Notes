create database if not exists testdb;

use testdb;

drop table if exists e;

CREATE TABLE e (
 id INT NOT NULL,
 fname VARCHAR(30),
 lname VARCHAR(30)
)
 PARTITION BY RANGE (id) (
 PARTITION p0 VALUES LESS THAN (50),
 PARTITION p1 VALUES LESS THAN (100),
 PARTITION p2 VALUES LESS THAN (150),
 PARTITION p3 VALUES LESS THAN (MAXVALUE)
);

INSERT INTO e VALUES
 (1669, "Jim", "Smith"),
 (337, "Mary", "Jones"),
 (16, "Frank", "White"),
 (2005, "Linda", "Black");
	
	CREATE TABLE e2 LIKE e;
	ALTER TABLE e2 REMOVE PARTITIONING;
	
	SELECT PARTITION_NAME, TABLE_ROWS FROM INFORMATION_SCHEMA.PARTITIONS WHERE TABLE_NAME = 'e';
	
	 ALTER TABLE e EXCHANGE PARTITION p0 WITH TABLE e2;
	
	 SELECT PARTITION_NAME, TABLE_ROWS FROM INFORMATION_SCHEMA.PARTITIONS WHERE TABLE_NAME = 'e';