# Bow Business v28 — Stripe thin event reconciliation fix

Fixes the confirmed HTTP 400 `Missing checkout session` for Stripe's `v2.core.event` notification (`v1.checkout.session.completed`). Unlike snapshot events, thin events carry the Checkout Session reference in `related_object.id`. The handler now supports both payload formats. If the reference is omitted, it retrieves the authoritative v2 event through the Stripe SDK, then retrieves the Checkout Session and verifies payment before updating the existing Supabase order.

## Install
Extract this overlay at the existing Bow Business project root, replacing only `server.js`. No SQL migration, no environment variable changes, no shipping rate changes. Deploy to your existing production Vercel site. Keep v27's other files installed.

## Verify
In Stripe Sandbox, resend the *existing* `v1.checkout.session.completed` event for Checkout Session `cs_test_a0f22JrgShVdX0Zk9Xhm1iiHd5ipopiSVBtIbgcAXe8EAV26IhgdgGWdIj`. Expect HTTP 200 with `reconciled:true` or `alreadyPaid:true`. Then query the matching Supabase order and confirm `status='paid'`, `paid_at` set, `payment_mode='test'`. Do not create a new payment or manually mark an order paid.

If Stripe returns 503 about SDK thin event support, update the `stripe` npm dependency to a current version that supports `stripe.v2.core.events.retrieve`, redeploy, and retry. Restricted test keys need Checkout Sessions read permission and, only for the fallback path, Events v2 read permission.

If you see a different error, retain the HTTP status/response and Vercel function logs (redact secrets) for targeted diagnosis.

This patch was syntax-checked, but no live Stripe event was replayed in this environment.
