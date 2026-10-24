-- Phase 2C: non-destructive internal production notes. Run in Bow Business project only.
alter table public.bow_orders add column if not exists production_notes text not null default '';
-- Preserve existing RLS and grants; notes are returned only through the authenticated admin API.
