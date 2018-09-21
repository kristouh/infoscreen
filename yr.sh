#!/bin/bash


#url
bergen='https://www.yr.no/sted/Norge/Hordaland/Bergen/Bergen/time_for_time.html'

temperatur=$(curl -sL $bergen | grep 'Temperatur:' | cut -d '>' -f2 | cut -d '<' -f1)
regn=$(curl -sL $bergen | grep 'Nedbør:' | cut -d '>' -f2 | cut -d '<' -f1)
vind=$(curl -sL $bergen | grep 'Vind: ' | cut -d ':' -f2 | cut -d '.' -f1)
tid=$(curl -sL $bergen | grep 'Gjelder for: ' | grep -o -e 'kl \d*–\d*')

echo $regn > 'regn.txt'
echo $vind > 'vind.txt'
echo $temperatur > 'temp.txt'
echo $tid > 'tid.txt'




