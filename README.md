# Conma CMP — Google Consent Mode v2 (GTM Community Template)

Official Google Tag Manager template for **[Conma](https://conma.lat)**, a web Consent
Management Platform (CMP) compliant with **Google Consent Mode v2** (effective June 2026).

CMP Partner Program **Developer ID:** `dM2M5Yz`

## What it does

This tag sets the **default consent state** synchronously during GTM's *Consent
Initialization*, **before any Google tag fires**:

- **Geo-targeted defaults** via `setDefaultConsentState`:
  - **EEA/UK (32 regions):** strict opt-in — every purpose `denied` except `security_storage`.
  - **Global (LATAM / US / rest):** permissive opt-out — configurable via the template field.
- Covers all **7 Consent Mode v2 signals**: `ad_storage`, `analytics_storage`,
  `ad_user_data`, `ad_personalization`, `functionality_storage`,
  `personalization_storage`, `security_storage`.
- Restores a returning visitor's prior choice from `localStorage._cmp_consent`
  via `updateConsentState`.
- Registers Conma's CMP **Developer ID** (`dM2M5Yz`) with `gtagSet`.
- Uses `wait_for_update: 500` so Google tags wait for the banner's signal.

The consent **banner UI** is loaded by a separate Custom HTML tag — this template only
governs the consent state.

## Installation

1. In GTM, add this template from the Community Template Gallery.
2. Create a **Tag** from it. Set the trigger to **Consent Initialization - All Pages**
   and **Tag Priority to 999**.
3. (Optional) Adjust *Analytics outside EEA/UK* to `granted` (opt-out) or `denied` (opt-in).
4. Add the Conma banner via a separate Custom HTML tag.

## Configuration

| Field | Description | Default |
| --- | --- | --- |
| Analytics outside EEA/UK | Initial `analytics_storage` for non-EEA/UK users. In EEA/UK it is always `denied`. | `granted` |

## License

[Apache License 2.0](./LICENSE)
