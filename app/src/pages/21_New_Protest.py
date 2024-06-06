import logging
logger = logging.getLogger()

import streamlit as st
from modules.nav import SideBarLinks
import requests

st.set_page_config(layout = 'wide')

SideBarLinks()

st.sidebar.header("New Protest")

st.title("Create a New Protest")

country_names = requests.get('http://api:4000/cntry/names').json()
cause_names = requests.get('http://api:4000/cause/names').json()
user_id = st.selectbox("Your User ID", placeholder="Choose an option", index = None, options=['1','2','3']) # (created_by)
location = st.text_input("Location (City)")
date = st.date_input("Protest Date", value = None)
violent = st.selectbox("Violent?", options=["True","False"], index = None, placeholder="Choose an option")
country = st.selectbox("Country", options=country_names, index = None, placeholder="Choose an option")
cause = st.selectbox("Protest Cause", placeholder="Choose an option",index = None, options=cause_names)
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