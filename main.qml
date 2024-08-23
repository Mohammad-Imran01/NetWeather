import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts
import QtWebEngine


import AppStyle 1.0
import DataHandler 1.0

import "./public.js" as Js

ApplicationWindow {
    id:wndId
    Material.theme: Material.Dark

    visible: true
    width: 914
    height: 768
    color: constColors[3]
    x:1300
    y:300

    flags: Qt.Window

    property bool varDisplayMaxMode: wndId.width >= 1360
    property bool varDisplayMidMode: (wndId.width >= 1030) && (wndId.width < 1360)
    property bool varDisplayMinMode: wndId.width < 1030
    readonly property int constContainerMax:1280
    readonly property int constContainerMid: 940
    readonly property int constContainerMin: 640

    property double varWidthContainer: {
        if (varDisplayMaxMode)
            return constContainerMax
        else if (varDisplayMidMode)
            return constContainerMid
        return constContainerMin
    }
    readonly property int constRowTopHeight:300


    ////// font sizes
    property int sizeH1:11
    property int sizeH2:13
    property int sizeH3:15
    property int sizeH4:17
    property int sizeH5:19
    property int sizeH6:21
    property int sizeH7:24
    property int sizeH8:27
    property int sizeH9:30
    // property int sizeH6:34




    signal refreshPressed()

    property string varBlue:"#0a2c57"
    property color varBlack:"#18191a"

    property int    varSpacing:5
    property string varColorWhite :"#ffffff"

    property double varTemperature_2m
    property double varRelative_humidity_2m
    property double varApparent_temperature
    property double varIs_day
    property double varPrecipitation
    property double varRain
    property double varShowers
    property double varSnowfall
    property double varWeather_code
    property double varCloud_cover
    property double varPressure_msl
    property double varSurface_pressure
    property double varWind_speed_10m
    property double varWind_direction_10m
    property double varWind_gusts_10m



    property var constColors: [
        /*0.white*/   "white",
        /*1.skyblue*/ "#3e89b5",
        /*2.orange*/  "orange",
        /*3.blue*/    "#327de6",
        /*4. black*/  "#18191a",
        /*5. dark grey*/"#212121",
        /*6. transparent*/"transparent"
    ]
    property double varMyLAT: 34.6937
    property double varMyLON: 135.5023
    property double varCardHeight:130
    property double varCardWidthNormal:200
    property double varCardWidthSelected:350

    property string varGPSData:""


    Image {
        anchors.fill: parent
        asynchronous: true
        source: "qrc:/images/clearBlueSky.jpg"
    }

    Rectangle /*background cover to increase text visiblity*/{
        anchors.fill: parent
        color: constColors[4]
        opacity:.4
    }

    //------------------------------------------------------------------
    CBtn /*The GPS Icon to set data for current position*/
    {
        x: AppStyle.varLeftBarWidth/2 - width/2
        anchors {
            verticalCenter: topBarId.verticalCenter}
        setIcon: "qrc:/images/hamburgerWhite.png"
        z:5
        backgroundColor: "transparent"
        onBtnClicked: AppStyle.varLeftBarActive = !AppStyle.varLeftBarActive
    }


    CTopBar {
        id:topBarId
        // textD.text: "wndWidth: " + wndId.width + "  cntWidth: " + varWidthContainer
        // textD.font.pixelSize: 20
        anchors {
            top:parent.top
            left:leftBarId.right
            leftMargin: AppStyle.varLeftBarActive ?1:0
        }
        height: AppStyle.varTopBarHeight
        width:parent.width-leftBarId.width - anchors.leftMargin
    }

    CLeftBar {
        id:leftBarId
        anchors {
            left:parent.left
            top:parent.top
            bottom:parent.bottom
        }
        width:   AppStyle.varLeftBarActive ? AppStyle.varLeftBarWidth:0
        visible: AppStyle.varLeftBarActive
        enabled: AppStyle.varLeftBarActive
    }



    // CCentralData {
    //     id:cntMain
    //     anchors.centerIn: parent
    //     anchors {
    //         verticalCenterOffset: -parent.height*.22
    //         // horizontalCenterOffset: -parent.width/5
    //     }
    //     height:200
    //     width:300

    //     // cntMain.varLocation:wndId.
    //     varTemperature:wndId.varTemperature_2m
    //     varIsCelsius:true
    //     varWeatherType:wndId.varWeather_code
    //     // cntMain.varLastUpdateTime:varwea
    //     // cntMain.varAirQuality
    //     // cntMain.varAirSeverity
    //     // cntMain.varFeelsLike:76
    //     // cntMain.varWindSpeed
    //     // cntMain.varVisibility
    //     // cntMain.varBarometer
    // }



    Flickable {
        id: flickId
        anchors.fill: parent

        contentWidth: gridId.width;
        contentHeight: gridId.height

        // contentY: topBarId.y + topBarId.height*1.1

        clip:true

        anchors.topMargin:topBarId.y + topBarId.height*1.1

        GridLayout {
            id: gridId
            columns: varDisplayMinMode ? 1: varDisplayMaxMode ?4:3
            rows:varDisplayMinMode?2:1


            columnSpacing: 10
            rowSpacing: 10
            width: varWidthContainer
            x:(parent.parent.width-width)/2

            CCentralLayout {
                // color: "darkred"
                height: constRowTopHeight

                Layout.columnSpan: varDisplayMaxMode ? 2 : 1

                Layout.fillWidth:  true
            }


            Rectangle {
                color: "lightgreen"
                height: constRowTopHeight
                Layout.preferredWidth: gridId.columns
                Layout.fillWidth: true

                WebEngineView {
                    id: webView
                    url: "https://google.com"//"http://maps.openweathermap.org/maps/2.0/weather/PA0/5/5/5?date=1552861800&appid="+Js.getOpenWeather_APIKEY()
                    Component.onCompleted: console.log(Js.openWeatherMapRequestlink(5, 5, 5, 'clouds_new', Js.getOpenWeather_APIKEY()))
                    anchors.fill: parent

                    // Signals to handle different stages of web loading
                    // onLoadingChanged: {
                    //     if (loadRequest.status === WebEngineLoadRequest.Loading) {
                    //         console.log("Loading started:", loadRequest.url)
                    //         loadingIndicator.visible = true
                    //         errorMessage.visible = false
                    //     } else if (loadRequest.status === WebEngineLoadRequest.Loaded) {
                    //         console.log("Loading finished:", loadRequest.url)
                    //         loadingIndicator.visible = false
                    //         errorMessage.visible = false
                    //     } else if (loadRequest.status === WebEngineLoadRequest.Error) {
                    //         console.log("Loading error:", loadRequest.url)
                    //         loadingIndicator.visible = false
                    //         errorMessage.visible = true
                    //         errorMessage.text = "Failed to load: " + loadRequest.url + "\nError: " + loadRequest.errorString
                    //     }
                    // }

                    // Show detailed console messages for debugging
                    onUrlChanged: console.log("URL changed to:", url)
                    // onLoadStarted: console.log("Load started")
                    // onLoadFinished: console.log("Load finished:", loadSuccess)
                    // onLoadingError: console.log("Loading error:", loadRequest.errorString)

                    // Handle the rendering process error
                    // onRenderProcessTerminated: {
                    //     console.log("Render process terminated with status:", status)
                    //     errorMessage.visible = true
                    //     errorMessage.text = "Render process terminated. Status: " + status
                    // }
                }


                Rectangle {
                    id: loadingIndicator
                    width: 100
                    height: 4
                    color: "blue"
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: false
                }// Loading Indicator


                Text {
                    id: errorMessage
                    color: "red"
                    font.pixelSize: 16
                    visible: false
                    anchors.centerIn: parent
                }// Error Message Display
            } // main map widget webengine loads contents, a loader and some indicators
            Rectangle {
                color: "lightgreen"
                height: constRowTopHeight
                Layout.preferredWidth: gridId.columns
                Layout.fillWidth: true

                WebEngineView {
                    url: "https://google.com"//"http://maps.openweathermap.org/maps/2.0/weather/PA0/5/5/5?date=1552861800&appid="+Js.getOpenWeather_APIKEY()
                    Component.onCompleted: console.log(Js.openWeatherMapRequestlink(5, 5, 5, 'clouds_new', Js.getOpenWeather_APIKEY()))
                    anchors.fill: parent

                    // Signals to handle different stages of web loading
                    // onLoadingChanged: {
                    //     if (loadRequest.status === WebEngineLoadRequest.Loading) {
                    //         console.log("Loading started:", loadRequest.url)
                    //         loadingIndicator.visible = true
                    //         errorMessage.visible = false
                    //     } else if (loadRequest.status === WebEngineLoadRequest.Loaded) {
                    //         console.log("Loading finished:", loadRequest.url)
                    //         loadingIndicator.visible = false
                    //         errorMessage.visible = false
                    //     } else if (loadRequest.status === WebEngineLoadRequest.Error) {
                    //         console.log("Loading error:", loadRequest.url)
                    //         loadingIndicator.visible = false
                    //         errorMessage.visible = true
                    //         errorMessage.text = "Failed to load: " + loadRequest.url + "\nError: " + loadRequest.errorString
                    //     }
                    // }

                    // Show detailed console messages for debugging
                    onUrlChanged: console.log("URL changed to:", url)
                    // onLoadStarted: console.log("Load started")
                    // onLoadFinished: console.log("Load finished:", loadSuccess)
                    // onLoadingError: console.log("Loading error:", loadRequest.errorString)

                    // Handle the rendering process error
                    // onRenderProcessTerminated: {
                    //     console.log("Render process terminated with status:", status)
                    //     errorMessage.visible = true
                    //     errorMessage.text = "Render process terminated. Status: " + status
                    // }
                }

            } // dummy main map widget webengine loads contents, a loader and some indicators

            // Rectangle {
            //     color: "steelblue"
            //     height: constRowTopHeight
            //     Layout.preferredWidth:gridId.columns

            //     Layout.fillWidth: true
            // }
            Rectangle {
                color: "pink"
                height: 0//constRowTopHeight
                Layout.preferredWidth:gridId.columns

                Layout.fillWidth: true
            }


            WeatherView /*Cards at bottom of mainwindow, showing the seven day weather data*/
            {
                // anchors {
                //     left: leftBarId.right
                //     right:parent.right
                //     bottom: parent.bottom
                //     margins:50
                // }
                height:varCardHeight
                Layout.columnSpan:gridId.columns

                Layout.fillWidth:  true
            }
        }
    }





    /////////// functions /////////////////
    Component.onCompleted: {
        weatherModel.urlhandler(qsTr("https://api.open-meteo.com/v1/forecast?latitude=12.913&longitude=77.64&daily=weather_code,temperature_2m_max,temperature_2m_min"))

        // console.log("leftWidth: " +leftBarId.width + ", TopHeight: " + topBarId.height)
    }

    Connections {
        target:dataHandler

        function onVarIconTypeChanged() {
            console.log("IconType: " + dataHandler.varIconType)
            cntMain.varWeatherIconType = dataHandler.varIconType
        }

        function onDataAvailableChanged() {
            wndId.varTemperature_2m       = dataHandler.varTemperature_2m
            wndId.varRelative_humidity_2m = dataHandler.varRelative_humidity_2m
            wndId.varApparent_temperature = dataHandler.varApparent_temperature
            wndId.varIs_day               = dataHandler.varIs_day
            wndId.varPrecipitation        = dataHandler.varPrecipitation
            wndId.varRain                 = dataHandler.varRain
            wndId.varShowers              = dataHandler.varShowers
            wndId.varSnowfall             = dataHandler.varSnowfall
            wndId.varWeather_code         = dataHandler.varWeather_code
            wndId.varCloud_cover          = dataHandler.varCloud_cover
            wndId.varPressure_msl         = dataHandler.varPressure_msl
            wndId.varSurface_pressure     = dataHandler.varSurface_pressure
            wndId.varWind_speed_10m       = dataHandler.varWind_speed_10m
            wndId.varWind_direction_10m   = dataHandler.varWind_direction_10m
            wndId.varWind_gusts_10m       = dataHandler.varWind_gusts_10m


            // console.log(varTemperature_2m           + "\n")
            // console.log(varRelative_humidity_2m     + "\n")
            // console.log(varApparent_temperature     + "\n")
            // console.log(varIs_day                   + "\n")
            // console.log(varPrecipitation            + "\n")
            // console.log(varRain                     + "\n")
            // console.log(varShowers                  + "\n")
            // console.log(varSnowfall                 + "\n")
            // console.log(varWeather_code             + "\n")
            // console.log(varCloud_cover              + "\n")
            // console.log(varPressure_msl             + "\n")
            // console.log(varSurface_pressure         + "\n")
            // console.log(varWind_speed_10m           + "\n")
            // console.log(varWind_direction_10m       + "\n")
            // console.log(varWind_gusts_10m           + "\n")
        }
    }

    function handleGPSPressed() {
        /*https://api.open-meteo.com/v1/forecast?latitude=34.6937&longitude=135.5023&
    current=temperature_2m,relative_humidity_2m,apparent_temperature,is_day,precipitation,
    rain,showers,snowfall,weather_code,cloud_cover,pressure_msl,surface_pressure,wind_speed_10m,
    wind_direction_10m,wind_gusts_10m&timezone=auto&past_days=0*/

        var latLon = "latitude=34.6937&longitude=135.5023"
        var varDaily = varDailyProperties.join(',')
        var link = constMateoLink + "/v1/forecast?"+ latLon +"&current="+ varDaily +"&timezone=auto&past_days=0"

        dataHandler.urlhandler(link)

        dataHandler.setIconVal(varMyLAT + "",
                               varMyLON + "")
        // console.log(link)

    }

    // CWeatherTile {
    //     anchors.fill:parent
    //     z:1000
    // }


}

