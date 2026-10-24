-- Bow Business Phase 2A: additive, non-destructive production workflow.
-- Run only in the dedicated Bow Business Supabase project.
alter table public.bow_orders add column if not exists production_status text not null default 'to_make';
alter table public.bow_orders add column if not exists production_updated_at timestamptz;
alter table public.bow_orders add column if not exists tracking_number text not null default '';
alter table public.bow_orders drop constraint if exists bow_orders_production_status_check;
alter table public.bow_orders add constraint bow_orders_production_status_check check (production_status in ('to_make','making','ready_to_ship','shipped'));
create index if not exists bow_orders_production_queue_idx on public.bow_orders (production_status,created_at desc) where status='paid';
-- Existing RLS and grants remain unchanged; server-side credentials only.
