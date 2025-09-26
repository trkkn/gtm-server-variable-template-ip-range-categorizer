___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "categories": ["ANALYTICS", "UTILITY"],
  "displayName": "IP Range Categorizer",
  "description": "Maps a user IP or a range of IPs to a string. For example, useful for creating a traffic_type variable that differentiates inter/external traffic.",
  "containerContexts": ["SERVER"],
  "brand": {
    "id": "github.com_trakken",
    "displayName": "TRKKN",
    "thumbnail": "data:image/jpeg;base64,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\u003d\u003d"
  }
}
___NOTES___

Created on 06/08/2021, 10:04:13

___SANDBOXED_JS_FOR_SERVER___

const getRemoteAddress = require("getRemoteAddress");
const log = require("logToConsole");
const makeNumber = require("makeNumber");
const makeString = require("makeString");
const templateDataStorage = require("templateDataStorage");
const getContainerVersion = require("getContainerVersion");
const Math = require("Math");

log("data=", data);

let errorMessage;
let visitorType = data.defaultValue;
const userIP = data.userIp || getRemoteAddress();

// handle ipv6
if (isIPv6(userIP)) {
  log("ipv6 not supported");
  return visitorType + "_ipv6";
}

if (data.lookupType === "upperLowerRangeLookup") {
  visitorType = getUpperLowerIPRangeLookup();
} else {
  visitorType = getCidrLookup();
}
return visitorType;

// ------ function declarations ------
/**
 * checks if the IP address is IPv6
 * @param {string} userIp The user's IP address
 * @returns Boolean
 */
function isIPv6(userIp) {
  return userIP.indexOf(":") >= 0;
}

/**
 * Looks up visitor type based on CIDR ranges
 * @returns {string} The visitor type for the user IP
 */
function getCidrLookup() {
  for (let i = 0; i < data.cidrRanges.length; i++) {
    const cidr = data.cidrRanges[i];
    log("cidrRange: ", cidr.cidrRange);
    log("userIP: ", userIP);
    if (!isValidCidrRange(cidr.cidrRange)) {
      continue;
    }
    if (isIp4InCidr(userIP, cidr.cidrRange)) {
      visitorType = cidr.visitorType;
      break;
    }
  }
  return visitorType;
}

/**
 * Validates if a CIDR range string is properly formatted
 * @param {string} cidr - The CIDR range to validate (e.g., "192.168.1.0/24")
 * @returns {boolean} True if the CIDR range is valid, false otherwise
 */
function isValidCidrRange(cidr) {
  const parts = cidr.split("/");
  if (parts.length != 2) {
    errorMessage = "invalid cidr range";
    log(errorMessage);
    return false;
  }

  const range = parts[0];
  const bits = parts[1];
  if (bits < 0 || bits > 32) {
    errorMessage = "invalid cidr range";
    log(errorMessage);
    return false;
  }

  const ipParts = range.split(".");
  if (ipParts.length != 4) {
    errorMessage = "invalid cidr range";
    log(errorMessage);
    return false;
  }

  return true;
}

/**
 * Looks up visitor type using legacy IP range method with upper/lower limits
 * @returns {string} The visitor type for the user IP
 */
function getUpperLowerIPRangeLookup() {
  // if the ip is not in the cached range, then it is no
  // worth checking out which range category it belongs to.
  // in this case, we just return the default category
  if (!userIPInCachedRange(userIP)) {
    log("ip not in relevant range");
    return visitorType;
  }

  for (let i = 0; i < data.ipRanges.length; i++) {
    const ipRange = data.ipRanges[i];
    log("ipRange: ", ipRange);
    log("userIP: ", userIP);

    if (!userIP || !ipRange.upperLimit || !ipRange.lowerLimit) {
      errorMessage = "please provide three IPs";
      log(errorMessage);
      return errorMessage;
    }

    // only needed for performance reasons. areAllArrayMambersLower would work here too.
    if (ipRange.upperLimit === ipRange.lowerLimit && ipRange.upperLimit === userIP) {
      visitorType = ipRange.visitorType;
      break;
    }

    const upperParts = ipRange.upperLimit.split(".");
    const lowerParts = ipRange.lowerLimit.split(".");
    const userParts = userIP.split(".");
    if (userParts.length != lowerParts.length || userParts.length != upperParts.length) {
      errorMessage = "cannot compare IPs of uneqal length";
      log(errorMessage);
      return errorMessage;
    }

    if (
      areAllArrayMambersLower(lowerParts, userParts) &&
      areAllArrayMambersLower(userParts, upperParts)
    ) {
      log("ip is in range");
      visitorType = ipRange.visitorType;
      break;
    }
  }

  return visitorType;
}

/*
The following two CIDR related functions are copied from here:
https://tech.mybuilder.com/determining-if-an-ipv4-address-is-within-a-cidr-range-in-javascript/
*/
/**
 * Determines if an IPv4 address is within a CIDR range
 * @param {string} ip - The IPv4 address to check
 * @param {string} cidr - The CIDR range (e.g., "192.168.1.0/24")
 * @returns {boolean} True if the IP is within the CIDR range
 */
function isIp4InCidr(ip, cidr) {
  const range = cidr.split("/")[0];
  const bits = cidr.split("/")[1];
  const mask = ~(Math.pow(2, 32 - bits) - 1);
  return (IPtoNumber(ip) & mask) === (IPtoNumber(range) & mask);
}

/**
 * Compares two arrays to check if all members of the first array are lower than or equal to corresponding members in the second array
 * @param {Array} firstArray - The first array to compare
 * @param {Array} seccondArray - The second array to compare against
 * @returns {boolean} True if all members of firstArray are <= corresponding members of seccondArray
 */
function areAllArrayMambersLower(firstArray, seccondArray) {
  if (firstArray.length != seccondArray.length) {
    log("cannot compare arrays of different lenght");
    return;
  }

  let allAreLower = true;
  for (let i = 0; i < firstArray.length; i++) {
    if (makeNumber(firstArray[i]) > makeNumber(seccondArray[i])) {
      log(firstArray[i], " is not <= ", seccondArray[i]);
      allAreLower = false;
      break;
    }
  }
  return allAreLower;
}

/**
 * Checks if a user IP is within the cached IP ranges
 * @param {string} userIP - The user's IP address
 * @returns {boolean} True if the IP is found in the cached ranges
 */
function userIPInCachedRange(userIP) {
  const allIps = getAllIpsFromCache();
  return allIps.indexOf(makeString(IPtoNumber(userIP))) >= 0;
}

/**
 * Retrieves all IPs from cache or generates them from IP ranges if cache is invalid
 * @returns {Array<string>} Array of all IP addresses as strings
 */
function getAllIpsFromCache() {
  const ipCache = templateDataStorage.getItemCopy("ipCache");

  let allIps = [];
  const containerData = getContainerVersion();

  if (
    ipCache &&
    ipCache.latestVersion &&
    ipCache.latestVersion === containerData.version &&
    ipCache.allIps
  ) {
    log("retrieved IPs from cache: ", ipCache);
    allIps = ipCache.allIps;
  } else {
    for (var i = 0; i < data.ipRanges.length; i += 1) {
      var ipRange = data.ipRanges[i];
      var lower = IPtoNumber(ipRange.lowerLimit);
      var upper = IPtoNumber(ipRange.upperLimit);

      // cap the rangeToCover at 100 in order to avoid inifinte loops (just to be double-sure because who knows)
      const theoreticalLimit = upper - lower;
      const rangeToCover = Math.min(theoreticalLimit, 100);
      log("range to cover: ", upper, lower, rangeToCover);
      var current = lower;

      while (current - lower <= rangeToCover) {
        log(current);
        allIps.push(makeString(current));
        current += 1;
      }
    }
    const ipCacheObject = {
      latestVersion: containerData.version,
      allIps: allIps,
    };
    log("created new ip cache object", ipCacheObject);
    templateDataStorage.setItemCopy("ipCache", ipCacheObject);
  }
  return allIps;
}

/**
 * Converts an IP address string to a numerical representation for comparison
 * @param {string} ip - The IP address string (e.g., "192.168.1.1")
 * @returns {number} Numerical representation of the IP address
 */
function IPtoNumber(ip) {
  var ipSplit = ip.split(".");
  let newIP = [];
  for (let i = 0; i < ipSplit.length; i++) {
    const element = "000" + ipSplit[i];
    newIP.push(element.substring(element.length - 3));
  }
  return makeNumber(newIP.join(""));
}

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

___TERMS_OF_SERVICE___


By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.



___TESTS___

scenarios:
- name: upper lower IP range // ip is in first Range
  code: |-
    mockData.userIp = "217.111.97.8";
    mockData.lookupType = "upperLowerRangeLookup";

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo(mockData.ipRanges[0].visitorType);

    mockData.userIp = "217.111.97.15";

    // Call runCode to run the template's code.
    variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(mockData.defaultValue);
    assertThat(variableResult).isEqualTo(mockData.ipRanges[0].visitorType);
- name: upper lower IP range // ip is in second range
  code: |-
    mockData.userIp = "176.95.141.126";
    mockData.lookupType = "upperLowerRangeLookup";

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo(mockData.ipRanges[1].visitorType);
- name: upper lower IP range // ip is below range
  code: |-
    mockData.userIp = "217.111.97.7";
    mockData.lookupType = "upperLowerRangeLookup";

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo(mockData.defaultValue);
- name: upper lower IP range // ip is above range
  code: |-
    mockData.userIp = "172.16.1.1";
    mockData.lookupType = "upperLowerRangeLookup";

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo(mockData.defaultValue);
- name: upper lower IP range // invalid IP range
  code: |-
    mockData.userIp = "128.0.0.10";
    mockData.lookupType = "upperLowerRangeLookup";

    mockData.ipRanges.push({"lowerLimit":"128.0.0.10","upperLimit":"128.0.0.0","visitorType":"invalid"});

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo(mockData.defaultValue);
- name: upper lower IP range // within range
  code: |-
    mockData.userIp = "10.0.0.0";
    mockData.lookupType = "upperLowerRangeLookup";

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo("Hannes two");
- name: upper lower IP range // exact match
  code: |-
    mockData.userIp = "91.55.104.134";
    mockData.lookupType = "upperLowerRangeLookup";

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo("Exact");
- name: cidr // exact match
  code: |-
    mockData.userIp = "176.95.141.126";

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo(mockData.cidrRanges[1].visitorType);
- name: cidr // within range
  code: |-
    mockData.userIp = "176.95.141.126";
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo(mockData.cidrRanges[1].visitorType);
    assertThat(variableResult).isNotEqualTo(mockData.defaultValue);

    // Call runCode to run the template's code.
    mockData.userIp = "176.95.141.125";
    variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isNotEqualTo(mockData.defaultValue);
    assertThat(variableResult).isEqualTo(mockData.cidrRanges[1].visitorType);
- name: cidr // not in range
  code: |-
    mockData.userIp = "176.95.141.1";
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo(mockData.defaultValue);
- name: cidr // invalid IP range
  code: |-
    mockData.userIp = "192.0.90.1";

    mockData.cidrRanges.push({"cidrRange": "192.0.90.1", "visitorType": "also Hannes"});
    mockData.cidrRanges.push({"cidrRange": "acdsed", "visitorType": "invalid"});

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns a result.
    assertThat(variableResult).isEqualTo(mockData.defaultValue);
- name: ipv6 // not supported
  code: |-
    mockData.userIp = "2001:0db8:85a3:0000:0000:8a2e:0370:7334";

    // Call runCode to run the template's code.
    let variableResult = runCode(mockData);

    // Verify that the variable returns default value with _ipv6 suffix.
    assertThat(variableResult).isEqualTo(mockData.defaultValue + "_ipv6");
setup: |-
  const mockData = {
    "ipRanges":[
      {"lowerLimit":"217.111.97.8","upperLimit":"217.111.97.15","visitorType":"Hannes"},
      {"lowerLimit":"176.95.141.126","upperLimit":"176.95.141.126","visitorType":"also Hannes"},
      {"lowerLimit":"10.0.0.0","upperLimit":"10.255.255.255","visitorType":"Hannes two"},
      {"lowerLimit":"91.55.104.134","upperLimit":"91.55.104.134","visitorType":"Exact"}
    ],
    "cidrRanges": [
      {"cidrRange": "217.110.207.98/32", "visitorType": "Hannes"},
      {"cidrRange": "176.95.141.126/30", "visitorType": "also Hannes"}
    ],
    "defaultValue":"External"
  };
