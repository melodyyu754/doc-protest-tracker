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

st.header('Community Forum')


# You can access the session state to make a more customized/personalized app experience
st.write(f"### Hi, {st.session_state['first_name']}.")

# add filtering on the sidebar to filter the data by cause with checkboxes
st.sidebar.header('Filter Data')
causes = st.sidebar.multiselect('Select Causes', ['A', 'B', 'C'])

data = {} 
try:
  data = requests.get('http://api:4000/psts/posts').json()
except:
  st.write("**Important**: Could not connect to sample api, so using dummy data.")
  data = {"a":{"b": "123", "c": "hello"}, "z": {"b": "456", "c": "goodbye"}}

# st.dataframe(data)

# Define a function to create a card for each post
def create_card(post):
    st.markdown(f"""
    <div style="border: 1px solid #ddd; border-radius: 8px; padding: 16px; margin-bottom: 16px;">
        <h3>{post['title']}</h3>
        <p>{post['text']}</p>
        <small>Posted by {post['created_by']} on {post['creation_date']}</small>
    </div>
    """, unsafe_allow_html=True)

# Display each post in a card
for post in data:
    create_card(post)