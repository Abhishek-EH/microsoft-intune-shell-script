#!/bin/bash
echo -e "\t######################################################################################
\t\t# Author : Abhishek Bharat Parab
\t\t# Script version : 1.0.1
\t\t# Description : This script can run on any linux system, which supports bash shell script
\t###############################################################################################"


#TO SET INPUT PATH OF IPA FILE
ipadir="$HOME/Desktop/microsoft_intune_prod/ipafiles"

#TO FIND WHETHER FOLDER 'MICROSOFT_INTUNE_PROD' EXIST ON THE DESKTOP IN THE SYSTEM. IF NOT THEN, IT WILL BE CREATED !
if [ -d "$ipadir" ]
then
   echo -e "Path : ${ipadir} exist in the system...\n\n" 
else
   mkdir ~/Desktop/microsoft_intune_prod/     # To create microsoft_intune_prod
   mkdir ~/Desktop/microsoft_intune_prod/ipafiles/ # To create folder name - ipafiles under the above folder.
   chmod -R 770 $HOME/Desktop/microsoft_intune_prod/ # To set full permission for user and group owner of this folder.
   echo -e "Path : ${ipadir} has been created in the system..." 
fi


cd $HOME/Desktop/microsoft_intune_prod/ipafiles

sipa=0
while [ "$sipa" != 1 ]; do
    read -p "STEP 1 - Enter the ipa file name : " ipaname

    #To get list of IPA files by matching seach criteria
    readIpaFiles=$(find . -type f -iname "*$ipaname*"| awk '{ print substr($1,3)}')

    # To set array to hold & search IPA elements and display as a list
    ipaarray=($readIpaFiles)
    #echo "Content in Array :  ${ipaarray[@]}"
    echo -e "$ipaarray \n\n"
    count=0
    for(( i=0; i<=${#ipaarray[@]} ; i++ ));do
        if [ ${#ipaarray[@]} != 0 ] 
        then
            if [ $count == ${#ipaarray[@]} ]
            then
                sipa=1
            else
                echo "$i - ${ipaarray[i]}"
                ((count=count+1))
            fi 
        else
            echo -e "ipa filename with keyword '$ipaname' didn't find in the path : $ipadir \n"     
        fi
    done  
done

echo -e "Total $count match found for $ipaname ...\n"
#To select intended IPA file using number
#To check choice contains only numbers
# To check choice must be either from within displayed list 
state=0
setIpaFile=""

while [ "$state" != 1 ]; do
    read -p "STEP 2 - Select intended IPA by number :" choice
        if [[ $choice =~ ^[0-9]+$ ]]
        then
            echo -e "$choice is a number but a list contains only ${#ipaarray[@]} matched elements...\n"
            if [ $choice -lt ${#ipaarray[@]} ]
            then
                echo -e "$choice is less than or equal to ${#ipaarray[@]} \n"
                for(( i=0; i<=${#ipaarray[@]}; i++ ));do
                    if [ $i == $choice ] 
                    then
                        setIpaFile=${ipaarray[i]}
                        #echo "$setIpaFile"
                        state=1
                    fi
                done
            else
                echo -e "Select valid number from the list above !\n"
            fi    
        else
            echo -e " $choice is not a number !\n"
        fi
    done

echo -e "\n\nYou have selected the IPA package : " $setIpaFile
export INPUT_IPA_PATH=$(pwd)/$setIpaFile
echo -e "\n Source path for ipa : "$INPUT_IPA_PATH

######################################################################################################


#TO SET PROVISIONING PROFILE FILES FOLDER PATH
ppdir="$HOME/Desktop/PROVISIONING_PROFILE_2021-22"
if [ -d "$ppdir" ] 
then
    echo -e "\nPath : ${ppdir} exist in the system...\n\n" 
    if [ "$(ls -A $ppdir)" ]
    then
        echo -e "${ppdir} is not empty directory....\n"
    else 
        echo -e "${ppdir} is an empty directory....\n"
        exit
    fi 
else
    mkdir $HOME/Desktop/PROVISIONING_PROFILE_2021-22/
    chmod -R 770 $HOME/Desktop/PROVISIONING_PROFILE_2021-22/
    echo -e "Path : ${ppdir} was created for you in the system..." 
fi


cd $HOME/Desktop/PROVISIONING_PROFILE_2021-22
echo -e "\n"

while [ "$spp" != 1 ]; do
    read -p "STEP 3 - Enter provisioning file name : " provisioningProfileName
    echo $provisioningProfileName

    #To get list of provisioning profiles matching seach criteria
    readppfiles=$(find . -type f -iname "*$provisioningProfileName*"| awk '{ print substr($1,3)}')

    # To set array to hold search provisioning profile elements and display as a list
    pparray=($readppfiles)
    #echo "Content in Array :  ${pparray[@]}"
    ppcount=0
    for(( i=0; i<=${#pparray[@]}; i++ ));do
        if [ ${#pparray[@]} != 0 ]
        then
            if [ $ppcount == ${#pparray[@]} ]
            then
                spp=1
            else
                echo "$i - ${pparray[i]}"
                ((ppcount=ppcount+1))
            fi
        else
            echo -e "Provision profile with keyword '$provisioningProfileName' isn't found in the path : $ppdir \n"     
        fi
    done        
done




#To select correct provisioning profile file using number
setppfile=""

#for(( i=0; i< ${#pparray[@]}; i++ ));do
#    if [ $i == $choice ] 
#    then
#        setppfile=${pparray[i]}
#        #echo "$setppfile"
#    fi
#done
statep=0
while [ "$statep" != 1 ]; do
    read -p "STEP 4 - Select Provision profile file by number :" choice
        if [[ $choice =~ ^[0-9]+$ ]]
        then
            echo -e "$choice is a number but a list contains only ${#pparray[@]} matched elements...\n"
            if [ $choice -lt ${#pparray[@]} ]
            then
                echo -e "$choice is less than or equal to ${#pparray[@]} \n"
                for(( i=0; i<=${#pparray[@]}; i++ ));do
                    if [ $i == $choice ] 
                    then
                        setppfile=${pparray[i]}
                        #echo "$setppfile"
                        statep=1
                    fi
                done
            else
                echo -e "Select valid number from the list above !\n"
            fi    
        else
            echo -e " $choice is not a number !\n"
        fi
    done

echo -e "\n\nYou have selected the provisioning profile : " $setppfile



export SET_PROVISIONING_PROFILE_PATH=$(pwd)/$setppfile
echo -e "\n\n provisioning file path : "$SET_PROVISIONING_PROFILE_PATH
#read -p "Enter wrapped_ipa file path : " outputMdxPath

#open .

#TO SET OUTPUT PATH FOR WRAPPED IPA
cd $HOME/Desktop/microsoft_intune_prod/output
#export OUTPUT_WRAPPED_IPA_PATH=$(pwd)/$setIpaName"_wrapped".ipa
export OUTPUT_WRAPPED_IPA_PATH=$(pwd)/$setIpaFile"_wrapped".ipa
echo -e "\n\n>>>>Destination path for wrapped ipa : "$OUTPUT_WRAPPED_IPA_PATH

cd $HOME/Desktop/microsoft_intune
#./setup/IntuneMAMPackager/Contents/MacOS/IntuneMAMPackager -i $inputPath -o /Users/hdfcjamf/Desktop/microsoft_intune/output/$appName"_wrapped".ipa -p $provisioningProfilePath -c "CE FA 93 71 4B 6B 95 C9 42 43 28 C0 22 69 38 DF B5 1C 11 D0"  -v true
./version15-3-0/IntuneMAMPackager/Contents/MacOS/IntuneMAMPackager -i $INPUT_IPA_PATH -o $OUTPUT_WRAPPED_IPA_PATH -p $SET_PROVISIONING_PROFILE_PATH -c "CE FA 93 71 4B 6B 95 C9 42 43 28 C0 22 69 38 DF B5 1C 11 D0"  -v true