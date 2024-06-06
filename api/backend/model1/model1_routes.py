########################################################
# Sample customers blueprint of endpoints
# Remove this file if you are not using it in your project
########################################################
from flask import Blueprint, request, jsonify, make_response, current_app
# import json
from backend.db_connection import db
from backend.model1.model1_functions import predict

model1 = Blueprint('model1', __name__)

# Get all customers from the DB
@model1.route('/model1/<var01>/<var02>/<var03>', methods=['GET'])
def predicting_amount_of_protests(var01, var02, var03):
    current_app.logger.info(f'var01 = {var01}')
    current_app.logger.info(f'var02 = {var02}')
    current_app.logger.info(f'var03 = {var03}')

    prediction = predict(var01, var02, var03)
    #print(prediction)
    return_dict = {'prediction_value': prediction}
    #current_app.logger.info(f'hello = {return_dict}')
    the_response = make_response(jsonify(return_dict))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'

#     return the_response