# Bow Business v17 — Phase 3A

Adds a responsive product detail dialog with product image gallery (existing product photo and individual design images), design selection, quantity, add to bag, and shareable `?product=<id>#shop` URLs. No database changes or backend pricing changes.

The product link opens the selected product on the storefront, not a separate server-rendered URL. This is not yet product-specific server-side SEO. Only existing images are displayed; additional photo uploads per design require a future schema change.

## Install
Extract the hotfix over your v16 project. Run `node --check public/app.js`. Commit and push `public/index.html`, `public/app.js`, and `public/style.css`.

## Certification
1. Open View details & photos for a product with multiple designs. Switch designs and confirm main image changes.
2. Add quantities of two different designs to the bag and verify separate cart lines.
3. Check Everyday Cuties two-for-$5 pricing at checkout.
4. Copy product link and open in a private browser. Check back/forward navigation and mobile display.
5. Test Stripe in test mode; live payment not certified here.
