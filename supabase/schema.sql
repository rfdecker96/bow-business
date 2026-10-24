-- Run in a NEW, dedicated Bow Business Supabase project, not an existing app database.
create table if not exists public.bow_products (
 id uuid primary key default gen_random_uuid(),
 name text not null check(length(name) between 1 and 90),
 tier text not null check(tier in ('baby','cutie','beautiful','extra','everyday')),
 description text not null default '' check(length(description)<=500),
 image text not null,
 active boolean not null default true,
 created_at timestamptz not null default now()
);
create table if not exists public.bow_orders (
 id uuid primary key default gen_random_uuid(),
 session_id text not null unique,
 status text not null default 'pending',
 items jsonb not null default '[]'::jsonb,
 email text not null default '',
 shipping jsonb,
 paid_at timestamptz,
 created_at timestamptz not null default now()
);
alter table public.bow_products enable row level security;
alter table public.bow_orders enable row level security;
-- No browser/client policies. Server-side secret key only.
revoke all on public.bow_products from anon, authenticated;
revoke all on public.bow_orders from anon, authenticated;
insert into storage.buckets (id,name,public,file_size_limit,allowed_mime_types)
values ('bow-images','bow-images',true,5242880,array['image/jpeg','image/png','image/webp'])
on conflict (id) do update set public=true,file_size_limit=5242880,allowed_mime_types=array['image/jpeg','image/png','image/webp'];
-- Public read access only. Server secret key performs writes.
