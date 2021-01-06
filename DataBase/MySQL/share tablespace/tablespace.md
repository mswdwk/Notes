# 1 innodb_data_file_path
Defines the name, size, and attributes of InnoDB system tablespace data files.. If you do not specify a value for innodb_data_file_path, the default behavior is to create a single auto-extending
data file, slightly larger than 12MB, named ibdata1.
# 2 if you find 'xxx tablespace is missing' then you should do below.

## 1) alter table xxx discard tablespace

## 2) alter table xxx import tablespace

# 3 mysqld got signal 6

# 4 recv_recovery_from_checkpoint_start
# 5 Some pointers may be invalid and cause the dump to abort
# 6 handle_fatal_signal