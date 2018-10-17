//// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0
import SmartLineComponent 1.0

IGuiView
{
    id: linecomponent
    property int qm_BorderStyle: 0
    property int qm_FillStyle: 0
    property int qm_LineWidth: 0
    property int qm_LineStartArrow: 0
    property int qm_LineEndArrow: 0
    property int qm_LineEndsShape: 0

    /// @brief Line Component implemented in C++
    IGuiSmartLine {
        id : smartline
        anchors.fill: parent
        penWidth: {return linecomponent.qm_LineWidth}
        penStyle: {return linecomponent.qm_BorderStyle}
        backgroundcolor: linecomponent.qm_FillColor
        foregroundColor : linecomponent.qm_TextColor
        lineStartArrow: {return linecomponent.qm_LineStartArrow}
        lineEndArrow: {return linecomponent.qm_LineEndArrow}
        lineEndsShape: {return linecomponent.qm_LineEndsShape}
        fillStyle: {return linecomponent.qm_FillStyle}
    }

    function setLinePoints(startX,startY,endX,endY)
    {
        smartline.lineStartPoint.x = startX
        smartline.lineStartPoint.y = startY
        smartline.lineEndPoint .x = endX
        smartline.lineEndPoint .y = endY
    }
}

