# Bow Business v22: Phase 5B + 5C

## Before deploying
Run `supabase/migrations/phase5b_5c_product_merchandising.sql` in the dedicated Bow Business Supabase SQL Editor. Additive changes only. Do not apply to unrelated Supabase projects.

## Features
- Admin product editor: measured size information, featured toggle, seasonal collection name.
- Storefront: size shown on product cards/details; featured-first default sort; Featured and named seasonal collection filters.
- Seasonal collections are generated from active products with matching collection names. No additional collection table or admin screen.
- No pricing, Stripe, stock, gift, or production workflow changes.

## Verification gate
1. Run SQL migration and confirm three new columns.
2. Edit an existing product: set a real measured size, feature it, and assign `Fall Favorites`. Save and refresh admin.
3. Confirm storefront displays size, Featured filter, Fall Favorites filter, and featured-first default sort.
4. Hide that product and confirm it disappears from storefront collections.
5. Test existing product design and attachment selections, and a Stripe test checkout before production promotion.

The latest v21 catalogue JavaScript hotfix is retained in this build.
