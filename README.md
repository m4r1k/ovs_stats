# Open vSwitch DPDK Statistics
## Take Network Statistics for DPDK
Generate Open vSwitch DPDK network statistics
- Simple and easy to understand shell script
- Aggregate port statistics showing RX, TX, drops, and errors
- Aggregate port rates showing RX and TX total MB and MB/s
- OVS-DPDK specific
- Lightweight executing only two Open vSwitch commands
- Precise time different calculator ensuring the Open vSwitch command overhead is taken into account while calculating the packet per seconds statistics
### Example output
```
########## Open vSwitch DPDK STATS over 60 seconds ##########
                   Port             TX             RX       TX Drops       RX Drops      TX Errors      RX Errors         TX PPS         RX PPS    TX & RX PPS   TX Drops PPS   RX Drops PPS
                 br-int              0              0           3083              0              0              0              0              0              0          51.38              0
        br-int-snooper0       21052709              0              0              0              0              0      350878.48              0      350878.48              0              0
                  br-n0          14152              0           4335              0              0              0         235.86              0         235.86          72.25              0
                  br-n1          14152              0           4335              0              0              0         235.86              0         235.86          72.25              0
                  dpdk0         314693         251031              0              0              0              0        5244.88        4183.85        9428.73              0              0
                  dpdk1         296587         353529              0              0              0              0        4943.11        5892.15       10835.26              0              0
                  dpdk2       18782217        8250190              0              0              0              0      313036.95      137503.16      450540.11              0              0
                  dpdk3         496948       11021767              0              0              0              0        8282.46      183696.11      191978.58              0              0
             ovs-netdev              0              0              0              0              0              0              0              0              0              0              0
         tbr-115453ba-3              0              0             46              0              0              0              0              0              0           0.76              0
         vhu0bffebd7-bd         624900         646944            423              0              0              0       10415.00       10782.40       21197.40           7.05              0
         vhu32abd017-2f        2871629       15732746              0              0              0              0       47860.48      262212.43      310072.91              0              0
         vhu3b19783d-e3         325250         330165              0              0              0              0        5420.83        5502.75       10923.58              0              0
         vhu61df6cc2-2e         265737         281096              0              0              0              0        4428.95        4684.93        9113.88              0              0
         vhud0abf04e-08       15763264        2899455              0              0              0              0      262721.06       48324.25      311045.31              0              0

########## Open vSwitch DPDK RATES over 60 seconds ##########
                   Port             TX             RX        TX Rate        RX Rate   TX & RX Rate
                 br-int             0B             0B           0bps           0bps           0bps
        br-int-snooper0         3.4GiB             0B        462Mbps           0bps        462Mbps
                  br-n0         1.2MiB             0B        160Kbps           0bps        160Kbps
                  br-n1         1.2MiB             0B        160Kbps           0bps        160Kbps
                  dpdk0         121MiB          75MiB         17Mbps         10Mbps         26Mbps
                  dpdk1         119MiB         158MiB         16Mbps         21Mbps         37Mbps
                  dpdk2         2.8GiB         1.1GiB        379Mbps        145Mbps        524Mbps
                  dpdk3         102MiB         1.5GiB         14Mbps        196Mbps        209Mbps
             ovs-netdev             0B             0B           0bps           0bps           0bps
         tbr-115453ba-3             0B             0B           0bps           0bps           0bps
         vhu0bffebd7-bd         116MiB         165MiB         16Mbps         22Mbps         38Mbps
         vhu32abd017-2f         388MiB         2.3GiB         52Mbps        306Mbps        358Mbps
         vhu3b19783d-e3         137MiB         140MiB         19Mbps         19Mbps         37Mbps
         vhu61df6cc2-2e          92MiB          97MiB         13Mbps         13Mbps         26Mbps
         vhud0abf04e-08         2.0GiB         426MiB        271Mbps         57Mbps        328Mbps
```
