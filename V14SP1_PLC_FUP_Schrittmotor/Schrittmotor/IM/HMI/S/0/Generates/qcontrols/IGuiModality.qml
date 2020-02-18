import QtQuick 2.0
Rectangle
{
    id:dialogModality
    x: -(parent.x)
    y: -(parent.y)
    width: 1280
    height: 1280
    z:-1
    color: "#00000000"
    MouseArea
    {
        anchors.fill: dialogModality
		acceptedButtons: Qt.LeftButton | Qt.RightButton
    }
}
