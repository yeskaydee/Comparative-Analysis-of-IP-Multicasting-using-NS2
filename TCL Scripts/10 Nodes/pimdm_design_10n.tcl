set ns [new Simulator -multicast on]
# caution:- Simulator

#Trace-file
set tf [open trace_pimdm.tr w]
$ns trace-all $tf

#Animation-file
set nf [open animation_pimdm.nam w]
$ns namtrace-all $nf
set f0 [open bytes_p_10_n.tr w]


#Colors for traffic
$ns color 1 red
$ns color 2 blue
$ns color 3 yellow
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


$n3 color blue
$n7 color yellow
$n9 color blue
$n5 color red
$n6 color red
$n8 color yellow

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


#Setting up PIMDM protocol, which return mrthandle as a handle

set mproto DM
set mrthandle [$ns mrtproto $mproto]

#Setting up 3 groups namely group1,group2 and group3, and setting up its address
set group1 [Node allocaddr]
set group2 [Node allocaddr]
set group3 [Node allocaddr]

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
#source3
set udp3 [new Agent/UDP]
$ns attach-agent $n2 $udp3
$udp3 set dst_addr_ $group3
$udp3 set dst_port_ 0
$udp3 set fid_ 3
set cbr3 [new Application/Traffic/CBR]
$cbr3 attach-agent $udp3
$cbr3 set packetSize_ 3000

# Create receiver to accept the packets

set rcvr1 [new Agent/LossMonitor]
$ns attach-agent $n3 $rcvr1
$ns at 1.0 "$n3 join-group $rcvr1 $group2"
$ns at 1.0 "$n3 label \"group2\""

set rcvr2 [new Agent/LossMonitor]
$ns attach-agent $n5 $rcvr2
$ns at 1.5 "$n5 join-group $rcvr2 $group1"
$ns at 1.5 "$n5 label \"group1\""

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


#Now the nodes are leaving group
$ns at 4.5 "$n3 leave-group $rcvr1 $group2"
$ns at 4.5 "$n3 label \" \""
$ns at 5.0 "$n5 leave-group $rcvr2 $group1"
$ns at 5.0 "$n5 label \" \""
$ns at 5.5 "$n6 leave-group $rcvr3 $group1"
$ns at 5.5 "$n6 label \" \""
$ns at 6.0 "$n7 leave-group $rcvr4 $group3"
$ns at 6.0 "$n7 label \" \""
$ns at 6.5 "$n8 leave-group $rcvr5 $group3"
$ns at 6.5 "$n8 label \" \""
$ns at 7.0 "$n9 leave-group $rcvr6 $group2"
$ns at 7.0 "$n3 label \" \""

proc record {} {
global rcvr1 rcvr2 rcvr3 rcvr4 rcvr5 rcvr6 f0
global cbr1 cbr2 cbr3
set ns [Simulator instance]
set time 0.2
set bw1 [$rcvr1 set bytes_]
set bw2 [$rcvr2 set bytes_]
set bw3 [$rcvr3 set bytes_]
set bw4 [$rcvr4 set bytes_]
set bw5 [$rcvr5 set bytes_]
set bw6 [$rcvr6 set bytes_]

set now [$ns now]
puts $f0 "$now [expr ($bw1+$bw2+$bw3+$bw4+$bw5+$bw6)/$time*8/1000000]"


$rcvr1 set bytes_ 0
$rcvr2 set bytes_ 0
$rcvr3 set bytes_ 0
$rcvr4 set bytes_ 0
$rcvr5 set bytes_ 0
$rcvr6 set bytes_ 0
$ns at [expr $now+$time] "record"
}
$ns at 0.0 "record"

#Starting the traffic at specified tim
$ns at 0.5 "$cbr1 start"
$ns at 8.0 "$cbr1 stop"
$ns at 0.5 "$cbr2 start"
$ns at 8.0 "$cbr2 stop"
$ns at 0.5 "$cbr3 start"
$ns at 8.0 "$cbr3 stop"

#Termination, with file closing and calling a procedure
$ns at 8.5 "finish"
proc finish {} {
global ns tf nf
$ns flush-trace
close $tf
close $nf
exec nam animation_pimdm.nam &
exit 0
}

$ns run
