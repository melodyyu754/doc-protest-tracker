import logging
logger = logging.getLogger()

import streamlit as st
from modules.nav import SideBarLinks
import requests
import plotly.express as px
import pandas as pd

st.set_page_config(layout = 'wide')

# Display the appropriate sidebar links for the role of the logged in user
SideBarLinks()

st.title('Predicting k-means cluster')
st.write('')

gdp_per_capita = st.slider('GDP per Capita:', 0, 200000, 10000)

# makes protests per capita a slider from 0 to 200 with a default value of 50
protests_per_capita = st.slider('Protests per Capita:', 0, 200, 50)

# max number of clusters is 10, number input
n_clusters = st.number_input('Number of Clusters:', min_value=0, max_value=10, value=3)
  
# Make a predict button that sends the input values to the REST API
if st.button('Predict Clusters', type='primary', use_container_width=True):
    response = requests.get(f'http://api:4000/model2/model2/{gdp_per_capita}/{protests_per_capita}/{n_clusters}')
    
    if response.status_code == 200:
        results = response.json()
        logger.info(f"Response: {results}")

        # Extract prediction results
        clusters = results['prediction_value'][0]
        predicted_cluster = results['prediction_value'][1]

        # Transform the list of lists into a DataFrame
        cluster_data = []
        for cluster_num, cluster in clusters.items():  # Iterate over keys and values
            for country in cluster:
                cluster_data.append({'country': country, 'cluster': int(cluster_num)}) 


        df = pd.DataFrame(cluster_data)

        # Debug: Display the DataFrame to ensure it's correct
        st.write("DataFrame for Clusters:")
        st.write(df)
        
        # Display the dataframe with columns cluster 1, cluster 2 ..., and the countries in each column.
        st.write('### Cluster Prediction Results:')
        st.write('The following table shows the predicted cluster for each country based on the input values.')
        
        # column names should be cluster 1, cluster 2, etc, and the text cells should be the countries in each cluster
        # use a loop to create a table with the countries in each cluster
        df_display = pd.DataFrame()

        st.table(df_display)

        # Create a choropleth map
        fig = px.choropleth(df, locations='country',
                            locationmode='country names',
                            color='cluster',
                            hover_name='country',
                            title='Cluster Prediction Results',
                            color_continuous_scale=px.colors.sequential.Plasma)

        fig.update_layout(height=600, width=800)  # Set the height and width of the figure
        st.plotly_chart(fig)

        st.write('### Predicted Cluster:')
        st.write(predicted_cluster)
    else:
        st.error('Failed to get prediction. Please try again.')