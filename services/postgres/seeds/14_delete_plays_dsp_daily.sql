DELETE FROM "plays_shazam_daily" p WHERE NOT EXISTS (SELECT 1 FROM "tracks" t WHERE p.isrc = t.isrc);
DELETE FROM "plays_youtube_age_daily" p WHERE NOT EXISTS (SELECT 1 FROM "tracks" t WHERE p.isrc = t.isrc);

DELETE FROM "plays_youtube_gender_daily" p WHERE NOT EXISTS (SELECT 1 FROM "tracks" t WHERE p.isrc = t.isrc);

DELETE FROM "plays_youtube_country_daily" p WHERE NOT EXISTS (SELECT 1 FROM "tracks" t WHERE p.isrc = t.isrc);

DELETE FROM "plays_spotify_age_daily" p WHERE NOT EXISTS (SELECT 1 FROM "tracks" t WHERE p.isrc = t.isrc);

DELETE FROM "plays_spotify_gender_daily" p WHERE NOT EXISTS (SELECT 1 FROM "tracks" t WHERE p.isrc = t.isrc);

DELETE FROM "plays_spotify_country_daily" p WHERE NOT EXISTS (SELECT 1 FROM "tracks" t WHERE p.isrc = t.isrc);

DELETE FROM "plays_line_age_daily" p WHERE NOT EXISTS (SELECT 1 FROM "tracks" t WHERE p.isrc = t.isrc);

DELETE FROM "plays_line_gender_daily" p WHERE NOT EXISTS (SELECT 1 FROM "tracks" t WHERE p.isrc = t.isrc);

DELETE FROM "plays_apple_age_daily" p WHERE NOT EXISTS (SELECT 1 FROM "tracks" t WHERE p.isrc = t.isrc);

DELETE FROM "plays_apple_gender_daily" p WHERE NOT EXISTS (SELECT 1 FROM "tracks" t WHERE p.isrc = t.isrc);

DELETE FROM "plays_apple_country_daily" p WHERE NOT EXISTS (SELECT 1 FROM "tracks" t WHERE p.isrc = t.isrc);

DELETE FROM "plays_amazon_country_daily" p WHERE NOT EXISTS (SELECT 1 FROM "tracks" t WHERE p.isrc = t.isrc);

