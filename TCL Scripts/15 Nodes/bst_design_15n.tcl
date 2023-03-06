set ns [new Simulator -multicast on]
# caution:- Simulator

#Trace-file
set tf [open trace_bst_15n.tr w]
$ns trace-all $tf

#Animation-file
set nf [open animation_bst_15n.nam w]
$ns namtrace-all $nf
set f0 [open bytes_b_15_n.txt w]

#Colors for traffic
$ns color 1 gold
$ns color 2 cyan
$ns color 3 magenta
# the nam colors for the prune packets
$ns color 30 purple
# the nam colors for the graft packets
$ns color 31 green

#Intializing nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]
set n9 [$ns node]
set n10 [$ns node]
set n11 [$ns node]
set n12 [$ns node]
set n13 [$ns node]
set n14 [$ns node]

$ns at 0.0 "$n0 label \"source1\""
$ns at 0.0 "$n1 label \"source2\""
$ns at 0.0 "$n2 label \"source3\""


#Creating the link with drop-tail queue  # caution:- DropTail
$ns duplex-link $n0 $n1 10Mb 10ms DropTail
$ns duplex-link $n0 $n2 10Mb 10ms DropTail
$ns duplex-link $n1 $n2 10Mb 10ms DropTail
$ns duplex-link $n1 $n3 10Mb 10ms DropTail
$ns duplex-link $n1 $n4 10Mb 10ms DropTail
$ns duplex-link $n2 $n4 10Mb 10ms DropTail
$ns duplex-link $n2 $n5 10Mb 10ms DropTail
$ns duplex-link $n3 $n4 10Mb 10ms DropTail
$ns duplex-link $n4 $n5 10Mb 10ms DropTail
$ns duplex-link $n3 $n6 10Mb 10ms DropTail
$ns duplex-link $n3 $n7 10Mb 10ms DropTail
$ns duplex-link $n4 $n7 10Mb 10ms DropTail
$ns duplex-link $n4 $n8 10Mb 10ms DropTail
$ns duplex-link $n5 $n8 10Mb 10ms DropTail
$ns duplex-link $n5 $n9 10Mb 10ms DropTail
$ns duplex-link $n6 $n7 10Mb 10ms DropTail
$ns duplex-link $n7 $n8 10Mb 10ms DropTail
$ns duplex-link $n8 $n9 10Mb 10ms DropTail
$ns duplex-link $n10 $n11 10Mb 10ms DropTail
$ns duplex-link $n11 $n12 10Mb 10ms DropTail
$ns duplex-link $n12 $n13 10Mb 10ms DropTail
$ns duplex-link $n13 $n14 10Mb 10ms DropTail
$ns duplex-link $n6 $n10 10Mb 10ms DropTail
$ns duplex-link $n6 $n11 10Mb 10ms DropTail
$ns duplex-link $n7 $n11 10Mb 10ms DropTail
$ns duplex-link $n7 $n12 10Mb 10ms DropTail
$ns duplex-link $n8 $n12 10Mb 10ms DropTail
$ns duplex-link $n8 $n13 10Mb 10ms DropTail
$ns duplex-link $n9 $n13 10Mb 10ms DropTail
$ns duplex-link $n9 $n14 10Mb 10ms DropTail


#Setting the orientation to get the pyramid topology
$ns duplex-link-op $n0 $n1 orient left-down
$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right
$ns duplex-link-op $n1 $n3 orient left-down
$ns duplex-link-op $n1 $n4 orient right-down
$ns duplex-link-op $n2 $n4 orient left-down
$ns duplex-link-op $n2 $n5 orient right-down
$ns duplex-link-op $n3 $n4 orient right
$ns duplex-link-op $n4 $n5 orient right
$ns duplex-link-op $n3 $n6 orient left-down
$ns duplex-link-op $n3 $n7 orient right-down
$ns duplex-link-op $n4 $n7 orient left-down
$ns duplex-link-op $n4 $n8 orient right-down
$ns duplex-link-op $n5 $n8 orient left-down
$ns duplex-link-op $n5 $n9 orient right-down
$ns duplex-link-op $n6 $n7 orient right
$ns duplex-link-op $n7 $n8 orient right
$ns duplex-link-op $n8 $n9 orient right
$ns duplex-link-op $n6 $n10 orient left-down
$ns duplex-link-op $n6 $n11 orient right-down
$ns duplex-link-op $n10 $n11 orient right
$ns duplex-link-op $n7 $n11 orient left-down
$ns duplex-link-op $n7 $n12 orient right-down
$ns duplex-link-op $n11 $n12 orient right
$ns duplex-link-op $n8 $n12 orient left-down
$ns duplex-link-op $n8 $n13 orient right-down
$ns duplex-link-op $n12 $n13 orient right
$ns duplex-link-op $n9 $n13 orient left-down
$ns duplex-link-op $n9 $n14 orient right-down
$ns duplex-link-op $n13 $n14 orient right

#Setting up 3 groups namely group1,group2 and group3, and setting up its address
set group1 [Node allocaddr]
set group2 [Node allocaddr]
set group3 [Node allocaddr]

#Setting up BST protocol. -->Bidirectional
BST set RP_($group1) $n3
BST set RP_($group2) $n4
BST set RP_($group3) $n5
$ns mrtproto BST
$ns at 0.0 "$n3 label \"RP-G1\""
$ns at 0.0 "$n4 label \"RP-G2\""
$ns at 0.0 "$n5 label \"RP-G3\""

#Now setting-up source for both groups (udp-cbr)
#source1
set udp1 [new Agent/UDP]
$ns attach-agent $n0 $udp1
$udp1 set dst_addr_ $group1
$udp1 set dst_port_ 0
$udp1 set fid_ 1
set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1
$cbr1 set packetSize_ 3000  # I have set packet size because i am only able to see thin stripes of packet,thus unable to see it properly
#source2

set udp2 [new Agent/UDP]
$ns attach-agent $n1 $udp2
$udp2 set dst_addr_ $group2
$udp2 set dst_port_ 0
$udp2 set fid_ 2
set cbr2 [new Application/Traffic/CBR]
$cbr2 attach-agent $udp2
$cbr2 set packetSize_ 3000

set udp3 [new Agent/UDP]
$ns attach-agent $n2 $udp3
$udp3 set dst_addr_ $group3
$udp3 set dst_port_ 0
$udp3 set fid_ 3
set cbr3 [new Application/Traffic/CBR]
$cbr3 attach-agent $udp3
$cbr3 set packetSize_ 3000

set rcvr1 [new Agent/LossMonitor]
$ns attach-agent $n3 $rcvr1
$ns at 1.0 "$n3 join-group $rcvr1 $group2"
$ns at 1.0 "$n3 label \"RP-G1 & group2\""

set rcvr2 [new Agent/LossMonitor]
$ns attach-agent $n5 $rcvr2
$ns at 1.5 "$n5 join-group $rcvr2 $group1"
$ns at 1.5 "$n5 label \"RP-G3 & group1\""

set rcvr3 [new Agent/LossMonitor]
$ns attach-agent $n6 $rcvr3
$ns at 2.0 "$n6 join-group $rcvr3 $group1"
$ns at 2.0 "$n6 label \"group1\""

set rcvr4 [new Agent/LossMonitor]
$ns attach-agent $n7 $rcvr4
$ns at 2.5 "$n7 join-group $rcvr4 $group3"
$ns at 2.5 "$n7 label \"group3\""

set rcvr5 [new Agent/LossMonitor]
$ns attach-agent $n8 $rcvr5
$ns at 3.0 "$n8 join-group $rcvr5 $group3"
$ns at 3.0 "$n8 label \"group3\""

set rcvr6 [new Agent/LossMonitor]
$ns attach-agent $n9 $rcvr6
$ns at 3.5 "$n9 join-group $rcvr6 $group2"
$ns at 3.5 "$n9 label \"group2\""

set rcvr7 [new Agent/LossMonitor]
$ns attach-agent $n10 $rcvr7
$ns at 4.0 "$n10 join-group $rcvr7 $group2"
$ns at 4.0 "$n10 label \"group2\""

set rcvr8 [new Agent/LossMonitor]
$ns attach-agent $n11 $rcvr8
$ns at 4.5 "$n11 join-group $rcvr8 $group1"
$ns at 4.5 "$n11 label \"group1\""

set rcvr9 [new Agent/LossMonitor]
$ns attach-agent $n12 $rcvr9
$ns at 5.0 "$n12 join-group $rcvr9 $group3"
$ns at 5.0 "$n12 label \"group3\""

set rcvr10 [new Agent/LossMonitor]
$ns attach-agent $n13 $rcvr10
$ns at 5.5 "$n13 join-group $rcvr10 $group1"
$ns at 5.5 "$n13 label \"group1\""

set rcvr11 [new Agent/LossMonitor]
$ns attach-agent $n14 $rcvr11
$ns at 6.0 "$n14 join-group $rcvr11 $group2"
$ns at 6.0 "$n14 label \"group2\""

#Now the nodes are leaving group
$ns at 7.0 "$n3 leave-group $rcvr1 $group2"
$ns at 7.0 "$n3 label \"RP-G1 \""
$ns at 7.5 "$n5 leave-group $rcvr2 $group1"
$ns at 7.5 "$n5 label \"RP-G3 \""
$ns at 8.0 "$n6 leave-group $rcvr3 $group1"
$ns at 8.0 "$n6 label \" \""
$ns at 8.5 "$n7 leave-group $rcvr4 $group3"
$ns at 8.5 "$n7 label \" \""
$ns at 9.0 "$n8 leave-group $rcvr5 $group3"
$ns at 9.0 "$n8 label \" \""
$ns at 9.5 "$n9 leave-group $rcvr6 $group2"
$ns at 9.5 "$n9 label \" \""
$ns at 10.0 "$n10 leave-group $rcvr7 $group2"
$ns at 10.0 "$n10 label \" \""
$ns at 10.5 "$n11 leave-group $rcvr8 $group1"
$ns at 10.5 "$n11 label \" \""
$ns at 11.0 "$n12 leave-group $rcvr9 $group3"
$ns at 11.0 "$n12 label \" \""
$ns at 11.5 "$n13 leave-group $rcvr10 $group1"
$ns at 11.5 "$n13 label \" \""
$ns at 12.0 "$n14 leave-group $rcvr11 $group2"
$ns at 12.0 "$n14 label \" \""

proc record {} {
global rcvr1 rcvr2 rcvr3 rcvr4 rcvr5 rcvr6 f0 rcvr7 rcvr8 rcvr9 rcvr10 rcvr11 
global cbr1 cbr2 cbr3
set ns [Simulator instance]
set time 0.2
set bw1 [$rcvr1 set bytes_]
set bw2 [$rcvr2 set bytes_]
set bw3 [$rcvr3 set bytes_]
set bw4 [$rcvr4 set bytes_]
set bw5 [$rcvr5 set bytes_]
set bw6 [$rcvr6 set bytes_]
set bw7 [$rcvr7 set bytes_]
set bw8 [$rcvr8 set bytes_]
set bw9 [$rcvr9 set bytes_]
set bw10 [$rcvr10 set bytes_]
set bw11 [$rcvr11 set bytes_]

set now [$ns now]
puts $f0 "$now [expr ($bw1+$bw2+$bw3+$bw4+$bw5+$bw6+$bw7+$bw8+$bw9+$bw10+$bw11)/$time*8/1000000]"
# Calculating the average throughput

$rcvr1 set bytes_ 0
$rcvr2 set bytes_ 0
$rcvr3 set bytes_ 0
$rcvr4 set bytes_ 0
$rcvr5 set bytes_ 0
$rcvr6 set bytes_ 0
$rcvr7 set bytes_ 0
$rcvr8 set bytes_ 0
$rcvr9 set bytes_ 0
$rcvr10 set bytes_ 0
$rcvr11 set bytes_ 0
$ns at [expr $now+$time] "record"
}
$ns at 0.0 "record"

#Starting the traffic at specified tim
$ns at 0.5 "$cbr1 start"
$ns at 12.5 "$cbr1 stop"
$ns at 0.5 "$cbr2 start"
$ns at 12.5 "$cbr2 stop"
$ns at 0.5 "$cbr3 start"
$ns at 12.5 "$cbr3 stop"


#Termination, with file closing and calling a procedure
$ns at 13 "finish"
proc finish {} {
global ns tf nf
$ns flush-trace
close $tf
close $nf
exec nam animation_bst_15n.nam &
exit 0
}

$ns run
