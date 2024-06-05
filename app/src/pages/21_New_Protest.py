import logging
logger = logging.getLogger()

import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')

SideBarLinks()

st.sidebar.header("New Protest")

st.title("Create a New Protest")
user_id = st.selectbox("User ID", options=['1','2','3'], placeholder="Choose an option") # (created_by)
location = st.text_input("Location (City)")
date = st.date_input("Protest Date", value = None)
violent = st.selectbox("Violent?", options=["True","False"], placeholder="Choose an option")
country = st.selectbox("Country", options=["United States", "Spain", "Belgium"], placeholder="Choose an option")
cause = st.selectbox("Protest Cause", options=["BLM", "BLM"], placeholder="Choose an option")
description = st.text_area("Protest Description")


# Submission Button
if st.button("Submit"):
    if user_id and location and date and violent and country and cause:
        if violent == 'True':
            violent = 1
        else:
            violent = 0
        
        if cause == "BLM":
            cause = 1

        api_url = "http://api:4000//prtsts/addprotest"
        payload = {
                "user_id": user_id,
                "location": location,
                "date": str(date),
                "violent": violent,
                "country": country,
                "cause": cause,
                "description": description
            }
        response = requests.post(api_url, json=payload)
        
        if response.status_code == 201 or response.status_code == 200:
            st.success("Post submitted successfully!")
        else:
            st.error("Failed to submit post. Please try again.")
    else:
        st.warning("Please fill in all fields.")