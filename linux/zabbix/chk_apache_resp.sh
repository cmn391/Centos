#!/bin/bash 
SERVER=$3

function count {
day=`date +"%Y.%m.%d"`
curdate=`date -d '1 minute ago' +%s%N | cut -b1-13`
last1min=`date -d '2 minute ago' +%s%N | cut -b1-13`

curl -XGET "http://${SERVER}:9200/logstash-$day/_search?pretty" -d'
{
  "facets": {
    "3": {
      "query": {
        "filtered": {
          "query": {
            "query_string": {
              "query": "_type:access-log AND reqtime_microsec:'"$1"' AND hostname:'"$2"'"
            }
          },
          "filter": {
            "bool": {
              "must": [
                {
                  "range": {
                    "@timestamp": {
                      "from": '"$last1min"',
                      "to": '"$curdate"'
                    }
                  }
                },
                {
                  "fquery": {
                    "query": {
                      "query_string": {
                        "query": "_type: access-log  and usage2: marvel"
                      }
                    },
                    "_cache": true
                  }
                }
              ]
            }
          }
        }
      }
    }
  },
  "size": 0
}\"' /dev/null 2>&1 | grep count | awk '{print $3}'
}

case $1 in
	to1)
		count "[0 TO 1000000]" $2 ${SRV}
		;;
        1to3)
                count "[1000000 TO 3000000]" $2 ${SRV}
                ;;
        3to5)
                count "[3000000 TO 5000000]" $2 ${SRV}
                ;;
        5to)
                count "[5000000 TO *]" $2 ${SRV}
                ;;
esac
