#!/bin/sh

rm -rf antt-tex
rm -f antt.zip
rm -rf ./tmp/ 

# this is full font for TeX 
SRC="https://jmn.pl/pliki/AntykwaTorunska-tex-2_08.zip"
curl -# -o antt.zip $SRC

if [ ! -d $HOME/.fonts/groff/devps ]; then 
    mkdir -p $HOME/.fonts/groff/devps
fi
if [ ! -d $HOME/.fonts/gs ] ; then
    mkdir -p $HOME/.fonts/gs
fi

unzip antt.zip
cp $PWD/antt-tex/fonts/type1/public/antt/*.pfb $HOME/.fonts/gs

echo "generating postscript fonts"
mv ./antt-tex/fonts/afm/public/ ./tmp/

cd $PWD/tmp/antt/

if [ "$?" != "0" ]; then 
    echo "failed to cd to ./tmp/antt/"
    exit 1
fi

for i in `ls antt*.afm`; do 
    OUTNAME=`basename $i .afm`
    OUTNAME=`echo $OUTNAME | tr '[:lower:]' '[:upper:]'`
    echo "converting $i into $OUTNAME"
    afmtodit -d /usr/share/groff/current/font/devps/DESC -e /usr/share/groff/current/font/devps/text.enc $i /usr/share/groff/current/font/devps/generate/textmap $OUTNAME
    mv $OUTNAME $HOME/.fonts/groff/devps
done


SRC="ftp://ftp.gust.org.pl/pub/GUST/contrib/fonts/cm-pl/plpsfont.zip"
curl -# -o plpsfont.zip $SRC
unzip plpsfont.zip
cp $PWD/plpsfont/fonts/type1/public/pl/*.pfb $HOME/.fonts/gs

echo "generating postscript fonts"
mv ./plpsfonts/fnts/afm/public/ ./tmp/

cd $PWD/plpsfont/fonts/afm/public/pl/

if [ "$?" != "0" ]; then 
    echo "failed to cd to afm directory"
    exit 1
fi

for i in `ls pl*.afm`; do 
    OUTNAME=`basename $i .afm`
    OUTNAME=`echo $OUTNAME | tr '[:lower:]' '[:upper:]'`
    echo "converting $i into $OUTNAME"
    afmtodit -d /usr/share/groff/current/font/devps/DESC -e /usr/share/groff/current/font/devps/text.enc $i /usr/share/groff/current/font/devps/generate/textmap $OUTNAME
    mv $OUTNAME $HOME/.fonts/groff/devps
done


SRC="ftp://ftp.gust.org.pl/pub/GUST/contrib/fonts/cm-pl/plpsfont.zip"
curl -# -o antt.zip $SRC
