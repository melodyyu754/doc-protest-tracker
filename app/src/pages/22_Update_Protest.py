import streamlit as st
from streamlit_extras.app_logo import add_logo
import numpy as np
import random
import time
from modules.nav import SideBarLinks
import requests

SideBarLinks()  # Assuming this function sets up your sidebar navigation

# --- API Interactions ---

def update_protest(protest_id, location, description):
    api_url = "http://api:4000/prtsts/protest"
    payload = {
        "protest_id": protest_id,
        "location": location,
        "description": description
    }
    return requests.put(api_url, json=payload)

# --- Update Post Section ---

st.write("### Update Protest")
protest_id = st.text_input("Protest ID to Update")
location = st.text_input("New Protest Location")
description = st.text_area("Update your Protest here...")

if st.button("Update Protest"):
    if protest_id and location and description:
        response = update_protest(protest_id, location, description)

        if response.status_code == 200:
            st.success("Protest updated successfully!")
            st.experimental_rerun()  # Refresh the UI to clear the form
        else:
            st.error(f"Failed to update protest ({response.status_code}). Please try again.")
    else:
        st.warning("Please fill in all fields.")
