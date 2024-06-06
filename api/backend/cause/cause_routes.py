from flask import Blueprint, request, jsonify, make_response, current_app
import json
from backend.db_connection import db

causes = Blueprint('causes', __name__)

@causes.route('/names', methods=['GET'])
def get_cause_names():
    # get a cursor object from the database
    cursor = db.get_db().cursor()
    query = 'SELECT cause_name FROM cause'   
    current_app.logger.info(query)
    cursor.execute(query)
    theData = cursor.fetchall()
    cause_names = [row[0] for row in theData]
    return jsonify(cause_names)

@causes.route('/addcause', methods=['POST'])
def add_cause():
    cursor = db.get_db().cursor()
    query = 'SELECT cause_name FROM cause'   
    current_app.logger.info(query)
    cursor.execute(query)
    theData = cursor.fetchall()
    cause_names = [row[0] for row in theData]
    return jsonify(cause_names)
from flask import Blueprint, request, jsonify, make_response, current_app
import json
from backend.db_connection import db

causes = Blueprint('causes', __name__)

@causes.route('/names', methods=['GET'])
def get_cause_names():
    # get a cursor object from the database
    cursor = db.get_db().cursor()
    query = 'SELECT cause_name FROM cause'   
    current_app.logger.info(query)
    cursor.execute(query)
    theData = cursor.fetchall()
    cause_names = [row[0] for row in theData]
    return jsonify(cause_names)

@causes.route('/addcause', methods=['POST'])
def add_cause():
    # get a cursor object from the database
    cursor = db.get_db().cursor()
    query = 'SELECT cause_name FROM cause'   
    current_app.logger.info(query)
    cursor.execute(query)
    theData = cursor.fetchall()
    cause_names = [row[0] for row in theData]
    return jsonify(cause_names)