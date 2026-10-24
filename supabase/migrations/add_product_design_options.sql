-- Run once in the dedicated Bow Business Supabase project. Existing products remain unchanged.
alter table public.bow_products add column if not exists designs jsonb not null default '[]'::jsonb;
comment on column public.bow_products.designs is 'Named design choices with stable IDs and public Supabase Storage image URLs';
