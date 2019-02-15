# Open vSwitch DPDK Statistics

## Take Network Statistics for DPDK
Generate Open vSwitch network statistics

### Example output
```
########## Open vSwitch DPDK STATS over 60 seconds ##########
                   Port             TX             RX       TX Drops       RX Drops      TX Errors      RX Errors         TX PPS         RX PPS    TX & RX PPS   TX Drops PPS   RX Drops PPS
                 br-int              0              0           3081              0              0              0              0              0              0          51.35              0
        br-int-snooper0       20998298              0              0              0              0              0      349971.63              0      349971.63              0              0
                  br-n0          14118              0           4321              0              0              0         235.30              0         235.30          72.01              0
                  br-n1          14119              0           4321              0              0              0         235.31              0         235.31          72.01              0
                  dpdk0         276564         212366              0              0              0              0        4609.40        3539.43        8148.83              0              0
                  dpdk1         251564         311087              0              0              0              0        4192.73        5184.78        9377.51              0              0
                  dpdk2       18944912        8239414              0              0              0              0      315748.53      137323.56      453072.10              0              0
                  dpdk3         502874       11211937              0              0              0              0        8381.23      186865.61      195246.85              0              0
             ovs-netdev              0              0              0              0              0              0              0              0              0              0              0
         tbr-115453ba-3              0              0             46              0              0              0              0              0              0            .76              0
         vhu0bffebd7-bd         555645         567197            635              0              0              0        9260.75        9453.28       18714.03          10.58              0
         vhu32abd017-2f        3062135       15792445              0              0              0              0       51035.58      263207.41      314243.00              0              0
         vhu3b19783d-e3         269152         272250              0              0              0              0        4485.86        4537.50        9023.36              0              0
         vhu61df6cc2-2e         240775         255882              0              0              0              0        4012.91        4264.70        8277.61              0              0
         vhud0abf04e-08       15821210        3088116              0              0              0              0      263686.83       51468.60      315155.43              0              0

########## Open vSwitch DPDK RATES over 60 seconds ##########
                   Port             TX             RX        TX Rate        RX Rate   TX & RX Rate
                 br-int             0B             0B           0B/s           0B/s           0B/s
        br-int-snooper0         3.4GiB             0B         57MB/s           0B/s         57MB/s
                  br-n0         1.2MiB             0B         20KB/s           0B/s         20KB/s
                  br-n1         1.2MiB             0B         20KB/s           0B/s         20KB/s
                  dpdk0         122MiB          55MiB        2.1MB/s        936KB/s        3.0MB/s
                  dpdk1          86MiB         145MiB        1.5MB/s        2.5MB/s        3.9MB/s
                  dpdk2         2.8GiB         1.1GiB         48MB/s         19MB/s         66MB/s
                  dpdk3          96MiB         1.5GiB        1.6MB/s         25MB/s         27MB/s
             ovs-netdev             0B             0B           0B/s           0B/s           0B/s
         tbr-115453ba-3             0B             0B           0B/s           0B/s           0B/s
         vhu0bffebd7-bd         109MiB         129MiB        1.9MB/s        2.2MB/s        4.0MB/s
         vhu32abd017-2f         414MiB         2.3GiB        6.9MB/s         39MB/s         46MB/s
         vhu3b19783d-e3         115MiB         118MiB        2.0MB/s        2.0MB/s        3.9MB/s
         vhu61df6cc2-2e          82MiB          87MiB        1.4MB/s        1.5MB/s        2.9MB/s
         vhud0abf04e-08         2.0GiB         443MiB         34MB/s        7.4MB/s         42MB/s
```
