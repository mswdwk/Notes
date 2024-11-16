#!/bin/bash
# https://www.elastic.co/guide/en/elasticsearch/reference/current/getting-started.html

# 1 create an es index mapping
curl -X PUT "localhost:9200/my-explicit-mappings-books?pretty" -H 'Content-Type: application/json' -d'
{
  "mappings": {
    "dynamic": false,  
    "properties": {  
      "name": { "type": "text" },
      "author": { "type": "text" },
      "release_date": { "type": "date", "format": "yyyy-MM-dd" },
      "page_count": { "type": "integer" }
    }
  }
}
'
# 2 get an es index mapping
curl -X GET  "localhost:9200/my-explicit-mappings-books?pretty"

#
