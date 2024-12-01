#!/bin/bash

# Create output folder
#if [ ! -d output ]; then
    mkdir -p output;
#fi;

echo "Generating examples for "$5

export operations

if [ $5 = "ActivationStatus" ]; then    
    operations=(Get ListByMobilePacketCore)
else
    operations=(CreateOrUpdate Delete Get ListByResourceGroup ListBySubscription UpdateTags)
fi    
for operation in "${operations[@]}"
do
echo $operation
    if [ ! -f $3 ]
    then
        touch $3
    fi
    if [ ! -f $4 ]
    then
        touch $4
    fi
    
    sed -e '/GETCONTENTS/{
    s/GETCONTENTS//g
    r '$3'
    }' $operation.txt > tmp1
    
    sed -e '/PUTCONTENTS/{
    s/PUTCONTENTS//g
    r '$4'
    }' tmp1 > tmp2

    sed 's/OBJECTTYPE/'$5'/g' tmp2 > tmp1
    cp tmp1 tmp2
    sed 's/OBJECTNAME/'$1'/g' tmp2 > tmp1
    sed 's/OBJECTINSTANCE/'$2'/g' tmp1 > tmp2
    
    # $6 is parent object 1 type, $7 is parent object 1 instance
    if [ -z "$6" ]
    then
        sed 's#PARENTOBJECT1INSTANCE##g' tmp2 > tmp1
        sed 's#PARENTOBJECT1##g' tmp1 > tmp2
    else
        parentInstance="\"${6}Name\": \"${7}\","
        sed 's#PARENTOBJECT1INSTANCE#'"${parentInstance}"'#g' tmp2 > tmp1
        parentObject="${6}s/"
        sed 's#PARENTOBJECT1#'"${parentObject}"'#g' tmp1 > tmp2
    fi
    
    # $8 is parent object 2 type, $9 is parent object 2 instance
    if [ -z "$8" ]
    then
        sed 's#PARENTOBJECT2INSTANCE##g' tmp2 > tmp1
        sed 's#PARENTOBJECT2##g' tmp1 > tmp2
    else
        parentInstance="\"${8}Name\": \"${9}\","
        sed 's#PARENTOBJECT2INSTANCE#'"${parentInstance}"'#g' tmp2 > tmp1
        parentObject="${8}s/"
        sed 's#PARENTOBJECT2#'"${parentObject}"'#g' tmp1 > tmp2
    fi        
    
    if [ $# -eq 9 ]
    then
        path="${8}s/${9}/${6}s/${7}/${1}s/${2}"
        sed 's#PATHCONTENTS#'"${path}"'#g' tmp2 > tmp1
    elif [ $# -eq 7 ]
    then
        path="${6}s/${7}/${1}s/${2}"
        sed 's#PATHCONTENTS#'"${path}"'#g' tmp2 > tmp1
    else
        path="${1}s/${2}"
        sed 's#PATHCONTENTS#'"${path}"'#g' tmp2 > tmp1
    fi
#    mv tmp1 output/$5_$operation.json
    jq . tmp1 > output/$5_$operation.json
    rm tmp1 tmp2
done

