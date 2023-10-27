# copIterator
## source file: store/copr/coprocessor.go
## 1) get data from tikv through copIterator Open method
build 
create tikv response data chan respCh
## 2) table reader executor get data from tikv through copIterator Next method
function	recvFromRespCh get tikv data from chan 'respCh'

# TableReaderExecutor
## source file: executor/table_reader.go

## 1) 

