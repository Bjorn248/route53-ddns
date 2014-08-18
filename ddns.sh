#!/bin/bash

MY_DOMAIN="FILL_IN_WITH_DOMAIN_YOU_WISH_TO_BE_DYNAMIC"

HOSTED_ZONE_ID="FILL_IN_WITH_HOSTED_ZONE_ID"

CURRENT_RECORD=$(dig +short $MY_DOMAIN)

CURRENT_IP=$(curl checkip.amazonaws.com)

if [ "$CURRENT_RECORD" != "$CURRENT_IP" ];
then
    sed -r "s/FILL_ME_IN/$CURRENT_IP/g" update_template.json > update.json
    sed -ri "s/FILL_IN_WITH_DOMAIN_YOU_WISH_TO_BE_DYNAMIC/$MY_DOMAIN/g" update.json
    aws route53 change-resource-record-sets --hosted-zone-id $HOSTED_ZONE_ID --change-batch file://./update.json
    echo "DNS Updated"
else
    echo "No change required"
fi
