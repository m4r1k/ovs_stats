#!/bin/bash

_STATS=false
_RATES=false
_WAITSECONDS=60

if (( $# == 0 )); then
        _STATS=true
else
	while [ $# -gt 0 ]; do
		_ARG=$1
		shift
		case "${_ARG}" in
			"-s"|"--stats")
				_STATS=true
			;;
			"-r"|"--rates")
				_RATES=true
			;;
			"-d"|"--duration")
				if ! [[ "${1}" =~ ^[0-9]+$ ]]; then
			        	echo "WARNING - Invalid duration -.-' Using default 60 seconds"
			        	_WAITSECONDS=60
				else
			        	_WAITSECONDS=$1
				fi
	
	                        if [[ "$(echo ${@}|sed -e 's/--duration//g' -e 's/-d//g' -e 's/[0-9]//g' -e 's/ //g')" == "" ]]; then
	                                _STATS=true
	                        fi
	
				shift
			;;
			*)
				echo -e "Open vSwitch packet statistics\n"
				echo "-h|--help - Help"
				echo "-s|--stats - Packets per Second statistics (default option)"
				echo "-r|--rates - Rates per Second statistics"
				echo "-d <seconds>|--duration <seconds> - How long to collect statistics"
				echo -e "\nFederico Iezzi - fiezzi@redhat.com"
				exit 1
			;;
		esac
	done
fi

_START=$(expr $(date +%s%N) / 1000)

_COUNTERS="$(ovs-appctl dpctl/show -s)"

_END=$(expr $(date +%s%N) / 1000)

# Ensure the wait time between two 'ovs-appctl dpctl/show -s' iteration is precise at the microsecond
usleep $(bc <<< "(${_WAITSECONDS} * 1000 * 1000) - (${_END} - ${_START})") 2>/dev/null &

_PORTS="$(echo "${_COUNTERS}"|grep -E "port [0-9]{1,99}:"|awk '{print $3}'|sort|wc -l)"

_COUNT=0
while read -r _PORT
do
	# Ensure to exclude VXLAN and GRE system ports
	if [[ "${_PORT}" =~ "gre_sys" || "${_PORT}" =~ "vxlan_sys" ]]; then continue; fi

	_NAME[${_COUNT}]=${_PORT}
	_TXT0[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "TX packets:[0-9]{1,99}"|sed -e "s/^.*://g")
	_RXT0[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "RX packets:[0-9]{1,99}"|sed -e "s/^.*://g")
	_TXERRORT0[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "TX .*errors:[0-9]{1,99}"|grep -E -o "errors:[0-9]{1,99}"|sed -e "s/^.*://g")
	[[ "${_TXERRORT0[${_COUNT}]}" == "" ]] && _TXERRORT0[${_COUNT}]=0
	_RXERRORT0[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "RX .*errors:[0-9]{1,99}"|grep -E -o "errors:[0-9]{1,99}"|sed -e "s/^.*://g")
	[[ "${_RXERRORT0[${_COUNT}]}" == "" ]] && _RXERRORT0[${_COUNT}]=0
	_TXDROPT0[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "TX .*dropped:[0-9]{1,99}"|grep -E -o "dropped:[0-9]{1,99}"|sed -e "s/^.*://g")
	_RXDROPT0[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "RX .*dropped:[0-9]{1,99}"|grep -E -o "dropped:[0-9]{1,99}"|sed -e "s/^.*://g")
	_TXBT0[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "TX bytes:[0-9]{1,99}"|sed -e "s/^.*://g")
	_RXBT0[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "RX bytes:[0-9]{1,99}"|sed -e "s/^.*://g")
	((_COUNT++))
done <<< "$(echo "${_COUNTERS}"|grep -E "port [0-9]{1,99}:"|awk '{print $3}'|sort)"

# Process OVS stats in background while waiting for usleep to complete
wait

_COUNTERS="$(ovs-appctl dpctl/show -s)"

_COUNT=0
while read -r _PORT
do
	# Ensure to exclude VXLAN and GRE system ports
	if [[ "${_PORT}" =~ "gre_sys" || "${_PORT}" =~ "vxlan_sys" ]]; then continue; fi

        _TXT1[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "TX packets:[0-9]{1,99}"|sed -e "s/^.*://g")
        _RXT1[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "RX packets:[0-9]{1,99}"|sed -e "s/^.*://g")
	_TXERRORT1[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "TX .*errors:[0-9]{1,99}"|grep -E -o "errors:[0-9]{1,99}"|sed -e "s/^.*://g")
	[[ "${_TXERRORT1[${_COUNT}]}" == "" ]] && _TXERRORT1[${_COUNT}]=0
	_RXERRORT1[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "RX .*errors:[0-9]{1,99}"|grep -E -o "errors:[0-9]{1,99}"|sed -e "s/^.*://g")
	[[ "${_RXERRORT1[${_COUNT}]}" == "" ]] && _RXERRORT1[${_COUNT}]=0
	_TXDROPT1[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "TX .*dropped:[0-9]{1,99}"|grep -E -o "dropped:[0-9]{1,99}"|sed -e "s/^.*://g")
	_RXDROPT1[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "RX .*dropped:[0-9]{1,99}"|grep -E -o "dropped:[0-9]{1,99}"|sed -e "s/^.*://g")
	_TXBT1[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "TX bytes:[0-9]{1,99}"|sed -e "s/^.*://g")
	_RXBT1[${_COUNT}]=$(echo "${_COUNTERS}"|grep -A 4 -E "(${_PORT} \(|${_PORT}$)"|grep -E -o "RX bytes:[0-9]{1,99}"|sed -e "s/^.*://g")
        ((_COUNT++))
done <<< "$(echo "${_COUNTERS}"|grep -E "port [0-9]{1,99}:"|awk '{print $3}'|sort)"

if ${_STATS} ; then
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
		_TX="$( bc <<< "scale=2; ${_TXT1[${i}]} - ${_TXT0[${i}]}"|sed -e "s/^\./0./g" -e "s/^-\./-0./g" )"
		_RX="$( bc <<< "scale=2; ${_RXT1[${i}]} - ${_RXT0[${i}]}"|sed -e "s/^\./0./g" -e "s/^-\./-0./g" )"
		_TXDROP="$( bc <<< "scale=2; ${_TXDROPT1[${i}]} - ${_TXDROPT0[${i}]}"|sed -e "s/^\./0./g" -e "s/^-\./-0./g" )"
		_RXDROP="$( bc <<< "scale=2; ${_RXDROPT1[${i}]} - ${_RXDROPT0[${i}]}"|sed -e "s/^\./0./g" -e "s/^-\./-0./g" )"
		_TXE="$( bc <<< "scale=2; ${_TXERRORT1[${i}]} - ${_TXERRORT0[${i}]}"|sed -e "s/^\./0./g" -e "s/^-\./-0./g" )"
		_RXE="$( bc <<< "scale=2; ${_RXERRORT1[${i}]} - ${_RXERRORT0[${i}]}"|sed -e "s/^\./0./g" -e "s/^-\./-0./g" )"
		_TXS="$( bc <<< "scale=2; (${_TXT1[${i}]} - ${_TXT0[${i}]}) / ${_WAITSECONDS}"|sed -e "s/^\./0./g" -e "s/^-\./-0./g" )"
		_RXS="$( bc <<< "scale=2; (${_RXT1[${i}]} - ${_RXT0[${i}]}) / ${_WAITSECONDS}"|sed -e "s/^\./0./g" -e "s/^-\./-0./g" )"
		_TXRXS="$( bc <<< "scale=2; ( (${_TXT1[${i}]} - ${_TXT0[${i}]}) + (${_RXT1[${i}]} - ${_RXT0[${i}]}) ) / ${_WAITSECONDS}"|sed -e "s/^\./0./g" -e "s/^-\./-0./g" )"
		_TXDROPS="$( bc <<< "scale=2; (${_TXDROPT1[${i}]} - ${_TXDROPT0[${i}]}) / ${_WAITSECONDS}"|sed -e "s/^\./0./g" -e "s/^-\./-0./g" )"
		_RXDROPS="$( bc <<< "scale=2; (${_RXDROPT1[${i}]} - ${_RXDROPT0[${i}]}) / ${_WAITSECONDS}"|sed -e "s/^\./0./g" -e "s/^-\./-0./g" )"
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
fi

if ${_RATES} ; then
	echo -e "\n########## Open vSwitch DPDK RATES over ${_WAITSECONDS} seconds ##########"
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
		_TXB="$( numfmt --to=iec-i --suffix=B $( bc <<< "scale=2; ${_TXBT1[${i}]} - ${_TXBT0[${i}]}"|sed -e "s/^\./0./g" -e "s/^-\./-0./g" ) )"
		_RXB="$( numfmt --to=iec-i --suffix=B $( bc <<< "scale=2; ${_RXBT1[${i}]} - ${_RXBT0[${i}]}"|sed -e "s/^\./0./g" -e "s/^-\./-0./g" ) )"
		_TXR="$( numfmt --to=iec --suffix=B $( bc <<< "scale=2; ( (${_TXBT1[${i}]} - ${_TXBT0[${i}]}) / ${_WAITSECONDS} ) * 8"|sed -e "s/^\./0./g" -e "s/^-\./-0./g" )|sed -e "s/B/bps/g" )"
		_RXR="$( numfmt --to=iec --suffix=B $( bc <<< "scale=2; ( (${_RXBT1[${i}]} - ${_RXBT0[${i}]}) / ${_WAITSECONDS} ) * 8"|sed -e "s/^\./0./g" -e "s/^-\./-0./g" )|sed -e "s/B/bps/g" )"
		_TXRXR="$( numfmt --to=iec --suffix=B $( bc <<< "scale=2; ( ( (${_TXBT1[${i}]} - ${_TXBT0[${i}]}) + (${_RXBT1[${i}]} - ${_RXBT0[${i}]}) ) / ${_WAITSECONDS} ) * 8"|sed -e "s/^\./0./g" -e "s/^-\./-0./g" )| sed -e "s/B/bps/g" )"
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
fi

exit 0
