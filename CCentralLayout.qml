import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    id:mainCntOut
    radius:6
    color:"#1e2a61"
    clip:true
    Column {
        id:mainCnt
        anchors.fill:parent
        spacing:10

        anchors {
            margins: varDisplayMidMode?20: 30
            leftMargin: varDisplayMidMode?15: 20
            rightMargin:varDisplayMidMode?15: 20
        }

        Row {
            id:rrr1
            Text {
                id:currentWeatherTextId
                text:"<span style='font-size:"+ sizeH5+"px';>Current Weather</span>" + "<br>"
                     + "<span style='font-size:"+ sizeH3+"px';>10:12 AM</span>"
                textFormat:Text.RichText
                color:"white"
                lineHeight :1
            }

            Item {
                width:mainCnt.width- currentWeatherTextId.width-reviewRectId.width-2//*rrr1.anchors.margins
                height:1
            }

            Rectangle {
                id:reviewRectId
                height:mainCnt.height*.12
                width:mainCnt.width*.37
                radius:height*.2
                color:Qt.lighter(mainCntOut.color)
            }
        }// Top row: current weather, time. [seeing differwnt weather box]

        Row {
            spacing:varDisplayMidMode ? 10:25
            Rectangle {
                y:!varDisplayMidMode?0:5
                height:!varDisplayMidMode? 60:45
                radius:width
                width:height
                // color:"orange"
                color:"transparent"
                border.width:0
                Image {
                    source: "qrc:/images/icons/weather-storm.png"
                    anchors.fill: parent
                }
            }
            Row { // MAIN Current Weather Text
                height:parent.height

                Text {
                    text: "30"
                    font.pixelSize: varDisplayMidMode?sizeH5*2.4: sizeH5*3.2
                    color: "white"
                    font.letterSpacing:-2
                    font.family:"Arial"
                }

                Text {
                    text: "°C"
                    font.pixelSize: sizeH4*1.7+1 //35
                    color: "white"
                    font.letterSpacing:-2

                    height:parent.height
                    verticalAlignment: Text.AlignTop
                    y: varDisplayMidMode?0: 7  // Adjust this value to fit within your boundary
                }
            }

            Item {
                height:parent.height
                width:varDisplayMidMode ? 5: 30
            }
            Text {
                id:currentWeatherTypeTextId
                text:"<span style='font-size:"+(varDisplayMidMode?sizeH4+2: sizeH5+1)+"px'>Current Weather</span>" + "<br>"
                     + "<span style='font-size:"+(varDisplayMidMode?sizeH3+1:sizeH4)+"px'>Feels Like&nbsp;34°</span>"
                textFormat:Text.RichText
                color:"white"
                lineHeight :1
                y:15
                font {family:"Arial"; pixelSize: sizeH3}
            }
        }// Mid Row: Image, main degree of temperature, currentweather, feels like, texts.

        Text {
            width:parent.width
            font.letterSpacing:-1
            text:varDisplayMidMode ?  " ":
                                     "Scattered light rain showers are expected. The high will reach 34° on this humid day."
            color:"white"
            verticalAlignment:Text.AlignVCenter
            height: varDisplayMidMode ? (implicitHeight/3):implicitHeight*3
            wrapMode: Text.WordWrap
            font {
                family:"Arial"
                pixelSize:sizeH5
            }
        }

        GridView {
            id: gridView
            width:mainCnt.width
            height:childrenRect.height

            cellWidth: width/(varDisplayMidMode ? 4:6)
            cellHeight: 50
            model: varDisplayMidMode ? 8:6
            delegate: Rectangle {
                // anchors.centerIn: parent
                width: gridView.cellWidth
                height: gridView.cellHeight
                color: "transparent"

                Row{
                    Rectangle{
                        height:parent.height;
                        width:varDisplayMidMode ? 0:25
                        color:"transparent"
                        // color:"transparent"
                    }
                    Column {
                        id:cntTextData
                        // Air quality row
                        Row {
                            spacing: 2
                            width:parent.width
                            Text {
                                clip: true
                                textFormat: Text.RichText
                                text: "Air quality"// + gridView.width
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                font {
                                    pixelSize:varDisplayMidMode? sizeH1:sizeH2
                                    family: 'Arial'
                                }
                                height: implicitHeight + 2
                                color: "white"
                            }

                            Rectangle {
                                id: cnt_i
                                height: varDisplayMidMode? 10:12
                                width: varDisplayMidMode ?10:12
                                color: "transparent"
                                radius: width
                                border.width: 0.5
                                border.color: "white"

                                y:2

                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true
                                    onEntered: {
                                        cnt_i.color = "red"
                                    }
                                    onExited: {
                                        cnt_i.color = "green"
                                    }
                                }

                                Text {
                                    text: 'i'
                                    anchors.centerIn: parent
                                    font {
                                        pixelSize: 8
                                        family: 'Arial'
                                    }
                                    height: implicitHeight
                                    width: implicitWidth
                                    color: parent.border.color
                                }
                            }
                        }

                        // Value row
                        Row {
                            spacing: 2

                            Rectangle {
                                height: 9
                                width: 9
                                color: "orange"
                                radius: width
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            Text {
                                clip: true
                                textFormat: Text.RichText
                                text: "126"
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignHCenter
                                font {
                                    pixelSize: varDisplayMidMode ?sizeH4: sizeH5
                                    family: 'Arial'

                                }
                                color: "white"
                            }

                            Rectangle {
                                height: 9
                                width: 9
                                color: "orange"
                                radius: width
                                anchors.verticalCenter: parent.verticalCenter
                            }
                        }
                    }
                }
            }
        } // Last Item GridView: Air Quality, model data Texts.
    }
}











