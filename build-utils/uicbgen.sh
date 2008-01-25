#!/bin/sh
top_srcdir="${1-.}"
echo "/* This file is autogenerated by" $(basename $0) "*/"
echo
echo "const name_func_link_t UicbList[] ="
echo "{"
for file in ${top_srcdir}/*.h ${top_srcdir}/layouts/*.h
do
    echo "    /* $file */"
    grep '^Uicb uicb_' $file | cut -d' ' -f2 | cut -d\; -f1 | while read uicb
    do
        shortname=$(echo $uicb | cut -d _ -f2-)
        echo "    {\"$shortname\", $uicb},"
        grep -q "\*$shortname\*" ${top_srcdir}/awesomerc.1.txt || \
            echo "  WARNING: $uicb NOT documented" >&2
    done
done

echo "    {NULL, NULL}"
echo "};"
