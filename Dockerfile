FROM python:3.10

WORKDIR /comments

COPY . .

RUN pip install --no-cache-dir -r requirements.txt

RUN pip install --no-cache-dir psycopg2-binary==2.9.1

EXPOSE 5000

CMD ["python", "api.py"]