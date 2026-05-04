SELECT 'plays_shazam_daily', COUNT(1) FROM "plays_shazam_daily"
UNION ALL
SELECT 'plays_youtube_age_daily', COUNT(1) FROM "plays_youtube_age_daily"
UNION ALL
SELECT 'plays_youtube_gender_daily', COUNT(1) FROM "plays_youtube_gender_daily"
UNION ALL
SELECT 'plays_youtube_country_daily', COUNT(1) FROM "plays_youtube_country_daily"
UNION ALL
SELECT 'plays_spotify_age_daily', COUNT(1) FROM "plays_spotify_age_daily"
UNION ALL
SELECT 'plays_spotify_gender_daily', COUNT(1) FROM "plays_spotify_gender_daily"
UNION ALL
SELECT 'plays_spotify_country_daily', COUNT(1) FROM "plays_spotify_country_daily"
UNION ALL
SELECT 'plays_line_age_daily', COUNT(1) FROM "plays_line_age_daily"
UNION ALL
SELECT 'plays_line_gender_daily', COUNT(1) FROM "plays_line_gender_daily"
UNION ALL
SELECT 'plays_apple_age_daily', COUNT(1) FROM "plays_apple_age_daily"
UNION ALL
SELECT 'plays_apple_gender_daily', COUNT(1) FROM "plays_apple_gender_daily"
UNION ALL
SELECT 'plays_apple_country_daily', COUNT(1) FROM "plays_apple_country_daily"
UNION ALL
SELECT 'plays_amazon_country_daily', COUNT(1) FROM "plays_amazon_country_daily"
;
SELECT 'plays_shazam_daily', COUNT(1) FROM "plays_shazam_daily" WHERE play_count IS NULL
UNION ALL
SELECT 'plays_youtube_age_daily', COUNT(1) FROM "plays_youtube_age_daily" WHERE play_count IS NULL
UNION ALL
SELECT 'plays_youtube_gender_daily', COUNT(1) FROM "plays_youtube_gender_daily" WHERE play_count IS NULL
UNION ALL
SELECT 'plays_youtube_country_daily', COUNT(1) FROM "plays_youtube_country_daily" WHERE play_count IS NULL
UNION ALL
SELECT 'plays_spotify_age_daily', COUNT(1) FROM "plays_spotify_age_daily" WHERE play_count IS NULL
UNION ALL
SELECT 'plays_spotify_gender_daily', COUNT(1) FROM "plays_spotify_gender_daily" WHERE play_count IS NULL
UNION ALL
SELECT 'plays_spotify_country_daily', COUNT(1) FROM "plays_spotify_country_daily" WHERE play_count IS NULL
UNION ALL
SELECT 'plays_line_age_daily', COUNT(1) FROM "plays_line_age_daily" WHERE play_count IS NULL
UNION ALL
SELECT 'plays_line_gender_daily', COUNT(1) FROM "plays_line_gender_daily" WHERE play_count IS NULL
UNION ALL
SELECT 'plays_apple_age_daily', COUNT(1) FROM "plays_apple_age_daily" WHERE play_count IS NULL
UNION ALL
SELECT 'plays_apple_gender_daily', COUNT(1) FROM "plays_apple_gender_daily" WHERE play_count IS NULL
UNION ALL
SELECT 'plays_apple_country_daily', COUNT(1) FROM "plays_apple_country_daily" WHERE play_count IS NULL
UNION ALL
SELECT 'plays_amazon_country_daily', COUNT(1) FROM "plays_amazon_country_daily" WHERE play_count IS NULL
;
