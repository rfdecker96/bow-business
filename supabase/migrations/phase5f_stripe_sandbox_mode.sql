-- v24: additive, shared-Supabase Stripe test/live isolation.
-- Existing orders are live by default. Apply BEFORE deploying v24 code.
alter table public.bow_orders add column if not exists payment_mode text not null default 'live';
alter table public.bow_orders drop constraint if exists bow_orders_payment_mode_check;
alter table public.bow_orders add constraint bow_orders_payment_mode_check check (payment_mode in ('live','test'));
create index if not exists bow_orders_payment_mode_created_idx on public.bow_orders(payment_mode,created_at desc);
-- Existing grants and RLS unchanged. Only the server-side Supabase client writes orders.
