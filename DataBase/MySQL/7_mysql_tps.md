Some one use 'Com_commit' to calculate MySQL TPS.
However, this is not accurate when sql is autocommit,
because 'Com_commit' value not increase at this scene.
For example,the 'Com_commit' not increase when 
execute update/delete/insert sql statment with
autocommit on.

'Com_commit' value is accurate when use no autocommit.
For example: 
```
    begin;
    update table1 set name='xxx' where id=123;
    commit;
```
At this scene,'Com_update' and 'Com_commit' both increase.

