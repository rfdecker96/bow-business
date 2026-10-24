-- Phase 4C: optional gift message stored on the order, never as a paid option.
-- Apply to the Bow Business Supabase project before deploying v21.
alter table public.bow_orders add column if not exists is_gift boolean not null default false;
alter table public.bow_orders add column if not exists gift_message text not null default '';
alter table public.bow_orders drop constraint if exists bow_orders_gift_message_length;
alter table public.bow_orders add constraint bow_orders_gift_message_length check (char_length(gift_message)<=300);
