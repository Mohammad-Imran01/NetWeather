import QtQuick 2.15

import "public.js" as Jmain

// Rectangle {
//     color:"transparent"
// border{width:2; color:"steelblue";}
Item {

    height:200
    width:300

    property string varLocation     :"Kolkata, WB"
    property int    varTemperature  :37
    property bool   varIsCelsius    : true
    property string varWeatherType  :"Partly Sunny"
    property string varLastUpdateTime   :"01.27 PM"

    property int    varAirQuality   : 36
    property string varAirSeverity  : "Good air"
    // property int varFeelsLike:76
    property int    varWindSpeed    :9
    property int    varVisibility   :8
    property double varBarometer    :1004.00

    property alias varWeatherIconType: cntIconId.weatherIcon

    CLabel /*Top text current location*/
    {
        anchors {
            horizontalCenter: parent.horizontalCenter
            top:parent.top
        }
        text: varLocation

        font.pixelSize: 26
    }

    CLabel /*Bottom text air weather type*/
    {
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom:parent.bottom
        }
        text: varWeatherType

        font.pixelSize: 26
    }

    CLabel /*Texperature huge text*/
    {
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        text: Jmain.addUnit(varTemperature, font.pixelSize)

        font.pixelSize: 115
        textFormat:Text.RichText

        font.letterSpacing:-3
    }

    CWIcon /*Main weather data main image*/
    {id:cntIconId
        height:100
        width:100
        // anchors.centerIn: parent

        anchors {
            verticalCenter: parent.verticalCenter
            left:parent.left
            leftMargin: Math.floor(-width*.45)
        }
    }

    CLabel /*Current unit of the current weather shown Weather shown*/
    {
        anchors {
            verticalCenter: parent.verticalCenter
            right: parent.right
        }
        z:1
        textFormat: Text.RichText
        text:
            `<span style="font-size:30px;">${varIsCelsius ? "C" : "F"}</span>` +
                                                            `<br>` +
                                                            `<span style="font-size:21px;color:#ccc;">${varIsCelsius ? "F" : "C"}</span>` +
                                                                                                                       `<span style="font-size:13px;color:transparent">.</span>`

        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
    }

    CLabel {
        text: "Updated as of " + varLastUpdateTime
        anchors {
            top:parent.bottom
            horizontalCenter: parent.horizontalCenter
            topMargin: Math.floor(height/4)
        }
        font {
            pixelSize: 20
        }
    }
}
