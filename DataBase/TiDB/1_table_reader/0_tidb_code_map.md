server.(*Server).onConn (tidb/server/server.go:626) {
	server.(*clientConn).onCon {
		server.(*clientConn).Run (tidb/server/conn.go:1129){
			server.(*clientConn).dispatch { 
				case mysql.ComQuery:
				server.(*clientConn).handleQuery (tidb/server/conn.go:1849) {
					stmts = cc.ctx.Parse(ctx, sql);
					server.(*clientConn).handleStmt {
						rs = server.(*TiDBContext).ExecuteStmt (tidb/server/driver_tidb.go:258){
							session.(*session).ExecuteStmt { 
								// translate ast to a plan (stored in executor.ExecStmt)
								stmt, err := executor.(*Compiler).Compile(ctx,stmtNode)  (tidb/executor/compiler.go:112){
									planner.Optimize { 
										planner.optimize (tidb/planner/optimize.go:401) {
											planner.buildLogicalPlan { 
												core_plan = core.(*PlanBuilder).Build(ctx,node)  (tidb/planner/core/planbuilder.go:790) {
													case *ast.ExplainStmt: core.(*PlanBuilder).buildExplain{
														b.buildExplainPlan(targetPlan, explain.Format, nil, explain.Analyze, explain.Stmt, nil)
													} 
													case *ast.SelectStmt: core.(*PlanBuilder).buildSelect{
													}
													case *ast.InsertStmt: core.(*PlanBuilder).buildInsert{
													}
												} // end PlanBuilder Build
											}
											// Handle the non-logical plan statement.
											logic, isLogicalPlan := p.(core.LogicalPlan)
											finalPlan, cost, err := core.DoOptimize(ctx, sctx, builder.GetOptFlag(), logic)
										}
									}
								}
								// Execute the physical plan in stmt .
								recordSet, err = runStmt(ctx, s, stmt) {
									rs, err = s.Exec(ctx) (executor/adapter.go:455) {
										err = a.openExecutor(ctx, e);
									}
									err = finishStmt(ctx, se, err, s)
								}
							}
						}
						// send result to client
						cc.writeResultset(ctx, rs, false, status, 0) {
							cc.initResultEncoder(ctx)	
							cc.writeChunks(ctx, rs, binary, serverStatus) {
								for {
									err := rs.Next(ctx, req)
									rowCount := req.NumRows()
									if rowCount == 0  { break }
									for i:=0; i< rowCount;i++ {
										data, err = dumpBinaryRow(data, rs.Columns(), req.GetRow(i), cc.rsEncoder)
										cc.writePacket(data);
									}
								}
							}
						}
					} // end handleStmt
				}
				case mysql.ComStmtPrepare:
					cc.handleStmtPrepare(ctx, dataStr)
				case mysql.ComInitDB:
					if err := cc.useDB(ctx, dataStr); err != nil {
						return err
					}
					return cc.writeOK(ctx)
			}
		}
	}
}
