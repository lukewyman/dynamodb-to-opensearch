import logging 


logger = logging.getLogger()
logger.setLevel(logging.INFO)

def handler(event, context):
    
    for record in event['Records']:
        logger.info(f'DynamoDB Change Record: {record}')