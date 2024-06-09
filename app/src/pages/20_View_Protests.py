import logging

import requests
import streamlit as st # type: ignore
from modules.nav import SideBarLinks
from datetime import date

logger = logging.getLogger()

st.set_page_config(layout="wide")

# Display the appropriate sidebar links for the role of the logged in user
SideBarLinks()

st.title("Protests")

col1, col2, col3 = st.columns(3)
d = False
if st.session_state['role'] != 'politician':
  

  with col1:
    if st.button(label = "Add Protest",
            type = 'primary',
            use_container_width=True):
      st.switch_page('pages/21_New_Protest.py')

  with col2:
    if st.button(label = "Update Protest",
            type = 'primary',
            use_container_width=True):
      st.switch_page('pages/22_Update_Protest.py')

  with col3:
    if st.button(label = "Remove Protest",
            type = 'primary',
            use_container_width=True):
      st.switch_page('pages/23_Delete_Protests.py')


st.header("Past and Current Protests")
st.sidebar.header('Filter Data')

causes = requests.get('http://api:4000/cause/cause').json()
cause_names = [cause['cause_name'] for cause in causes]
cause_mapping = {cause['cause_name']: cause['cause_id'] for cause in causes}

users = requests.get('http://api:4000/users/usernames').json()
usernames = [user['full_name'] for user in users]
user_mapping = {user['full_name']: user['user_id'] for user in users}

country_names = requests.get('http://api:4000/cntry/names').json()

# Inputs for filtering
date = st.sidebar.date_input('Creation Date', value=None, max_value=date.today())


# Multi-select for causes
selected_causes = st.sidebar.multiselect("Select Causes", options=cause_names)
selected_cause_ids = [cause_mapping[cause] for cause in selected_causes]

# Multi-select for usernames
selected_usernames = st.sidebar.multiselect('Select Usernames', options=usernames)
selected_user_ids = [user_mapping[username] for username in selected_usernames]

# Multi-select for countries
selected_countries = st.sidebar.multiselect('Select Countries', options=country_names)

params = {}

# Button to trigger the filter action
if st.sidebar.button('Filter Posts'):
    # Construct the query parameters
    
    if date:
        params['date'] = date
        logger.info(f'date = {date}')
    if selected_user_ids:
        params['created_by'] = selected_user_ids
    if selected_causes:
        params['cause'] = selected_cause_ids
    if selected_countries:
        logger.info(f'selected_countries = {selected_countries}')
        params['protests.country'] = selected_countries
    


    logger.info(f'params = {params}')

    # Make a request to the backend API


data ={}
try:
  data = requests.get('http://api:4000/prtsts/protests', params = params).json()
  if len(data) == 0:
    st.write("No protests found with the selected filters")
except:
  st.write("**Important**: Could not connect to sample api")

# Define a function to create a card for each post
def create_card(protest):
    st.markdown(f"""
    <div style="border: 1px solid #ddd; border-radius: 8px; padding: 16px; margin-bottom: 16px;">
        <h2>{protest['cause_name']}</h2>
        <h4>{protest['date']}</h4>
        <h4>{protest['location']},{protest['country']} </h4>
        <p>{protest['description']}</p>
        <p>{protest['full_name']}
    </div>
    """, unsafe_allow_html=True)

# Display each post in a card
for protest in data:
    create_card(protest)