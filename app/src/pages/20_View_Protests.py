import logging

import requests
import streamlit as st # type: ignore
from modules.nav import SideBarLinks

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
data ={}
try:
  data = requests.get('http://api:4000/prtsts/protests').json()
except:
  st.write("**Important**: Could not connect to sample api")

# Define a function to create a card for each post
def create_card(protest):
    st.markdown(f"""
    <div style="border: 1px solid #ddd; border-radius: 8px; padding: 16px; margin-bottom: 16px;">
        <h2>{protest['Cause']}</h2>
        <h4>{protest['Date']}</h4>
        <h4>{protest['City']},{protest['Country']} </h4>
        <p>{protest['Description']}</p>
    </div>
    """, unsafe_allow_html=True)

# Display each post in a card
for protest in data:
    create_card(protest)