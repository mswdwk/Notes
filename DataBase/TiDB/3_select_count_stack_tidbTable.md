chunk.(*Decoder).decodeColumn (tidb/util/chunk/codec.go:316)
chunk.(*Decoder).Decode (tidb/util/chunk/codec.go:267)
distsql.(*selectResult).readFromChunk (tidb/distsql/select_result.go:346)
distsql.(*selectResult).Next (tidb/distsql/select_result.go:276)
executor.(*tableResultHandler).nextChunk (tidb/executor/table_reader.go:596)
executor.(*TableReaderExecutor).Next (tidb/executor/table_reader.go:331)
executor.Next (tidb/executor/executor.go:324)
executor.(*StreamAggExec).consumeCurGroupRowsAndFetchChild (tidb/executor/aggregate.go:1398)
executor.(*StreamAggExec).consumeOneGroup (tidb/executor/aggregate.go:1326)
executor.(*StreamAggExec).Next (tidb/executor/aggregate.go:1315)
executor.Next (tidb/executor/executor.go:324)
executor.(*ExecStmt).next (tidb/executor/adapter.go:1220)
executor.(*recordSet).Next (tidb/executor/adapter.go:173)
session.(*execStmtResult).Next (Unknown Source:1)
server.(*tidbResultSet).Next (tidb/server/driver_tidb.go:434)
server.(*clientConn).writeChunks (tidb/server/conn.go:2205)
server.(*clientConn).writeResultset (tidb/server/conn.go:2148)
server.(*clientConn).handleStmt (tidb/server/conn.go:2021)
server.(*clientConn).handleQuery (tidb/server/conn.go:1849)
server.(*clientConn).dispatch (tidb/server/conn.go:1380)
server.(*clientConn).Run (tidb/server/conn.go:1129)
server.(*Server).onConn (tidb/server/server.go:626)
server.(*Server).startNetworkListener.func2 (tidb/server/server.go:483)
runtime.goexit (go/src/runtime/asm_amd64.s:1598)
