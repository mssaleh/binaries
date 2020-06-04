#/usr/bin/env bash

AUTH_TOKEN=cf_token
ZONE_ID=cf_zone_id
A_RECORD_NAME="cf_record_name"
A_RECORD_ID=cf_record_id

# Retrieve the last recorded public IP address
IP_RECORD="/tmp/ip-record"
RECORDED_IP=`cat $IP_RECORD`

# Fetch the current public IP address
PUBLIC_IP=$(curl --silent https://api.ipify.org) || exit 1

#If the public ip has not changed, nothing needs to be done, exit.
if [ "$PUBLIC_IP" = "$RECORDED_IP" ]; then
    exit 0
fi

# Otherwise, your Internet provider changed your public IP again.
# Record the new public IP address locally
echo $PUBLIC_IP > $IP_RECORD

# Record the new public IP address on Cloudflare using API v4
RECORD=$(cat <<EOF
{ "type": "A",
  "name": "$A_RECORD_NAME",
  "content": "$PUBLIC_IP",
  "ttl": 180,
  "proxied": false }
EOF
)
curl "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$A_RECORD_ID" \
     -X PUT \
     -H "Authorization: Bearer $AUTH_TOKEN" \
     -H "Content-Type:application/json" \
     -d "$RECORD"
