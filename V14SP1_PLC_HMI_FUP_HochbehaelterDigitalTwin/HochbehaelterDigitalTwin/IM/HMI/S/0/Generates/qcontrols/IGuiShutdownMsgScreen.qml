import QtQuick 2.0

/// Background screen
Rectangle
{

    id:qMessageScreen
    objectName: "messagescreen"
    width : 0
    height : 0
    color : "white"

    // text
    Text{
        id: qMessageText
        anchors.fill: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: "black"
        font.family: "Tohoma"
        font.pointSize: 12
       text:"Shutting down..."
    }
	
    //Set the text
    function setValue(value)
    {
        qMessageText.text = value;
    }

    function setSize(newWidth,newHeight)
    {
       qMessageScreen.width = newWidth
       qMessageScreen.height = newHeight
    }

    function setRotation(angle)
    {
        //landscape mode SRT
        if(angle === 90)
        {
           var diff = Math.abs(height - width)
           x = x + (diff / 2)
           y = y - (diff / 2)
           rotation = angle
        }
    }
}



