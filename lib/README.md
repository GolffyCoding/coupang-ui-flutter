# Coupang UI V5 — Clean Architecture (UI Preserved)

This version is a **refactor of the supplied source**, not a redesign.
The original UI implementations, dimensions, colors, Korean labels, image URLs,
product data, review UI, product detail tabs, sticky tab bar, quantity selector,
and bottom action bar are preserved from the supplied source.

Source basis: the original file is a 3,714-line Flutter app containing Home,
Product Detail, shared widgets, product/review models and app bootstrap.

## Architecture

lib/
- app/ — application bootstrap
- core/ — theme and reusable UI primitives
- features/home/ — Home presentation + controller/use case
- features/product/ — product domain, demo data and product presentation

## Important rule

Do not rewrite the UI while migrating architecture. Move code first, then refactor
logic behind the same widgets. The current Home and Product Detail screens should
look the same as the supplied source.

## What changed architecturally

- `CpColors` / `CpText` -> `core/theme/cp_theme.dart`
- Shared widgets -> `core/widgets/coupang_widgets.dart`
- `Product` -> product domain entity
- `Review` -> product domain entity
- Home demo products -> data repository
- Home product access -> `GetHomeProducts` + `HomeController`
- Home UI -> home presentation
- Product Detail UI -> product presentation
- App bootstrap -> `app/app.dart`
- `main()` -> `main.dart`

## UI fidelity

No placeholder Home/Product Detail was introduced. The provided UI code is retained.
