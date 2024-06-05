########################################################
# Sample customers blueprint of endpoints
# Remove this file if you are not using it in your project
########################################################

from flask import Blueprint, request, jsonify, make_response, current_app
import json
from backend.db_connection import db

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

    #need to edit
    query = 'SELECT post_id, title, creation_date, text, created_by, cause FROM posts'
    filters = []

    #     # Apply filters
    # if 'product_code' in request.args:
    #     filters.append(f"product_code = '{request.args['product_code']}'")
    # if 'product_name' in request.args:
    #     filters.append(f"product_name LIKE '%{request.args['product_name']}%'")
    # if 'category' in request.args:
    #     filters.append(f"category = '{request.args['category']}'")
    # if 'min_price' in request.args:
    #     filters.append(f"list_price >= {request.args['min_price']}")
    # if 'max_price' in request.args:
    #     filters.append(f"list_price <= {request.args['max_price']}")

    if filters:
        query += ' WHERE ' + ' AND '.join(filters)

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

# @products.route('/product/<id>', methods=['GET'])
# def get_product_detail (id):

#     query = 'SELECT id, product_name, description, list_price, category FROM products WHERE id = ' + str(id)
#     current_app.logger.info(query)

#     cursor = db.get_db().cursor()
#     cursor.execute(query)
#     column_headers = [x[0] for x in cursor.description]
#     json_data = []
#     the_data = cursor.fetchall()
#     for row in the_data:
#         json_data.append(dict(zip(column_headers, row)))
#     return jsonify(json_data)
    

# # get the top 5 products from the database
# @products.route('/mostExpensive')
# def get_most_pop_products():
#     cursor = db.get_db().cursor()
#     query = '''
#         SELECT product_code, product_name, list_price, reorder_level
#         FROM products
#         ORDER BY list_price DESC
#         LIMIT 5
#     '''
#     cursor.execute(query)
#     # grab the column headers from the returned data
#     column_headers = [x[0] for x in cursor.description]

#     # create an empty dictionary object to use in 
#     # putting column headers together with data
#     json_data = []

#     # fetch all the data from the cursor
#     theData = cursor.fetchall()

#     # for each of the rows, zip the data elements together with
#     # the column headers. 
#     for row in theData:
#         json_data.append(dict(zip(column_headers, row)))

#     return jsonify(json_data)


# @products.route('/tenMostExpensive', methods=['GET'])
# def get_10_most_expensive_products():
    
#     query = '''
#         SELECT product_code, product_name, list_price, reorder_level
#         FROM products
#         ORDER BY list_price DESC
#         LIMIT 10
#     '''

#     cursor = db.get_db().cursor()
#     cursor.execute(query)

#     column_headers = [x[0] for x in cursor.description]

#     # create an empty dictionary object to use in 
#     # putting column headers together with data
#     json_data = []

#     # fetch all the data from the cursor
#     theData = cursor.fetchall()

#     # for each of the rows, zip the data elements together with
#     # the column headers. 
#     for row in theData:
#         json_data.append(dict(zip(column_headers, row)))
    
#     return jsonify(json_data)

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
    query += "'" + str(cause) + "')g"
   
    
    print(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return "Success"

# ### Get all product categories
# @products.route('/categories', methods = ['GET'])
# def get_all_categories():
#     query = '''
#         SELECT DISTINCT category AS label, category as value
#         FROM products
#         WHERE category IS NOT NULL
#         ORDER BY category
#     '''

#     cursor = db.get_db().cursor()
#     cursor.execute(query)

#     json_data = []
#     # fetch all the column headers and then all the data from the cursor
#     column_headers = [x[0] for x in cursor.description]
#     theData = cursor.fetchall()
#     # zip headers and data together into dictionary and then append to json data dict.
#     for row in theData:
#         json_data.append(dict(zip(column_headers, row)))
    
#     return jsonify(json_data)

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