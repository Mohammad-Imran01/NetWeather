import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle /*LeftBar: Constitutes the left bar of the main window.*/
{
    id:leftBarId
    color: varBlack
    opacity:.8

    Rectangle {
        id:borderId
        width:2
        anchors {
            top:parent.top
            right:parent.right
            bottom: parent.bottom
        }
        color: constColors[4]
    }


    CBtn /*The settings button*/
    {
        id:settingsBtnId
        x: AppStyle.varLeftBarWidth/2 - width/2
        y: parent.height-x-height

        setIcon: "qrc:/images/settinglite.png"
        z:5
        backgroundColor: "transparent"

        onBtnClicked :{
            if(!AppStyle.varLeftBarActive) return
        }
    }


    Behavior on width {
        NumberAnimation {
            duration: 200
        }
    }
}
