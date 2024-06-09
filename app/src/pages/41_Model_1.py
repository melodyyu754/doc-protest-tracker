import logging
logger = logging.getLogger()
import time
import streamlit as st
from modules.nav import SideBarLinks
import requests
import json
import pandas as pd
import numpy as np



lobf_json = requests.get(f'http://api:4000/model1/lobf').json()
logger.info(f'hiii = {lobf_json}')
requests.post(f'http://api:4000/model1/insert-params', json=lobf_json)

st.set_page_config(layout = 'wide')

# Display the appropriate sidebar links for the role of the logged in user
SideBarLinks()

st.title('Predicting the Number of Protests in a Specific Region')

st.write('Think of a country you would like to learn more about and input the following information to see how many protests are likely to occur in the country of your choice!')

regions = ["Western", "Asian", "South American"]

# create a 3 column layout
col1, col2, col3, col4, col5 = st.columns(5)
with col1:
  country_input = st.text_input('Insert Country Name:')
# add one number input for variable 1 into column 1
with col2:
  var_01 = st.slider('Select Public Trust in Government (Percentage in Decimal Form):', 0.0, 100.0, 50.0)

# add another number input for variable 2 into column 2
with col3:
  var_02 = st.slider('Select GDP per Capita:', 0.0, 200000.0, 50.0)

# Region Dropdown
with col4:
  var_03 = st.selectbox("Select Region:", regions)
# Population Input
with col5:
  var_04 = st.number_input('Insert Population:',
                           step=1)

logger.info(f'var_01 = {var_01}')
logger.info(f'var_02 = {var_02}')
logger.info(f'var_03 = {var_03}')
logger.info(f'var_04 = {var_04}')

# add a button to use the values entered into the number field to send to the 
# prediction function via the REST API
if st.button('Predict Number of Protests',
             type='primary',
             use_container_width=True):
  results = requests.get(f'http://api:4000/model1/model1/{var_01}/{var_02}/{var_03}/{var_04}').json()
  logger.info(f"Response: {results}")
  pred_per_capita = results['prediction_value']
  activity_level = requests.get(f'http://api:4000/model1/activity-level/{pred_per_capita}').json()
  pred = pred_per_capita * var_04
  results_display = f'The estimated number of protests that will occur in {country_input} this year will be: {pred}'
  def stream_data():
    for word in results_display.split(" "):
        yield word + " "
        time.sleep(0.03)
  st.markdown(f"""
        <div style="background-color: silver;"> Numeric Predicton: </div>
      """, unsafe_allow_html=True)
  st.write_stream(stream_data)

  # Define a dictionary mapping text to colors (you can customize this)
  level_to_color = {
      "low": "green",
      "medium": "khaki",
      "high": "red"
  }

  def create_circle_box(text):
    """Creates a Streamlit column with a colored circle and text."""

    color = level_to_color[activity_level['activity_level']]  # Get color from dictionary (default if not found)
    col1, col2 = st.columns(2)
    with col1:
      st.write("")  # Add an empty space for better layout
      circle_html = f"""
        <div style="border-radius: 25%;width: 50px;height: 50px;background-color: {color};"></div>
      """
      st.markdown(circle_html, unsafe_allow_html=True)
    with col2:
      st.write(text) 
      st.write(f""" <p style="color: {color}; font-weight: bold;">{activity_level['activity_level']}</p> """, unsafe_allow_html=True)
      st.write(" protest activity level")

  st.markdown(f"""
      <div style="background-color: silver;"> Activity Level Prediction: </div>
    """, unsafe_allow_html=True)
  create_circle_box(f'In terms of protest events per capita, this country will have a relatively ')

