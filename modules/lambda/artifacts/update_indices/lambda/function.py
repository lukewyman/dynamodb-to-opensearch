from opensearchpy import OpenSearch, RequestsHttpConnection
import boto3 
import requests 
from requests_aws4auth import AWS4Auth
import os 
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

region = os.environ['AWS_REGION']
service = 'es'
credentials = boto3.Session().get_credentials()
awsauth = AWS4Auth(credentials.access_key, credentials.secret_key,
                   region, service, session_token=credentials.token)

host = os.environ['OPENSEARCH_ENDPOINT']
index = os.environ['INDEX_NAME']
type = '_doc'
url = f'https://{host}/{index}/{type}/'

headers = { 'Content-Type': 'application/json' }

def handler(event, context):
    logger.info(event)

    client = OpenSearch(
        hosts = [{'host': host, 'port': 443}],
        http_auth = awsauth,
        use_ssl = True,
        verify_certs = True,
        connection_class = RequestsHttpConnection
    )

    count = 0
    if (event.get("Records", None) != None):
        for record in event['Records']:
            logger.info(f'DynamoDB Change Record: {record}')            

            if record['eventName'] == 'REMOVE':
                id = record['dynamodb']['Keys']['book_id']['S']
                logger.info(f'Removing document with id: {id}')

                response = client.delete(
                    index = index,
                    id = id,
                )
                count += 1
                logger.info(response)
            else:
                id = record['dynamodb']['Keys']['book_id']['S']
                document = record['dynamodb']['NewImage']       
                logger.info(f'Indexing document: {document}')

                response = client.index(
                    index = index,
                    body = document,
                    id = id, 
                    refresh = True
                )
                count += 1
                logger.info(response)

    return f'{count} records processed.'
