
import json
from datetime import datetime
from kafka import KafkaProducer

bootstrap_servers = ['localhost:9092']
topicName = 'kafkademo'

producer = KafkaProducer(bootstrap_servers = bootstrap_servers, value_serializer=lambda v: json.dumps(v).encode('utf-8'))
ack = producer.send(topicName, {"type": "event", "date": datetime.now().isoformat(), "message": "Payment received!"})
metadata = ack.get()

print(metadata.topic)
print(metadata.partition)

producer.flush()