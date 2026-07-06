# Verificación de cumplimiento — Conma CMP en GTM (Consent Mode v2)

> Reporte de verificación end-to-end del comportamiento de consentimiento de Conma sobre
> el dominio de prueba **metra.com.co** (contenedor `GTM-KR9BXBPG`, propiedad GA4 `G-4FK1NNK3H3`).
>
> **Fecha:** 2026-07-02
> **Verificado por:** equipo Conma
> **Alcance:** rama global/LATAM (opt-out permisivo) y rama EEA/UK (opt-in estricto GDPR).

---

## 1. Diseño verificado

Conma registra el estado por defecto con **dos** `setDefaultConsentState()` geo-diferenciados
(ver `packages/gtm/src/application/GtmTemplate.ts`):

| Rama | Regiones | ad_storage | analytics_storage | functionality | personalization | security | ad_user_data | ad_personalization |
|------|----------|-----------|-------------------|---------------|-----------------|----------|--------------|--------------------|
| **EEA/UK** (`region: EEA_REGIONS`) | 32 países (27 UE + IS, LI, NO + GB, CH) | denied | **denied** | denied | denied | granted | denied | denied |
| **Global/LATAM** (sin `region`) | resto del mundo | denied | **granted** | granted | denied | granted | denied | denied |

Ambas ramas incluyen `wait_for_update: 500`. Los 7 parámetros de GCM v2 (junio 2026) están presentes.
`ad_*` siempre `denied` por defecto en **todas** las regiones (opt-in explícito para marketing).

---

## 2. Rama Global / LATAM — verificado ✅

Navegación desde Colombia (sin VPN). Vista previa de GTM:

- Evento "Valor predeterminado" con `region` EEA → aparece en `-` (no aplica fuera de EEA). Correcto.
- Evento "Valor predeterminado" global → `analytics_storage: Concedido`, `functionality_storage: Concedido`,
  `security_storage: Concedido`, resto `Denegado`. Coincide con el diseño.
- Al aceptar todo en el banner → `gtag('consent','update')` pone los 7 parámetros en `Concedido`.

**Resultado:** rama permisiva LATAM funciona según diseño. Legalmente válida en Colombia (Ley 1581,
sin exigencia de opt-in previo para analítica).

---

## 3. Rama EEA/UK — verificado ✅

Navegación con **VPN de salida en la UE**.

### 3.1 Consent default (Console) ✅

`window.dataLayer.filter(x => Array.isArray(x) && x[0]==="consent" && x[1]==="default")` devuelve:

```js
{
  ad_storage:             "denied",
  ad_user_data:           "denied",
  ad_personalization:     "denied",
  analytics_storage:      "denied",   // ← rama estricta activa (vs "granted" en LATAM)
  functionality_storage:  "denied",
  personalization_storage:"denied",
  security_storage:       "granted",
  wait_for_update:        500
}
```

Todo denegado salvo `security_storage`. Opt-in estricto GDPR confirmado. El geo-targeting de
`region: EEA_REGIONS` funciona en producción.

### 3.2 GA4 dispara en modo cookieless conforme (Network) ✅

Hit a `.../collect?v=2&tid=G-4FK1NNK3H3`:

| Parámetro | Valor | Significado |
|-----------|-------|-------------|
| `gcs` | **G100** | Consent Mode activo · ad_storage **denegado** · analytics_storage **denegado** |
| `npa` | 1 | Non-Personalized Ads (consecuencia de ads denegado) |
| `dma` | 1 | Señal Digital Markets Act (obligatoria en EEA) |
| `dma_cps` | `-` | Sin consentimiento basado en cookies pasado |
| `gcd` | 13p3p3p2p5l1 | Estado default detallado (denegado por defecto) |

Es un **cookieless ping**: medición agregada/modelada sin identificador persistente. Comportamiento
conforme al RGPD bajo advanced consent mode.

### 3.3 Cookies — sin cookies de analítica antes de consentir ✅

Test en limpio (Clear site data → VPN EU → recarga en frío → **sin interactuar con el banner**):

**Application → Cookies → metra.com.co: vacío.** Cero cookies, ninguna `_ga` / `_ga_*`.

La cookie `_ga_4FK1NNK3H3` observada en la primera pasada era **contaminación del test LATAM previo**
(contador de sesión `o2` = 2ª sesión; la 1ª fue la navegación desde Colombia con analítica concedida,
sin limpiar almacenamiento entre pruebas). Confirmado: bajo `analytics_storage: denied` en la EEA,
Conma **no escribe ningún identificador persistente** antes del consentimiento.

---

## 4. Resumen

| Verificación | LATAM | EEA |
|--------------|:-----:|:---:|
| Geo-targeting `region` | ✅ | ✅ |
| Default correcto (7 params + wait_for_update) | ✅ | ✅ |
| Update tras aceptar → todo concedido | ✅ | — |
| GA4 `gcs` acorde al consentimiento | ✅ | ✅ (G100) |
| Señales DMA (`dma=1`) | n/a | ✅ |
| Sin cookies de analítica antes de consentir | n/a | ✅ |

**Estado:** ambas ramas (LATAM y EEA) verificadas y conformes. El CMP de Conma configura el estado
por defecto según la región, notifica correctamente el rechazo a Google (`gcs=G100` + señales DMA en
EEA) y no escribe identificadores persistentes antes del consentimiento. Sin hallazgos abiertos.
