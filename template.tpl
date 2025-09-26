___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "categories": [
    "ANALYTICS",
    "UTILITY"
  ],
  "displayName": "IP Range Categorizer",
  "description": "Maps a user IP or a range of IPs to a string. For example, useful for creating a traffic_type variable that differentiates inter/external traffic.",
  "containerContexts": [
    "SERVER"
  ]
}

___NOTES___

Created on 06/08/2021, 10:04:13

___SERVER_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_request",
        "versionId": "1"
      },
      "param": [
        {
          "key": "remoteAddressAllowed",
          "value": {
            "type": 8,
            "boolean": true
          }
        },
        {
          "key": "headersAllowed",
          "value": {
            "type": 8,
            "boolean": true
          }
        },
        {
          "key": "requestAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "headerAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queryParameterAccess",
          "value": {
            "type": 1,
            "string": "any"
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
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
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

___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "userIp",
    "displayName": "User IP",
    "simpleValueType": true,
    "alwaysInSummary": false,
    "help": "The IP of the user/client to check. Defaults to reading the IP address from the request",
    "valueHint": "defaults to user IP from request"
  },
  {
    "type": "TEXT",
    "name": "defaultValue",
    "displayName": "Default Value",
    "simpleValueType": true,
    "defaultValue": "External",
    "help": "all unmatched IP addresses will return this value",
    "alwaysInSummary": true,
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "LABEL",
    "name": "label0",
    "displayName": "╭ <strong>IP Ranges</strong> ────────",
    "enablingConditions": []
  },
  {
    "type": "SELECT",
    "name": "lookupType",
    "displayName": "IP Range Type",
    "macrosInSelect": false,
    "selectItems": [
      {
        "value": "cidrRangeLookup",
        "displayValue": "CIDR Range"
      },
      {
        "value": "upperLowerRangeLookup",
        "displayValue": "Upper/Lower IP"
      }
    ],
    "simpleValueType": true,
    "defaultValue": "cidrRangeLookup",
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ]
  },
  {
    "type": "SIMPLE_TABLE",
    "name": "cidrRanges",
    "displayName": "",
    "simpleTableColumns": [
      {
        "defaultValue": "",
        "displayName": "CIDR Range",
        "name": "cidrRange",
        "type": "TEXT",
        "valueHint": "e. g. 217.111.97.8/29",
        "isUnique": true
      },
      {
        "defaultValue": "",
        "displayName": "Visitor Type",
        "name": "visitorType",
        "type": "TEXT",
        "valueHint": "Internal"
      }
    ],
    "enablingConditions": [
      {
        "paramName": "lookupType",
        "paramValue": "cidrRangeLookup",
        "type": "EQUALS"
      }
    ]
  },
  {
    "type": "SIMPLE_TABLE",
    "name": "ipRanges",
    "displayName": "IP Ranges",
    "simpleTableColumns": [
      {
        "defaultValue": "",
        "valueHint": "1.2.3.0",
        "displayName": "Lower Limit (full ip)",
        "name": "lowerLimit",
        "type": "TEXT",
        "valueValidators": [
          {
            "type": "REGEX",
            "args": ["([0-9]{1,3}\\.){3}[0-9]{1,3}"],
            "errorMessage": "This is not a valid IP Address Range. A valid IP Range looks like this 217.111.97.8"
          }
        ],
        "isUnique": true
      },
      {
        "defaultValue": "",
        "valueHint": "1.2.3.255",
        "displayName": "Upper Limit (full ip)",
        "name": "upperLimit",
        "type": "TEXT",
        "valueValidators": [
          {
            "type": "REGEX",
            "args": ["([0-9]{1,3}\\.){3}[0-9]{1,3}"]
          }
        ],
        "isUnique": true
      },
      {
        "defaultValue": "",
        "displayName": "Visitor Type",
        "name": "visitorType",
        "type": "TEXT",
        "valueHint": "internal"
      }
    ],
    "help": "Only IPv4 Addresses are supported. If you have a CIDR-range (e. g. 217.111.97.8/29 --> the /29 is the important part here), you can get the actual IP-range by entering your IP on a page like this: https://mxtoolbox.com/subnetcalculator.aspx",
    "enablingConditions": [
      {
        "paramName": "lookupType",
        "paramValue": "upperLowerRangeLookup",
        "type": "EQUALS"
      }
    ]
  },

  {
    "type": "LABEL",
    "name": "infoSection",
    "displayName": "╭ <strong>Helpful Info</strong> ────────"
  },
  {
    "type": "LABEL",
    "name": "whatsMyIPLabel",
    "displayName": "<a href=\"https://icanhazip.com\" target=\"_blank\">💻 What's my IP address?</a>"
  },
  {
    "type": "LABEL",
    "name": "documentationLabel",
    "displayName": "<a href=\"https://github.com/trkkn/gtm-server-variable-template-ip-range-categorizer\" target=\"_blank\">🧭 Template Documentation</a>"
  },
  {
    "type": "LABEL",
    "name": "noIPv6SupportLabel",
    "displayName": "💡 IPv6 will fall back to default value"
  },
  {
    "type": "LABEL",
    "name": "label2",
    "displayName": "🔁 Template Version: 2.0.1"
  }
]
