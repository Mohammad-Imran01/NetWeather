import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id:cnt
    CBtn {
        id:btnLeft
        setIcon: "qrc:/images/right-arrow.png"
        backgroundColor: constColors[0]
        imageRotation: 180
        onBtnClicked: {
            listViewId.decrementCurrentIndex()
        }
        z:5
        implicitWidth: 25
        radius:2

        anchors {
            leftMargin: width*.1
            left:parent.left
            verticalCenter: parent.verticalCenter
        }
    }

    CBtn {
        id:btnRight
        setIcon: btnLeft.setIcon
        backgroundColor: btnLeft.backgroundColor
        z:btnLeft.z
        implicitWidth:btnLeft.implicitWidth
        radius:btnLeft.radius

        onBtnClicked: {
            listViewId.incrementCurrentIndex()
        }

        anchors {
            right:parent.right
            verticalCenter: parent.verticalCenter
            rightMargin: width*.1
        }
    }

    ListView {
        id:listViewId
        anchors.fill: parent
        cacheBuffer:1
        orientation: ListView.Horizontal
        spacing: 11

        clip:true

        onCurrentIndexChanged: {
            if (currentIndex >= 0 && currentIndex < count) {
                positionViewAtIndex(currentIndex, contentY)
            }
        }
        boundsBehavior: Flickable.StopAtBounds

        Behavior on currentIndex {
            NumberAnimation {
                duration: 100
            }
        }

        model:weatherModel
        delegate: WeatherItem {
            height: listViewId.height
            width:isActive ?
                    varCardWidthSelected:varCardWidthNormal

            varDate:model.day
            varMaxTemp: Math.ceil(parseFloat(model.maxTemp))
            varMinTemp: Math.ceil(parseFloat(model.minTemp))
            varTypeWeather:model.weatherType.split(', ')[0]

            isActive: index === listViewId.currentIndex

            MouseArea {
                anchors.fill: parent
                onClicked: listViewId.currentIndex = index
            }
            Behavior on width {
                NumberAnimation {
                    duration: 200
                }
            }
        }
    }
}
