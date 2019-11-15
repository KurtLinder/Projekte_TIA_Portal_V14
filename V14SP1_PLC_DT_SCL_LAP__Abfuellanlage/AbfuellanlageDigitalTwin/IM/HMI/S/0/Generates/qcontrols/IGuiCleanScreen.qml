import QtQuick 2.0

/// Background screen
Rectangle
{

    id:qCleanScreen
    objectName: "cleanscreen"

    //background screen properties
    property int backgroundScreenWidth
    property int backgroundScreenHeight
    property int backgroundScreenBorderWidth
    property color backgroundScreenBorderColor
    property color backgroundScreenFillColor

    // page properties
    backgroundScreenWidth: 0
    backgroundScreenHeight: 0

    backgroundScreenBorderWidth: 0
    //backgroundScreenBorderColor: "black"
    backgroundScreenFillColor: "white"

    //text properties
    property int textXpos
    property int textYpos
    property string textFontFamily
    property int textFontSize
    property color textColor

    textXpos: backgroundScreenWidth/2 - 42
    textYpos: backgroundScreenHeight/2 - 70
    textFontFamily: "Arial"
    textFontSize: 12
    textColor: "black"

    //outer static rect properties
    property int outerRectXpos
    property int outerRectYpos
    property int outerRectWidth
    property int outerRectHeight
    property int outerRectBorderWidth
    property color outerRectBorderColor
    property color outerRectFillColor

    outerRectXpos: 20
    outerRectYpos:  backgroundScreenHeight/2 - 20
    outerRectWidth: backgroundScreenWidth - 40
    outerRectHeight: 47
    outerRectBorderWidth: 1
    outerRectBorderColor: "black"
    outerRectFillColor : "white"

    //flow rect properties
    property int innerRectWidth
    property int innerRectHeight
    property color innerRectFillColor

    innerRectWidth: outerRectWidth
    innerRectHeight: outerRectHeight
    innerRectFillColor: "black"

    width:qCleanScreen. backgroundScreenWidth
    height: qCleanScreen.backgroundScreenHeight
    border.width: qCleanScreen.backgroundScreenBorderWidth
    border.color: qCleanScreen.backgroundScreenBorderColor
    color: qCleanScreen.backgroundScreenFillColor
    z: 500

    // text
    Text{
        id:text
        x: qCleanScreen.textXpos
        y:qCleanScreen.textYpos
        text: "Clean now..."
        font.family: qCleanScreen.textFontFamily
        font.pointSize: qCleanScreen.textFontSize
        color: qCleanScreen.textColor
    }


    Rectangle
    {
        id: outeRect
        x: qCleanScreen.outerRectXpos
        y: qCleanScreen.outerRectYpos
        width: qCleanScreen.outerRectWidth
        height: qCleanScreen.outerRectHeight
        border.width: qCleanScreen.outerRectBorderWidth
        border.color: qCleanScreen.outerRectBorderColor
        color: qCleanScreen.outerRectFillColor

        //flow rect
        Rectangle {
            id: innerRect

            x: outeRect.border.width
            y: outeRect.border.width

            width: outerRectWidth -(2*outeRect.border.width)
            height: outerRectHeight -(2*outeRect.border.width)
            color: innerRectFillColor
            property int timePeriod : 0           
            Behavior on width {
                SmoothedAnimation {
                    velocity: ((outeRect.width - 2*outeRect.border.width) / innerRect.timePeriod )

                    onRunningChanged:
                    {
                        if(!running)
                            closeCleanScreen();
                    }

                }

            }
        }
    }


    function setSize(nPageWidth,nPageHeight)
    {
        proxy.setCleanScreeActivated(true);
        qCleanScreen.backgroundScreenWidth = nPageWidth;
        qCleanScreen.backgroundScreenHeight = nPageHeight;
    }

    //function for set the clean screen duration value
    function setStatusValue(value)
    {

        innerRect.timePeriod = value;
        innerRect.width = 0;
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

    //function to close the clean screen
    function closeCleanScreen()
    {
            proxy.destroyCleanScreenComponent();
    }

    MouseArea
    {
        anchors.fill: parent
    }

}










