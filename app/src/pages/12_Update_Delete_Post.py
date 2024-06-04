import streamlit as st
from streamlit_extras.app_logo import add_logo
import numpy as np
import random
import time
from modules.nav import SideBarLinks
import requests

SideBarLinks()

# create a function to simulate a REST API call to update a post
def update_post(post_id, title, text):
    time.sleep(2)
    return {
        "post_id": post_id,
        "title": title,
        "text": text,
        "updated_at": time.time()
    }

# create a function to simulate a REST API call to delete a post
def delete_post(post_id):
    time.sleep(2)
    return {
        "post_id": post_id,
        "deleted_at": time.time()
    }

# build it out in the app using streamlit, in two separate columns

# make two columns
col1, col2 = st.columns(2)
# add a text input for the post ID in column 1
with col1:
  st.write("### Update Post")
  post_id = st.text_input("Post ID to Update")
  title = st.text_input("New Post Title")
  text = st.text_area("Update your post here...")
if st.button("Update Post"):
    if post_id and title and text:
        # Here, you would typically integrate with your forum's database or API to update the post data.
        # Example API endpoint to update an existing post
        api_url = f"http://your-api-url.com/posts/{post_id}"
        payload = {
            "title": title,
           
            "text": text
        }
        response = requests.put(api_url, json=payload)
        
        if response.status_code == 200:
            st.success("Post updated successfully!")
            # Optionally, clear the form after submission
            st.experimental_rerun()
        else:
            st.error("Failed to update post. Please try again.")
    else:
        st.warning("Please fill in the post ID, title, and post text.")

# delete post
with col2:
  st.write("### Delete Post")
  delete_post_id = st.text_input("Delete Post ID")
  # add a button to delete the post
  if st.button("Delete Post", type="secondary", use_container_width=True):
      # call the delete post function
      deleted_post = delete_post(delete_post_id)
      st.write(deleted_post)
