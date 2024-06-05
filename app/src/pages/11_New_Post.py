import logging
logger = logging.getLogger()

import streamlit as st
from modules.nav import SideBarLinks
import requests
from datetime import date

st.set_page_config(layout = 'wide')

SideBarLinks()

st.sidebar.header("New Post")

st.title("Create a New Post")
user_id = st.selectbox("User ID", options=['1','2','3'], placeholder="Choose an option") # (created_by)
title = st.text_input("Post Title")
creation_date = st.date_input("Creation Date", value=date.today())
text = st.text_area("Post Description")
cause = st.selectbox("Protest Cause", options=["BLM", "Free Palestine", "Pro Choice"], placeholder="Choose an option")



# Submission Button
if st.button("Submit"):
    if user_id and title and creation_date and text and cause:
       
        
        if cause == "BLM":
            cause = 1

        api_url = "http://api:4000//psts/addpost"
        payload = {
                "user_id": user_id,
                "title": title,
                "creation_date": str(creation_date),
                "text": text,
               
                "cause": cause,
              
            }
        response = requests.post(api_url, json=payload)
        
        if response.status_code == 201 or response.status_code == 200:
            st.success("Post submitted successfully!")
        else:
            st.error("Failed to submit post. Please try again.")
    else:
        st.warning("Please fill in all fields.")