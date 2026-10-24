-- Phase 5B + 5C. Additive, preserves all existing products and orders.
alter table public.bow_products add column if not exists size_info text not null default '';
alter table public.bow_products add column if not exists featured boolean not null default false;
alter table public.bow_products add column if not exists seasonal_collection text not null default '';
alter table public.bow_products drop constraint if exists bow_products_size_info_length;
alter table public.bow_products add constraint bow_products_size_info_length check (char_length(size_info) <= 160);
alter table public.bow_products drop constraint if exists bow_products_seasonal_collection_length;
alter table public.bow_products add constraint bow_products_seasonal_collection_length check (char_length(seasonal_collection) <= 50);
create index if not exists bow_products_featured_idx on public.bow_products(featured) where featured = true;
