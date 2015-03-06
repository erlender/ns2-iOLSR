#remove-all-packet-headers       ;# removes all except common
#add-packet-header IP Message     ;# hdrs reqd for cbr traffic


if { $argc < 2 || $argc > 2 } {
        puts "Command line usage: ns <script-name.ext> gilbertchange seed "
        exit -1
}

#options
set opt(gilbertchange)		[lindex $argv 0] ;# Probability of a good link going bad. In millionths. 
set opt(seed)			[lindex $argv 1]




# set up the antennas to be centered in the node and 1.5 meters above it
Antenna/OmniAntenna set X_ 0
Antenna/OmniAntenna set Y_ 0
Antenna/OmniAntenna set Z_ 1.5
Antenna/OmniAntenna set Gt_ 1.0
Antenna/OmniAntenna set Gr_ 1.0

# Initialize the SharedMedia interface with parameters to make
# it work like 802.11b DSSS radio interface
Phy/WirelessPhy set CPThresh_ 10.0
Phy/WirelessPhy set CSThresh_ 1.559e-11;   # 550m
#Phy/WirelessPhy set CSThresh_ 3.652e-10;   # 250m
Phy/WirelessPhy set RXThresh_ 3.652e-10;    # 250m
Phy/WirelessPhy set Pt_ 0.28183815
Phy/WirelessPhy set freq_ 2.4e+9 
Phy/WirelessPhy set L_ 1.0

Mac/802_11 set SlotTime_          0.000020        ;# 20us
Mac/802_11 set SIFS_              0.000010        ;# 10us
Mac/802_11 set PreambleLength_    144             ;# 144 bit
Mac/802_11 set PLCPHeaderLength_  48              ;# 48 bits
Mac/802_11 set PLCPDataRate_      1.0e6           ;# 1Mbps

#you can set dataRate for DATA here
Mac/802_11 set dataRate_ 2e6
#you can set basicRate for RTS/CTS, and ACK here
Mac/802_11 set basicRate_ 1e6

Mac/802_11 set RTSThreshold_ 3000
Mac/802_11 set ShortRetryLimit_ 7 ;# NOTE NOTE NOTE
Mac/802_11 set LongRetryLimit_ 4



Agent/UDP set packetSize_ 1500

Agent/OLSR set debug_       false
Agent/OLSR set use_mac_     true ;# NOTE NOTE NOTE
Agent/OLSR set willingness_ 3
Agent/OLSR set hello_ival_  2.0
Agent/OLSR set tc_ival_     5.0
Agent/OLSR set mid_ival_    5.0

Agent/OLSR set wsn_z_base_ 2;
Agent/OLSR set wsn_z_incr_ 0;




Mac/802_11 set gilbertchange $opt(gilbertchange) ;# in millionth
Mac/802_11 set ingress false;
Agent/OLSR set immediatetrans_ false;
Agent/OLSR set tcsolicit_ false;
Agent/OLSR set reversetc_ false;
Agent/OLSR set vtimeweight_ 1;
Agent/OLSR set tcttl_ true;
Agent/OLSR set force_vttc_max_ true;

set opt(nn) 40


# more options
set opt(fname)		"simresults"
set opt(nm)		"$opt(fname).nam"
set opt(tr)		"$opt(fname)_$opt(gilbertchange)_$opt(seed).tr"	;# trace file
set opt(chan)		Channel/WirelessChannel

set opt(prop)		Propagation/TwoRayGround
set opt(netif)		Phy/WirelessPhy
set opt(mac)		Mac/802_11
set opt(ifq)		Queue/DropTail/PriQueue
set opt(ll)			LL
set opt(ant)        Antenna/OmniAntenna
set opt(sc) "../../top/1500x300/0mps/$opt(nn)nodes/$opt(seed).top"
set opt(x)			1500	;# X & Y dimension of the topography
set opt(y)			300     ;# hard wired for now...
set opt(ifqlen)		30		;# max packet in ifq
set opt(rp)         OLSR    ;# routing protocls: dsdv/dsr
set opt(pktsz)		50.0;
set opt(pktsz_wh)		[expr $opt(pktsz)+20];
set opt(cbrstart)	    500.0;
set val(engmodel)       EnergyModel
set val(txPower)        0.175                       ;# transmitting power in mW
set val(rxPower)        0.175                       ;# recving power in mW
set val(sensePower)     0.00000175;                 ;# sensing power in mW
set val(idlePower)      0.0                         ;# idle power in mW
set val(initeng)        5000.0                        ;# Initial energy in Joules
set val(initlowengmax)        [expr $val(initeng)/2.0];# Half of the other nodes
set val(initlowengmin)        [expr $val(initeng)/4.0];#  1/4 of the other nodes

#puts "packet size is $opt(pktsz) and load is $opt(flowload)"

# create simulator instance
set ns_ [new Simulator]

# Set seed to 0 to employ heuristic seed, instead of a pre-defined seed.
puts "Setting seed to 0 (heuristic)"

#puts "OBSERVE! SEED is now 1 !!!!!!! --------------- ------- ---------"
ns-random 0

# Trace file settings
$ns_ use-newtrace
set tracefd [open $opt(tr) w]
set namtrace [open $opt(nm) w]
$ns_ trace-all $tracefd
$ns_ namtrace-all-wireless $namtrace $opt(x) $opt(y)

# Set topograpyh
set topo	[new Topography]
$topo load_flatgrid $opt(x) $opt(y)

set opt(stop)		18000.0		;# simulation time
#set opt(nn)         10        ;# total number of wireless nodes





# Create God
create-god [expr $opt(nn)]

$ns_ node-config -adhocRouting $opt(rp) \
		 -llType $opt(ll) \
		 -macType $opt(mac) \
		 -ifqType $opt(ifq) \
		 -ifqLen $opt(ifqlen) \
         -antType $opt(ant) \
         -phyType $opt(netif) \
         -propInstance [new $opt(prop)] \
         -channel [new $opt(chan)] \
         -topoInstance $topo \
         -wiredRouting OFF \
         -agentTrace ON \
         -routerTrace ON \
         -macTrace ON \
		 -movementTrace OFF \
		 -mobileIP OFF \
		 -energyModel $val(engmodel) \
     	-rxPower $val(rxPower) \
     	-txPower $val(txPower) \
     	-sensePower $val(sensePower) \
     	-idlePower $val(idlePower) \
     	-initialEnergy $val(initeng)




#set lowm $opt(nodechange)
#set lowmpc [expr $opt(nodechange)*100.0/$opt(nn)]
#puts "lowm is $lowmpc %"

#[expr int(floor(rand()*($opt(nn)-$lowm)))+$lowm]
#$ns_ node-config -initialEnergy $val(initloweng)

#for {set i 0} {$i < $lowm} {incr i} {
#	set lnenergy [expr rand()*($val(initlowengmax)-$val(initlowengmin))+$val(initlowengmin)]
#	$ns_ node-config -initialEnergy $lnenergy
#	puts "node $i is set with initial energy at $lnenergy"
#	set node_($i) [$ns_ node]	
#	$node_($i) random-motion 0	;# disable random motion     
#}



$ns_ node-config -initialEnergy $val(initeng)



for {set i 0} {$i <  $opt(nn) } {incr i} {
	set node_($i) [$ns_ node]	
	$node_($i) random-motion 0	;# disable random motion     
	#puts "Routing access from mac for node $i: "
	set nmac_($i) [$node_($i) set mac_(0)]
	set nolsr_($i) [$node_($i) agent 255]
	$nmac_($i) register-olsr $nolsr_($i)  
}
































# create topology
# Define node movement model
#
puts "Creating topology."
source $opt(sc)


#Sink is random, thus this is commented.
#$node_(39) set X_ 0.1
#$node_(39) set Y_ 150

#set k 0
#for {set i 0} {$i < 5 } {incr i} {
	#for {set j 0} {$j < 5 } {incr j} {
		#$node_($k) set X_ [expr $i* 200.0]
		#$node_($k) set Y_ [expr $j* 200.0]
		#incr k
	#}
#}

#$node_(0) set X_ 0.1
#$node_(0) set Y_ 150
#$node_(1) set X_ 150
#$node_(1) set Y_ 300
#$node_(2) set X_ 300
#$node_(2) set Y_ 300
#$node_(3) set X_ 450
#$node_(3) set Y_ 300
#$node_(4) set X_ 600
#$node_(4) set Y_ 300
#$node_(5) set X_ 150
#$node_(5) set Y_ 0.1
#$node_(6) set X_ 370
#$node_(6) set Y_ 0.1
#$node_(7) set X_ 600
#$node_(7) set Y_ 0.1
#$node_(8) set X_ 750
#$node_(8) set Y_ 150
#$node_(9) set X_ 900
#$node_(9) set Y_ 150





for {set i 0} {$i < $opt(nn)} {incr i} {
#	$ns_ at 0.0 "$node_($i) label \"Node $i\""
	$ns_ initial_node_pos $node_($i) 30
}




set pfl_pps 1


set receiver [expr $opt(nn)-1] ;# sink is always the last node
set cbrstarttime $opt(cbrstart)
set pause 0
set duration 1
#set cbrstoptime [expr $opt(cbrstart)+$duration]
set flowcnt 0
#while {$cbrstarttime<=$opt(stop)} {
#set sender $receiver
#while {$sender<=$lowm || $sender==$receiver} {
#	set sender [expr int(floor(rand()*($opt(nn)-$lowm)))+$lowm]
#}

# All nodes send to sink
for {set i 0} {$i<$opt(nn)-1} {incr i} {
	set sender $i;
	
	set udp($flowcnt) [new Agent/UDP]
	set sink($flowcnt) [new Agent/LossMonitor]
	set cbr($flowcnt) [new Application/Traffic/CBR]
	$udp($flowcnt) set class_ 1
	$udp($flowcnt) set prio_ 1
	$ns_ attach-agent $node_($sender) $udp($flowcnt)
	$ns_ attach-agent $node_($receiver) $sink($flowcnt)
	$ns_ connect $udp($flowcnt) $sink($flowcnt)
	$cbr($flowcnt) set packetSize_ $opt(pktsz)
	if { $pfl_pps != 0 } {			
		$cbr($flowcnt) set interval_ [expr 1.0/"$pfl_pps"]
		$cbr($flowcnt) set random_ 1
		$cbr($flowcnt) attach-agent $udp($flowcnt)
		$ns_ at $cbrstarttime "$cbr($flowcnt) start"
	#	$ns_ at $cbrstoptime "$cbr($flowcnt) stop"

		#puts "$cbrstarttime: flow $flowcnt from $sender to $receiver"

		incr flowcnt	
		set cbrstarttime [expr $cbrstarttime+1]
#		set cbrstoptime [expr $cbrstarttime+$duration]
	}
	
}
#}

# create common objects reqd for wireless sim.
if { $opt(x) == 0 || $opt(y) == 0 } {
	puts "No X-Y boundary values given for wireless topology\n"
}

#puts "Seeding Random number generator with $opt(seed)\n"
#ns-random $opt(seed)


for {set i 100} {$i<140} {incr i} {
	for {set j 5} {$j < 10} {incr j} {
		#$ns_ at $i "[$node_($j) agent 255] print_rtable"
		#$ns_ at $i "[$node_($j) agent 255] print_linkset"
		#$ns_ at $i "[$node_($j) agent 255] print_nbset"
		#$ns_ at $i "[$node_($j) agent 255] print_midset"
		#$ns_ at $i "[$node_($j) agent 255] print_nb2hopset"
		#$ns_ at $i "[$node_($j) agent 255] print_mprset"
		#$ns_ at $i "[$node_($j) agent 255] print_mprselset"
		#$ns_ at $i "[$node_($j) agent 255] print_topologyset"
	}
	}


# Tell all the nodes when the simulation ends

for {set i 0} {$i < $opt(nn) } {incr i} {
    $ns_ at $opt(stop).0000010 "$node_($i) reset";
}

$ns_ at $opt(stop) "$ns_ nam-end-wireless $opt(stop)"
$ns_ at $opt(stop).21 "finish"
$ns_ at $opt(stop).20 "puts \"NS EXITING...\" ; "

proc finish {} {
	global ns_ tracefd namtrace f0 f1 fu opt
	$ns_ flush-trace
	#Close the output files
	close $namtrace
	close $tracefd	
    puts "\nFinishing ns.."
	exit 0
}

#Show progress info.
source "~/scripts/tcl/timenotify.tcl"
$ns_ at 0.9 "timenotify"

puts "Starting Simulation..."
$ns_ run

