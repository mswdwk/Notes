// sql means: where group1='china' and ( (group1='china' and group2='河北') or (group1='china' and group2='湖北')  )

GET /idx_test_1/_search
{
  "query": {
    "bool": {
      "filter": [
        { "term": {"group1": "china"} 
        },{
          "bool": {
            "should": [
              { "bool": {
                  "must": [
                    { "term": {"group1": "china"} },
                    { "term": {"group2": "河北"} }
                  ]
                }
              },
              { "bool": {
                  "must": [
                    { "term": {"group1": "china"} },
                    { "term": {"group2": "湖北"} }
                  ]
                }
              }
            ]
          }
        }
      ]
    }
  }
}
