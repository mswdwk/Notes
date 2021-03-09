```C++
THD in sql_class.h (sql) :   Cost_model_server m_cost_model;
THD in sql_class.h (sql) :   void init_cost_model() { m_cost_model.init(); }
THD in sql_class.h (sql) :   const Cost_model_server* cost_model() const { return &m_cost_model; }
TABLE in table.h (sql) :   Cost_model_table m_cost_model;
TABLE::init_cost_model in table.h (sql) :     m_cost_model.init(cost_model_server, this);
TABLE in table.h (sql) :   const Cost_model_table* cost_model() const { return &m_cost_model; }
```