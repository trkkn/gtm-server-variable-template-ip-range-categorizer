# 2.0.1
- DOCS: doc strings everywhere
- UI: cleaned up interface of the variable
  
# 2.0.0
- FEAT: now supports the use of CIDR ranges (e. g. 1.2.3.4/32). No more need to spell out the IPs in the range

# 1.2.0
- introduced caching of positive IP matches. This will massively improve performance of the variable by creating a list of all IP address that can potentially be matched. Using the list, we can quickly discard all those IP addresses that won't be matched (which will be 90+ %)