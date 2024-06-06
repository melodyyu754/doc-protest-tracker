import logging
logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.INFO)
logger = logging.getLogger(__name__)

import streamlit as st
from modules.nav import SideBarLinks

st.set_page_config(layout = 'wide')

st.session_state['authenticated'] = False
SideBarLinks(show_home=True)

st.title('Rallify')

st.write('\n\n')
st.write('### HI! As which user would you like to log in?')

if st.button("Act as Sally, a student activist at Columbia University",
            type = 'primary',
            use_container_width=True):
    st.session_state['authenticated'] = True
    st.session_state['role'] = 'activist'
    st.session_state['first_name'] = 'Sally'
    st.switch_page('pages/00_Activist_Home.py')

if st.button('Act as McGuinness, the president of the United States',
            type = 'primary',
            use_container_width=True):
    st.session_state['authenticated'] = True
    st.session_state['role'] = 'politician'
    st.session_state['first_name'] = 'McGuinness'
    st.switch_page('pages/01_Politician_Home.py')

if st.button('Act as Sydney, a reporter at the New York Times',
            type = 'primary',
            use_container_width=True):
    st.session_state['authenticated'] = True
    st.session_state['role'] = 'journalist'
    st.session_state['first_name'] = 'Sydney'
    st.switch_page('pages/02_Journalist_Home.py')
