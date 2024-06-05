import logging

import requests
import streamlit as st # type: ignore
from modules.nav import SideBarLinks

logger = logging.getLogger()

st.set_page_config(layout="wide")

# Display the appropriate sidebar links for the role of the logged in user
SideBarLinks()

st.title("Protests")
st.header("Past and Current Protests")
data ={}
try:
  data = requests.get('http://api:4000/prtsts/protests').json()
except:
  st.write("**Important**: Could not connect to sample api")
st.table(data)
