#!/bin/bash
# assumes you have gs and tesseract installed
# gs: https://www.ghostscript.com/
# tesseract: https://github.com/tesseract-ocr/tesseract

if [ -z "$1" ]; then
    echo path to pdf file?
    read fname
else
    fname=$1
fi

name=`echo ${fname} | awk -F\. '{print $1}'`

gs -dNOPAUSE -dBATCH -sDEVICE=png16m -r300 -sOutputFile="page-%d.png" ${fname}

for f in `ls page-*.png`; do
    page=`echo $f | awk -F\- '{print $2}' | awk -F\. '{print $1}'`
    tesseract ${f} page-${page} -l eng PDF

    # clean up intermediary png file
    /bin/rm ${f}
done

gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -sOutputFile=${name}-ocr.pdf page-*.pdf

# clean up intermediary OCRd pages
/bin/rm page-*.pdf

