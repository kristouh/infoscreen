#!/bin/bash


#url
straume='https://reiseplanlegger.skyss.no/scripts/TravelMagic/TravelMagicWE.dll/avgangsinfo?context=wap.xhtml&lang=no&from=Straume%20bro%20(Bergen)'

tider_sentrum=()
nummer_sentrum=()
navn_sentrum=()

tider_soreide=()
nummer_soreide=()
navn_soreide=()

sentrum='12015515'
soreide='12015528'

#retning sentrum
tider_sentrum=$(curl -sL $straume | grep -A6 $sentrum | grep -A1 'tm-time' | grep -e '\d*:\d*')
nummer_sentrum=$(curl -sL $straume | grep -A12 $sentrum | grep -E 'tm-line-nr' | cut -d '>' -f2 |cut -d '<' -f1)
navn_sentrum=$(curl -sL $straume | grep -A12 $sentrum | grep -o -E -e 'tm-line-destination.{0,40}' | cut -d '>' -f2 |cut -d '<' -f1)
navn_sentrum=${navn_sentrum//til /til_}
navn_sentrum=${navn_sentrum// terminal/_terminal}
#retning Soreide
tider_soreide=$(curl -sL $straume | grep -A6 $soreide | grep -A1 'tm-time' | grep -e '\d*:\d*')
nummer_soreide=$(curl -sL $straume | grep -A12 $soreide | grep -E 'tm-line-nr' | cut -d '>' -f2 |cut -d '<' -f1)
navn_soreide=$(curl -sL $straume | grep -A12 $soreide | grep -o -E -e 'tm-line-destination.{0,40}' | cut -d '>' -f2 |cut -d '<' -f1)
navn_soreide=${navn_soreide//til /til_}
navn_soreide=${navn_soreide// terminal/_terminal}
navn_soreide=${navn_soreide// Lufthavn/_Lufthavn}







