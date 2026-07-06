# Guion narrado — Video de Audit (CMP Partner Program)

> Guion palabra por palabra para la grabación del video de **S24-22**.
> Complementa a `cmp-audit-video-checklist.md` (ese es el checklist técnico; este es lo que se dice y se muestra).
>
> **Cómo usarlo:** graba narrando el bloque `ES` (o léelo de base) y usa el bloque `EN` como
> subtítulos / voz en inglés. Google revisa en inglés → los subtítulos EN son **obligatorios**.
>
> **Duración objetivo:** 5–8 min. Ritmo pausado, sin prisa al mostrar la consola.
> **Tip:** graba cada escena por separado y únelas; es más fácil corregir un tramo que rehacer todo.
>
> **⚠️ Región de grabación (importante):** graba con **VPN de salida en la Unión Europea**. Conma
> aplica defaults geo-diferenciados: en la UE todos los purposes arrancan en `denied` (opt-in GDPR),
> pero fuera de la UE (p. ej. Colombia) `analytics_storage` y `functionality_storage` arrancan en
> `granted` (opt-out permisivo, válido bajo Ley 1581). Este guion narra la vista **todo `denied`**,
> que es la más sólida para el revisor de Google — y **solo se ve grabando desde la UE**. La
> verificación end-to-end de ambas ramas (con evidencia de dataLayer, Network y cookies) está en
> `cmp-gtm-compliance-verification.md`.

---

## Escena 0 — Intro (⏱ ~0:20 · 🎬 logo Conma o pantalla del portal)

> 🗣️ **ES:** "Hola. Soy [nombre], de Conma. Conma es una Consent Management Platform web
> compatible con Google Consent Mode v2. En este video muestro, de principio a fin, cómo el
> banner de Conma configura el estado de consentimiento por defecto, cómo lo actualiza según la
> elección del usuario, y cómo se refleja en Google Consent Mode, tanto por gtag como por GTM."

> 🗣️ **EN:** "Hi. I'm [name], from Conma. Conma is a web Consent Management Platform compliant
> with Google Consent Mode v2. In this video I'll show, end to end, how the Conma banner sets the
> default consent state, how it updates it based on the user's choice, and how that is reflected in
> Google Consent Mode — both via gtag and via GTM."

---

## Escena A — Consola del CMP (⏱ ~1:00 · 🎬 `app.conma.lat` logueado)

> 🎬 Mostrar: dominio configurado → configurador del banner → dónde se copia el snippet.

> 🗣️ **ES:** "Esta es la consola de Conma. Aquí, el dueño del sitio registra su dominio y
> configura el banner de consentimiento: textos, categorías y apariencia. Una vez configurado,
> Conma genera el snippet de instalación. El sitio puede instalarlo de dos formas: directamente
> en el `<head>` con gtag, o a través de Google Tag Manager. Vamos a validar ambas."

> 🗣️ **EN:** "This is the Conma console. Here the website owner registers their domain and
> configures the consent banner: copy, categories and appearance. Once configured, Conma generates
> the installation snippet. The site can install it in two ways: directly in the `<head>` using
> gtag, or through Google Tag Manager. We'll validate both."

---

## Escena B — Validación web vía gtag (⏱ ~1:30 · 🎬 página de prueba + DevTools Console)

> 🎬 Antes de grabar: **VPN de salida en la UE activa**, luego `Clear site data` (Application →
> Storage) y recargar (banner y dataLayer desde cero).

> 🗣️ **ES:** "Abro una página con el snippet de Conma instalado directamente en el `<head>`.
> Aparece el banner. Antes de tocar nada, abro la consola del navegador y reviso el dataLayer.
> Aquí está el **consent default**: una entrada `default` con los siete parámetros de Consent Mode v2.
> Todos están en `denied` —salvo `security_storage`— y esto ocurre **antes** del primer `page_view`:
> ningún tag de Google dispara con consentimiento hasta que el usuario decide."

> 🗣️ **EN:** "I open a page with the Conma snippet installed directly in the `<head>`. The banner
> appears. Before interacting, I open the browser console and inspect the dataLayer. Here is the
> **consent default**: one `default` entry with the seven Consent Mode v2 parameters. All are set to
> `denied` —except `security_storage`— and this happens **before** the first `page_view`: no Google
> tag fires with consent until the user decides."

> 🎬 Mostrar Developer ID (comando 1 del checklist).

> 🗣️ **ES:** "También confirmo el Developer ID de Conma en el dataLayer:
> `set developer_id.dM2M5Yz true`. Está presente en cada carga."

> 🗣️ **EN:** "I also confirm Conma's Developer ID in the dataLayer:
> `set developer_id.dM2M5Yz true`. It's present on every load."

> 🎬 Clic en **Aceptar** en el banner → mostrar `consent update` (comando 3).

> 🗣️ **ES:** "Ahora acepto en el banner. Se dispara un `consent update` con los cuatro parámetros
> en `granted`: `ad_storage`, `analytics_storage`, `ad_user_data` y `ad_personalization`. El
> consentimiento del usuario se propagó a Google Consent Mode."

> 🗣️ **EN:** "Now I accept in the banner. A `consent update` fires with the four parameters set to
> `granted`: `ad_storage`, `analytics_storage`, `ad_user_data` and `ad_personalization`. The user's
> consent has propagated to Google Consent Mode."

---

## Escena C — Validación web vía GTM (⏱ ~1:30 · 🎬 `metra.com.co` + Tag Assistant)

> 🎬 Tag Assistant conectado (https://tagassistant.google.com). Estado limpio.

> 🗣️ **ES:** "Ahora la misma validación pero a través de Google Tag Manager. Conecto Tag Assistant
> a `metra.com.co`, donde el banner de Conma está desplegado vía GTM. En el estado de Consent Mode
> veo primero el `default` con todo en `denied`."

> 🗣️ **EN:** "Now the same validation but through Google Tag Manager. I connect Tag Assistant to
> `metra.com.co`, where the Conma banner is deployed via GTM. In the Consent Mode state I first see
> the `default` with everything set to `denied`."

> 🎬 Aceptar el banner → Tag Assistant muestra el `update`.

> 🗣️ **ES:** "Acepto el banner y Tag Assistant registra la transición: el estado pasa a `update`
> con los cuatro purposes en `granted`. El Developer ID `dM2M5Yz` también está presente en esta
> vía. El comportamiento por gtag y por GTM es idéntico."

> 🗣️ **EN:** "I accept the banner and Tag Assistant records the transition: the state moves to
> `update` with all four purposes set to `granted`. The `dM2M5Yz` Developer ID is present here too.
> The behavior via gtag and via GTM is identical."

---

## Escena D — Prueba del `gcs` y señales DMA (⏱ ~1:00 · 🎬 DevTools Network, filtro `collect`) · opcional pero muy convincente

> 🗣️ **ES:** "Como prueba adicional, en la pestaña Network filtro las peticiones `collect`. Con el
> consentimiento rechazado, el parámetro `gcs` viaja como `G100`: un ping anónimo, sin
> identificadores. Como grabo desde la Unión Europea, la petición también incluye las señales de la
> Digital Markets Act: `dma=1`, `npa=1` —anuncios no personalizados— y `dma_cps` en guion, es decir,
> ningún consentimiento por cookies. Al aceptar, la siguiente petición muestra `gcs=G111`: medición
> completa. Esto confirma que Consent Mode gobierna de verdad el comportamiento de las etiquetas de Google."

> 🗣️ **EN:** "As an additional proof, in the Network tab I filter `collect` requests. With consent
> denied, the `gcs` parameter is sent as `G100`: an anonymous, cookieless ping. Since I'm recording
> from the European Union, the request also carries the Digital Markets Act signals: `dma=1`,
> `npa=1` —non-personalized ads— and `dma_cps` as a dash, meaning no cookie-based consent. After
> accepting, the next request shows `gcs=G111`: full measurement. This confirms Consent Mode is
> genuinely governing how Google tags behave."

> 🎬 Cambiar a **Application → Cookies → dominio**. El panel está **vacío** (sin `_ga` / `_ga_*`).

> 🗣️ **ES:** "Y la prueba definitiva: en Application, la lista de cookies del sitio está vacía. Con
> el consentimiento rechazado, Conma no escribe ninguna cookie de analítica ni identificador
> persistente antes de que el usuario decida."

> 🗣️ **EN:** "And the definitive proof: under Application, the site's cookie list is empty. With
> consent denied, Conma writes no analytics cookie and no persistent identifier before the user decides."

---

## Escena E — Cierre (⏱ ~0:25 · 🎬 pantalla del portal o logo)

> 🗣️ **ES:** "En resumen: Conma establece el estado de consentimiento por defecto en `denied`,
> lo actualiza según la elección del usuario, cubre los cuatro purposes de Consent Mode v2 y funciona
> igual por gtag y por GTM, con el Developer ID `dM2M5Yz`. Conma es una CMP exclusivamente web, por lo
> que la validación de apps móviles Android e iOS no aplica. Gracias."

> 🗣️ **EN:** "To summarize: Conma sets the default consent state to `denied`, updates it based on
> the user's choice, covers all four Consent Mode v2 purposes, and behaves identically via gtag and
> via GTM, with Developer ID `dM2M5Yz`. Conma is a web-only CMP, so mobile app validation for Android
> and iOS is not applicable. Thank you."

---

## Anexo — Guion de comandos de consola (secuencia default → aceptar → update)

> Este es el **paso a paso exacto** para grabar la validación en DevTools → pestaña **Console**.
> Está pensado para la implementación **vía GTM** (Escena C, `metra.com.co`), pero los mismos
> comandos sirven igual para la vía gtag (Escena B). Copia y pega cada comando en el orden indicado.
>
> **Antes de empezar:** activa la **VPN de salida en la UE**, abre la página en **Incógnito** con
> DevTools ya abierto (Console), zoom al 100–110 %. Así el banner aparece desde cero, el dataLayer
> arranca limpio y el default se muestra con todos los purposes en `denied` (ver ⚠️ nota de región arriba).

### Paso 1 — Estado inicial (banner visible, sin tocar nada)

Con el banner en pantalla y **antes** de hacer clic, muestra el `consent default`:

```js
window.dataLayer.filter(x => Array.isArray(x) && x[0] === "consent" && x[1] === "default")
```

> ✅ **Qué debe salir:** un `Array(3)` → `["consent", "default", {…}]` con los **7 parámetros**
> en `denied` excepto `security_storage: "granted"`, más `wait_for_update: 500`.
> Expande el objeto `2:` en pantalla para que se lean los 7 (esta es la toma clave del video).

Para verlo plano (opcional, queda más limpio en cámara):

```js
window.dataLayer.find(x => Array.isArray(x) && x[0] === "consent" && x[1] === "default")[2]
```

### Paso 2 — Confirmar el Developer ID de Conma

```js
window.dataLayer.filter(x => Array.isArray(x) && x[0] === "set" && x[1] === "developer_id.dM2M5Yz")
```

> ✅ **Qué debe salir:** `["set", "developer_id.dM2M5Yz", true]`. Confirma que Google identifica
> a Conma como la CMP que gobierna el consentimiento.

### Paso 3 — Aceptar en el banner

Haz clic en **Aceptar todo** / **Accept all** en el banner (acción manual, en cámara).

### Paso 4 — Estado tras el consentimiento (el `consent update`)

Vuelve a la consola y ejecuta el mismo filtro cambiando `"default"` por `"update"`:

```js
window.dataLayer.filter(x => Array.isArray(x) && x[0] === "consent" && x[1] === "update")
```

> ✅ **Qué debe salir:** un `["consent", "update", {…}]` con los parámetros de marketing y
> analítica pasando a `granted` (`ad_storage`, `analytics_storage`, `ad_user_data`,
> `ad_personalization`). Esto demuestra en vivo la transición **denied → granted**.

### Paso 5 (opcional) — Ver default y update juntos

Para una sola toma que muestre el ciclo completo:

```js
window.dataLayer.filter(x => Array.isArray(x) && x[0] === "consent")
```

> Debe listar primero el `default` (todo `denied`) y luego el `update` (con `granted`),
> en ese orden. Es la prueba visual más contundente del ciclo de consentimiento.

### Nota GTM — validación complementaria con Tag Assistant

Como el video se usa para la **implementación GTM**, además de la consola conviene mostrar
**Tag Assistant** (https://tagassistant.google.com) conectado al dominio: en el panel de
**Consent** verás el mismo `default` (denied) y, tras aceptar, el `update` (granted), con el
Developer ID `dM2M5Yz`. Esto prueba que el comportamiento por GTM es idéntico al de gtag y que
el tag de Conma (Consent Initialization, priority 999) corre **antes** que cualquier tag de Google.

> ⚠️ **Recordatorio:** los warnings de WooCommerce/Klaviyo o un `401` de plugins del sitio
> (p. ej. yith/wishlist en pereirajewelry.com) **no son de Conma** y no afectan el consent.
> Para una consola limpia en cámara, `metra.com.co` es mejor opción de grabación.

---

## Notas de producción

- **Subtítulos EN son obligatorios** aunque narres en español. Opciones:
  - YouTube (video "no listado") genera subtítulos automáticos → luego reemplazas el texto por el bloque `EN` de este guion (mucho más preciso).
  - O quemar subtítulos con CapCut / Premiere / DaVinci usando los bloques `EN`.
  - Alternativa más simple: **narrar directamente en inglés** leyendo el bloque `EN` (evita el paso de subtitular).
- No muestres datos sensibles en pantalla (tokens, claves, emails de clientes). Si el portal los muestra, encuádralos fuera o difumínalos.
- Cierra pestañas/extensiones ajenas antes de grabar; deja solo lo necesario (portal, página de prueba, DevTools, Tag Assistant).
- Graba a ≥ 1080p. Zoom de DevTools al 100–110 % para que el dataLayer se lea bien.
- Marca **S24-22** en `SPRINTS.md` al terminar (ver checklist §3).
