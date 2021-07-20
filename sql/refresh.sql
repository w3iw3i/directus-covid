-- Update published_records table with latest records

WITH published AS (
SELECT DISTINCT ON (CAST(data ->> 'id' AS bigint))
       CAST(data ->> 'id' AS bigint) as id, 
       CAST(data ->> 'country_region' AS character varying(255)) as country_region, 
       CAST(data ->> 'date' AS date) as date, 
       CAST(data ->> 'last_updated' AS timestamp with time zone) as last_updated, 
       CAST(data ->> 'confirmed' AS integer) as confirmed,
       CAST(data ->> 'deaths' AS integer) as deaths,
       CAST(data ->> 'recovered' AS integer) as recovered,
       CAST(data ->> 'active' AS integer) as active
FROM public.directus_revisions WHERE collection = 'records' AND data ->> 'status' = 'published'
ORDER BY CAST(data ->> 'id' AS bigint), CAST(data ->> 'last_updated' AS timestamp with time zone) DESC
)
INSERT INTO public.published_records (record_id, country_region, date, last_updated, confirmed, deaths, recovered, active)
SELECT * FROM published
ON CONFLICT (record_id) DO UPDATE 
SET country_region = excluded.country_region,
date = excluded.date,
last_updated = excluded.last_updated,
confirmed = excluded.confirmed,
deaths = excluded.deaths,
recovered = excluded.recovered,
active = excluded.active;