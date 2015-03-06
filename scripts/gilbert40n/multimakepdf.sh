./multigraph.sh;
cd pdf;
rm *.pdf;
for i in *.eps; do 
ps2pdf $i;
rm $i;
done;
for i in *.pdf; do 
pdfcrop $i $i;
done;
cd ..
