
import QtQuick 2.0

// @brief Rectangle shows the pressed state of the object
Rectangle{
    id: qSmartFocusRect
    anchors.fill: parent
    color: "transparent"
    opacity : 0.3
    z:1
    property int focusWidth : 0
    property color focusColor
    border.width: focusWidth
    border.color: focusColor
}


