# Bow Business v26 — Restricted Stripe API key compatibility

This is a minimal overlay on top of v25. It updates only `server.js` and does not alter the webhook handlers, checkout flow, Supabase tables, admin UI, or product pricing.

## Supported Stripe API keys

- `STRIPE_SECRET_KEY`: `sk_live_...` or `rk_live_...` (production public checkout)
- `STRIPE_TEST_SECRET_KEY`: `sk_test_...` or `rk_test_...` (admin-only sandbox checkout)
- `STRIPE_WEBHOOK_SECRET`: live webhook signing secret `whsec_...`
- `STRIPE_TEST_WEBHOOK_SECRET`: sandbox webhook signing secret `whsec_...`

The `rk_` keys are restricted API keys. Stripe still enforces their actual permissions. For this checkout implementation, grant **write** permission for Checkout Sessions and any other permissions Stripe indicates are necessary for `stripe.checkout.sessions.create` with inline price data, shipping options, and payment processing. Prefer least privilege; do not grant broad permissions without evidence. The key must belong to the corresponding live/test environment.

## Installation

1. Ensure the v25 overlay is already deployed. Back up `server.js`.
2. Copy this ZIP's `server.js` into the project root. No SQL migration is needed.
3. Keep your existing live `rk_live_...` key in `STRIPE_SECRET_KEY` if it has sufficient permissions. Configure `STRIPE_TEST_SECRET_KEY` with a sandbox `rk_test_...` or `sk_test_...` key.
4. Keep the two distinct webhook signing secrets (`whsec_...`). Do not put an `rk_` key in a webhook-secret variable.
5. Push and redeploy production. Test sandbox checkout from the admin dashboard, then confirm live checkout remains enabled without submitting a real payment.

**Note:** This patch does not grant Stripe permissions or validate keys against Stripe's servers. If checkout fails with a Stripe permission error, inspect Stripe's error and adjust the restricted key permissions in the Stripe Dashboard. Never paste secret key values into chat.
