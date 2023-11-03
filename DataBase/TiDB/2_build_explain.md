# reference 
## [TiDB 源码阅读系列文章（三）SQL 的一生](https://cn.pingcap.com/blog/tidb-source-code-reading-3/)
## [TiDB 源码阅读系列文章（六）Select 语句概览](https://cn.pingcap.com/blog/tidb-source-code-reading-6/)

# TIDB CODE MAP
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
														p, err = b.buildTableRefs(ctx, sel.From) {
															buildResultSetNode(ctx context.Context, node ast.ResultSetNode, isCTE bool) {
																case *ast.Join:
																	return b.buildJoin(ctx, x)
																case *ast.TableSource:	
																	switch v := x.Source.(type) {
																		case *ast.TableName:
																			p, err = b.buildDataSource(ctx, v, &x.AsName) {
																				if tableInfo.IsView() {
																					return b.BuildDataSourceFromView(ctx, dbName, tableInfo, currentQBNameMap4View, currentViewHints)
																				}
																			}
																			return p
																	}
																case *ast.SelectStmt:
																	return b.buildSelect(ctx, x)
															}
														}
														if sel.Where != nil {
															p, err = b.buildSelection(ctx, p, sel.Where, nil) (planner/core/logical_plan_builder.go:1033)
														}
													}
													case *ast.InsertStmt: core.(*PlanBuilder).buildInsert{
													}
													case *ast.InsertStmt: core.(*PlanBuilder).buildDDL(ctx context.Context, node ast.DDLNode) {
														switch v := node.(type) {
															case *ast.CreateTableStmt: { }
															case *ast.CreateViewStmt: {
																
															}
														}
													}
												} // end PlanBuilder Build
											}
											// Handle the non-logical plan statement.
											logic, isLogicalPlan := p.(core.LogicalPlan)
											//  DoOptimize optimizes a logical plan to a physical plan.
											finalPlan, cost, err := core.DoOptimize(ctx, sctx, builder.GetOptFlag(), logic) {
												logic, err := logicalOptimize(ctx, flag, logic) {
													for i, rule := range optRuleList {
														logic, err = rule.optimize(ctx, logic, opt)
													}
												}
												physical, cost, err := physicalOptimize(logic, &planCounter) {
													preparePossibleProperties(logic)
													opt := defaultPhysicalOptimizeOption()
													t, _, err := logic.findBestTask(prop, planCounter, opt) (planner/core/find_best_task.go:803) {
														tblTask, err = ds.convertToTableScan(prop, candidate, opt) {
															ts, _ := ds.getOriginalPhysicalTableScan(prop, candidate.path, candidate.isMatchProp)
															ts.addPushedDownSelection(copTask, ds.stats.ScaleByExpectCnt(prop.ExpectedCnt))
														}
														idxTask, err := ds.convertToIndexScan(prop, candidate, opt)
														appendCandidate(ds, idxTask, prop, opt)
														curIsBetter, err := compareTaskCost(ds.ctx, idxTask, t, opt)
													}
													cost, err = getPlanCost(t.plan(), property.RootTaskType, NewDefaultPlanCostOption())
													return t.plan(), cost, err
												}
												finalPlan, err := postOptimize(ctx, sctx, physical)
											}
										}
									}
								}
								// Execute the physical plan in stmt .
								recordSet, err = runStmt(ctx, s, stmt) {
									rs, err = s.Exec(ctx) (executor/adapter.go:455) {
										e, err := a.buildExecutor()
										err = a.openExecutor(ctx, e) {
											executor.( xxx ).open {
												executor.(*TableReaderExecutor).Open {
													executor.(*TableReaderExecutor).buildResp {
														executor.selectResultHook.SelectResult {
															distsql.SelectWithRuntimeStats {
																sr, err := Select(ctx, sctx, kvReq, fieldTypes, fb) {
																	resp := sctx.GetClient().Send(ctx, kvReq, sctx.GetSessionVars().KVVars, option)
																	return &selectResult{
																		label:              "dag",
																		resp:               resp,
																		rowLen:             len(fieldTypes),
																		fieldTypes:         fieldTypes,
																		ctx:                sctx,
																		feedback:           fb,
																		sqlType:            label,
																		memTracker:         kvReq.MemTracker,
																		storeType:          kvReq.StoreType,
																		paging:             kvReq.Paging.Enable,
																		distSQLConcurrency: kvReq.Concurrency,
																	}, nil
																}
															}
														}
													}
												}
											}
										}
										pi.SetProcessInfo(sql, time.Now(), cmd, maxExecutionTime) {
											// GetExplainRowsForPlan get explain rows for plan.
											func GetExplainRowsForPlan(plan Plan) (rows [][]string) {
												err := explain.RenderResult(){
													switch strings.ToLower(e.Format) {
														case types.ExplainFormatBrief: {
															flat := FlattenPhysicalPlan(e.TargetPlan, true)
															e.explainFlatPlanInRowFormat(flat)
														}
													}
												}
											}
	
										}
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
									err := rs.Next(ctx, req) {
										// for ExplainExec
										e.generateExplainInfo(ctx) (rows [][]string,err error) {   [ executor/explain.go:71 ]
											e.executeAnalyzeExec(ctx);
											err = e.explain.RenderResult() {
												flat := FlattenPhysicalPlan(e.TargetPlan, true)
												e.explainFlatPlanInRowFormat(flat)	
											}
											return e.explain.Rows
										}
									}
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


# 1 planner/core ToString translate a plan to string
func ToString(p Plan) string (planner/core/stringer.go:26)
# TestCrossValidationSelectivity
# Flat Plan Test
file : planner/core/flat_plan_test.go
func : TestFlatPhysicalPlan
testdata: 
		planner/core/testdata/flat_plan_suite_in.json
	   	planner/core/testdata/flat_plan_suite_out.json
