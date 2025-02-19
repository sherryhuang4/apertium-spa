#!/bin/bash

#set -e
#set -o pipefail
echo "Grep tests"
{
for file in apertium-spa.spa.metadix
do 
    grep -H "<i> " $file
    grep -H " </i>" $file
    grep -H "<l> " $file
    grep -H " </l>" $file
    grep -H "<r> " $file
    grep -H " </r>" $file
    grep -H -P "\xa0" $file # non-breaking space
    grep -H "<b/><s" $file
    grep -H "<b/><b/>" $file
    grep -H "<b/><g>" $file
    grep -H -P "<i>[^<]+ [^<]+</i>" $file
    grep -H -P "<l>[^<]+ [^<]+</l>" $file
    grep -H -P "<r>[^<]+ [^<]+</r>" $file

    #Poden ser correctes
    grep -H "<b/></l>" $file | sed -E '/n="cont/d'
    grep -H "<b/></r>" $file | sed -E '/n="cont/d'
    grep -H "<b/></i>" $file | sed -E '/n="cont/d' 
    
done
} > "dev/greptests.txt"

echo "Checking for differences"
git diff --exit-code
