// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0
import SmartRectangleComponent 1.0

IGuiView
{
    id: rectanglcomp
    property int qm_BorderStyle: 0
    property int qm_FillStyle: 0
    property int qm_RectangleRadiusHorizontal: 0
    property int qm_RectangleRadiusVertical: 0

    /// @brief Rectangle Component implemented in C++
    IGuiSmartRectangle{
        id: smartrectangle
        anchors.fill: parent
        penWidth: {return rectanglcomp.qm_BorderWidth}
        penStyle: {return rectanglcomp.qm_BorderStyle}
        vectheight : {return parent.height}
        vectwidth : {return parent.width}
        foregroundColor: rectanglcomp.qm_TextColor
        backgroundcolor: rectanglcomp.qm_FillColor
        fillStyle: {return rectanglcomp.qm_FillStyle}
        cornerradiushor: {return rectanglcomp.qm_RectangleRadiusHorizontal}
        cornerradiusver: {return rectanglcomp.qm_RectangleRadiusVertical}
    }
}

