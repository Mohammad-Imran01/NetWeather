pragma Singleton
import QtQuick 2.15

QtObject {
    readonly property color background: "#232429"
    readonly property color hoverColor: "#2a2d36"
    readonly property color textBackground: "#2b2f3b"
    readonly property color popupBackground: "#333742"
    readonly property color appStyle: "#1d5ffe"
    readonly property color labelColor: "#85889b"
    readonly property color textColor: "#FFFFFF"
    readonly property color borderColor: "#464a53"
    readonly property color placeholderColor: "#757985"

    property double varLeftBarWidth:65
    property double varTopBarHeight:65
    property bool   varLeftBarActive: false
}
