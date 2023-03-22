# MongoDB - Kafka connect
Setup guide for running Kafka and MongoDB within docker containers, and writing events to kafka which get persisted to MongoDB. This is built upon Confluent's Kafka platform, but can also be done using vanilla, Apache Kafka.

## Docker Images
We run the following images:
 - mongodb (single node, no database authentication)
 - apache zookeeper 
 - apache kafka
 - kafka connect
The last 3 all use Confluent Platform images

## Steps
1. Start the docker images. It may take some time to download them if you do not already have them downloaded
```docker compose up```
Sometimes the kafka-connect image might fail, if so, restart it.

2. Once everything is started, add the mongo-sink-connector. Edit the `addMongoSink.sh` file to change the parameters, such as the Kafka topic name, the MongoDB URL, other MongoDB options (database, collection). Then run the file. This runs a REST query to the connect endpoint running on 8083 and configures the mongo-sink endpoint.
```sh addMongoSink.sh```

3. You can now write data to the kafka topic and data will be automatically populated in MongoDB. NB: the topic you write to must MATCH the topic configured in sink connector configuration.

4. To manually add events, you can edit the following python file 
```kafka-producer.py```

## View results in MongoDB
If you've ran the script as per the instructions, you will have written a document to a kafka topic, which is then automatically sinked to MongoDB. You can log into the database and view the data. By default, MongoDB is running locally on port 27017, and data is written to the `kafkademo.events` name space
```mongosh localhost:27017```
Navigate to the database run `db.events.findOne()` and you will see something like:
```
{
  "_id": {
    "$oid": "641b674799866015ce90c688"
  },
  "date": "2023-03-22T20:38:31.130440",
  "type": "event",
  "message": "Payment received!"
}
```