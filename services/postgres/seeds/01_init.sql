-- Drop existing tables
DROP TABLE IF EXISTS message_room;
DROP TABLE IF EXISTS messages;
DROP TABLE IF EXISTS plays_yearly;
DROP TABLE IF EXISTS plays_monthly;
DROP TABLE IF EXISTS plays_daily;
DROP TABLE IF EXISTS short_notes;
DROP TABLE IF EXISTS favorites;
DROP TABLE IF EXISTS notifications;
DROP TABLE IF EXISTS news;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS offers;
DROP TABLE IF EXISTS raids;
DROP TABLE IF EXISTS quests;
DROP TABLE IF EXISTS txs_credential;
DROP TABLE IF EXISTS txs_fsp;
DROP TABLE IF EXISTS product_track;
DROP TABLE IF EXISTS user_artist;
DROP TABLE IF EXISTS maps;
DROP TABLE IF EXISTS indicators;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS tracks;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS artists;
DROP TABLE IF EXISTS users;

-- Drop existing types
DROP TYPE IF EXISTS offer_status;
DROP TYPE IF EXISTS user_status;
DROP TYPE IF EXISTS user_role;

-- Create types
CREATE TYPE "offer_status" AS ENUM (
  'ongoing',
  'suspend',
  'finished'
);

CREATE TYPE "user_status" AS ENUM (
  'invited',
  'rejected',
  'joined'
);

CREATE TYPE "user_role" AS ENUM (
  'musician',
  'curator',
  'other'
);

-- Create tables
CREATE TABLE "users" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "username" varchar NOT NULL,
  "role" user_role NOT NULL,
  "evm_addr" varchar,
  "status" user_status NOT NULL,
  "invited_by" uuid,
  "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "artists" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "name" varchar NOT NULL,
  "since" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE "products" (
  "upc" varchar PRIMARY KEY,
  "title" varchar NOT NULL
);

CREATE TABLE "tracks" (
  "isrc" varchar PRIMARY KEY
);

CREATE TABLE "rooms" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid()
);

CREATE TABLE "indicators" (
  "id" smallint PRIMARY KEY,
  "name" varchar NOT NULL
);

CREATE TABLE "maps" (
  "following_user_id" uuid NOT NULL,
  "followed_user_id" uuid NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("following_user_id", "followed_user_id"),
  FOREIGN KEY ("following_user_id") REFERENCES "users" ("id") ON DELETE CASCADE,
  FOREIGN KEY ("followed_user_id") REFERENCES "users" ("id") ON DELETE CASCADE
);

CREATE TABLE "user_artist" (
  "user_id" uuid NOT NULL,
  "artist_id" uuid NOT NULL,
  PRIMARY KEY ("user_id", "artist_id"),
  FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE,
  FOREIGN KEY ("artist_id") REFERENCES "artists" ("id") ON DELETE CASCADE
);

CREATE TABLE "product_track" (
  "upc" varchar NOT NULL,
  "isrc" varchar NOT NULL,
  PRIMARY KEY ("upc", "isrc"),
  FOREIGN KEY ("upc") REFERENCES "products" ("upc") ON DELETE CASCADE,
  FOREIGN KEY ("isrc") REFERENCES "tracks" ("isrc") ON DELETE CASCADE
);

CREATE TABLE "txs_fsp" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "from" uuid NOT NULL,
  "to" uuid NOT NULL,
  "amount" bigint NOT NULL,
  "tx_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY ("from") REFERENCES "users" ("id") ON DELETE CASCADE,
  FOREIGN KEY ("to") REFERENCES "users" ("id") ON DELETE CASCADE
);

CREATE TABLE "txs_credential" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "to" uuid NOT NULL,
  "amount" bigint NOT NULL,
  "tx_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY ("to") REFERENCES "users" ("id") ON DELETE CASCADE
);

CREATE TABLE "quests" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "name" varchar NOT NULL,
  "description" text
);

CREATE TABLE "raids" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "owner" uuid NOT NULL,
  "title" varchar NOT NULL,
  FOREIGN KEY ("owner") REFERENCES "users" ("id") ON DELETE CASCADE
);

CREATE TABLE "offers" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "raid_id" uuid NOT NULL,
  "owner" uuid NOT NULL,
  "release_dt" date NOT NULL,
  "title" varchar NOT NULL,
  "description" text,
  "status" offer_status NOT NULL DEFAULT 'ongoing',
  FOREIGN KEY ("raid_id") REFERENCES "raids" ("id") ON DELETE CASCADE,
  FOREIGN KEY ("owner") REFERENCES "users" ("id") ON DELETE CASCADE
);

CREATE TABLE "comments" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "user_id" uuid NOT NULL,
  "offer_id" uuid NOT NULL,
  "content" text NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE,
  FOREIGN KEY ("offer_id") REFERENCES "offers" ("id") ON DELETE CASCADE
);

CREATE TABLE "news" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "title" varchar NOT NULL,
  "body" text NOT NULL,
  "user_id" uuid NOT NULL,
  "category" varchar NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE
);

CREATE TABLE "notifications" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "user_id" uuid NOT NULL,
  "title" varchar NOT NULL,
  "content" text NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE
);

CREATE TABLE "favorites" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "user_id" uuid NOT NULL,
  "liked_by" uuid NOT NULL,
  FOREIGN KEY ("user_id") REFERENCES "users" ("id") ON DELETE CASCADE,
  FOREIGN KEY ("liked_by") REFERENCES "users" ("id") ON DELETE CASCADE
);

CREATE TABLE "short_notes" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "favorite_id" uuid NOT NULL,
  "comment" varchar(140) NOT NULL,
  FOREIGN KEY ("favorite_id") REFERENCES "favorites" ("id") ON DELETE CASCADE
);

CREATE TABLE "plays_daily" (
  "isrc" varchar NOT NULL,
  "date" date NOT NULL,
  "spotify" int NOT NULL DEFAULT 0,
  "apple" int NOT NULL DEFAULT 0,
  "line" int NOT NULL DEFAULT 0,
  "amazon" int NOT NULL DEFAULT 0,
  "youtube" int NOT NULL DEFAULT 0,
  "sum" int NOT NULL DEFAULT 0,
  PRIMARY KEY ("isrc", "date"),
  FOREIGN KEY ("isrc") REFERENCES "tracks" ("isrc") ON DELETE CASCADE
);

CREATE TABLE "plays_monthly" (
  "isrc" varchar NOT NULL,
  "date" date NOT NULL,
  "spotify" int NOT NULL DEFAULT 0,
  "apple" int NOT NULL DEFAULT 0,
  "line" int NOT NULL DEFAULT 0,
  "amazon" int NOT NULL DEFAULT 0,
  "youtube" int NOT NULL DEFAULT 0,
  "sum" int NOT NULL DEFAULT 0,
  PRIMARY KEY ("isrc", "date"),
  FOREIGN KEY ("isrc") REFERENCES "tracks" ("isrc") ON DELETE CASCADE
);

CREATE TABLE "plays_yearly" (
  "isrc" varchar NOT NULL,
  "date" date NOT NULL,
  "spotify" int NOT NULL DEFAULT 0,
  "apple" int NOT NULL DEFAULT 0,
  "line" int NOT NULL DEFAULT 0,
  "amazon" int NOT NULL DEFAULT 0,
  "youtube" int NOT NULL DEFAULT 0,
  "sum" int NOT NULL DEFAULT 0,
  PRIMARY KEY ("isrc", "date"),
  FOREIGN KEY ("isrc") REFERENCES "tracks" ("isrc") ON DELETE CASCADE
);

CREATE TABLE "messages" (
  "id" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "room_id" uuid NOT NULL,
  "send_by" uuid NOT NULL,
  "recipient" uuid NOT NULL,
  "message" text NOT NULL,
  "created_at" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY ("room_id") REFERENCES "rooms" ("id") ON DELETE CASCADE,
  FOREIGN KEY ("send_by") REFERENCES "users" ("id") ON DELETE CASCADE,
  FOREIGN KEY ("recipient") REFERENCES "users" ("id") ON DELETE CASCADE
);

CREATE TABLE "message_room" (
  "room_id" uuid NOT NULL,
  "message_id" uuid NOT NULL,
  PRIMARY KEY ("room_id", "message_id"),
  FOREIGN KEY ("room_id") REFERENCES "rooms" ("id") ON DELETE CASCADE,
  FOREIGN KEY ("message_id") REFERENCES "messages" ("id") ON DELETE CASCADE
);

CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_status ON users(status);
CREATE INDEX idx_offers_status ON offers(status);
CREATE INDEX idx_news_category ON news(category);
CREATE INDEX idx_plays_daily_date ON plays_daily(date);
CREATE INDEX idx_plays_monthly_date ON plays_monthly(date);
CREATE INDEX idx_plays_yearly_date ON plays_yearly(date);

COMMENT ON COLUMN "offers"."id" IS 'UUID is used instead of ULID for consistency';
COMMENT ON COLUMN "news"."body" IS 'Content of the post';
COMMENT ON COLUMN "messages"."recipient" IS 'User ID of the message recipient';
