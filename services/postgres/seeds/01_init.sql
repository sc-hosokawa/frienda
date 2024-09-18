-- Drop existing tables
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS maps;
DROP TABLE IF EXISTS txs_fsp;
DROP TABLE IF EXISTS purchase_history;
DROP TABLE IF EXISTS webhook_stripe;
DROP TABLE IF EXISTS webhook_clerk;
DROP TABLE IF EXISTS quests;
DROP TABLE IF EXISTS offers;
DROP TABLE IF EXISTS raids;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS news;
DROP TABLE IF EXISTS notifications;
DROP TABLE IF EXISTS favorites;
DROP TABLE IF EXISTS short_notes;
DROP TABLE IF EXISTS artists;
DROP TABLE IF EXISTS user_artist;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS tracks;
DROP TABLE IF EXISTS product_track;
DROP TABLE IF EXISTS plays_daily;
DROP TABLE IF EXISTS plays_monthly;
DROP TABLE IF EXISTS plays_yearly;
DROP TABLE IF EXISTS indicators;
DROP TABLE IF EXISTS messages;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS room_user;

-- Drop existing types
DROP TYPE IF EXISTS offer_status;
DROP TYPE IF EXISTS user_status;
DROP TYPE IF EXISTS user_role;
DROP TYPE IF EXISTS artist_status;
DROP TYPE IF EXISTS purchase_status;

-- Install extensions
CREATE EXTENSION IF NOT EXISTS "ulid";