#datacols="1:(\$2+\$3+\$4+\$5+\$6+\$7+\$8+\$9+\$10+\$11)/10:12";linestype="yerrorlines"
#datacols="1:(\$2+\$3+\$4+\$5+\$6+\$7+\$8+\$9+\$10+\$11)/10";linestype="linespoints"

#datacols="1:(\$2+\$3+\$4+\$5+\$6+\$7+\$8+\$9+\$10+\$11+\$12+\$13+\$14+\$15+\$16+\$17+\$18+\$19+\$20+\$21+\$22+\$23+\$24+\$25+\$26+\$27+\$28+\$29+\$30+\$31)/30:32";linestype="yerrorlines"
datacols="1:(\$2+\$3+\$4+\$5+\$6+\$7+\$8+\$9+\$10+\$11)/10:12";linestype="yerrorlines"
#datacols="1:(\$2+\$3+\$4+\$5+\$6+\$7+\$8+\$9+\$10+\$11)/10";linestype="lines"



#size="0.8,0.5"
#size="0.8,0.4"
size="1.0,0.8"
fontsize="20"
lw="4" # line width
ps="2" # point size





# WSNOLSR dissected Total graphs
for i in rtrtrans; do #  rtrtrans tottran; do
touch tmp.tmp;
rm tmp.tmp;
t="reset;"
#t="$t set title \"Study of node birth impact\";"
t="$t set size $size;"
t="$t set border 3;"
t="$t set autoscale;"
t="$t set xlabel 'Simulation time (s)';"
t="$t set xrange [*:*];";
#t="$t set log x;";
t="$t set key below;"
#t="$t set key bottom left;"
#t="$t set key width -2;"
#t="$t set key box;"
t="$t set grid;"

#t="$t set yrange [0:*];";
if [ $i == "rtrtrans" ]; then 
t="$t set ylabel 'Transmissions/10000s';";
#t="$t set key right center;";
#t="$t set logscale y;";
#t="$t set key right;";
t="$t set yrange [*:*];";

elif [ $i == "tottrans" ]; then 
t="$t set ylabel 'Transmissions';";
t="$t set yrange [0:*];";
else
t="$t set ylabel '$i';";

fi
t="$t set terminal postscript color 'Computer Modern Roman' $fontsize eps;"
t="$t set output 'pdf/time300k_iolsr_"$i".eps';"

t="$t set xtics nomirror;"
t="$t set ytics nomirror;"
t="$t plot";

col=4;

t="$t 'wsnolsr_lin/results/0-300000s_$i.coi' using $datacols title 'iOLSR lin' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+1;
t="$t 'wsnolsr_exp2/results/0-300000s_$i.coi' using $datacols title 'iOLSR exp2' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1,"
let col=col+3;
t="$t 'wsnolsr_exp3/results/0-300000s_$i.coi' using $datacols title 'iOLSR exp3' with $linestype lw $lw lc $col lt $col ps $ps axis x1y1"
let col=col+1;


echo $t >> tmp.tmp;
gnuplot tmp.tmp;
done;



rm tmp.tmp;
find -iname "*.eps" -size 0 -exec rm '{}' \;;

