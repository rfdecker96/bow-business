# Bow Business v27 — parcel-based shipping + payment reconciliation

1. Back up your existing Supabase database. Run `supabase/migrations/phase5g_shipping_settings.sql` in your existing project's SQL Editor before deployment. No second project.
2. Extract the hotfix at the project root, preserving all existing files and environment variables.
3. Commit and push `server.js`, `public/admin.js`, `public/admin.html`, the migration and this README to your existing production Vercel project.
4. In the admin dashboard, open Shipping settings. Starting rates: $9.95 small (1-3 packing points), $12.95 medium (4-8), $16.95 large (9-16), plus $4 for each further 8 points. All configurable.
5. Packing points are rough volume estimates, NOT weight or USPS quotes: baby=1, everyday=1, cutie=2, beautiful=3, extra=4. Quantities multiply points. Validate real packaging sizes and costs with Pirate Ship. No automatic Pirate Ship rate API is integrated. Domestic US only, as before.
6. Existing `SHIPPING_RATE_USD` ($5 default) is used only if the shipping settings table/row is unavailable. Check server logs if fallback occurs.
7. Both public live checkout and owner-only sandbox checkout calculate shipping server-side. Stripe Checkout displays the calculated fixed shipping line. Old sessions retain their original shipping price.
8. Webhooks now retrieve the authoritative Checkout Session from Stripe and only mark a matching order paid after confirming `payment_status=paid`. Handles repeated delivery idempotently, and accepts `checkout.session.completed` and `checkout.session.async_payment_succeeded` (also their `v1.`-prefixed variants). Requires Checkout Sessions READ permission on restricted API keys (`rk_live_` / `rk_test_`).
9. In Stripe Sandbox, resend the previously failed/completed `checkout.session.completed` event for order `75c8fcfb-462e-4bcd-acee-07f7f452e59d`. Verify order changes to paid and address/email are populated. Do not manually mark paid or create another test purchase until verified.
10. Validate live checkout session creation separately WITHOUT making a real charge. Verify admin test orders never enter live fulfillment.

Security: the settings table has RLS enabled, no anon/authenticated privileges; only server-side service-role credentials access it. Never expose Stripe/Supabase secrets.

IMPORTANT: shipping rates are proposed customer-facing charges, not guaranteed USPS/Pirate Ship postage or profit. Rates vary by distance, season, dimensions and weight.
