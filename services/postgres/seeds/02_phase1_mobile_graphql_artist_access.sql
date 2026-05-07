-- API-39 / API-44 / API-3 / API-4 / API-5
-- Mobile GraphQL artist access schema additions.
-- This file is intentionally separate from 01_full_schema.sql so the staging
-- schema dump remains easy to compare.

ALTER TYPE public.user_artist_status ADD VALUE IF NOT EXISTS 'canceled';

ALTER TABLE public.user_artist
  ADD COLUMN IF NOT EXISTS request_message character varying(200);

ALTER TABLE public.user_artist
  ADD COLUMN IF NOT EXISTS is_default boolean DEFAULT false;

UPDATE public.user_artist
SET is_default = false
WHERE is_default IS NULL;

ALTER TABLE public.user_artist
  ALTER COLUMN is_default SET DEFAULT false,
  ALTER COLUMN is_default SET NOT NULL;

ALTER TABLE public.user_artist
  ADD COLUMN IF NOT EXISTS requested_at timestamp without time zone;

WITH ranked_defaults AS (
  SELECT
    id,
    ROW_NUMBER() OVER (
      PARTITION BY user_id
      ORDER BY artist_id ASC, id ASC
    ) AS rn
  FROM public.user_artist
  WHERE is_default = true
)
UPDATE public.user_artist AS ua
SET is_default = false
FROM ranked_defaults AS rd
WHERE ua.id = rd.id
  AND rd.rn > 1;

CREATE UNIQUE INDEX IF NOT EXISTS idx_user_artist_one_default_per_user
  ON public.user_artist (user_id)
  WHERE is_default = true;
