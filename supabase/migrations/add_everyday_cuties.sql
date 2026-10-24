-- Run once in the Bow Business Supabase SQL Editor for existing installations.
ALTER TABLE public.bow_products DROP CONSTRAINT IF EXISTS bow_products_tier_check;
ALTER TABLE public.bow_products ADD CONSTRAINT bow_products_tier_check CHECK (tier IN ('baby','cutie','beautiful','extra','everyday'));
