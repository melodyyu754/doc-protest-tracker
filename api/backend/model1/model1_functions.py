import numpy as np 
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.metrics import r2_score
from backend.db_connection import db
from flask import jsonify
import logging
logger = logging.getLogger()

def linear_regression(X, y):
    """performs the linear perceptron algorithm which takes in an original X matrix and a y vector
    Args:
        X (2d-array): represents a matrix of a bias column with numeric values representative of the x features
        y (1d-array): represents a vector of labels (-1 or 1)
    Returns:
        w (1d-array): the final weight vector that determines the direction and orientation of the line of best fit
    """
    return np.linalg.inv(X.T.dot(X)).dot(X.T).dot(y)

def linreg_predict(Xnew, ynew, m):
    """takes in the X matrix, y vector, and the m vector which contains the coefficients of the calculated line of best fit and outputs a dictionary that contains the predicted y values, the residuals, the mse, and the r2 score

    Args:
        Xnew (1d or 2d-array): which includes all the desired predictor feature values (not including the bias term)
        y (1d-array):  includes all corresponding output values to Xnew
        m (1d-array): contains the coefficients from the line of best fit function
    Returns:
        preds (dictionary): dictionary containing the predicted y values, the residuals between the y values and the predicted y values, the mse, and the r2 score
    """
    linreg_stats = {}
    ypreds = np.matmul(Xnew, m)
    linreg_stats['ypreds'] = ypreds
    resids = ynew - ypreds
    linreg_stats['resids'] = resids
    
    #the mse function
    mse = np.square(resids).mean()
    linreg_stats['mse'] = mse
    linreg_stats['r2'] = r2_score(ynew, ypreds)
    
    return linreg_stats

def initialize():
    # PRESENT MODEL
    # Defining my X and y arrays

    # get a database cursor 
    cursor = db.get_db().cursor()
    # get the model params from the database
    query = 'SELECT * FROM real_data_scaled ORDER BY id'
    cursor.execute(query)
    data_scaled = cursor.fetchall()
    logger.info(f'dataset: {data_scaled}')
    column_names = ['id', 'event_date', 'country', 'western', 'asian', 'south_american', 'counts', 'population_scaled', 'events_per_capita_scaled', 'gdp_per_capita_scaled', 'public_trust_percentage_scaled']
    df_scaled = pd.DataFrame.from_records(data_scaled, columns=column_names)
    
    X = df_scaled[['public_trust_percentage_scaled', 'gdp_per_capita_scaled', 'western', 'asian', 'south_american', 'population_scaled']]
    y = df_scaled['events_per_capita_scaled']

    # Cross validation
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

    # Adding Interaction Terms because public trust percentage and gdp per capita are highly correlated  
    X_train['public_trust_x_gdp_per_capita'] = X_train['public_trust_percentage_scaled'] * X_train['gdp_per_capita_scaled']
    X_test['public_trust_x_gdp_per_capita'] = X_test['public_trust_percentage_scaled'] * X_test['gdp_per_capita_scaled'] 

    # addressing multicolinerarity by having these features interact since they are highly correlated
    X_train_poly_2a = X_train['public_trust_percentage_scaled'] * X_train['public_trust_percentage_scaled']
    X_train_poly_2b = X_train['gdp_per_capita_scaled'] * X_train['gdp_per_capita_scaled']
    X_train_poly_3a = X_train['public_trust_percentage_scaled'] * X_train['public_trust_percentage_scaled'] * X_train['public_trust_percentage_scaled']
    X_train_poly_3b = X_train['gdp_per_capita_scaled'] * X_train['gdp_per_capita_scaled'] * X_train['gdp_per_capita_scaled']

    X_test_poly_2a = X_test['public_trust_percentage_scaled'] * X_test['public_trust_percentage_scaled']
    X_test_poly_2b = X_test['gdp_per_capita_scaled'] * X_test['gdp_per_capita_scaled']
    X_test_poly_3a = X_test['public_trust_percentage_scaled'] * X_test['public_trust_percentage_scaled'] * X_test['public_trust_percentage_scaled']
    X_test_poly_3b = X_test['gdp_per_capita_scaled'] * X_test['gdp_per_capita_scaled'] * X_test['gdp_per_capita_scaled']

    # Concatenate features individually to make the model simpler 
    # right now my model only has x_a * x_b + x_a^3 * x_a^3 is this what you meant? or should x_a^2 * x_a^2 also be included
    X_train_poly = np.concatenate((X_train[['public_trust_percentage_scaled', 'gdp_per_capita_scaled']],
                                    X_train_poly_2a.values.reshape(-1, 1),
                                    X_train_poly_2b.values.reshape(-1, 1),
                                    X_train_poly_3a.values.reshape(-1, 1), 
                                    X_train_poly_3b.values.reshape(-1, 1)), axis=1)
    X_test_poly = np.concatenate((X_test[['public_trust_percentage_scaled', 'gdp_per_capita_scaled']],
                                    X_test_poly_2a.values.reshape(-1, 1),
                                    X_test_poly_2b.values.reshape(-1, 1),
                                    X_test_poly_3a.values.reshape(-1, 1), 
                                    X_test_poly_3b.values.reshape(-1, 1)), axis=1)

    # adding bias column to my X_train and X_test matrix
    X_train_poly = np.concatenate((np.ones((X_train_poly.shape[0], 1)), X_train_poly), axis=1)
    X_test_poly = np.concatenate((np.ones((X_test_poly.shape[0], 1)), X_test_poly), axis=1)

    # Concatenate the transformed features with the original categorical features
    X_train_poly = np.concatenate((X_train_poly, X_train[['western', 'asian', 'south_american', 'public_trust_x_gdp_per_capita', 'population_scaled']]), axis=1)
    X_test_poly = np.concatenate((X_test_poly, X_test[['western', 'asian', 'south_american', 'public_trust_x_gdp_per_capita', 'population_scaled']]), axis=1)

    # --- Create and Fit Model ---
    lobf = linear_regression(X_train_poly, y_train)
    return lobf

def predict(var01, var02, var03, var04):
    """
    Retreives model parameters from the database and uses them for real-time prediction
    """
    var01 = pd.to_numeric(var01)
    var02 = pd.to_numeric(var02)
    var04 = pd.to_numeric(var04)

    # get a database cursor 
    cursor = db.get_db().cursor()
    # get the model params from the database
    query = 'SELECT * FROM real_data ORDER BY id'
    cursor.execute(query)
    data_not_scaled = cursor.fetchall()

    column_names = ['id', 'event_date', 'country', 'counts', 'population', 'events_per_capita', 'gdp_per_capita', 'western', 'asian', 'south_american', 'public_trust_percentage']
    df_not_scaled = pd.DataFrame.from_records(data_not_scaled, columns=column_names)

    # get a database cursor 
    cursor = db.get_db().cursor()
    # get the model params from the database
    query = 'SELECT beta_0, beta_1, beta_2, beta_3, beta_4, beta_5, beta_6, beta_7, beta_8, beta_9, beta_10, beta_11 FROM model1_lobf_coefficients ORDER BY sequence_number DESC LIMIT 1'
    cursor.execute(query)
    values = cursor.fetchone()
    logger.info(f'from query: {values}')
    lobf_coefficients = list(values)
    logger.info(f"coefficients: {lobf_coefficients}")

    # turn the values from the database into a numpy array
    lobf = np.array(list(map(float, lobf_coefficients)))

    public_trust_input_scaled = ((int(var01) - df_not_scaled['public_trust_percentage'].mean()) / df_not_scaled['public_trust_percentage'].std()).round(3)
    print(public_trust_input_scaled)
    gdp_per_capita_input_scaled = ((int(var02) - df_not_scaled['gdp_per_capita'].mean()) / df_not_scaled['gdp_per_capita'].std()).round(3)
    print(gdp_per_capita_input_scaled)
    population_input_scaled = ((int(var04) - df_not_scaled['population'].mean()) / df_not_scaled['population'].std()).round(3)
    if var03 == 'Western':
        input_vector = np.array([[public_trust_input_scaled,
                                  gdp_per_capita_input_scaled,
                                  public_trust_input_scaled ** 2,
                                  gdp_per_capita_input_scaled ** 2,
                                  public_trust_input_scaled ** 3,
                                  gdp_per_capita_input_scaled ** 3,
                                  1,
                                  0,
                                  0,
                                  public_trust_input_scaled * gdp_per_capita_input_scaled,
                                  population_input_scaled]])
    elif var03 == 'Asian':
        input_vector = np.array([[public_trust_input_scaled,
                                  gdp_per_capita_input_scaled,
                                  public_trust_input_scaled ** 2,
                                  gdp_per_capita_input_scaled ** 2,
                                  public_trust_input_scaled ** 3,
                                  gdp_per_capita_input_scaled ** 3,
                                  0,
                                  1,
                                  0,
                                  public_trust_input_scaled * gdp_per_capita_input_scaled,
                                  population_input_scaled]])
    else:
        input_vector = np.array([[public_trust_input_scaled,
                                  gdp_per_capita_input_scaled,
                                  public_trust_input_scaled ** 2,
                                  gdp_per_capita_input_scaled ** 2,
                                  public_trust_input_scaled ** 3,
                                  gdp_per_capita_input_scaled ** 3,
                                  0,
                                  0,
                                  1,
                                  public_trust_input_scaled * gdp_per_capita_input_scaled,
                                  population_input_scaled]])
             
    input_vector = np.concatenate((np.ones((1, 1)), input_vector), axis=1)
    # this might be event per capita, which we should probably change???
    prediction_scaled = np.matmul(input_vector, lobf)
    prediction_unscaled = prediction_scaled[0] * df_not_scaled['events_per_capita'].std().round(3) + df_not_scaled['events_per_capita'].mean()
    return prediction_unscaled

def generate_activity_level(pred_per_capita):
    pred_per_capita = pd.to_numeric(pred_per_capita)
    if pred_per_capita < 4.6:
        return "low"
    elif pred_per_capita < 9.3:
        return "medium"
    else:
        return "high"