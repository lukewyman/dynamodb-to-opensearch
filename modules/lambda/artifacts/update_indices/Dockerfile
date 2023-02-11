FROM amazon/aws-lambda-python:3.9

COPY requirements.txt /tmp/
RUN pip3 install --upgrade pip
RUN pip3 install -r /tmp/requirements.txt --target "${LAMBDA_TASK_ROOT}"

COPY lambda/function.py ${LAMBDA_TASK_ROOT}

CMD ["function.handler"]