# Bow Business v21 — Phase 4B + 4C

## What's included
- Visual Everyday Cuties bundle builder. Shares existing design and attachment selections, cart, and server-side $3 each / 2 for $5 pricing. No additional discount stacking.
- Optional gift-order flag and gift message (up to 300 characters) shown in admin orders and printable production sheets.
- No gift-wrap option, surcharge, or packaging guarantee. This requires a separately approved business offering.
- No automated emails, inventory tracking, or changes to existing products.

## Installation
1. Extract the hotfix over v20.
2. Run `supabase/migrations/phase4b_4c_gift_orders.sql` in the Bow Business Supabase SQL Editor BEFORE deploying.
3. Commit and deploy changed files to Vercel.
4. Use Stripe test mode: add two different Everyday Cuties designs with different attachments, confirm $5 before shipping, mark as gift and add a note. Verify selected designs, attachments and gift message in the admin order and printed sheet.

## Validation
Static JavaScript syntax checks only; Supabase migration, real browser, Vercel and Stripe tests remain to be performed.
