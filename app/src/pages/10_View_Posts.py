import pandas as pd
import streamlit as st
from streamlit_extras.app_logo import add_logo
import world_bank_data as wb
import matplotlib.pyplot as plt
import numpy as np
import plotly.express as px
from modules.nav import SideBarLinks
import requests
import logging 
from datetime import date
import logging 
from datetime import date


logger = logging.getLogger()

# Call the SideBarLinks from the nav module in the modules directory
SideBarLinks()

# set the header of the page

st.header('Community Forum')


# You can access the session state to make a more customized/personalized app experience
st.write(f"### Hi, {st.session_state['first_name']}.")

# add filtering on the sidebar to filter the data by cause with checkboxes
st.sidebar.header('Filter Data')
causes = st.sidebar.multiselect('Select Causes', ['A', 'B', 'C'])

# add filtering on the sidebar to filter the data by cause with checkboxes
st.sidebar.header('Filter Data')
#selected_causes = st.sidebar.multiselect('Select Causes', ['A', 'B', 'C'])

# data = {} 
# try:
#   data = requests.get('http://api:4000/psts/posts').json()
# except:
#   st.write("**Important**: Could not connect to sample api, so using dummy data.")
#   data = {"a":{"b": "123", "c": "hello"}, "z": {"b": "456", "c": "goodbye"}}

# st.dataframe(data)

cause_names = requests.get('http://api:4000//cause/names').json()

cause_dict = requests.get('http://api:4000/cause/cause').json()
cause_mapping = {cause['cause_name']: cause['cause_id'] for cause in cause_dict}


# Inputs for filtering
creation_time = st.sidebar.date_input('Creation Time', value=None, max_value=date.today())


# Multi-select inputs for usernames and cause names
# doing later
#selected_usernames = st.multiselect('Usernames', list('1', '2', '3'))
# Multi-select for causes
selected_causes = st.sidebar.multiselect("Select Causes", options=cause_names)
selected_cause_ids = [cause_mapping[cause] for cause in selected_causes]


params = {}

# Button to trigger the filter action
if st.button('Filter Posts'):
    # Construct the query parameters
    
    if creation_time:
        params['creation_time'] = creation_time
        logger.info(f'creation_time = {creation_time}')
        
    # if selected_usernames:
    #     params['user_id'] = [usernames[username] for username in selected_usernames]
    if selected_causes:
        params['cause'] = selected_cause_ids


    logger.info(f'params = {params}')

    # Make a request to the backend API


data = {}
data = requests.get('http://api:4000/psts/posts', params= params).json()    

#     # Check if the request was successful
# if response.status_code == 200:
#     filtered_posts = response.json()
#     if filtered_posts:
#         # Display the filtered posts in a table
#         df = pd.DataFrame(filtered_posts)
#         st.dataframe(df)
#     else:
#         st.write("No posts found with the given filters.")
# else:
#     st.write("Error fetching filtered posts. Please try again.")




# Define a function to create a card for each post
def create_card(post):
    st.markdown(f"""
    <div style="border: 1px solid #ddd; border-radius: 8px; padding: 16px; margin-bottom: 16px;">
        <h3>{post['title']}</h3>
        <p>{post['text']}</p>
        <small>Posted by {post['created_by']} on {post['creation_date']}</small>
    </div>
    """, unsafe_allow_html=True)

# # get the countries from the world bank data
# with st.echo(code_location='above'):
#     countries:pd.DataFrame = wb.get_countries()
   
#     st.dataframe(countries)

# Display each post in a card
for post in data:
    create_card(post)