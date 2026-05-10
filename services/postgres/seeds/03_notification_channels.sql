-- Mobile notification list channel storage schema.
-- Keep this separate from 01_full_schema.sql so existing schema dumps remain comparable.

CREATE TABLE IF NOT EXISTS public.notification_channels (
  notification_id integer NOT NULL,
  channel character varying NOT NULL,
  CONSTRAINT notification_channels_pkey PRIMARY KEY (notification_id, channel),
  CONSTRAINT notification_channels_channel_check
    CHECK (channel IN ('MOBILE_PUSH', 'EMAIL', 'HOME'))
);

ALTER TABLE ONLY public.notification_channels
  DROP CONSTRAINT IF EXISTS notification_channels_notification_id_fkey;

ALTER TABLE ONLY public.notification_channels
  ADD CONSTRAINT notification_channels_notification_id_fkey
  FOREIGN KEY (notification_id)
  REFERENCES public.notifications(id)
  ON DELETE CASCADE;

CREATE INDEX IF NOT EXISTS notification_channels_channel_notification_id_idx
  ON public.notification_channels (channel, notification_id);
