from flask import Blueprint, request, jsonify, make_response, current_app
import json
from backend.db_connection import db

countries = Blueprint('countries', __name__)

# Get all the products from the database
@countries.route('/countries', methods=['GET'])
def get_countries():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    #need to edit
    query = 'SELECT country, protests_per_capita, population, gdp_per_capita, unemployment_rate, urbanization_rate, inflation_rate FROM country'   
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

@countries.route('/names', methods=['GET'])
def get_country_names():
    # get a cursor object from the database
    cursor = db.get_db().cursor()
    query = 'SELECT country FROM country'   
    current_app.logger.info(query)
    cursor.execute(query)
    theData = cursor.fetchall()
    country_names = [row[0] for row in theData]
    return jsonify(country_names)
