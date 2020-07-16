#!/bin/bash

sub_domain=$1

gcloud dns record-sets transaction start --zone "test-zone"
for svc in api 
do
    #check ip
    _ip=`gcloud compute addresses list --filter name=${sub_domain}-${svc} --format 'value(address)'`
    #craete addresses
    if [ -z "${_ip}" ]
    then
        gcloud compute addresses create ${sub_domain}-${svc} --global
        _ip=`gcloud compute addresses list --filter name=${sub_domain}-${svc} --format 'value(address)'`
        gcloud dns record-sets transaction add -z=test-zone --name="${sub_domain}-${svc}.test.net."  --type=A  --ttl=300 "${_ip}"
    fi
done
gcloud dns record-sets transaction execute --zone "test-zone"
exit 0
