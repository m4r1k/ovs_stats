# Open vSwitch DPDK Statistics

## Take Network Statistics for DPDK
Generate Open vSwitch network statistics

### Example output
```
########## Open vSwitch DPDK STATS over 300 seconds ##########
                   Port             TX             RX       TX Drops       RX Drops      TX Errors      RX Errors         TX PPS         RX PPS    TX & RX PPS   TX Drops PPS   RX Drops PPS
                 br-int              0              0       52116093              0              0              0              0              0              0          51.61              0
        br-int-snooper0    95404323462              0              0              0              0              0      351629.06              0      351629.06              0              0
                  br-n0      253722977              8       74113822              0              0              0         235.75              0         235.75          71.86              0
                  br-n1      253721746              8       74114040              0              0              0         235.73              0         235.73          71.85              0
                  dpdk0     2304183064     1749629323              0              0              0              0        5037.01        3753.33        8790.35              0              0
                  dpdk1     1708314351     2377954475              0              0              0              0        3607.91        4792.11        8400.03              0              0
                  dpdk2   158265561382   100683404067              0           3166              0              0       52733.61      146433.93      199167.55              0              0
                  dpdk3    64521888856   122626420532              0           2429              0              0      272924.00      179313.26      452237.26              0              0
             ovs-netdev              0              0              0              0              0              0              0              0              0              0              0
         tbr-e36bb74d-1              0              0         774770              0              0              0              0              0              0            .76              0
         vhu30435df2-3a   180866166427    30855651250         479504              0                             0      265660.08       50678.68      316338.76              0              0
         vhu38309cc7-8c     2019108751     2141605466           1060              0                             0        4088.40        4358.58        8446.98              0              0
         vhubf1a0856-72     1864751199     1870821933            523              0                             0        4231.26        4286.30        8517.56              0              0
         vhud40edf72-6c    30522408120   180062419688          15870              0                             0       50280.10      265174.35      315454.45              0              0
         vhud5de0985-00    11671176412    11869309218       36318702              0                             0        9610.15        9804.25       19414.40           3.35              0

########## Open vSwitch DPDK RATES ##########
                   Port             TX             RX        TX Rate        RX Rate   TX & RX Rate
                 br-int             0B             0B           0B/s           0B/s           0B/s
        br-int-snooper0          16TiB             0B         57MB/s           0B/s         57MB/s
                  br-n0          21GiB           648B         20KB/s           0B/s         20KB/s
                  br-n1          21GiB           648B         20KB/s           0B/s         20KB/s
                  dpdk0         806GiB         424GiB        1.8MB/s        994KB/s        2.7MB/s
                  dpdk1         663GiB         987GiB        1.5MB/s        2.0MB/s        3.4MB/s
                  dpdk2          24TiB          14TiB        8.0MB/s         20MB/s         28MB/s
                  dpdk3          11TiB          16TiB         42MB/s         24MB/s         65MB/s
             ovs-netdev             0B             0B           0B/s           0B/s           0B/s
         tbr-e36bb74d-1             0B             0B           0B/s           0B/s           0B/s
         vhu30435df2-3a          23TiB         4.7TiB         35MB/s        7.4MB/s         42MB/s
         vhu38309cc7-8c         622GiB         683GiB        1.4MB/s        1.6MB/s        2.9MB/s
         vhubf1a0856-72         755GiB         771GiB        1.6MB/s        1.6MB/s        3.1MB/s
         vhud40edf72-6c         4.3TiB          26TiB        6.8MB/s         39MB/s         46MB/s
         vhud5de0985-00         2.3TiB         2.7TiB        1.8MB/s        2.2MB/s        4.0MB/s
```
