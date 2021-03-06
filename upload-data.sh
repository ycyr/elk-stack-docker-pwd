#!/bin/sh
cd /root/elk-stack-docker-pwd/
pip install elasticsearch-curator
docker-compose up -d
sleep 60
/usr/bin/curator --config /root/elk-stack-docker-pwd/curator.yml /root/elk-stack-docker-pwd/create-index.yml
gunzip logs.jsonl.gz
curl -H 'Content-Type: application/x-ndjson' -XPOST 'localhost:9200/_bulk?pretty' --data-binary @logs.jsonl
curl -XGET 'localhost:9200/_cat/indices?v&pretty'
gzip  logs.jsonl
git checkout -- logs.jsonl.gz
