# Bow Business v24 — Stripe Sandbox compatibility

**One Supabase project.** Live and test orders are distinguished by `payment_mode`.

## Order of operations
1. Back up Supabase. Run `supabase/migrations/phase5f_stripe_sandbox_mode.sql` on the Bow Business project **before** deploying code. Existing orders default to `live`.
2. In Vercel **Production**, set `STRIPE_PAYMENT_MODE=live`, keep existing `sk_live_...` key and live webhook signing secret. Redeploy production. If you currently use Stripe test keys in production, do NOT set live until actual live credentials are configured.
3. In a separate Vercel **Preview** deployment, set `STRIPE_PAYMENT_MODE=test`, `STRIPE_SECRET_KEY=sk_test_...`, its **own** sandbox `STRIPE_WEBHOOK_SECRET=whsec_...`, and the same Supabase credentials as production. Set `BASE_URL` to the exact stable preview URL.
4. Register the preview URL `/api/stripe-webhook` in the Stripe sandbox. Register the live domain webhook separately in live Stripe.
5. Test `/api/config`, test checkout, paid webhook, admin Test Orders filter, and ensure sandbox orders cannot be moved to production. Check live checkout after redeploy.

## Safeguards
- Checkout disabled unless explicit payment mode, matching Stripe key prefix, Supabase and webhook secret are configured.
- Stripe webhook signature + event livemode + session livemode checked.
- Webhook updates only matching mode and pending session; duplicate events do not reapply mutations.
- Sandbox orders excluded from default production queue and cannot be updated through production endpoint.
- No automated emails, stock tracking, or new Supabase project.

## Caveats
- The shared database still holds test customer information: use fictitious test details.
- Do not connect sandbox to live shipping or fulfillment automations.
- Stripe CLI webhook secrets and dashboard endpoint secrets differ; use the secret for each actual endpoint.
- This hotfix does not certify the live checkout, asynchronous payment methods, or all failure recovery paths.
