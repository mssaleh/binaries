#/usr/bin/env bash

cloudflare_zone_id=cf_zone_id
cloudflare_token=cf_token
sub_domain="cf_record_name"

# FQDN
domain_name=$sub_domain.smart-home.app
# Retrieve Record ID
curl "https://api.cloudflare.com/client/v4/zones/"$cloudflare_zone_id"/dns_records?type=A" \
-X GET -H "Authorization: Bearer "$cloudflare_token"" -H "Content-Type:application/json" > /tmp/djson || exit 1
domain_record_id=$(cat /tmp/djson | jq -r ".result[] | select(.name==\""$domain_name"\") | .id")
rm -Rf /tmp/djson
echo "Domain: $domain_name has Record ID: $domain_record_id"

# Retrieve the last recorded public IP address
IP_RECORD="/tmp/ip-record"
RECORDED_IP=`cat $IP_RECORD`

# Fetch the current public IP address
# PUBLIC_IP=$(dig @resolver1.opendns.com ANY myip.opendns.com +short)
PUBLIC_IP=$(curl --silent https://api.ipify.org) || exit 1
# PUBLIC_IP=$(curl -s http://checkip.dyndns.com | sed -e 's/.*Current IP Address: //' -e 's/<.*$//')

#If the public ip has not changed, nothing needs to be done, exit.
if [ "$PUBLIC_IP" = "$RECORDED_IP" ]; then
    exit 0
fi

# Otherwise, your Internet provider changed your public IP again.
# Record the new public IP address locally
echo $PUBLIC_IP > $IP_RECORD

# Record the new public IP address on Cloudflare using API v4
cf_record_update=$(echo "{\"type\":\"A\",\"name\":\"$sub_domain\",\"content\":\"$PUBLIC_IP\",\"ttl\":180,\"proxied\":false}")

curl "https://api.cloudflare.com/client/v4/zones/$cloudflare_zone_id/dns_records/$domain_record_id" \
     -X PUT \
     -H "Authorization: Bearer $cloudflare_token" \
     -H "Content-Type:application/json" \
     --data "$cf_record_update" || exit 1
echo "Done"
exit 0
