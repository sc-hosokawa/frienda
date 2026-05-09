-- Local dummy data for mobile GraphQL artist access and notification flows.
-- Applied after schema extension SQL files.

INSERT INTO public.users (
  id,
  username,
  email,
  status,
  category,
  primary_category,
  is_superadmin,
  realname,
  greeting
) VALUES
  (
    'usr_superadmin_0001',
    'superadmin',
    'superadmin@example.test',
    'joined',
    'musician',
    'musician',
    true,
    'Super Admin',
    'Local superadmin user'
  ),
  (
    'usr_artist_admin_01',
    'artist-admin',
    'artist-admin@example.test',
    'joined',
    'musician',
    'musician',
    false,
    'Artist Admin',
    'Representative of Artist Alpha'
  ),
  (
    'usr_artist_member_01',
    'artist-member',
    'artist-member@example.test',
    'joined',
    'creator',
    'creator',
    false,
    'Artist Member',
    'Accepted member of Artist Alpha and Beta'
  ),
  (
    'usr_pending_000001',
    'pending-user',
    'pending-user@example.test',
    'joined',
    'supporter',
    'supporter',
    false,
    'Pending User',
    'User with a pending artist request'
  ),
  (
    'usr_rejected_00001',
    'rejected-user',
    'rejected-user@example.test',
    'joined',
    'supporter',
    'supporter',
    false,
    'Rejected User',
    'User with a rejected artist request'
  ),
  (
    'usr_canceled_00001',
    'canceled-user',
    'canceled-user@example.test',
    'joined',
    'supporter',
    'supporter',
    false,
    'Canceled User',
    'User with a canceled artist request'
  ),
  (
    'usr_fallback_00001',
    'fallback-user',
    'fallback-user@example.test',
    'joined',
    'musician',
    'musician',
    false,
    'Fallback User',
    'Accepted member without an explicit default artist'
  ),
  (
    'usr_outsider_00001',
    'outsider-user',
    'outsider-user@example.test',
    'joined',
    'supporter',
    'supporter',
    false,
    'Outsider User',
    'User without artist mappings'
  )
ON CONFLICT (id) DO UPDATE SET
  username = EXCLUDED.username,
  email = EXCLUDED.email,
  status = EXCLUDED.status,
  category = EXCLUDED.category,
  primary_category = EXCLUDED.primary_category,
  is_superadmin = EXCLUDED.is_superadmin,
  realname = EXCLUDED.realname,
  greeting = EXCLUDED.greeting,
  updated_at = now();

INSERT INTO public.artists (
  id,
  display_name_jp,
  display_name_en,
  display_name_kana,
  img_url,
  fsp,
  status,
  since,
  universal_id,
  artist_id
) VALUES
  (
    '00000000-0000-0000-0000-000000000101',
    'Artist Alpha JP',
    'Artist Alpha',
    'artist alpha',
    'https://example.test/images/artist-alpha.png',
    1200,
    'visible',
    '2024-01-01',
    'dummy-artist-alpha',
    'artist_alpha_0001'
  ),
  (
    '00000000-0000-0000-0000-000000000102',
    'Artist Beta JP',
    'Artist Beta',
    'artist beta',
    'https://example.test/images/artist-beta.png',
    800,
    'visible',
    '2024-02-01',
    'dummy-artist-beta',
    'artist_beta_0001'
  ),
  (
    '00000000-0000-0000-0000-000000000103',
    'Artist Gamma JP',
    'Artist Gamma',
    'artist gamma',
    'https://example.test/images/artist-gamma.png',
    300,
    'visible',
    '2024-03-01',
    'dummy-artist-gamma',
    'artist_gamma_0001'
  )
ON CONFLICT (artist_id) DO UPDATE SET
  display_name_jp = EXCLUDED.display_name_jp,
  display_name_en = EXCLUDED.display_name_en,
  display_name_kana = EXCLUDED.display_name_kana,
  img_url = EXCLUDED.img_url,
  fsp = EXCLUDED.fsp,
  status = EXCLUDED.status,
  since = EXCLUDED.since,
  universal_id = EXCLUDED.universal_id;

INSERT INTO public.user_artist (
  id,
  user_id,
  is_admin,
  status,
  artist_id,
  request_message,
  is_default,
  requested_at
) VALUES
  (
    10001,
    'usr_artist_admin_01',
    true,
    'accept',
    'artist_alpha_0001',
    'Initial representative membership.',
    true,
    now() - interval '30 days'
  ),
  (
    10002,
    'usr_artist_member_01',
    false,
    'accept',
    'artist_alpha_0001',
    'Accepted member request for Alpha.',
    true,
    now() - interval '20 days'
  ),
  (
    10003,
    'usr_artist_member_01',
    false,
    'accept',
    'artist_beta_0001',
    'Accepted member request for Beta.',
    false,
    now() - interval '18 days'
  ),
  (
    10004,
    'usr_pending_000001',
    false,
    'check',
    'artist_alpha_0001',
    'Please approve my request to join Artist Alpha.',
    false,
    now() - interval '3 days'
  ),
  (
    10005,
    'usr_rejected_00001',
    false,
    'reject',
    'artist_alpha_0001',
    'Rejected request that can be resent.',
    false,
    now() - interval '10 days'
  ),
  (
    10006,
    'usr_canceled_00001',
    false,
    'canceled',
    'artist_alpha_0001',
    'Canceled request that can be resent.',
    false,
    now() - interval '7 days'
  ),
  (
    10007,
    'usr_fallback_00001',
    false,
    'accept',
    'artist_alpha_0001',
    'Accepted membership without explicit default.',
    false,
    now() - interval '12 days'
  ),
  (
    10008,
    'usr_fallback_00001',
    false,
    'accept',
    'artist_beta_0001',
    'Second accepted membership without explicit default.',
    false,
    now() - interval '11 days'
  ),
  (
    10009,
    'usr_artist_admin_01',
    true,
    'accept',
    'artist_beta_0001',
    'Representative of Artist Beta for local notification tests.',
    false,
    now() - interval '16 days'
  )
ON CONFLICT (id) DO UPDATE SET
  user_id = EXCLUDED.user_id,
  is_admin = EXCLUDED.is_admin,
  status = EXCLUDED.status,
  artist_id = EXCLUDED.artist_id,
  request_message = EXCLUDED.request_message,
  is_default = EXCLUDED.is_default,
  requested_at = EXCLUDED.requested_at;

INSERT INTO public.tracks (
  isrc,
  img_url,
  title,
  artist_id
) VALUES
  (
    'JPAAA2400001',
    'https://example.test/images/track-alpha.png',
    'Alpha Local Track',
    'artist_alpha_0001'
  ),
  (
    'JPBBB2400001',
    'https://example.test/images/track-beta.png',
    'Beta Local Track',
    'artist_beta_0001'
  )
ON CONFLICT (isrc) DO UPDATE SET
  img_url = EXCLUDED.img_url,
  title = EXCLUDED.title,
  artist_id = EXCLUDED.artist_id;

INSERT INTO public.notifications (
  id,
  title,
  content,
  category
) VALUES
  (
    10001,
    'Local artist request notification',
    'Dummy notification for local artist access testing.',
    'artist_request'
  )
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  category = EXCLUDED.category;

INSERT INTO public.notification_user (
  id,
  notification_id,
  "user",
  is_read
) VALUES
  (
    10001,
    10001,
    'usr_artist_admin_01',
    false
  )
ON CONFLICT (id) DO UPDATE SET
  notification_id = EXCLUDED.notification_id,
  "user" = EXCLUDED."user",
  is_read = EXCLUDED.is_read;

INSERT INTO public.notification_channels (notification_id, channel)
VALUES
  (10001, 'MOBILE_PUSH')
ON CONFLICT (notification_id, channel) DO NOTHING;

INSERT INTO public.notification_recipients (notification_id, user_id)
VALUES
  (10001, 'usr_artist_admin_01')
ON CONFLICT (notification_id, user_id) DO NOTHING;

SELECT setval(
  pg_get_serial_sequence('public.user_artist', 'id'),
  GREATEST((SELECT max(id) FROM public.user_artist), 1)
);

SELECT setval(
  pg_get_serial_sequence('public.notifications', 'id'),
  GREATEST((SELECT max(id) FROM public.notifications), 1)
);

SELECT setval(
  pg_get_serial_sequence('public.notification_user', 'id'),
  GREATEST((SELECT max(id) FROM public.notification_user), 1)
);
