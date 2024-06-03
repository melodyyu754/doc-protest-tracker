import logging

import streamlit as st
from modules.nav import SideBarLinks

logger = logging.getLogger()

st.set_page_config(layout = 'wide')

# Show appropriate sidebar links for the role of the currently logged in user
SideBarLinks()

st.title(f"Welcome Politician, {st.session_state['first_name']}.")
st.write('')
st.write('')
st.write('### What would you like to do today?')

if st.button('View Protests',
              type='primary',
              use_container_width=True):
    st.switch_page('pages/20_View_Protests.py')

if st.button('View Protest Map',
              type='primary',
              use_container_width=True):
    st.switch_page('pages/21_View_Protest_Map.py')

if st.button('View Model 1',
              type='primary',
              use_container_width=True):
    st.switch_page('pages/41_Model_1.py')