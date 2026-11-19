-- v27: one shared project, owner-only shipping rules via service-role backend.
create table if not exists public.bow_shipping_settings (
 id integer primary key check (id = 1),
 small_max_units integer not null default 3 check (small_max_units >= 1),
 medium_max_units integer not null default 8 check (medium_max_units >= 2),
 small_cents integer not null default 995 check (small_cents >= 100),
 medium_cents integer not null default 1295 check (medium_cents >= 100),
 large_cents integer not null default 1695 check (large_cents >= 100),
 extra_step_units integer not null default 8 check (extra_step_units >= 1),
 extra_step_cents integer not null default 400 check (extra_step_cents >= 0),
 updated_at timestamptz not null default now(),
 constraint bow_shipping_settings_order check (medium_max_units > small_max_units and medium_cents >= small_cents and large_cents >= medium_cents)
);
alter table public.bow_shipping_settings enable row level security;
revoke all on public.bow_shipping_settings from anon, authenticated;
-- Do not overwrite rates if the migration is rerun.
insert into public.bow_shipping_settings (id) values (1) on conflict (id) do nothing;
