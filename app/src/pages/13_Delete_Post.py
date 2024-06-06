import streamlit as st
from streamlit_extras.app_logo import add_logo
import numpy as np
import random
import time
from modules.nav import SideBarLinks
import requests

SideBarLinks()  # Assuming this function sets up your sidebar navigation

# --- API Interactions ---

def delete_post(post_id):
    api_url = f"http://api:4000/psts/post/{post_id}"
    response = requests.delete(api_url)
    return response

# --- Delete Post Section ---


st.write("### Delete Post")
delete_post_id = st.text_input("Delete Post ID")

if st.button("Delete Post"):
    if delete_post_id:
        response = delete_post(delete_post_id)

        if response.status_code == 200:
            st.success("Post deleted successfully!")
            st.experimental_rerun()
        else:
            st.error(f"Failed to delete post ({response.status_code}). Please try again.")
    else:
        st.warning("Please enter a post ID.")
