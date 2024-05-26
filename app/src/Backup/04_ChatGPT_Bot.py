import streamlit as st
from streamlit_extras.app_logo import add_logo
import numpy as np
import random
import time
from openai import OpenAI

def response_generator():
  response = random.choice (
    [
      "Hello there! How can I assist you today?",
      "Hi, human!  Is there anything I can help you with?",
      "Do you need help?",
    ]
  )
  for word in response.split():
    yield word + " "
    time.sleep(0.05)
#-----------------------------------------------------------------------

st.set_page_config (page_title="Sample Chat Bot", page_icon="🤖")
add_logo("assets/logo.png", height=320)

st.title("ChatGPT-Like Bot 🤖")

st.markdown("**Coming Soon**")

# # st.markdown("""
# #             Currently, this chat bot only returns a random message from the following list:
# #             - Hello there! How can I assist you today?
# #             - Hi, human!  Is there anything I can help you with?
# #             - Do you need help?
# #             """
# #            )

# client = OpenAI(api_key = st.secrets["OPENAI_API_KEY"])

# if "openai_model" not in st.session_state:
#   st.session_state["openai_model"] = "gpt-3.5-turbo"

# # Initialize chat history
# if "messages" not in st.session_state:
#   st.session_state.messages = []

# # Display chat message from history on app rerun
# for message in st.session_state.messages:
#   with st.chat_message(message["role"]):
#     st.markdown(message["content"])

# React to user input
# if prompt := st.chat_input("What is up?"):
#   # Display user message in chat message container
#   with st.chat_message("user"):
#     st.markdown(prompt)
  
#   # Add user message to chat history
#   st.session_state.messages.append({"role": "user", "content": prompt})

#   with st.chat_message("assistant"):
#     # Calling OpenAI here
#     stream = client.chat.completions.create(
#       model = st.session_state["openai_model"],
#       messages = [
#         {"role", m["role"], "content", m["content"]}
#         for m in st.session_state.messages
#       ],
#       stream=True,
#     )
#     response = st.write_stream(stream)

#   st.session_state.messages.append({"role": "assistant", "content": response})

# if prompt := st.chat_input("What is up?"):
#     st.session_state.messages.append({"role": "user", "content": prompt})
#     with st.chat_message("user"):
#         st.markdown(prompt)

#     with st.chat_message("assistant"):
#         stream = client.chat.completions.create(
#             model=st.session_state["openai_model"],
#             messages=[
#                 {"role": m["role"], "content": m["content"]}
#                 for m in st.session_state.messages
#             ],
#             stream=True,
#         )
#         response = st.write_stream(stream)
#     st.session_state.messages.append({"role": "assistant", "content": response})

