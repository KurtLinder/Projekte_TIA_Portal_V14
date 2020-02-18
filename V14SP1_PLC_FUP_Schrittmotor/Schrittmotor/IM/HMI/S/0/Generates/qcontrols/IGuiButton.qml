// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0

IGuiViewBitmap
{

    id: qButtonview    
    focus: qm_SmartFocus
    clip: true

    property Item staticComponentObjRotationRect: {return qButtonview}
    
    function setZOrder(value)
    {
        z= value
    }

    Text
    {
        id: buttontext
        text: qm_DisplayText
        color: qm_TextColor
        clip: true
        visible: qm_ContentVisibility
        parent : staticComponentObjRotationRect
        anchors.fill: parent
        anchors.bottomMargin: {return qm_MarginBottom + qm_BorderWidth}
        anchors.leftMargin: { return qm_MarginLeft + qm_BorderWidth}
        anchors.rightMargin: { return qm_MarginRight + qm_BorderWidth}
        anchors.topMargin: {return qm_MarginTop + qm_BorderWidth}

        horizontalAlignment: {return qm_ValueVarTextAlignmentHorizontal}
        verticalAlignment: {return qm_ValueVarTextAlignmentVertical}

        font.family: qm_FontFamilyName
        font.bold: qm_FontBold
        font.italic: qm_FontItalic
        font.underline: qm_FontUnderline
        font.pixelSize: qm_FontSize
    }
}
