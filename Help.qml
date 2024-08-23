import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: appWindow
    width: 1024
    height: 768
    visible: true
    y: 600
    x: 300
    color: "steelblue"

    property double varRowHeight: 340

    // Size type properties
    property bool varIsMaxSizeDisplay: appWindow.width >= 1690
    property bool varIsMidSizeDisplay: appWindow.width >= 1277 && appWindow.width < 1690
    property bool varIsMinSizeDisplay: appWindow.width < 1277

    readonly property double constMaxDisplayWidth: 1548
    readonly property double constMidDisplayWidth: 1165
    readonly property double constMinDisplayWidth: 765

    property double varWidthContainer: {
        if (varIsMaxSizeDisplay)
            return constMaxDisplayWidth
        else if (varIsMidSizeDisplay)
            return constMidDisplayWidth
        else
            return constMinDisplayWidth
    }

    ScrollView {
        width: varWidthContainer
        height: parent.height // Set a height smaller than the total content height
        anchors.horizontalCenter: parent.horizontalCenter
        // background: Rectangle { color: "black" }
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

        Column {
            spacing: 10
            width: varWidthContainer

            Grid {
                id: topGridId
                columns: varIsMaxSizeDisplay || varIsMidSizeDisplay ? 3 : 1

                Rectangle {
                    height: varRowHeight
                    width: varIsMaxSizeDisplay ? varWidthContainer / 2 : (varIsMidSizeDisplay ? varWidthContainer / 3 : varWidthContainer)
                    color: "pink"
                    Text {
                        text: "MAIN"
                        anchors.centerIn: parent
                    }
                }

                Rectangle {
                    height: varRowHeight
                    width: varIsMaxSizeDisplay || varIsMidSizeDisplay ? varWidthContainer / 3 : varWidthContainer
                    color: "brown"
                }

                Rectangle {
                    height: varRowHeight
                    width: varIsMaxSizeDisplay || varIsMidSizeDisplay ? varWidthContainer / 3 : varWidthContainer
                    color: "blue"
                }
            }
        }
    }
}
