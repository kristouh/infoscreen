#!/bin/bash


#url
straume='https://reiseplanlegger.skyss.no/scripts/TravelMagic/TravelMagicWE.dll/avgangsinfo?context=wap.xhtml&lang=no&from=Straume%20bro%20(Bergen)'

tider_sentrum_arr=()
nummer_sentrum_arr=()
navn_sentrum_arr=()

tider_soreide_arr=()
nummer_soreide_arr=()
navn_soreide_arr=()

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

for i in $tider_sentrum; do
	tider_sentrum_arr+=("$i")
done
for i in $nummer_sentrum; do
	nummer_sentrum_arr+=("$i")
done
for i in $navn_sentrum; do
	navn_sentrum_arr+=("$i")
done

for i in $tider_soreide; do
	tider_soreide_arr+=("$i")
done
for i in $nummer_soreide; do
	nummer_soreide_arr+=("$i")
done
for i in $navn_soreide; do
	navn_soreide_arr+=("$i")
done

ant_sentrum=${#tider_sentrum_arr[@]}
ant_soreide=${#tider_soreide_arr[@]}

echo 'Sentrum' > 'straumebro.txt'
for i in $(seq 0 $ant_sentrum); do
	echo "${nummer_sentrum_arr[$i]} ${navn_sentrum_arr[$i]} ${tider_sentrum_arr[$i]}" >> 'straumebro.txt'
done

echo 'Søreide' >> 'straumebro.txt'
for i in $(seq 0 $ant_sentrum); do
	echo "${nummer_soreide_arr[$i]} ${navn_soreide_arr[$i]} ${tider_soreide_arr[$i]}" >> 'straumebro.txt'
done


