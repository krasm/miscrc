#!/bin/sh

rm -rf antt-tex
rm -f antt.zip
rm -rf ./tmp/ 

# this is full font for TeX 
SRC="https://jmn.pl/pliki/AntykwaTorunska-tex-2_08.zip"
curl -# -o antt.zip $SRC

unzip antt.zip

mv ./antt-tex/fonts/afm/public/ ./tmp
cd ./tmp/antt/

if [ ! -d $HOME/.font/devps ]; then 
    mkdir -p $HOME/.font/devps
fi

echo "generating postscript fonts"
for i in `ls antt*.afm`; do 
    OUTNAME=`basename $i .afm`
    OUTNAME=`echo $OUTNAME | tr '[:lower:]' '[:upper:]'`
    echo "converting $i into $OUTNAME"
    afmtodit -d /usr/share/groff/current/font/devps/DESC -e /usr/share/groff/current/font/devps/text.enc $i /usr/share/groff/current/font/devps/generate/textmap $OUTNAME
    mv $OUTNAME $HOME/.fonts/devps
done
