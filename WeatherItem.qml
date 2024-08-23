import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id:dayId

    color:"transparent"
    Rectangle {
        anchors.fill:parent
        color:constColors[4]
        opacity:isActive ? .7:.4
        radius:parent.radius
    }
    clip:true
    radius:8

    //-------------------------------------------------------------
    property alias   varDate         : dateTextId.text
    property alias   varWeatherImg   : dateTextId.text
    property string  varMaxTemp
    property string  varMinTemp
    property string  varTypeWeather
    property string varPercipitation:"1"

    property bool isActive:false

    property alias varWeatherIconType: imageId.weatherIcon

    CLabel {
        id:dateTextId
        anchors {
            top:parent.top
            left:parent.left
            topMargin:height/3
            leftMargin:width/3
        }

        text:varDate
        color:constColors[0]

        font {
            pixelSize: 20
        }
    }


    CWIcon /* --- Image of the weather --- */
    {
        id:imageId

        height:60
        width: height

        anchors {
            verticalCenter: parent.verticalCenter
            verticalCenterOffset:10
            left:dateTextId.left
        }
    }
    CLabel /* --- Min and Max temperatures Weather type string --- */{
        id:tempTextId

        textFormat: Text.RichText
        lineHeight:1.2
        text: "<span>%1</span>&nbsp;".arg(varMaxTemp)
              + "<br/>"
              + "<span>%1</span>".arg(varMinTemp)
        color:constColors[0]
        font.pixelSize:23

        horizontalAlignment:Text.AlignLeft

        anchors {
            verticalCenter: imageId.verticalCenter
            // verticalCenterOffset:10
            left:imageId.right
            leftMargin:10
        }
    }

    CLabel /* --- Min and Max temperatures Weather type string --- */{
        id:extraTextId
        visible:isActive

        height:parent.height/3

        font {
            letterSpacing:-1
            pixelSize:17

        }

        textFormat: Text.RichText
        lineHeight:1.3
        text: "<span>%1</span>".arg(varTypeWeather)
              + "<br/>"
              + "<span>%1</span>".arg(varPercipitation)
        color:constColors[0]
        horizontalAlignment:Text.AlignRight

        anchors {
            verticalCenter:parent.verticalCenter
            right:parent.right
            rightMargin:parent.width*.05
        }
    }
}
