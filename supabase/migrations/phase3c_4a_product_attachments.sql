-- Bow Business v20: optional per-product attachment choices.
-- Existing products retain no required attachment selection until configured by an owner.
alter table public.bow_products add column if not exists attachments jsonb not null default '[]'::jsonb;
-- Enforce only supported styles; no inventory or pricing changes.
alter table public.bow_products drop constraint if exists bow_products_attachments_valid;
alter table public.bow_products add constraint bow_products_attachments_valid check (jsonb_typeof(attachments)='array' and attachments <@ '["clip","headband"]'::jsonb and jsonb_array_length(attachments)<=2);
