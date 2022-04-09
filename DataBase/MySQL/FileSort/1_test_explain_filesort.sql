show databases

create database if not exists testdb;
use testdb;
show tables ;

DROP TABLE IF EXISTS `test_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `test_order` (
  `distrib` varchar(32) not null,
  `D` char(32)  NOT NULL,
  `id` char(64) NOT NULL,
  `pk2` int(11) NOT NULL,
  `A` char(32)  NOT NULL,
  `B` int(11) NOT NULL,
  `C` varchar(32) NOT NULL,
  `ad` text not null,
  PRIMARY KEY (`id`,`pk2`),
  KEY `idx` (`A`,`B`,`C`,`D`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;


LOCK TABLES `test_order` WRITE;
/*!40000 ALTER TABLE `test_order` DISABLE KEYS */;

INSERT INTO `test_order` VALUES 
('content 1','a','a',1,'a',1,'c','this is a filed'),('dist 2','d 2','id 2',2,'a 2',2,'c 2','filed data 2'),('dist 3','d 3','id 3',3,'a 3',3,'c 3','filed data 3'),('dist 4','d 4','id 4',4,'a 4',4,'c 4','filed data 4'),
('dist 5','d 5','id 5',5,'a 5',5,'c 5','filed data 5'),('dist 6','d 6','id 6',6,'a 6',6,'c 6','filed data 6'),('dist 7','d 7','id 7',7,'a 7',7,'c 7','filed data 7'),('dist 8','d 8','id 8',8,'a 8',8,'c 8','filed data 8'),
('dist 50','d 50','id 50',50,'a 50',50,'c 50','filed data 50'),('dist 60','d 60','id 60',60,'a 60',60,'c 60','filed data 60'),('dist 70','d 70','id 70',70,'a 70',70,'c 70','filed data 70'),('dist 80','d 80','id 80',80,'a 80',80,'c 80','filed data 80'),
('dist 315','d 315','id 315',315,'a 315',315,'c 315','filed data 315'),('dist 316','d 316','id 16',316,'a 316',316,'c 316','filed data 316'),('dist 317','d 317','id 317',317,'a 317',317,'c 317','filed data 317'),('dist 318','d 318','id 318',318,'a 318',318,'c 318','filed data 318');

/*!40000 ALTER TABLE `test_order` ENABLE KEYS */;
UNLOCK TABLES;

select count(*) from test_order ;
select * from test_order

explain select * from test_order where distrib='cont' and D='d' and b=1234 order by A,B,C,D; -- Result field 'Extra' output on dbeaver client verion 21.2 is "Using filesort" same as mysql client,when mysql-server is 5.7.22 or 5.7.37 .

explain select * from test_order where distrib='cont' and D='d' and A='a'  order by A,B,C;  -- When mysql-server is 5.7.22, Result field 'Extra' output on dbeaver client verion 21.2 is "Using filesort" NOT same as mysql client.
																						   -- When mysql-server is 5.7.37,Result field 'Extra' output on deeaver client is SAME as mysql client.

explain select * from test_order where distrib='cont'  and D='d' and A='a' order by A;  -- When mysql-server is 5.7.22, Result field 'Extra' output on dbeaver client verion 21.2 is "Using filesort" NOT same as mysql client.
																				       -- When mysql-server is 5.7.37,Result field 'Extra' output on deeaver client is SAME as mysql client.

explain select * from test_order where distrib='cont'  and D='d' and A='a' order by B; -- no filesort. dbeaver client  verion 21.2 output same as mysql client , when mysql-server is 5.7.22 or 5.7.37

explain select * from test_order where distrib='cont'  and D='d' and A='a' order by B,C; -- no filesort. dbeaver client  verion 21.2 output same as mysql client, when mysql-server is 5.7.22 or 5.7.37


show variables like '%collation%'