from flask import Blueprint, request, jsonify, make_response, current_app
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
    row_headers = ["Cause", "Date", "City", "Country", "Description"]
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
    