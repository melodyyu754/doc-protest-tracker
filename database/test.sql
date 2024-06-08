USE GlobalProtests
SELECT id, event_date, country, western, asian, south_american, counts, population_scaled, events_per_capita_scaled, gdp_per_capita_scaled, public_trust_percentage_scaled FROM real_data_scaled ORDER BY id DESC
