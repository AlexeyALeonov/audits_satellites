#!/bin/bash
# Thanks for the script to our fellow community member @robertstanfield https://community.storj.io/channel/storagenode?msg=ftbNKerrkrpHXJ325

echo -e "Fetching satellite audits stat information. Please wait..."

audits=$(mktemp)
sats=$(mktemp)
if [ "$1" ]; then
  logs=$(mktemp)
  docker logs storagenode 2>$logs
else
  logs=$1
fi
cat $logs | grep GET_AUDIT > $audits
 
cat $audits | cut -f5 | cut -f5 -d " " | cut -f2 -d "\"" > ${sats}
known_sats=$(sort ${sats} | uniq)
 
for sat in $known_sats; do
  echo -e "Sat ID:\t\t\t\t$sat"
  echo -e "Unrecoverable Failed Audits:\t$(cat "$audits" | grep failed | grep open | grep -c "$sat")"
  echo -e "Recoverable Failed Audits:\t$(cat "$audits" | grep failed | grep -v open | grep -c "$sat")"
  echo -e "Successful Audits:\t\t$(cat "$audits" | grep downloaded | grep -c "$sat")"
done
 
rm $sats
rm $audits
