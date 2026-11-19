# Bow Business v25 — same Vercel production + same Supabase, two Stripe modes

## Safety model
- Public `/api/create-checkout-session` uses `STRIPE_SECRET_KEY` (sk_live_) only.
- Private `/api/admin/sandbox-checkout` requires existing admin cookie and CSRF, uses `STRIPE_TEST_SECRET_KEY` (sk_test_) only.
- Admin dashboard has a private test purchase control; it selects the first design/attachment for the chosen product.
- Live webhook: `/api/stripe-webhook` with `STRIPE_WEBHOOK_SECRET`.
- Test webhook: `/api/stripe-test-webhook` with `STRIPE_TEST_WEBHOOK_SECRET`.
- Both webhook handlers enforce signature, event livemode, metadata payment_mode, and matching DB payment_mode.
- Sandbox orders are excluded from production work queues and cannot be marked as in production.

## Deployment
1. Ensure v24 migration `phase5f_stripe_sandbox_mode.sql` is applied to the EXISTING Supabase project. No new migration for v25.
2. Apply this overlay to the project root. Keep your existing `.env` and Supabase project.
3. In Vercel **Production** environment configure:
   STRIPE_SECRET_KEY=sk_live_... (existing)
   STRIPE_WEBHOOK_SECRET=whsec_... (existing live endpoint)
   STRIPE_TEST_SECRET_KEY=sk_test_... (new sandbox)
   STRIPE_TEST_WEBHOOK_SECRET=whsec_... (new sandbox webhook)
   SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY unchanged.
4. Create Stripe **sandbox** event destination at https://YOUR-PRODUCTION-DOMAIN/api/stripe-test-webhook; subscribe to checkout.session.completed.
5. Keep existing **live** Stripe webhook at https://YOUR-PRODUCTION-DOMAIN/api/stripe-webhook.
6. Redeploy production. Sign into `/admin.html`, find Private Stripe Sandbox Checkout, choose a product, and click Create test checkout.
7. Complete checkout using Stripe test card 4242 4242 4242 4242 (future expiration, any CVC). Check admin Test Orders filter.

## Important
- Do not set `STRIPE_SECRET_KEY` to sk_test_ or replace the live webhook secret.
- Legacy `STRIPE_PAYMENT_MODE` is ignored by v25; remove it after confirming deployment if desired.
- The public checkout is intentionally **disabled** if live keys/webhook are absent, even if test keys exist.
- Admin sessions expire after 8 hours. Only trusted admins should be given admin access.
- No production data was modified by packaging this hotfix. Stripe and live Supabase were not contacted or tested.
