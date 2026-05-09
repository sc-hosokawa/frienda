-- Notification recipient snapshot schema for admin notification history.
-- Keep this separate from 01_full_schema.sql so existing schema dumps remain comparable.

CREATE TABLE IF NOT EXISTS public.notification_recipients (
  notification_id integer NOT NULL,
  user_id character varying(28) NOT NULL,
  created_at timestamp without time zone DEFAULT now() NOT NULL,
  CONSTRAINT notification_recipients_pkey PRIMARY KEY (notification_id, user_id)
);

ALTER TABLE ONLY public.notification_recipients
  DROP CONSTRAINT IF EXISTS notification_recipients_notification_id_fkey;

ALTER TABLE ONLY public.notification_recipients
  ADD CONSTRAINT notification_recipients_notification_id_fkey
  FOREIGN KEY (notification_id)
  REFERENCES public.notifications(id)
  ON DELETE CASCADE;

ALTER TABLE ONLY public.notification_recipients
  DROP CONSTRAINT IF EXISTS notification_recipients_user_id_fkey;

ALTER TABLE ONLY public.notification_recipients
  ADD CONSTRAINT notification_recipients_user_id_fkey
  FOREIGN KEY (user_id)
  REFERENCES public.users(id);

CREATE INDEX IF NOT EXISTS notification_recipients_user_id_notification_id_idx
  ON public.notification_recipients (user_id, notification_id);
