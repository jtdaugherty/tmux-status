
URL="http://api.wunderground.com/weatherstation/WXCurrentObXML.asp?ID="

if [ ! -z "$WEATHER_STATION" ]
then
    TEMP=$(curl -s "${URL}${WEATHER_STATION}" | grep temp_f | cut -d \> -f 2 | cut -d \< -f 1)
    if [ -z "${TEMP}" ]
    then
        echo "--°F"
    else
        echo "${TEMP}°F"
    fi
else
    echo "\$WEATHER_STATION not set"
fi
