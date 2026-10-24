# Bow Business v20 — Phase 3C + 4A

## Install
1. Extract hotfix over v19 (preserve local .env).
2. Run `supabase/migrations/phase3c_4a_product_attachments.sql` in the dedicated Bow Business Supabase project.
3. Deploy changed files to Vercel.

## Changes
- Collection sorting by newest, price ascending/descending, and name. Featured retains existing catalog order.
- Admin per-product clip/headband checkboxes. Both are optional; old products remain unchanged.
- Required attachment selection for configured products in storefront and product detail view.
- Cart lines, Stripe Checkout item names, order snapshots, owner production list and print sheets carry attachment selection.
- Server validates selections against stored allowed options; attachment choice does not alter price.
- No emails, stock management, or invented attachment availability.

## Manual certification
- Apply migration before deploying app; configure a test product with both attachments.
- Select one design with clip and the same design with headband: two distinct bag lines.
- Confirm both appear correctly in Stripe test Checkout and in paid order production sheet.
- Verify server rejects unlisted attachment and preserves mix-and-match discounts.
- Confirm legacy product with no configured attachments can still be purchased.
- Check newest and price sorting on mobile and desktop.

JavaScript syntax check is not a live payment certification.
