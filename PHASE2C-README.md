# Bow Business v16 — Phase 2C

Adds optional internal production notes and design photos to the admin order list and printable production sheet. Notes are not sent to customers.

## Installation
1. Back up your existing project and extract the hotfix over the project root. Do not replace .env.
2. Run `supabase/migrations/phase2c_production_notes.sql` in your dedicated Bow Business Supabase SQL editor.
3. Deploy to Vercel. Existing paid orders remain unchanged.
4. Test with a Stripe test-mode order, add notes, save, refresh, print and verify the design, quantity, notes and shipping address.

New orders snapshot the design photo at checkout. Older orders attempt to use the current product photo, which may be missing or changed if the catalogue has been edited. Existing order records are not backfilled.

No customer notes form or email automation is added in this phase.
