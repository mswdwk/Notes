# main execute flow

## important codes fragment
```golang
	handleStmt()  {
		rs, err := cc.ctx.ExecuteStmt(ctx, stmt){
			runStmt(){
				Exec(){
					e, err := a.buildExecutor()
        				err = a.openExecutor(ctx, e)
					handled, result, err := a.handleNoDelay(ctx, e, isPessimistic);
				}
			}
		}
		retryable, err := cc.writeResultset(ctx, rs, false, status, 0);
		handled, err := cc.handleQuerySpecial(ctx, status)
		execStmt.(*executor.ExecStmt).FinishExecuteStmt(0, err, false)
	}
```
## 1 buildExecutor

## 2 openExecutor
	build kv request, include start_key,end_key

## 3 exec Excutor:  executor.(*ExecStmt).Exec : 
	file: executor/adapter.go
	func: func (a *ExecStmt) Exec(ctx context.Context) (_ sqlexec.RecordSet, err error)
	build recordSet

## 4 write result to client
	loop call recordSet Next ,until return 0 row
