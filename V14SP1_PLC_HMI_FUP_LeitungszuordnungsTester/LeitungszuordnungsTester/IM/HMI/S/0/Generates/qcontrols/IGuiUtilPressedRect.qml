
import QtQuick 2.0

// @brief Rectangle shows the pressed state of the object
Rectangle{
    id: qSmartPressedRect
    anchors.fill: parent
    property int borderWidth : 0
    property color borderColor : "transparent"
    color: "transparent"
    opacity: 0.5
    z:1
    border.width: borderWidth
    border.color: borderColor

}
