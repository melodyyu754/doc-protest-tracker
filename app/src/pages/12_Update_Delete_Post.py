import streamlit as st
from streamlit_extras.app_logo import add_logo
import numpy as np
import random
import time
from modules.nav import SideBarLinks

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
  update_post_id = st.text_input("Post ID")
  title = st.text_input("Title")
  text = st.text_area("Text")
  # add a button to update the post
  if st.button("Update Post", type="primary", use_container_width=True):
      # call the update post function
      updated_post = update_post(update_post_id, title, text)
      st.write(updated_post)

# delete post
with col2:
  st.write("### Delete Post")
  delete_post_id = st.text_input("Delete Post ID")
  # add a button to delete the post
  if st.button("Delete Post", type="secondary", use_container_width=True):
      # call the delete post function
      deleted_post = delete_post(delete_post_id)
      st.write(deleted_post)
