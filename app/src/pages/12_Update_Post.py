import streamlit as st
from streamlit_extras.app_logo import add_logo
import numpy as np
import random
import time
from modules.nav import SideBarLinks
import requests

SideBarLinks()  # Assuming this function sets up your sidebar navigation

# --- API Interactions ---

def update_post(post_id, title, text):
    api_url = "http://api:4000/psts/post"
    payload = {
        "post_id": post_id,
        "title": title,
        "text": text
    }
    return requests.put(api_url, json=payload)



# --- Update Post Section ---

st.write("### Edit Post")
post_id = st.text_input("Post ID to Update")
title = st.text_input("New Post Title")
text = st.text_area("Update your post here...")

if st.button("Update Post"):
    if post_id and title and text:
        response = update_post(post_id, title, text)

        if response.status_code == 200:
            st.success("Post updated successfully!")
            st.experimental_rerun()  # Refresh the UI to clear the form
        else:
            st.error(f"Failed to update post ({response.status_code}). Please try again.")
    else:
        st.warning("Please fill in all fields.")

