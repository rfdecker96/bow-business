# Bow Business v9 — Supabase + Vercel migration

## Setup
1. Create a **new dedicated Supabase project** for Bow Business. Do not reuse Deploy Hatch or other existing projects.
2. Run `supabase/schema.sql` in its SQL Editor. This creates two RLS-enabled tables and a public-read `bow-images` storage bucket.
3. Copy `.env.example` to `.env` and set `SUPABASE_URL`, `SUPABASE_SECRET_KEY` (or legacy `SUPABASE_SERVICE_ROLE_KEY`), `ADMIN_USERNAME`, `ADMIN_PASSWORD`, `SESSION_SECRET`, and Stripe test settings. Never commit `.env` or expose the Supabase secret key in browser code.
4. `npm install` and `npm run dev`. Admin is `/admin.html`.
5. In Vercel select Framework Preset **Other**, Node 22, and the directory containing `package.json`. Set all environment variables in Vercel's project settings; `BASE_URL` must equal the deployed HTTPS origin. Set the Stripe webhook endpoint to `https://YOUR_DOMAIN/api/stripe-webhook` and listen for `checkout.session.completed`.
6. Confirm uploading, adding, editing, deleting, checkout and webhook delivery in **test mode** before enabling live payments.

## Migration of existing data
This package **does not automatically import your local `data/store.json` or existing `public/uploads`**. Back those up. Old product images must be uploaded to the `bow-images` bucket and product image URLs updated before importing product records. Order histories also require an explicit one-time import; don't overwrite live data. Contact us to run a controlled migration with your actual data.

## Security and hosting notes
Admin sessions are stateless signed HTTP-only cookies, with CSRF token and 8-hour expiry. Admin password is configured via environment variable. Set a strong password and secret. This is a minimal owner-login implementation, not multi-user Supabase Auth. No built-in distributed login rate limiting; configure Vercel firewall/rate limits before public production admin access. Supabase secret key remains server-only. Supabase Storage bucket is public-read for catalogue images, but no anonymous write policy exists. Stripe prices are computed server-side from tiers. Images and database persist across deployments.

The existing static storefront assets and both uploaded hero/collection images are retained. The server is also runnable locally without Vercel. Run `npm run check` to verify JavaScript syntax.
