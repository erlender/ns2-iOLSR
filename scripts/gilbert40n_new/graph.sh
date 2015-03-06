#datacols="1:(\$2+\$3+\$4+\$5+\$6+\$7+\$8+\$9+\$10+\$11)/10:12";linestype="yerrorlines"
#datacols="1:(\$2+\$3+\$4+\$5+\$6+\$7+\$8+\$9+\$10+\$11)/10";linestype="linespoints"

#datacols="1:(\$2+\$3+\$4+\$5+\$6+\$7+\$8+\$9+\$10+\$11+\$12+\$13+\$14+\$15+\$16+\$17+\$18+\$19+\$20+\$21+\$22+\$23+\$24+\$25+\$26+\$27+\$28+\$29+\$30+\$31)/30:32";linestype="yerrorlines"
datacols="(\$1/1000000):(\$2+\$3+\$4+\$5+\$6+\$7+\$8+\$9+\$10+\$11)/10:12";linestype="yerrorlines"




#size="0.8,0.5"
#size="0.8,0.4"
size="1.0,0.8"
fontsize="20"
lw="4" # line width
ps="2" # point size



# iOLSR
for i in collisions goodput ifq loop nrte ret ttl; do # arp cbk collisions delay end goodput hops ifq jitter loop nrte recvspp sentpkts transmissions ttl; do
touch tmp.tmp;
rm tmp.tmp;
t="reset;"
#t="$t set title \"Study of node birth impact\";"
t="$t set size $size;"
t="$t set border 3;"
t="$t set autoscale;"
t="$t set xlabel 'Link burst error probability';"
t="$t set xrange [0.00001:0.1];";
t="$t set log x;";
t="$t set key below;"
#t="$t set key box;"

#t="$t set key bottom left;"
#t="$t set key width -2;"
t="$t set grid;"
if [ $i == "cbk" ]; then 
t="$t set ylabel 'Packets lost';";
t="$t set yrange [0:*];";
elif [ $i == "collisions" ]; then
t="$t set ylabel 'Collisions';";
t="$t set logscale y;";
#t="$t set key outside;"
#t="$t set yrange [0:*];";
elif [ $i == "delay" ]; then 
t="$t set ylabel '$i (s)';";
#t="$t set yrange [0:0.1];";
elif [ $i == "goodput" ]; then 
t="$t set ylabel 'Goodput (%)';";
t="$t set yrange [*:100];";
#t="$t set key bottom left;"

#elif [ $i == "jitter" ]; then 
#t="$t set ylabel 'Jitter (s)';";
#t="$t set yrange [0:0.5];";
elif [ $i == "hops" ]; then
t="$t set ylabel 'Hops';";
elif [ $i == "loop" ]; then 
t="$t set ylabel 'Packets lost';";
t="$t set yrange [0:*];";
elif [ $i == "nrte" ]; then 
t="$t set ylabel 'Packets lost';";
t="$t set yrange [1:*];";
t="$t set logscale y;";
#t="$t set key top left;"
elif [ $i == "recvspp" ]; then 
t="$t set ylabel 'Received copies';";
elif [ $i == "ret" ]; then 
t="$t set ylabel 'Packets lost';";
t="$t set yrange [0:*];";
elif [ $i == "transmissions" ]; then 
t="$t set ylabel '$i';";
#t="$t set yrange [0:*];";
elif [ $i == "ttl" ]; then 
t="$t set ylabel 'Packets lost';";
t="$t set yrange [0:*];";
#t="$t set key top left;"
else
t="$t set ylabel '$i';";
#t="$t set yrange [0:*];";
fi
t="$t set terminal postscript color 'Computer Modern Roman' $fontsize eps;"
t="$t set output 'pdf/gilbert40n_iolsr_"$i".eps';"


t="$t set xtics nomirror;"
t="$t set ytics nomirror;"
t="$t plot";

col=1;
t="$t 'plainolsr_2/results/600-5900s_tos1_$i.coi' using $datacols title '2s Hello' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
t="$t 'plainolsr_20/results/600-5900s_tos1_$i.coi' using $datacols title '20s Hello' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
t="$t 'plainolsr_100/results/600-5900s_tos1_$i.coi' using $datacols title '100s Hello' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
#t="$t 'wsnolsr/results/600-5900s_tos1_$i.coi' using $datacols title 'iOLSR' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1"
let col=col+1;
t="$t 'wsnolsr_exp2/results/600-5900s_tos1_$i.coi' using $datacols title 'iOLSR' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1"
let col=col+2;
#t="$t 'aodv/results/600-5900s_tos1_$i.coi' using $datacols title 'AODV' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;


echo $t >> tmp.tmp;
gnuplot tmp.tmp;
done;




# WSNOLSR dissected Total graphs
for i in rtrtrans; do #  rtrtrans tottran; do
touch tmp.tmp;
rm tmp.tmp;
t="reset;"
#t="$t set title \"Study of node birth impact\";"
t="$t set size $size;"
t="$t set border 3;"
t="$t set autoscale;"
t="$t set xlabel 'Link burst error probability';"
t="$t set xrange [0.00001:0.1];";
t="$t set log x;";
t="$t set key below;"
#t="$t set key bottom left;"
#t="$t set key width -2;"
#t="$t set key box;"
t="$t set grid;"

#t="$t set yrange [0:*];";
if [ $i == "rtrtrans" ]; then 
t="$t set ylabel 'Transmissions';";
#t="$t set key right center;";
t="$t set logscale y;";
#t="$t set key right;";
t="$t set yrange [*:*];";

elif [ $i == "tottrans" ]; then 
t="$t set ylabel 'Transmissions';";
t="$t set yrange [0:*];";
else
t="$t set ylabel '$i';";

fi
t="$t set terminal postscript color 'Computer Modern Roman' $fontsize eps;"
t="$t set output 'pdf/gilbert40n_iolsr_"$i".eps';"

t="$t set xtics nomirror;"
t="$t set ytics nomirror;"
t="$t plot";

col=1;
t="$t 'plainolsr_2/results/600-5900s_$i.coi' using $datacols title '2s Hello' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
t="$t 'plainolsr_20/results/600-5900s_$i.coi' using $datacols title '20s Hello' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
t="$t 'plainolsr_100/results/600-5900s_$i.coi' using $datacols title '100s Hello' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;

#t="$t 'wsnolsr/results/600-5900s_$i.coi' using $datacols title 'iOLSR' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1"
let col=col+1;
t="$t 'wsnolsr_exp2/results/600-5900s_$i.coi' using $datacols title 'iOLSR' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1"
let col=col+2;
#t="$t 'aodv/results/600-5900s_$i.coi' using $datacols title 'AODV' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;


echo $t >> tmp.tmp;
gnuplot tmp.tmp;
done;



# iOLSR
for i in collisions goodput ifq loop nrte ret ttl; do # arp cbk collisions delay end goodput hops ifq jitter loop nrte recvspp sentpkts transmissions ttl; do
touch tmp.tmp;
rm tmp.tmp;
t="reset;"
#t="$t set title \"Study of node birth impact\";"
t="$t set size $size;"
t="$t set border 3;"
t="$t set autoscale;"
t="$t set xlabel 'Link burst error probability';"
t="$t set xrange [0.00001:0.1];";
t="$t set log x;";
t="$t set key below;"
#t="$t set key box;"

#t="$t set key bottom left;"
#t="$t set key width -2;"
t="$t set grid;"
if [ $i == "cbk" ]; then 
t="$t set ylabel 'Packets lost';";
t="$t set yrange [0:*];";
elif [ $i == "collisions" ]; then
t="$t set ylabel 'Collisions';";
t="$t set logscale y;";
#t="$t set key outside;"
#t="$t set yrange [0:*];";
elif [ $i == "delay" ]; then 
t="$t set ylabel '$i (s)';";
#t="$t set yrange [0:0.1];";
elif [ $i == "goodput" ]; then 
t="$t set ylabel 'Goodput (%)';";
t="$t set yrange [*:100];";
#t="$t set key bottom left;"

#elif [ $i == "jitter" ]; then 
#t="$t set ylabel 'Jitter (s)';";
#t="$t set yrange [0:0.5];";
elif [ $i == "hops" ]; then
t="$t set ylabel 'Hops';";
elif [ $i == "loop" ]; then 
t="$t set ylabel 'Packets lost';";
t="$t set yrange [0:*];";
elif [ $i == "nrte" ]; then 
t="$t set ylabel 'Packets lost';";
t="$t set yrange [1:*];";
t="$t set logscale y;";
#t="$t set key top left;"
elif [ $i == "recvspp" ]; then 
t="$t set ylabel 'Received copies';";
elif [ $i == "ret" ]; then 
t="$t set ylabel 'Packets lost';";
t="$t set yrange [0:*];";
elif [ $i == "transmissions" ]; then 
t="$t set ylabel '$i';";
#t="$t set yrange [0:*];";
elif [ $i == "ttl" ]; then 
t="$t set ylabel 'Packets lost';";
t="$t set yrange [0:*];";
#t="$t set key top left;"
else
t="$t set ylabel '$i';";
#t="$t set yrange [0:*];";
fi
t="$t set terminal postscript color 'Computer Modern Roman' $fontsize eps;"
t="$t set output 'pdf/gilbert40n_iolsrlinexp_"$i".eps';"


t="$t set xtics nomirror;"
t="$t set ytics nomirror;"
t="$t plot";

col=1;
#t="$t 'plainolsr_2/results/600-5900s_tos1_$i.coi' using $datacols title '2s hello' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
#t="$t 'plainolsr_20/results/600-5900s_tos1_$i.coi' using $datacols title '20s hello' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
#t="$t 'plainolsr_100/results/600-5900s_tos1_$i.coi' using $datacols title '100s hello' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;

t="$t 'wsnolsr/results/600-5900s_tos1_$i.coi' using $datacols title 'iOLSR lin' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
t="$t 'wsnolsr_exp2/results/600-5900s_tos1_$i.coi' using $datacols title 'iOLSR exp2' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+2;
#t="$t 'aodv/results/600-5900s_tos1_$i.coi' using $datacols title 'AODV' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
t="$t 'wsnolsr_exp3/results/600-5900s_tos1_$i.coi' using $datacols title 'iOLSR exp3' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1"
let col=col+1;


echo $t >> tmp.tmp;
gnuplot tmp.tmp;
done;

# iOLSR m og u TC TTL 
for i in collisions goodput nrte transmissions ttl; do # arp cbk collisions delay end goodput hops ifq jitter loop nrte recvspp sentpkts transmissions ttl; do
touch tmp.tmp;
rm tmp.tmp;
t="reset;"
#t="$t set title \"Study of node birth impact\";"
t="$t set size $size;"
t="$t set border 3;"
t="$t set autoscale;"
t="$t set xlabel 'Link burst error probability';"
t="$t set xrange [0.00001:0.1];";
t="$t set log x;";
t="$t set key below;"
#t="$t set key box;"

#t="$t set key bottom left;"
#t="$t set key width -2;"
t="$t set grid;"
if [ $i == "cbk" ]; then 
t="$t set ylabel 'Packets lost';";
t="$t set yrange [0:*];";
elif [ $i == "collisions" ]; then
t="$t set ylabel 'Collisions';";
t="$t set logscale y;";
#t="$t set key outside;"
#t="$t set yrange [0:*];";
elif [ $i == "delay" ]; then 
t="$t set ylabel '$i (s)';";
#t="$t set yrange [0:0.1];";
elif [ $i == "goodput" ]; then 
t="$t set ylabel 'Goodput (%)';";
t="$t set yrange [*:100];";
#t="$t set key bottom left;"

#elif [ $i == "jitter" ]; then 
#t="$t set ylabel 'Jitter (s)';";
#t="$t set yrange [0:0.5];";
elif [ $i == "hops" ]; then
t="$t set ylabel 'Hops';";
elif [ $i == "loop" ]; then 
t="$t set ylabel 'Packets lost';";
t="$t set yrange [0:*];";
elif [ $i == "nrte" ]; then 
t="$t set ylabel 'Packets lost';";
t="$t set yrange [1:*];";
t="$t set logscale y;";
#t="$t set key top left;"
elif [ $i == "recvspp" ]; then 
t="$t set ylabel 'Received copies';";
elif [ $i == "ret" ]; then 
t="$t set ylabel 'Packets lost';";
t="$t set yrange [0:*];";
elif [ $i == "transmissions" ]; then 
t="$t set ylabel '$i';";
#t="$t set yrange [0:*];";
elif [ $i == "ttl" ]; then 
t="$t set ylabel 'Packets lost';";
t="$t set yrange [0:*];";
#t="$t set key top left;"
else
t="$t set ylabel '$i';";
#t="$t set yrange [0:*];";
fi
t="$t set terminal postscript color 'Computer Modern Roman' $fontsize eps;"
t="$t set output 'pdf/gilbert40n_iolsrtcttl_"$i".eps';"


t="$t set xtics nomirror;"
t="$t set ytics nomirror;"
t="$t plot";

col=1;
#t="$t 'plainolsr_2/results/600-5900s_tos1_$i.coi' using $datacols title '2s hello' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
#t="$t 'plainolsr_20/results/600-5900s_tos1_$i.coi' using $datacols title '20s hello' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
#t="$t 'plainolsr_100/results/600-5900s_tos1_$i.coi' using $datacols title '100s hello' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;

#t="$t 'wsnolsr/results/600-5900s_tos1_$i.coi' using $datacols title 'iOLSR lin' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
t="$t 'wsnolsr_exp2/results/600-5900s_tos1_$i.coi' using $datacols title 'iOLSR exp2' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+2;
#t="$t 'aodv/results/600-5900s_tos1_$i.coi' using $datacols title 'AODV' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
#t="$t 'wsnolsr_exp3/results/600-5900s_tos1_$i.coi' using $datacols title 'iOLSR exp3' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1"
let col=col+1;
t="$t 'wsnolsr_TCTTL_exp2/results/600-5900s_tos1_$i.coi' using $datacols title 'iOLSR tcttl exp2' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1"
let col=col+1;


echo $t >> tmp.tmp;
gnuplot tmp.tmp;
done;




# WSNOLSR dissected Total graphs
for i in rtrtrans; do #  rtrtrans tottran; do
touch tmp.tmp;
rm tmp.tmp;
t="reset;"
#t="$t set title \"Study of node birth impact\";"
t="$t set size $size;"
t="$t set border 3;"
t="$t set autoscale;"
t="$t set xlabel 'Link burst error probability';"
t="$t set xrange [0.00001:0.1];";
t="$t set log x;";
t="$t set key below;"
#t="$t set key bottom left;"
#t="$t set key width -2;"
#t="$t set key box;"
t="$t set grid;"

#t="$t set yrange [0:*];";
if [ $i == "rtrtrans" ]; then 
t="$t set ylabel 'Transmissions';";
#t="$t set key right center;";
t="$t set logscale y;";
#t="$t set key right;";
t="$t set yrange [*:*];";

elif [ $i == "tottrans" ]; then 
t="$t set ylabel 'Transmissions';";
t="$t set yrange [0:*];";
else
t="$t set ylabel '$i';";

fi
t="$t set terminal postscript color 'Computer Modern Roman' $fontsize eps;"
t="$t set output 'pdf/gilbert40n_iolsrlinexp_"$i".eps';"

t="$t set xtics nomirror;"
t="$t set ytics nomirror;"
t="$t plot";

col=1;
#t="$t 'plainolsr_2/results/600-5900s_$i.coi' using $datacols title '2s hello' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
#t="$t 'plainolsr_20/results/600-5900s_$i.coi' using $datacols title '20s hello' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
#t="$t 'plainolsr_100/results/600-5900s_$i.coi' using $datacols title '100s hello' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
t="$t 'wsnolsr/results/600-5900s_$i.coi' using $datacols title 'iOLSR lin' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
t="$t 'wsnolsr_exp2/results/600-5900s_$i.coi' using $datacols title 'iOLSR exp2' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+2;
#t="$t 'aodv/results/600-5900s_$i.coi' using $datacols title 'AODV' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1"
let col=col+1;
t="$t 'wsnolsr_exp3/results/600-5900s_$i.coi' using $datacols title 'iOLSR exp3' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1"
let col=col+1;


echo $t >> tmp.tmp;
gnuplot tmp.tmp;
done;




for i in collisions goodput hops ifq loop nrte ret ttl; do # arp cbk collisions delay end goodput hops ifq jitter loop nrte recvspp sentpkts transmissions ttl; do
touch tmp.tmp;
rm tmp.tmp;
t="reset;"
#t="$t set title \"Study of node birth impact\";"
t="$t set size $size;"
t="$t set border 3;"
t="$t set autoscale;"
t="$t set xlabel 'Link burst error probability';"
t="$t set xrange [0.00001:0.1];";
t="$t set log x;";
t="$t set key below;"
#t="$t set key box;"

#t="$t set key bottom left;"
#t="$t set key width -2;"
t="$t set grid;"
if [ $i == "cbk" ]; then 
t="$t set ylabel 'Packets lost';";
t="$t set yrange [0:*];";
elif [ $i == "collisions" ]; then
t="$t set ylabel 'Collisions';";
t="$t set logscale y;";
#t="$t set key outside;"
#t="$t set yrange [0:*];";
elif [ $i == "delay" ]; then 
t="$t set ylabel '$i (s)';";
#t="$t set yrange [0:0.1];";
elif [ $i == "goodput" ]; then 
t="$t set ylabel 'Goodput (%)';";
t="$t set yrange [*:100];";
#t="$t set key bottom left;"

#elif [ $i == "jitter" ]; then 
#t="$t set ylabel 'Jitter (s)';";
#t="$t set yrange [0:0.5];";
elif [ $i == "hops" ]; then
t="$t set ylabel 'Hops';";
elif [ $i == "loop" ]; then 
t="$t set ylabel 'Packets lost';";
t="$t set yrange [0:*];";
elif [ $i == "nrte" ]; then 
t="$t set ylabel 'Packets lost';";
t="$t set yrange [1:*];";
t="$t set logscale y;";
#t="$t set key top left;"
elif [ $i == "recvspp" ]; then 
t="$t set ylabel 'Received copies';";
elif [ $i == "ret" ]; then 
t="$t set ylabel 'Packets lost';";
t="$t set yrange [0:*];";
elif [ $i == "transmissions" ]; then 
t="$t set ylabel '$i';";
#t="$t set yrange [0:*];";
elif [ $i == "ttl" ]; then 
t="$t set ylabel 'Packets lost';";
t="$t set yrange [0:*];";
#t="$t set key top left;"
else
t="$t set ylabel '$i';";
#t="$t set yrange [0:*];";
fi
t="$t set terminal postscript color 'Computer Modern Roman' $fontsize eps;"
t="$t set output 'pdf/gilbert40n_iolsraodv_"$i".eps';"


t="$t set xtics nomirror;"
t="$t set ytics nomirror;"
t="$t plot";

col=1;
#t="$t 'plainolsr_2/results/600-5900s_tos1_$i.coi' using $datacols title '2s hello' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
#t="$t 'plainolsr_20/results/600-5900s_tos1_$i.coi' using $datacols title '20s hello' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
#t="$t 'plainolsr_100/results/600-5900s_tos1_$i.coi' using $datacols title '100s hello' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
#t="$t 'wsnolsr/results/600-5900s_tos1_$i.coi' using $datacols title 'iOLSR' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
t="$t 'wsnolsr_exp2/results/600-5900s_tos1_$i.coi' using $datacols title 'iOLSR' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+2;
t="$t 'aodv/results/600-5900s_tos1_$i.coi' using $datacols title 'AODV' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1"
let col=col+1;


echo $t >> tmp.tmp;
gnuplot tmp.tmp;
done;




# WSNOLSR dissected Total graphs
for i in rtrtrans tottrans; do #  rtrtrans tottrans; do
touch tmp.tmp;
rm tmp.tmp;
t="reset;"
#t="$t set title \"Study of node birth impact\";"
t="$t set size $size;"
t="$t set border 3;"
t="$t set autoscale;"
t="$t set xlabel 'Link burst error probability';"
t="$t set xrange [0.00001:0.1];";
t="$t set log x;";
t="$t set key below;"
#t="$t set key bottom left;"
#t="$t set key width -2;"
#t="$t set key box;"
t="$t set grid;"

#t="$t set yrange [0:*];";
if [ $i == "rtrtrans" ]; then 
t="$t set ylabel 'Transmissions';";
#t="$t set key right center;";
t="$t set logscale y;";
#t="$t set key right;";
t="$t set yrange [*:*];";

elif [ $i == "tottrans" ]; then 
t="$t set ylabel 'Transmissions';";
#t="$t set yrange [0:*];";
t="$t set logscale y;";
else
t="$t set ylabel '$i';";

fi
t="$t set terminal postscript color 'Computer Modern Roman' $fontsize eps;"
t="$t set output 'pdf/gilbert40n_iolsraodv_"$i".eps';"

t="$t set xtics nomirror;"
t="$t set ytics nomirror;"
t="$t plot";

col=1;
#t="$t 'plainolsr_2/results/600-5900s_$i.coi' using $datacols title '2s hello' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
#t="$t 'plainolsr_20/results/600-5900s_$i.coi' using $datacols title '20s hello' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
#t="$t 'plainolsr_100/results/600-5900s_$i.coi' using $datacols title '100s hello' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
#t="$t 'wsnolsr/results/600-5900s_$i.coi' using $datacols title 'iOLSR' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
t="$t 'wsnolsr_exp2/results/600-5900s_$i.coi' using $datacols title 'iOLSR' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+2;
t="$t 'aodv/results/600-5900s_$i.coi' using $datacols title 'AODV' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1"
let col=col+1;


echo $t >> tmp.tmp;
gnuplot tmp.tmp;
done;


rm tmp.tmp;
find -iname "*.eps" -size 0 -exec rm '{}' \;;

