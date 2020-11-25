#!/bin/sh

rm -rf antt-tex
rm -f antt.zip
rm -rf ./tmp/ 

GROFF_FONT_PATH=$HOME/.fonts/groff/devps
GS_FONT_PATH=$HOME/.fonts/gs


create_dir() {
    D=$1
    echo "create directory $DIR"
    if [ ! -d $D ]; then 
	mkdir -p $D
    fi
}

generate_fonts() {
    echo "generating postscript fonts"
    for i in `find . -name *.afm -type f`; do 
	OUTNAME=`basename $i .afm`
	OUTNAME=`echo $OUTNAME | tr '[:lower:]' '[:upper:]'`
	echo "converting $i into $OUTNAME"
	afmtodit -d /usr/share/groff/current/font/devps/DESC -e /usr/share/groff/current/font/devps/text.enc $i /usr/share/groff/current/font/devps/generate/textmap $GROFF_FONT_PATH/$OUTNAME
    done
    
    echo "copying binary fonts"
    for i in `find . -name *.pfb -type f` ; do
	cp $i $GS_FONT_PATH/
    done
}

# this is full font for TeX 
SRC="https://jmn.pl/pliki/AntykwaTorunska-tex-2_08.zip"
curl -# -o antt.zip $SRC

unzip antt.zip

create_dir $GROFF_FONT_PATH
create_dir $GS_FONT_PATH

generate_fonts

rm -rf antt-tex/

curl -# -O ftp://ftp.gust.org.pl/pub/GUST/contrib/fonts/cm-pl/plpsfont.zip
unzip plpsfont.zip

generate_fonts

rm -rf plpsfont/

curl -# -L -O http://jmn.pl/pliki/ap1.101bas.zip
mkdir -p tmp
mv apl.101bas.zip tmp/
(cd tmp && unzip apl.101bas.zip)

generate_fonts

rm -rf tmp/

