#!/bin/bash
############################################
# Author : Abhishek Bharat Parab
# Script version : 1.0
# Description : This script can run on any linux system, which supports bash shell script#
############################################


#TO SET INPUT PATH OF IPA FILE
cd $HOME/path-to-intune-wrapper-foler-path/ipafiles # create folder "ipafile" and store your LOB IPA files before wrapping
read -p "Enter ipa name : " ipaName


setIpaName=$(find . -type f -iname "*$ipaname*" | awk '{ print substr($1,3)}')
echo -e "\n iOS app file name : "$setIpaName
export INPUT_IPA_PATH=$(pwd)/$setIpaName
echo -e "\n Absolute Input Path for ipa : "$INPUT_IPA_PATH


#TO SET PROVISIONING PROFILE FILES FOLDER PATH
cd $HOME/path-to-provisioning-profile-folder/ # To create folder with name "PROVISIONING_PROFILE_(specifiy-financial-year)" and store list of provisioning profiles in this folder
echo -e "\n"
read -p "Enter provisioning file name : " provisioningProfileName
echo $provisioningProfileName

#To get list of provisioning profiles matching seach criteria
readppfiles=$(find . -type f -iname "*$provisioningProfileName*"| awk '{ print substr($1,3)}')

# To set array to hold search element and display as a list
pparray=($readppfiles)
#echo "Content in Array :  ${pparray[@]}"
for(( i=0; i< ${#pparray[@]}; i++ ));do
    echo "$i - ${pparray[i]}"
done

#To select correct provisioning profile file using number
read -p "Select Provisioning certificate by number :" choice

setppfile=""

for(( i=0; i< ${#pparray[@]}; i++ ));do
    if [ $i == $choice ] 
    then
        setppfile=${pparray[i]}
        #echo "$setppfile"
    fi
done

echo -e "\n\nYou have selected the provisioning profile : " $setppfile

export SET_PROVISIONING_PROFILE_PATH=$(pwd)/$setppfile
echo -e "\n\n provisioning file path : "$SET_PROVISIONING_PROFILE_PATH


#TO SET OUTPUT PATH FOR WRAPPED IPA
cd $HOME/path-to-intune-wrapper-foler-path/output # create folder with name "output" in which all generated wrapped ipa will be stored.
export OUTPUT_WRAPPED_IPA_PATH=$(pwd)/$setIpaName"_wrapped".ipa

cd $HOME/path-to-intune-wrapper-foler-path

./IntuneMAMPackager/Contents/MacOS/IntuneMAMPackager -i $INPUT_IPA_PATH -o $OUTPUT_WRAPPED_IPA_PATH -p $SET_PROVISIONING_PROFILE_PATH -c "CA F9 90 70 40 60 95 C9 40 40 20 C0 20 60 38 DF B5 14 11 D0"  -v true