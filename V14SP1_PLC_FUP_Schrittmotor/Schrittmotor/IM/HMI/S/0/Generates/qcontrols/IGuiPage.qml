import QtQuick 2.0
Item
{
    id:qpage

    property int objId : 0
    property bool brightnessIsZero:false
    
    function notifyPageBrightnessZero(value)
    {
        brightnessIsZero = value
    }
    Keys.onPressed:
    {
        proxy.keyHandler(qpage.objId, event.key, true, event.count,event.isAutoRepeat);
        event.accepted = true;
    }
    z:1

    Keys.onReleased:
    {
        proxy.keyHandler(qpage.objId, event.key, false, event.count, event.isAutoRepeat);
        event.accepted = true;
    }
    MouseArea
    {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onPressed:
        {
            if(brightnessIsZero)
                proxy.lButtonDown(objId,mouse.x, mouse.y)
            mouse.accepted = false;
            propagateComposedEvents : true
        }
        onReleased:
        {
            if(brightnessIsZero)
                proxy.lButtonUp(objId,mouse.x, mouse.y)
            mouse.accepted = false;
            propagateComposedEvents : true
        }
        onPositionChanged:
        {
            if(brightnessIsZero)
                proxy.handleMouseMove(objId,mouse.x, mouse.y)
            mouse.accepted = true;
        }
    }
}
