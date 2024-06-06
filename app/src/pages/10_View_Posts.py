import pandas as pd
import streamlit as st
from streamlit_extras.app_logo import add_logo
import world_bank_data as wb
import matplotlib.pyplot as plt
import numpy as np
import plotly.express as px
from modules.nav import SideBarLinks
import requests

# Call the SideBarLinks from the nav module in the modules directory
SideBarLinks()

# set the header of the page
st.header('All Posts')

# You can access the session state to make a more customized/personalized app experience
st.write(f"### Hi, {st.session_state['first_name']}.")

# data = {} 
# try:
#   data = requests.get('http://api:4000/psts/posts').json()
# except:
#   st.write("**Important**: Could not connect to sample api, so using dummy data.")
#   data = {"a":{"b": "123", "c": "hello"}, "z": {"b": "456", "c": "goodbye"}}


# date = st.date_input("Protest Date", value = None)

# st.dataframe(data)

cause_names = requests.get('http://api:4000/causes/names').json()

cause_dict = requests.get('http://api:4000/causes/cause').json()
cause_mapping = {cause['name']: cause['id'] for cause in cause_dict}


# Inputs for filtering
creation_time = st.date_input('Creation Time', value = None)


# Multi-select inputs for usernames and cause names
# doing later
#selected_usernames = st.multiselect('Usernames', list('1', '2', '3'))
# Multi-select for causes
selected_causes = st.multiselect("Select Causes", options=cause_names)
selected_cause_ids = [cause_mapping[cause] for cause in selected_causes]


# Button to trigger the filter action
if st.button('Filter Posts'):
    # Construct the query parameters
    params = {}
    if creation_time:
        params['creation_time'] = creation_time
    # if selected_usernames:
    #     params['user_id'] = [usernames[username] for username in selected_usernames]
    if selected_causes:
        params['cause'] = selected_cause_ids

    # Make a request to the backend API
    response = requests.get('http://api:4000/psts/posts', params= params).json()
    # Check if the request was successful
    if response.status_code == 200:
        filtered_posts = response.json()
        if filtered_posts:
            # Display the filtered posts in a table
            df = pd.DataFrame(filtered_posts)
            st.dataframe(df)
        else:
            st.write("No posts found with the given filters.")
    else:
        st.write("Error fetching filtered posts. Please try again.")






# # get the countries from the world bank data
# with st.echo(code_location='above'):
#     countries:pd.DataFrame = wb.get_countries()
   
#     st.dataframe(countries)

# # the with statment shows the code for this block above it 
# with st.echo(code_location='above'):
#     arr = np.random.normal(1, 1, size=100)
#     test_plot, ax = plt.subplots()
#     ax.hist(arr, bins=20)

#     st.pyplot(test_plot)


# with st.echo(code_location='above'):
#     slim_countries = countries[countries['incomeLevel'] != 'Aggregates']
#     data_crosstab = pd.crosstab(slim_countries['region'], 
#                                 slim_countries['incomeLevel'],  
#                                 margins = False) 
#     st.table(data_crosstab)
