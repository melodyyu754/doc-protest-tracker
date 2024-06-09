from flask import Blueprint, request, jsonify, make_response, current_app
from backend.db_connection import db


protests = Blueprint('protests', __name__)

# Get all the protests from the data base
@protests.route('/protests', methods=['GET'])
def get_protests():
    # get a cursor object from the database
    cursor = db.get_db().cursor()
    query = """
        SELECT cause_name, date, location, protests.country, description, violent, 
        CONCAT(first_name, ' ', last_name) as full_name
        FROM protests
            JOIN cause on protests.cause = cause.cause_id
            JOIN users on protests.created_by = users.user_id
            JOIN country on protests.country = country.country
    
        """
    filters = []

        # Apply filters
    if 'date' in request.args:
        filters.append(f"date >= '{request.args['date']}'")
    if 'cause' in request.args:
        causes = request.args.getlist('cause')
        cause_filter = ', '.join(causes)
        filters.append(f"cause IN ({cause_filter})")
    if 'created_by' in request.args:
        usernames = request.args.getlist('created_by')
        user_filter = ', '.join(usernames)
        filters.append(f"created_by IN ({user_filter})")
    if 'protests.country' in request.args:
        countries = request.args.getlist('protests.country')
        countries_string = ["\"" + country + "\"" for country in countries]
        country_filter = ', '.join(countries_string)
        filters.append(f"country.country IN ({country_filter})")

    if filters:
        query += ' WHERE ' + ' AND '.join(filters)

    query += ' order by date desc'

    current_app.logger.info(f'Query: {query}')

    cursor.execute(query)
    row_headers = [x[0] for x in cursor.description]
    data = cursor.fetchall() # give back all the date from the sql statement
    json_data = []
    for row in data:
        json_data.append(dict(zip(row_headers, row))) # attribute name, attribute value, etc
    the_response = make_response(jsonify(json_data)) # turns dictionary into json and makes a response object
    the_response.status_code = 200
    the_response.mimetype = 'application/json' # what tyoe of data are we sending back
    return the_response # returns it back through the rest api stuff

# Add a protest
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
<<<<<<< HEAD

<<<<<<< HEAD
# Get one protest with one protest
@protests.route('/protests/<protest_id>', methods=['GET'])
def get_protest_detail(protest_id):
    query = ('SELECT * FROM protests WHERE protest_id = ' + str(protest_id))
    current_app.logger.info(query)
    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    theData = cursor.fetchall()
    json_data = [dict(zip(column_headers, row)) for row in theData]
    # Check if any data is found
    if not json_data:
        return jsonify({"error": "Post not found"}), 404
=======
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


>>>>>>> 5b99559 (working on filtering)

    return jsonify(json_data)

# DELETE a protest
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

# Get a particular user's protests
@protests.route('/myprotests/<user_id>', methods=['GET'])
def get_user_protests(user_id):
    query = ('SELECT cause_name, protest_id, location, date, description, created_by, protests.country, cause, first_name, last_name FROM protests LEFT JOIN users on protests.created_by = users.user_id LEFT JOIN cause on protests.cause = cause.cause_id WHERE user_id = ' + str(user_id))
    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    theData = cursor.fetchall()
    json_data = [dict(zip(column_headers, row)) for row in theData]
    # Check if any data is found
    if not json_data:
        return jsonify({"error": "Protest not found"}), 404

    return jsonify(json_data)
=======
    
>>>>>>> d364fda (began working on proper values for our protest drop downs)
