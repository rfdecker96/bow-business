# Bow Business v15 — Phase 2A + 2B

Adds a production queue and editable production stages for paid orders. **Does not track inventory.** Existing orders and products remain intact.

1. Back up the dedicated Bow Business Supabase database. Run `supabase/migrations/phase2_production_orders.sql` in its SQL editor.
2. Deploy updated files to Vercel. Keep existing secret environment variables.
3. Open `/admin.html`, sign in, and view the new Production orders panel.
4. Verify that pending checkouts cannot be moved into production; paid orders can move through To make, Making, Ready to ship, Shipped. Test print sheet and tracking field.
5. Verify Stripe webhook marks a test order paid and that its selected design names are present.

This release does not send emails or modify Stripe webhook behavior. Live end-to-end verification is required before production use.
