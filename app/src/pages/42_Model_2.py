import logging
logger = logging.getLogger()

import streamlit as st
from modules.nav import SideBarLinks
import requests
import json

st.set_page_config(layout = 'wide')

# Display the appropriate sidebar links for the role of the logged in user
SideBarLinks()

st.title('Predicting k-means cluster')
st.write('')

# create input fields for gdp per capita, protests per capita, and number of clusters
gdp_per_capita = st.number_input('GDP per Capita:', step=1)
protests_per_capita = st.number_input('Protests per Capita:', step=1)
n_clusters = st.number_input('Number of Clusters:', step=1)

# make a predict button that sends the input values to the REST API
if st.button('Predict Clusters',
             type='primary',
             use_container_width=True):
  results = requests.get(f'http://api:4000/model2/model2/{gdp_per_capita}/{protests_per_capita}/{n_clusters}').json()
  logger.info(f"Response: {results}")
  st.write(results)