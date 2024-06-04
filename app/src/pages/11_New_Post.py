import streamlit as st
from streamlit_extras.app_logo import add_logo
import pandas as pd
import pydeck as pdk
from urllib.error import URLError
from modules.nav import SideBarLinks
import requests

SideBarLinks()

# add the logo
add_logo("assets/logo.png", height=400)

# set up the page
st.sidebar.header("New Post")
st.write(
    """This is the page where you can create a new post. Fill out the form below to create a new post."""
)

st.title("Create a New Post")

# User ID (Assuming you have a user authentication system)
# Replace with your actual user ID retrieval logic
user_id = st.text_input("Your User ID (if not automatically filled)", value="Get from session")

# Post Title
title = st.text_input("Post Title")

# Cause Dropdown
causes = ["Technical Issue", "Feature Request", "General Discussion", "Other"]
selected_cause = st.selectbox("Select Cause", causes)

# Post Text (Using a text area for longer input)
text = st.text_area("Write your post here...")

# Submission Button
if st.button("Submit Post"):
    if title and text:

        api_url = "http://api:4000/psts/post"
        payload = {
                "user_id": user_id,
                "title": title,
                "cause": selected_cause,
                "text": text
            }
        response = requests.post(api_url, json=payload)
        
        if response.status_code == 201:
            st.success("Post submitted successfully!")
            # Optionally, clear the form after submission
            st.experimental_rerun()
        else:
            st.error("Failed to submit post. Please try again.")
    else:
        st.warning("Please fill in the title and post text.")



# st.write("## Post Information")
# title = st.text_input("Title", "")
# content = st.text_area("Content", "")
# author = st.text_input("Author", "")
# published = st.checkbox("Published")