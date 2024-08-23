import QtQuick 2.15
// import QtQuick.Layouts 1.0

// Constitues the topbar of main window
Rectangle /*TopBar*/ {
    // property alias textD:textDeb

    // Text {
    //     id:textDeb
    //     color:"red"
    //     anchors.centerIn: parent
    // }

    id:topBarId
    color: varBlack
    opacity:.75
    anchors {
        top:parent.top
        left:leftBarId.right
    }
    height:parent.height*.06
    width:parent.width-leftBarId.width - anchors.leftMargin

    Rectangle {
        id:borderId
        height:2
        anchors {
            left:parent.left
            right:parent.right
            bottom: parent.bottom
        }
        color: constColors[4]
    }

    Row {
        anchors.fill: parent
        layoutDirection:Qt.RightToLeft
        spacing:width*.03
        // rightPadding:gpsBtnId.width*.35

        CTextField {
            id:inputFieldId
            implicitWidth: topBarId.width*.3 //Math.max(searchIconId.width, Math.min(topBarId.width*.3, 300))
            implicitHeight: topBarId.height*.75
            isBold:false
            placeholderText: qsTr("City, State, Country.")
            // selectedTextColor: "#FFFFFF"
            // selectionColor: constColors[0]
            radius: 4
            borderColor : background.color

            anchors.verticalCenter: parent.verticalCenter

            onAccepted: {
                handleSearch()
                inputFieldId.clear()
            }

            CBtn {
                id:searchIconId
                anchors {
                    right:parent.right
                    rightMargin:width*.2
                    verticalCenter: parent.verticalCenter
                }
                // hoverEnabled: true
                onHoveredChanged: {
                    backgroundColor = hovered ? Qt.lighter("blue"):constColors[6]
                }
                onBtnClicked: {
                    handleSearch()
                    inputFieldId.clear()
                }

                implicitHeight: parent.implicitHeight*.8
                implicitWidth: implicitHeight
                backgroundColor: "transparent"
                z:1
                radius:4
                setIcon: "qrc:/images/searchlite.png"
            }
        }

        CBtn /*The GPS Icon to set data for current position*/ {
                        id:gpsBtnId
            implicitWidth:40
            implicitHeight:implicitWidth
            anchors {
                verticalCenter: parent.verticalCenter
            //     right:parent.right
            //     rightMargin:  width*.75
            }
            setIcon:"qrc:/images/gpslite.png"
            z:5
            backgroundColor: "transparent"
            radius:Math.max(height, width)
            // onPressed: handleGPSPressed()
        }
        CBtn /*The refersh button to refresh all data */ {
            id:refreshBtnId
            anchors {
                verticalCenter: parent.verticalCenter
                //     right:parent.right
                //     rightMargin:  width*.75
            }
            setIcon:"qrc:/images/refreshlite.png"
            z:5
            backgroundColor: "transparent"
            radius:Math.max(height, width)
            // onPressed: wndId.refreshPressed()
        }
    }
    function handleSearch() {
        var texts = inputFieldId.text.split(',')
        var city = texts.length > 0 ? texts[0]:""
        var state = texts.length > 1 ? texts[1]:""
        var country = texts.length > 2 ? texts[2]:""
        dataHandler.getLanLon(city, state, country)
    }
}
