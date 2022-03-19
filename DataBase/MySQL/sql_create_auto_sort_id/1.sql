-- https://blog.csdn.net/qq_34365173/article/details/80869475
-- mysql 生成排序号
-- method 1, give table t an column i,which is stand for the row id , i init as 0, display from 1 to the table row numbers.
select  (@i:=@i+1) as i,t.* from  t,(select   @i:=0)  as it where @i % 3 = 0 ;

-- method 2, however this method , next time execute the select sql, the a start from the table row number not from 1 !
set @a=0;
select (@a:=@a+1) as a,t.* from t;
