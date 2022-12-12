echo "\nAdding MongoDB Kafka Sink Connector"
curl -X POST -H "Content-Type: application/json" --data '
  {"name": "mongo-sink",
   "config": {
     "name": "mongo-sink",
     "connector.class":"com.mongodb.kafka.connect.MongoSinkConnector",
     "tasks.max":"1",
     "topics":"kafkademo",
     "connection.uri":"mongodb://mongo:27017",
     "database":"kafkademo",
     "collection":"events",
     "key.converter":"org.apache.kafka.connect.json.JsonConverter",
     "key.converter.schemas.enable":false,
     "value.converter":"org.apache.kafka.connect.json.JsonConverter",
     "value.converter.schemas.enable":false
}}' http://localhost:8083/connectors -w "\n"