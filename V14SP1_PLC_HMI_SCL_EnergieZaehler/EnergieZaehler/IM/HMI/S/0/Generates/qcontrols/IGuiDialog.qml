// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0

Rectangle {
	id: smartDialog
    width: 360
    height: 200
    color: "#555353"
    radius: 6

    property int titleBarHeight : 30
    
    signal componentCreated();

    Rectangle {
        id: rectangle1
        x: 0
        y: 0
        width: 360
        height: titleBarHeight
        color: "#383535"
        radius: 6
    }

    Rectangle {
        id: rectangle2
        x: 330
        y: 0
        width: 30
        height: 30
        color: "#070606"
        radius: 6
    }
    
    Component.onCompleted:
	{
		smartDialog.componentCreated()
	}
}
