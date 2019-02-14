#!/bin/bash

_START=$(expr $(date +%s%N) / 1000)

_WAITSECONDS=60

_COUNTERS="$(ovs-appctl dpctl/show -s)"
_PORTS="$(echo "${_COUNTERS}"|grep -E "port [0-9]{1,99}:"|awk '{print $3}'|sort|wc -l)"

_COUNT=0
while read -r _PORT
do
	_NAME[${_COUNT}]=${_PORT}
	_TXT0[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "TX packets:[0-9]{1,99}"|sed -e "s/^.*://g")
	_RXT0[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "RX packets:[0-9]{1,99}"|sed -e "s/^.*://g")
	_TXERRORT0[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "TX .*errors:[0-9]{1,99}"|grep -E -o "errors:[0-9]{1,99}"|sed -e "s/^.*://g")
	_RXERRORT0[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "RX .*errors:[0-9]{1,99}"|grep -E -o "errors:[0-9]{1,99}"|sed -e "s/^.*://g")
	_TXDROPT0[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "TX .*dropped:[0-9]{1,99}"|grep -E -o "dropped:[0-9]{1,99}"|sed -e "s/^.*://g")
	_RXDROPT0[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "RX .*dropped:[0-9]{1,99}"|grep -E -o "dropped:[0-9]{1,99}"|sed -e "s/^.*://g")
	_TXBT0[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "TX bytes:[0-9]{1,99}"|sed -e "s/^.*://g")
	_RXBT0[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "RX bytes:[0-9]{1,99}"|sed -e "s/^.*://g")
	((_COUNT++))
done <<< "$(echo "${_COUNTERS}"|grep -E "port [0-9]{1,99}:"|awk '{print $3}'|sort)"

_END=$(expr $(date +%s%N) / 1000)
usleep $(bc <<< "(${_WAITSECONDS} * 1000 * 1000) - (${_END} - ${_START})") 2>/dev/null

_COUNTERS="$(ovs-appctl dpctl/show -s)"

_COUNT=0
while read -r _PORT
do
        _TXT1[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "TX packets:[0-9]{1,99}"|sed -e "s/^.*://g")
        _RXT1[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "RX packets:[0-9]{1,99}"|sed -e "s/^.*://g")
	_TXERRORT1[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "TX .*errors:[0-9]{1,99}"|grep -E -o "errors:[0-9]{1,99}"|sed -e "s/^.*://g")
	_RXERRORT1[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "RX .*errors:[0-9]{1,99}"|grep -E -o "errors:[0-9]{1,99}"|sed -e "s/^.*://g")
	_TXDROPT1[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "TX .*dropped:[0-9]{1,99}"|grep -E -o "dropped:[0-9]{1,99}"|sed -e "s/^.*://g")
	_RXDROPT1[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "RX .*dropped:[0-9]{1,99}"|grep -E -o "dropped:[0-9]{1,99}"|sed -e "s/^.*://g")
	_TXBT1[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "TX bytes:[0-9]{1,99}"|sed -e "s/^.*://g")
	_RXBT1[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "RX bytes:[0-9]{1,99}"|sed -e "s/^.*://g")
        ((_COUNT++))
done <<< "$(echo "${_COUNTERS}"|grep -E "port [0-9]{1,99}:"|awk '{print $3}'|sort)"

echo -e "\n########## Open vSwitch DPDK STATS over ${_WAITSECONDS} seconds ##########"
printf "%23s" \
	"Port"
printf "%15s" \
	"TX" \
	"RX" \
	"TX Drops" \
	"RX Drops" \
	"TX Errors" \
	"RX Errors" \
	"TX PPS" \
	"RX PPS" \
	"TX & RX PPS" \
	"TX Drops PPS" \
	"RX Drops PPS"
echo
for (( i=0 ; i<${#_NAME[@]} ; i++ ))
do
	_TX="$( bc <<< "scale=2; ${_TXT1[${i}]}" )"
	_RX="$( bc <<< "scale=2; ${_RXT1[${i}]}" )"
	_TXDROP="$( bc <<< "scale=2; ${_TXDROPT1[${i}]}" )"
	_RXDROP="$( bc <<< "scale=2; ${_RXDROPT1[${i}]}" )"
	_TXE="$( bc <<< "scale=2; ${_TXERRORT1[${i}]}" )"
	_RXE="$( bc <<< "scale=2; ${_RXERRORT1[${i}]}" )"
	_TXS="$( bc <<< "scale=2; (${_TXT1[${i}]} - ${_TXT0[${i}]}) / ${_WAITSECONDS}" )"
	_RXS="$( bc <<< "scale=2; (${_RXT1[${i}]} - ${_RXT0[${i}]}) / ${_WAITSECONDS}" )"
	_TXRXS="$( bc <<< "scale=2; ( (${_TXT1[${i}]} - ${_TXT0[${i}]}) + (${_RXT1[${i}]} - ${_RXT0[${i}]}) ) / ${_WAITSECONDS}" )"
	_TXDROPS="$( bc <<< "scale=2; (${_TXDROPT1[${i}]} - ${_TXDROPT0[${i}]}) / ${_WAITSECONDS}" )"
	_RXDROPS="$( bc <<< "scale=2; (${_RXDROPT1[${i}]} - ${_RXDROPT0[${i}]}) / ${_WAITSECONDS}" )"
	printf "%23s" \
		"${_NAME[${i}]}"
	printf "%15s" \
		"${_TX}" \
		"${_RX}" \
		"${_TXDROP}" \
		"${_RXDROP}" \
		"${_TXE}" \
		"${_RXE}" \
		"${_TXS}" \
		"${_RXS}" \
		"${_TXRXS}" \
		"${_TXDROPS}" \
		"${_RXDROPS}"
	echo
done

echo -e "\n########## Open vSwitch DPDK RATES ##########"
printf "%23s" \
	"Port"
printf "%15s" \
	"TX" \
	"RX" \
	"TX Rate" \
	"RX Rate" \
	"TX & RX Rate"
echo
for (( i=0 ; i<${#_NAME[@]} ; i++ ))
do
	_TXB="$( numfmt --to=iec-i --suffix=B ${_TXBT1[${i}]} )"
	_RXB="$( numfmt --to=iec-i --suffix=B ${_RXBT1[${i}]} )"
	_TXR="$( numfmt --to=iec --suffix=B $( bc <<< "scale=2; (${_TXBT1[${i}]} - ${_TXBT0[${i}]}) / ${_WAITSECONDS}" ) )/s"
	_RXR="$( numfmt --to=iec --suffix=B $( bc <<< "scale=2; (${_RXBT1[${i}]} - ${_RXBT0[${i}]}) / ${_WAITSECONDS}" ) )/s"
	_TXRXR="$( numfmt --to=iec --suffix=B $( bc <<< "scale=2; ( (${_TXBT1[${i}]} - ${_TXBT0[${i}]}) + (${_RXBT1[${i}]} - ${_RXBT0[${i}]}) ) / ${_WAITSECONDS}" ) )/s"
	printf "%23s" \
		"${_NAME[${i}]}"
	printf "%15s" \
		"${_TXB}" \
		"${_RXB}" \
		"${_TXR}" \
		"${_RXR}" \
		"${_TXRXR}"
	echo
done

exit 0
