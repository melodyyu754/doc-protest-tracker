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
cause_names = requests.get('http://api:4000/cause/names').json()
user_id = st.text_input("User_ID", value=str(st.session_state['user_id']), disabled = True)

user_id = st.selectbox("User ID", options=['1','2','3'], placeholder="Choose an option") # (created_by)

title = st.text_input("Post Title")
creation_date = st.date_input("Creation Date", value=date.today())
text = st.text_area("Post Description")

causes = requests.get('http://api:4000/cause/cause').json()
cause_names =  [cause['cause_name'] for cause in causes]
selected_cause = st.selectbox("Select Cause", options=cause_names, placeholder="Choose an option")
cause_mapping = {cause['cause_name']: cause['cause_id'] for cause in causes}

# Submission Button
if st.button("Submit"):
    if user_id and title and creation_date and text and selected_cause:
        if cause == "Racial Inequality":
            cause = 1
        elif cause == "Climate Change":
            cause = 2
        elif cause == "Political Corruption":
            cause = 3
        elif cause == "Gender Equality":
            cause = 4
        elif cause == "Animal Rights":
            cause = 5
        elif cause == "Black Lives Matter":
            cause = 6
        elif cause == "Israeli-Palestine":
            cause = 7
=======
    if user_id and title and creation_date and text and selected_cause:
       
        
        
        cause = cause_mapping[selected_cause] # get the cause_id from the cause name
>>>>>>> 801232f (okay refactoring actually done now)

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