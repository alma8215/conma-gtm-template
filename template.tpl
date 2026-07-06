___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Conma CMP - Consent Mode v2",
  "description": "Establece Google Consent Mode v2 (EEA opt-in, global opt-out). Usar con trigger 'Consent Initialization - All Pages' y prioridad 999. El banner se carga por separado con un Custom HTML tag.",
  "categories": [
    "TAG_MANAGEMENT",
    "PERSONALIZATION"
  ],
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "SELECT",
    "name": "outsideEEA_analytics",
    "displayName": "Analytics fuera de EEA/UK",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "granted",
        "displayValue": "Permitido por defecto (opt-out - recomendado LATAM/US)"
      },
      {
        "value": "denied",
        "displayValue": "Denegado por defecto (opt-in - maxima privacidad global)"
      }
    ],
    "simpleValueType": true,
    "defaultValue": "granted",
    "help": "Estado inicial de analytics_storage para usuarios fuera de EEA/UK. En EEA/UK siempre es denied (GDPR obligatorio)."
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// Conma CMP — Tag 1: Consent Defaults
// Trigger: Consent Initialization - All Pages | Priority: 999
// Tag 2 (Custom HTML): carga el banner con window.__cmp_site y __cmp_apiKey

const setDefaultConsentState = require('setDefaultConsentState');
const updateConsentState = require('updateConsentState');
const localStorage = require('localStorage');
const JSON = require('JSON');

const analyticsOutside = data.outsideEEA_analytics || 'granted';

const EEA_REGIONS = ['AT','BE','BG','HR','CY','CZ','DK','EE','FI','FR','DE','GR','HU','IE','IT','LV','LT','LU','MT','NL','PL','PT','RO','SK','SI','ES','SE','IS','LI','NO','GB','CH'];

// 1. Defaults EEA/UK: opt-in obligatorio (GDPR / GCM v2 junio 2026)
setDefaultConsentState({
  ad_storage: 'denied',
  analytics_storage: 'denied',
  functionality_storage: 'denied',
  personalization_storage: 'denied',
  security_storage: 'granted',
  ad_user_data: 'denied',
  ad_personalization: 'denied',
  wait_for_update: 500,
  region: EEA_REGIONS
});

// 2. Defaults global: opt-out permisivo (LATAM / US / resto)
setDefaultConsentState({
  ad_storage: 'denied',
  analytics_storage: analyticsOutside,
  functionality_storage: 'granted',
  personalization_storage: 'denied',
  security_storage: 'granted',
  ad_user_data: 'denied',
  ad_personalization: 'denied',
  wait_for_update: 500
});

// 3. Restaurar sesion previa desde localStorage (<50ms)
// JSON.parse en sandbox GTM retorna undefined si el JSON es invalido (no lanza)
const savedRaw = localStorage.getItem('_cmp_consent');
const saved = savedRaw ? JSON.parse(savedRaw) : null;
if (saved && saved.preferences) {
  const p = saved.preferences;
  updateConsentState({
    ad_storage: p.marketing || 'denied',
    analytics_storage: p.statistics || 'denied',
    functionality_storage: p.preferences || 'denied',
    personalization_storage: p.preferences || 'denied',
    security_storage: 'granted',
    ad_user_data: p.marketing || 'denied',
    ad_personalization: p.marketing || 'denied'
  });
}

data.gtmOnSuccess();


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "access_consent",
        "versionId": "1"
      },
      "param": [
        {
          "key": "consentTypes",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_storage"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_user_data"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "ad_personalization"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "analytics_storage"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "functionality_storage"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "personalization_storage"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "consentType"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "security_storage"
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_local_storage",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "_cmp_consent"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Conma CMP Tag v1.0
* Google Consent Mode v2 — EEA opt-in, global opt-out
* Tag 1 de 2: solo consent defaults. El banner se carga con un Custom HTML tag separado.