########################################################
# Sample customers blueprint of endpoints
# Remove this file if you are not using it in your project
########################################################

from flask import Blueprint, request, jsonify, make_response, current_app
import json
import random
from backend.db_connection import db



protests = Blueprint('protests', __name__)

# Get all the protests from the data base
@protests.route('/protests', methods=['GET'])
def get_protests():
    # get a cursor object from the database
    cursor = db.get_db().cursor()
    query = """
        SELECT cause_name, date, location, protests.country, description
        FROM protests
            JOIN cause on protests.cause = cause.cause_id
        ORDER BY date
        """
    cursor.execute(query)
    row_headers = ["Cause", "Date", "City", "Country", "Decription"]
    data = cursor.fetchall() # give back all the date from the sql statement
    json_data = []
    for row in data:
        json_data.append(dict(zip(row_headers, row))) # attribute name, attribute value, etc
    the_response = make_response(jsonify(json_data)) # turns dictionary into json and makes a response object
    the_response.status_code = 200
    the_response.mimetype = 'application/json' # what tyoe of data are we sending back
    return the_response # returns it back through the rest api stuff

@protests.route('/addprotest', methods=['POST'])
def add_protest():
      # collecting data from the request object 
    data = request.json

    location = data['location']
    date = data['date']
    description = data['description']
    violent = data['violent']
    created_by = data['user_id']
    country = data['country']
    cause = data['cause']
    longitude = "1.1"
    latitude = "2.1"
    # Construct the query
    query = 'INSERT INTO protests (location, date, description, violent, created_by, country, cause, longitude, latitude) VALUES ('
    query += "'" + location + "',"
    query += "'" + date + "',"
    query += "'" + description + "',"
    query += "'" + str(violent) + "',"
    query += "'" + str(created_by) + "',"
    query += "'" + country + "',"
    query += "'" + str(cause) + "',"
    query += "'" + str(longitude)+ "',"
    query += "'" + str(latitude) + "')"
    
    print(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()

    return "Success"
    

# # Get all the products from the database
# @protests.route('/protests', methods=['GET'])
# def get_protests():
#     # get a cursor object from the database
#     cursor = db.get_db().cursor()

#     #need to edit
#     query = 'SELECT id, title, content, author, created_at FROM posts'
#     filters = []

#     #     # Apply filters
#     # if 'product_code' in request.args:
#     #     filters.append(f"product_code = '{request.args['product_code']}'")
#     # if 'product_name' in request.args:
#     #     filters.append(f"product_name LIKE '%{request.args['product_name']}%'")
#     # if 'category' in request.args:
#     #     filters.append(f"category = '{request.args['category']}'")
#     # if 'min_price' in request.args:
#     #     filters.append(f"list_price >= {request.args['min_price']}")
#     # if 'max_price' in request.args:
#     #     filters.append(f"list_price <= {request.args['max_price']}")

#     if filters:
#         query += ' WHERE ' + ' AND '.join(filters)

#     current_app.logger.info(query)
#     cursor.execute(query)
    
#     # use cursor to query the database for a list of products
#     # EDIT HERE: cursor.execute('SELECT id, product_code, product_name, list_price, category FROM products')

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
@protests.route('/protest', methods=['POST'])
def add_new_protest():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    # #extracting the variable, EDIT HERE
    # name = the_data['product_name']
    # description = the_data['product_description']
    # price = the_data['product_price']
    # category = the_data['product_category']

    # # Constructing the query
    # query = 'insert into products (product_name, description, category, list_price) values ("'
    # query += name + '", "'
    # query += description + '", "'
    # query += category + '", '
    # query += str(price) + ')'
    # current_app.logger.info(query)

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

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



#  location VARCHAR(80) NOT NULL,
#     date DATE NOT NULL,
#     description TEXT,
#    longitude FLOAT NOT NULL,
#     latitude FLOAT NOT NULL,
# UPDATE a post
@protests.route('/protest', methods = ['PUT'])
def update_protest():
   try:
        connection = db.get_db()
        cursor = connection.cursor()

        the_data = request.json
        protest_id = the_data['protest_id']
        location = the_data['location']
        description = the_data['description']
      

        query = 'UPDATE protests SET location = %s, description = %s WHERE protest_id = %s'

        current_app.logger.info(f'Updating post with post_id: {protest_id}')
        cursor.execute(query, (location, description, protest_id))
        connection.commit()

        if cursor.rowcount == 0:
            return make_response(jsonify({"error": "Post not found"}), 404)

        return make_response(jsonify({"message": "Post updated successfully"}), 200)
   except Error as e:
        current_app.logger.error(f"Error updating post with post_id: {protest_id}, error: {e}")
        return make_response(jsonify({"error": "Internal server error"}), 500)
   finally:
        if cursor:
            cursor.close()

# DELETE a post
@protests.route('/protest/<int:id>', methods=['DELETE'])
def delete_protest(id):
    cursor = db.get_db().cursor()

    # Constructing the query to delete the post by id
    query = 'DELETE FROM protests WHERE protest_id = %s'
    
    current_app.logger.info(f'Deleting protest with id: {id}')
    cursor.execute(query, (id,))
    db.get_db().commit()
    
    if cursor.rowcount == 0:
        return make_response(jsonify({"error": "Protest not found"}), 404)
    
    return jsonify({"message": "Protest deleted successfully"}), 200