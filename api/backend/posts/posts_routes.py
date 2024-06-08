########################################################
# Sample customers blueprint of endpoints
# Remove this file if you are not using it in your project
########################################################

from flask import Blueprint, request, jsonify, make_response, current_app
import json
from backend.db_connection import db
from datetime import datetime

# GET all posts, -filtering of posts 
# POST  new post 
# UPDATE a new post 
# DELETE a new post 

posts = Blueprint('posts', __name__)

# Get all the products from the database
@posts.route('/posts', methods=['GET'])
def get_posts():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    query = """SELECT title, creation_date, text, CONCAT(first_name, ' ', last_name) as full_name, cause_name 
    FROM posts
        JOIN cause on posts.cause = cause.cause_id
        JOIN users on posts.created_by = users.user_id
    """


    filters = []

        # Apply filters
    if 'creation_date' in request.args:
        filters.append(f"creation_date >= '{request.args['creation_date']}'")
    if 'cause' in request.args:
        causes = request.args.getlist('cause')
        cause_filter = ', '.join(causes)
        filters.append(f"cause IN ({cause_filter})")
    if 'created_by' in request.args:
        usernames = request.args.getlist('created_by')
        user_filter = ', '.join(usernames)
        filters.append(f"created_by IN ({user_filter})")


    if filters:
        query += ' WHERE ' + ' AND '.join(filters)

    query += ' order by creation_date desc'
    

    current_app.logger.info(query)
    cursor.execute(query)
    
    # use cursor to query the database for a list of products
    # EDIT HERE: cursor.execute('SELECT id, product_code, product_name, list_price, category FROM products')

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# POST a new product
@posts.route('/addpost', methods=['POST'])
def add_post():
      # collecting data from the request object 
    data = request.json

    title = data['title']
    creation_date = data['creation_date']
    text = data['text']
    created_by = data['user_id']
    cause = data['cause']

    # Construct the query
    query = 'INSERT INTO posts (title, creation_date, text, created_by, cause) VALUES ('
    query += "'" + title + "',"
    query += "'" + creation_date + "',"
    query += "'" + text + "',"
    query += "'" + str(created_by) + "',"
    query += "'" + str(cause) + "')"
   
    
    print(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return "Success"


# UPDATE a post
@posts.route('/post', methods = ['PUT'])
def update_post():
    try:
        connection = db.get_db()
        cursor = connection.cursor()

        the_data = request.json
        post_id = the_data['post_id']
        title = the_data['title']
        text = the_data['text']

        query = 'UPDATE posts SET title = %s, text = %s WHERE post_id = %s'

        current_app.logger.info(f'Updating post with post_id: {post_id}')
        cursor.execute(query, (title, text, post_id))
        connection.commit()

        if cursor.rowcount == 0:
            return make_response(jsonify({"error": "Post not found"}), 404)

        return make_response(jsonify({"message": "Post updated successfully"}), 200)
    except Error as e:
        current_app.logger.error(f"Error updating post with post_id: {post_id}, error: {e}")
        return make_response(jsonify({"error": "Internal server error"}), 500)
    finally:
        if cursor:
            cursor.close()

# DELETE a post
@posts.route('/post/<int:id>', methods=['DELETE'])
def delete_post(id):
    cursor = db.get_db().cursor()

    # Constructing the query to delete the post by id
    query = 'DELETE FROM posts WHERE post_id = %s'
    
    current_app.logger.info(f'Deleting post with post_id: {id}')
    cursor.execute(query, (id,))
    db.get_db().commit()
    
    if cursor.rowcount == 0:
        return make_response(jsonify({"error": "Post not found"}), 404)
    
    return jsonify({"message": "Post deleted successfully"}), 200