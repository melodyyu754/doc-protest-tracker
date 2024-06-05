import logging
logger = logging.getLogger()

import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')

# Display the appropriate sidebar links for the role of the logged in user
SideBarLinks()

st.title('Predicting the Number of Protests in a Specific Region')

st.write('Think of a country you would like to learn more about in terms of how likely protests are to occur and input the following information to see how many protests are likely to occur in the near future!')

regions = ["Western", "Asian", "South American"]

# create a 3 column layout
col1, col2, col3 = st.columns(3)

# add one number input for variable 1 into column 1
with col1:
  var_01 = st.slider('Public Trust in their Government (Percentage in Decimal Form):', 0.0, 100.0, 50.0)

# add another number input for variable 2 into column 2
with col2:
  var_02 = st.number_input('Selct GDP per Capita:',
                           step=1)
# Region Dropdown
with col3:
  var_03 = st.selectbox("Select Region:", regions)

logger.info(f'var_01 = {var_01}')
logger.info(f'var_02 = {var_02}')
logger.info(f'var_03 = {var_03}')

# add a button to use the values entered into the number field to send to the 
# prediction function via the REST API
if st.button('Predict Number of Protests',
             type='primary',
             use_container_width=True):
  results = requests.get(f'http://api:4000/model1/{var_01}/{var_02}/{var_03}').json()
  logger.info(f"Response: {results}")
  st.write(results)