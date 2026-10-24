# Bow Business Phase 3E v19 — Mobile Performance & SEO

## Scope
- Mobile navigation with toggle, Escape dismissal, and keyboard focus styles.
- Lazy decoding/loading for offscreen static images and product thumbnails, high-priority hero image, reduced-motion support.
- Search description, Open Graph metadata, canonical link and product-aware browser title/meta when JavaScript runs.
- robots.txt to discourage indexing admin and API routes.
- No database migration, pricing changes, Stripe changes, or product mutations.
- Includes v18a About Us hotfix.

## SEO limitations
This remains a client-rendered single-page storefront. Some crawlers do not execute JavaScript, so product-specific title/meta are not guaranteed to be indexed. Full product indexing needs server-rendered product URLs and sitemap after a canonical production domain is confirmed. Relative OG image URL may not be accepted by every social preview service; absolute production URLs are recommended once the domain is known.

## Manual verification
- At narrow mobile width, open and close the menu, follow anchors, test keyboard focus and Escape.
- Verify product photos, design options, mix-and-match pricing and checkout.
- Open a shared `?product=...` link and confirm details load and URL is preserved.
- Run Lighthouse on the deployed site before/after; this build does not claim measured speed gains.
