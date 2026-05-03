ALTER TABLE "plays_amazon_country_daily" ADD FOREIGN KEY ("isrc") REFERENCES "tracks" ("isrc");

ALTER TABLE "plays_apple_country_daily" ADD FOREIGN KEY ("isrc") REFERENCES "tracks" ("isrc");

ALTER TABLE "plays_youtube_country_daily" ADD FOREIGN KEY ("isrc") REFERENCES "tracks" ("isrc");

ALTER TABLE "plays_spotify_country_daily" ADD FOREIGN KEY ("isrc") REFERENCES "tracks" ("isrc");

ALTER TABLE "plays_apple_gender_daily" ADD FOREIGN KEY ("isrc") REFERENCES "tracks" ("isrc");

ALTER TABLE "plays_apple_age_daily" ADD FOREIGN KEY ("isrc") REFERENCES "tracks" ("isrc");

ALTER TABLE "plays_line_gender_daily" ADD FOREIGN KEY ("isrc") REFERENCES "tracks" ("isrc");

ALTER TABLE "plays_line_age_daily" ADD FOREIGN KEY ("isrc") REFERENCES "tracks" ("isrc");

ALTER TABLE "plays_spotify_gender_daily" ADD FOREIGN KEY ("isrc") REFERENCES "tracks" ("isrc");

ALTER TABLE "plays_spotify_age_daily" ADD FOREIGN KEY ("isrc") REFERENCES "tracks" ("isrc");

ALTER TABLE "plays_youtube_gender_daily" ADD FOREIGN KEY ("isrc") REFERENCES "tracks" ("isrc");

ALTER TABLE "plays_youtube_age_daily" ADD FOREIGN KEY ("isrc") REFERENCES "tracks" ("isrc");

ALTER TABLE "plays_shazam_daily" ADD FOREIGN KEY ("isrc") REFERENCES "tracks" ("isrc");

