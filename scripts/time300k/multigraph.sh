#!/bin/bash   



#datacols="1:(\$2+\$3+\$4+\$5+\$6+\$7+\$8+\$9+\$10+\$11)/10:12";linestype="yerrorlines"
datacols="1:(\$2+\$3+\$4+\$5+\$6+\$7+\$8+\$9+\$10+\$11)/10"; linestype="linespoints"
#datacols="1:(\$2)/1"; linestype="linespoints"
#datacols="1:(\$2+\$3+\$4+\$5+\$6+\$7+\$8+\$9+\$10+\$11+\$12+\$13+\$14+\$15+\$16+\$17+\$18+\$19+\$20+\$21+\$22+\$23+\$24+\$25+\$26+\$27+\$28+\$29+\$30+\$31)/30"
#datacols="1:2"
#linestype="linespoints"


fontsize="";
lw="3"; #line width
ps="1
"; #point size


x=0.0;
y=0.75;
sx=0.33334;
sy=0.25;
spy=0.0;

touch tmp.tmp;
rm tmp.tmp;
t="set term postscript enh 'Helvetica' 6 eps;";
t="$t set output 'pdf/multigraph_tos1.eps';";
t="$t set key left;";
t="$t set xtics nomirror;";
t="$t set ytics nomirror;";
t="$t set pointsize 0.5;";
t="$t set multiplot;";

# arp cbk end loop nrte goodput goodput150ms fwdrs collisions hops delay ifq jitter recvspp ret sentpkts transcol transmissions ttl
for i in goodput arp cbk ifq loop nrte collisions hops ret sentpkts transmissions ttl; do
t="$t set size $sx,$sy;";
t="$t set origin $x,$y;";

# True false statement
xh=$(echo "(1-($x+$sx))*100<=0" | bc);

x=$(echo "$x+$sx" | bc);
#if [ $xh == 0 ]; then
if (( $xh == 1 )); then
let x=0;
y=$(echo "$y-$sy-$spy" | bc);
fi



#t="reset;"
t="$t set autoscale;"
t="$t set xlabel 'Probability of a link going bad (1/1000000)';";
t="$t set xrange [*:*];";
t="$t set yrange [*:*];";
t="$t set log x;";
#t="$t set log y;";

if [ $i == "arp" ]; then
t="$t set ylabel 'Arp queue loss';";
elif [ $i == "cbk" ]; then 
t="$t set ylabel 'Callback loss';";
elif [ $i == "collisions" ]; then 
#t="$t set yrange [0:10000];";
t="$t set ylabel '$i';";
elif [ $i == "delay" ]; then 
t="$t set yrange [*:*];";
t="$t set ylabel 'Delay (s)';";
elif [ $i == "end" ]; then 
t="$t set ylabel 'Lost at end of sim';";
elif [ $i == "fwdrs" ]; then 
t="$t set yrange [*:*];";
t="$t set ylabel 'Ratio of forwarders per pkt';";
elif [ $i == "goodput" ]; then 
t="$t set yrange [*:*];";
t="$t set ylabel 'Goodput (%)';";
elif [ $i == "goodput150ms" ]; then 
t="$t set yrange [*:*];";
t="$t set ylabel 'Goodput (%), delay < 150ms';";
elif [ $i == "hops" ]; then 
#t="$t set yrange [3:8];";
t="$t set ylabel 'Hops';";
elif [ $i == "ifq" ]; then 
t="$t set yrange [*:*];";
t="$t set ylabel 'Interface queue loss';";
elif [ $i == "jitter" ]; then 
t="$t set yrange [*:*];";
t="$t set ylabel 'Jitter (s)';";
elif [ $i == "loop" ]; then 
t="$t set ylabel 'Loop loss';";
elif [ $i == "nrte" ]; then 
t="$t set ylabel 'No route loss';";
elif [ $i == "recvspp" ]; then 
t="$t set yrange [*:*];";
t="$t set ylabel 'Dup receives per packet';";
elif [ $i == "sentpkts" ]; then 
t="$t set ylabel 'Sent packets';";
elif [ $i == "transcol" ]; then 
t="$t set yrange [*:*];";
t="$t set ylabel 'Collisions / transmission';";
elif [ $i == "transmissions" ]; then 
t="$t set yrange [*:*];";
t="$t set ylabel '$i';";
elif [ $i == "ttl" ]; then 
t="$t set yrange [*:*];";
t="$t set ylabel 'Time to live loss';";
else
t="$t set ylabel '$i';";
fi
#t="$t set terminal postscript color 'Computer Modern Roman' 12 eps;"

t="$t plot";
col=1;
#t="$t 'plainolsr_2/results/600-5900s_tos1_$i.coi' using $datacols title '2s hello' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
#let col=col+1;
#t="$t 'plainolsr_2_2xload/results/600-5900s_tos1_$i.coi' using $datacols title '2s hello 2xload' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
#let col=col+1;
#t="$t 'plainolsr_20/results/600-5900s_tos1_$i.coi' using $datacols title '20s hello' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
#let col=col+1;
#t="$t 'plainolsr_100/results/600-5900s_tos1_$i.coi' using $datacols title '100s hello' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
#let col=col+1;
t="$t 'wsnolsr/results/600-5900s_tos1_$i.coi' using $datacols title 'Incr' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
t="$t 'wsnolsr_exp2/results/600-5900s_tos1_$i.coi' using $datacols title 'Incr exp' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
#t="$t 'wsnolsr_2xload/results/600-5900s_tos1_$i.coi' using $datacols title 'Incr 2xload' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
#let col=col+1;
#t="$t 'wsnolsr_ITC/results/600-5900s_tos1_$i.coi' using $datacols title 'Incr ITC' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
#let col=col+2;
#t="$t 'wsnolsr_ITC_TCS/results/600-5900s_tos1_$i.coi' using $datacols title 'Incr ITC TCS' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
#let col=col+1;
#t="$t 'wsnolsr_ITC_TCS_RTC/results/600-5900s_tos1_$i.coi' using $datacols title 'Incr ITC TCS RTC' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
#let col=col+1;
#t="$t 'wsnolsr_ITC_TCS_RTC_2vt/results/600-5900s_tos1_$i.coi' using $datacols title 'Incr ITC TCS RTC 2vt' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
#let col=col+1;
#t="$t 'wsnolsr_ITC_TCS_RTC_2vt_ingressq/results/600-5900s_tos1_$i.coi' using $datacols title 'Incr ITC TCS RTC 2vt ingr' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
#let col=col+2;
#t="$t 'wsnolsr_ITC_TCS_RTC_2vt_ingressq_2xload/results/600-5900s_tos1_$i.coi' using $datacols title 'Incr ITC TCS RTC 2vt ingr 2xload' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1;"
#let col=col+1;
t="$t 'aodv/results/600-5900s_tos1_$i.coi' using $datacols title 'aodv' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1;"
let col=col+1;


done;


echo $t >> tmp.tmp;
gnuplot tmp.tmp;




####################

x=0.0;
y=0.5;
sx=0.5;
sy=0.5;
spy=0.0;


touch tmp.tmp;
rm tmp.tmp;
t="set term postscript enh 'Helvetica' 6 eps;";
t="$t set output 'pdf/multigraph.eps';";
t="$t set key left;";
t="$t set xtics nomirror;";
t="$t set ytics nomirror;";
t="$t set pointsize 0.5;";
t="$t set multiplot;";

# arp cbk end loop nrte goodput goodput150ms fwdrs collisions hops delay ifq jitter recvspp sentpkts transcol transmissions ttl
for i in totrate rtrtrans tottrans; do
t="$t set size $sx,$sy;";
t="$t set origin $x,$y;";

# True false statement
xh=$(echo "(1-($x+$sx))*100<=0" | bc);

x=$(echo "$x+$sx" | bc);
#if [ $xh == 0 ]; then
if (( $xh == 1 )); then
let x=0;
y=$(echo "$y-$sy-$spy" | bc);
fi



#t="reset;"
t="$t set autoscale;"
t="$t set xlabel 'Probability of a link going bad (1/1000000)';";
t="$t set xrange [*:*];";
t="$t set yrange [*:*];";
t="$t set log x;";
t="$t set log y;";

if [ $i == "arp" ]; then
t="$t set ylabel 'Arp queue loss';";
elif [ $i == "cbk" ]; then 
t="$t set ylabel 'Callback loss';";
elif [ $i == "collisions" ]; then 
#t="$t set yrange [0:10000];";
t="$t set ylabel '$i';";
elif [ $i == "delay" ]; then 
t="$t set yrange [*:*];";
t="$t set ylabel 'Delay (s)';";
elif [ $i == "end" ]; then 
t="$t set ylabel 'Lost at end of sim';";
elif [ $i == "fwdrs" ]; then 
t="$t set yrange [*:*];";
t="$t set ylabel 'Ratio of forwarders per pkt';";
elif [ $i == "goodput" ]; then 
t="$t set yrange [*:*];";
t="$t set ylabel 'Goodput (%)';";
elif [ $i == "goodput150ms" ]; then 
t="$t set yrange [*:*];";
t="$t set ylabel 'Goodput (%), delay < 150ms';";
elif [ $i == "hops" ]; then 
#t="$t set yrange [3:8];";
t="$t set ylabel 'Hops';";
elif [ $i == "ifq" ]; then 
t="$t set yrange [*:*];";
t="$t set ylabel 'Interface queue loss';";
elif [ $i == "jitter" ]; then 
t="$t set yrange [*:*];";
t="$t set ylabel 'Jitter (s)';";
elif [ $i == "loop" ]; then 
t="$t set ylabel 'Loop loss';";
elif [ $i == "nrte" ]; then 
t="$t set ylabel 'No route loss';";
elif [ $i == "recvspp" ]; then 
t="$t set yrange [*:*];";
t="$t set ylabel 'Dup receives per packet';";
elif [ $i == "sentpkts" ]; then 
t="$t set ylabel 'Sent packets';";
elif [ $i == "transcol" ]; then 
t="$t set yrange [*:*];";
t="$t set ylabel 'Collisions / transmission';";
elif [ $i == "transmissions" ]; then 
t="$t set yrange [*:*];";
t="$t set ylabel '$i';";
elif [ $i == "ttl" ]; then 
t="$t set yrange [*:*];";
t="$t set ylabel 'Time to live loss';";
else
t="$t set ylabel '$i';";
fi
#t="$t set terminal postscript color 'Computer Modern Roman' 12 eps;"

t="$t plot";
col=1;
#t="$t 'plainolsr_2/results/600-5900s_$i.coi' using $datacols title '2s hello' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
#let col=col+1;
#t="$t 'plainolsr_2_2xload/results/600-5900s_$i.coi' using $datacols title '2s hello 2xload' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
#let col=col+1;
#t="$t 'plainolsr_20/results/600-5900s_$i.coi' using $datacols title '20s hello' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
#let col=col+1;
#t="$t 'plainolsr_100/results/600-5900s_$i.coi' using $datacols title '100s hello' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
#let col=col+1;
t="$t 'wsnolsr/results/600-5900s_$i.coi' using $datacols title 'Incr' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
t="$t 'wsnolsr_exp2/results/600-5900s_$i.coi' using $datacols title 'Incr exp' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
#t="$t 'wsnolsr_2xload/results/600-5900s_$i.coi' using $datacols title 'Incr 2xload' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
#let col=col+1;
#t="$t 'wsnolsr_ITC/results/600-5900s_$i.coi' using $datacols title 'Incr ITC' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
#let col=col+2;
#t="$t 'wsnolsr_ITC_TCS/results/600-5900s_$i.coi' using $datacols title 'Incr ITC TCS' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
#let col=col+1;
#t="$t 'wsnolsr_ITC_TCS_RTC/results/600-5900s_$i.coi' using $datacols title 'Incr ITC TCS RTC' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
#let col=col+1;
#t="$t 'wsnolsr_ITC_TCS_RTC_2vt/results/600-5900s_$i.coi' using $datacols title 'Incr ITC TCS RTC 2vt' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
#let col=col+1;
#t="$t 'wsnolsr_ITC_TCS_RTC_2vt_ingressq/results/600-5900s_$i.coi' using $datacols title 'Incr ITC TCS RTC 2vt ingr' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
#let col=col+2;
#t="$t 'wsnolsr_ITC_TCS_RTC_2vt_ingressq_2xload/results/600-5900s_$i.coi' using $datacols title 'Incr ITC TCS RTC 2vt ingr 2xload' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1;"
#let col=col+1;
t="$t 'aodv/results/600-5900s_$i.coi' using $datacols title 'aodv' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1;"
let col=col+1;

done;


echo $t >> tmp.tmp;
gnuplot tmp.tmp;






rm tmp.tmp;
find -iname "*.eps" -size 0 -exec rm '{}' \;;

