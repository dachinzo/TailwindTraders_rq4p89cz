#!/usr/bin/env bash

########################################################################################################################
# Configure App Secrets
########################################################################################################################

if [ ! -n "$ANDROID_APPCENTER_SECRET" ] || [ ! -n "$IOS_APPCENTER_SECRET" ] || [ ! -n "$ROOT_API_URL" ] || [ ! -n "$ROOT_API_WEBBFF_URL" ]  ; then
	echo ###################################################################################
    echo "Not all needed variables are set. The app won't be auto-provisioned correctly"
	echo ###################################################################################
    exit
fi

ANDROID_APPCENTER_SECRET_PLACEHOLDER="__ENTER_YOUR_ANDROID_APPCENTER_SECRET_HERE__"
IOS_APPCENTER_SECRET_PLACEHOLDER="__ENTER_YOUR_IOS_APPCENTER_SECRET_HERE__"
ROOT_API_URL_PLACEHOLDER="__ENTER_YOUR_HTTPS_ROOT_API_URL_HERE__"
ROOT_API_URL_WEBBFF_PLACEHOLDER="__ENTER_YOUR_HTTPS_WEBBFF_ROOT_API_URL_HERE__"

APP_DEFAULT_SETTINGS_FILE=$APPCENTER_SOURCE_DIRECTORY/Source/TailwindTraders.Mobile/TailwindTraders.Mobile/Features/Settings/DefaultSettings.cs

echo "Settings file to modify: $APP_DEFAULT_SETTINGS_FILE"

if [ -e "$APP_DEFAULT_SETTINGS_FILE" ] ; then
	echo "Updating Android AppCenter secret"
	sed -i ".bak" -e "s,$ANDROID_APPCENTER_SECRET_PLACEHOLDER,$ANDROID_APPCENTER_SECRET,g" $APP_DEFAULT_SETTINGS_FILE
	echo "Updating iOS AppCenter secret"
	sed -i ".bak" -e "s,$IOS_APPCENTER_SECRET_PLACEHOLDER,$IOS_APPCENTER_SECRET,g" $APP_DEFAULT_SETTINGS_FILE
	echo "Updating Root API URL"
	sed -i ".bak" -e "s,$ROOT_API_URL_PLACEHOLDER,$ROOT_API_URL,g" $APP_DEFAULT_SETTINGS_FILE	
	echo "Updating Root WEBBFF API URL"
	sed -i ".bak" -e "s,$ROOT_API_URL_WEBBFF_PLACEHOLDER,$ROOT_API_WEBBFF_URL,g" $APP_DEFAULT_SETTINGS_FILE
	
	echo "Resulting file content:"
	cat $APP_DEFAULT_SETTINGS_FILE
else
    echo "Error! File to modify not found"
	exit
fi
