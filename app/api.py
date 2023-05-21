import os
import logging
from flask import Flask, jsonify, request
import psycopg2

app = Flask(__name__)


logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger('Comments-API')


db_host = os.environ.get('DB_HOST', '172.22.160.58')
db_port = int(os.environ.get('DB_PORT', '5432'))
db_name = os.environ.get('DB_NAME', 'comments')
db_user = os.environ.get('DB_USER', 'comments')
db_password = os.environ.get('DB_PASSWORD', 'comments')


try:
    connection = psycopg2.connect(
        host=db_host,
        port=db_port,
        dbname=db_name,
        user=db_user,
        password=db_password
    )
    logger.info('Connected to the PostgreSQL database.')
    cursor = connection.cursor()

  
    create_table_query = """
    CREATE TABLE IF NOT EXISTS comments (
        id SERIAL PRIMARY KEY,
        email VARCHAR(255),
        comment TEXT,
        content_id INTEGER
    )
    """
    cursor.execute(create_table_query)
    connection.commit()
    logger.info('Table "comments" created or already exists.')
except psycopg2.Error as e:
    logger.error(f'Error connecting to the PostgreSQL database: {e}')



@app.route('/api/comment/new', methods=['POST'])
def receive_comment():
    data = request.get_json()
    email = data['email']
    comment = data['comment']
    content_id = data['content_id']


    try:
        insert_query = "INSERT INTO comments (email, comment, content_id) VALUES (%s, %s, %s)"
        cursor.execute(insert_query, (email, comment, content_id))
        connection.commit()
        logger.info('Comment added to the database.')
        return jsonify({'message': 'Comment added successfully'})
    except psycopg2.Error as e:
        logger.error(f'Error adding comment to the database: {e}')
        return jsonify({'message': 'An error occurred while adding the comment to the database.'}), 500



@app.route('/api/comment/list/<int:content_id>', methods=['GET'])
def list_comments(content_id):

    try:
        select_query = "SELECT email, comment FROM comments WHERE content_id = %s"
        cursor.execute(select_query, (content_id,))
        comments = cursor.fetchall()

        if not comments:
            return jsonify({'message': 'No comments found for the given content_id'})

        
        comments_list = [{'email': comment[0], 'comment': comment[1]} for comment in comments]
        return jsonify({'comments': comments_list})
    except psycopg2.Error as e:
        logger.error(f'Error retrieving comments from the database: {e}')
        return jsonify({'message': 'An error occurred while retrieving comments from the database.'}), 500


if __name__ == '__main__':
    app.run(host=os.environ.get('HOST', '0.0.0.0'), port=int(os.environ.get('PORT', 5000)))
