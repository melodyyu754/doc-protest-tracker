import numpy as np 
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.metrics import r2_score
# from backend.db_connection import db
from flask import jsonify
import logging
from sklearn.cluster import KMeans

logger = logging.getLogger()

# Load the CSV file
df_country = pd.read_csv("backend/model2/world_bank_data.csv")

# Print column names to debug
print(df_country.columns)

# Ensure column names match exactly
df_country.rename(columns=lambda x: x.strip(), inplace=True)

# Takes in protests per capita and gdp per capita, and returns the list of clusters with country names and the cluster the input data belongs to
def predict(protests_per_capita, gdp_per_capita, n_clusters):
    # turn n_clusters into an integer
    n_clusters = int(n_clusters)
    kmeans = KMeans(n_clusters=n_clusters, n_init=10)  # Set n_init explicitly
    kmeans.fit(df_country[['protests per capita', 'gdp per capita']])
    
    # Get the cluster labels for all data points
    df_country['cluster'] = kmeans.labels_
    
    # Create a dictionary to hold clusters and associated countries
    clusters = {}
    for cluster_num in range(n_clusters):
        clusters[cluster_num] = df_country[df_country['cluster'] == cluster_num]['country'].tolist()
    
    # Create a DataFrame for the input to maintain feature names
    input_data = pd.DataFrame([[protests_per_capita, gdp_per_capita]], columns=['protests per capita', 'gdp per capita'])
    
    # Predict the cluster for the input data
    input_cluster = kmeans.predict(input_data)[0]
    
    input_cluster = int(input_cluster)
    
    return clusters, input_cluster

# Call the predict function
clusters, input_cluster = predict(1, 120000, 3)
# print("Clusters with Country Names:", clusters)

# print cluster 0
print("Cluster 0:", clusters[0])
# print cluster 1
print("Cluster 1:", clusters[1])
# print cluster 2
print("Cluster 2:", clusters[2])

print("Input Data Cluster:", input_cluster)