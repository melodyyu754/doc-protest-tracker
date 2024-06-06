import streamlit as st
from streamlit_extras.app_logo import add_logo
import numpy as np
import random
import time
from modules.nav import SideBarLinks
import requests

SideBarLinks()  # Assuming this function sets up your sidebar navigation

# --- API Interactions ---

def delete_protest(protest_id):
    api_url = f"http://api:4000/prtsts/protest/{protest_id}"
    response = requests.delete(api_url)
    return response

# --- Delete Post Section ---

st.write("### Remove Protest")
delete_protest_id = st.text_input("Delete Protest ID")

if st.button("Delete Protest"):
    if delete_protest_id:
        response = delete_protest(delete_protest_id)

        if response.status_code == 200:
            st.success("Protest deleted successfully!")
            st.experimental_rerun()
        else:
            st.error(f"Failed to delete protest ({response.status_code}). Please try again.")
    else:
        st.warning("Please enter a protest ID.")
