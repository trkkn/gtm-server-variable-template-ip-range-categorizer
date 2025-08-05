___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "categories": ["ANALYTICS"],
  "displayName": "IP Range Categorizer",
  "description": "Mapps a user IP or a range of IPs to a string. For example, useful for creating a traffic_type variable that differentiates inter/external traffic.",
  "containerContexts": ["SERVER"],
  "brand": {
    "displayName": "TRKKN - IP Range Categorizer"
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
    "displayName": "╭────────────────────────────────────",
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
    "name": "label1",
    "displayName": "╰────────────────────────────────────",
    "enablingConditions": []
  },
  {
    "type": "LABEL",
    "name": "whatsMyIPLabel",
    "displayName": "<a href=\"https://icanhazip.com\" target=\"_blank\">💻 What's my IP address?</a>"
  },
  {
    "type": "LABEL",
    "name": "noIPv6SupportLabel",
    "displayName": "🙅‍♂️ IPv6 will fall back to default value"
  },
  {
    "type": "LABEL",
    "name": "label2",
    "displayName": "template version: 2.0.1"
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
