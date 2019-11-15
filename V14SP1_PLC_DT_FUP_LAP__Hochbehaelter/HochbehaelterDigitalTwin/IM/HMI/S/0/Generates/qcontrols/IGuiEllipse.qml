/** Template file for Ellipse/Circle */

import QtQuick 2.0
import SmartEllipseComponent 1.0

IGuiView
{
    id: ellipsecomponent
    property int qm_BorderStyle: 0
    property int qm_FillStyle: 0

    /// @brief Circle/Ellipse Component implemented in C++
    IGuiSmartEllipse{

        id: smartellipse
        anchors.fill: parent

        penWidth: {return ellipsecomponent.qm_BorderWidth}
        penStyle: {return ellipsecomponent.qm_BorderStyle}
        vectheight : {return parent.height}
        vectwidth : {return parent.width}
        foregroundColor: ellipsecomponent.qm_TextColor
        backgroundcolor: ellipsecomponent.qm_FillColor
        fillStyle: {return ellipsecomponent.qm_FillStyle}
    }
}

