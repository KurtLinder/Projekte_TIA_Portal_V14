// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0
IGuiViewBitmap{

    id:viewtextfield

    //For Dynamic loading of components
    property Item staticComponentObjRotationRect: {return viewtextfield}

    function setWarpMode()
    {
       textfield.wrapMode = Text.WordWrap
    }

    enabled: true
    Text {
        id:textfield
        clip:true
        parent:staticComponentObjRotationRect
        text: qm_DisplayText
        color: qm_TextColor
        anchors.fill: parent
        font.family: qm_FontFamilyName
        font.pixelSize: qm_FontSize;
        font.bold: qm_FontBold
        font.italic: qm_FontItalic
        font.underline: qm_FontUnderline
        font.strikeout: qm_FontStrikeout

        anchors.topMargin: {return qm_MarginTop + qm_BorderWidth}
        anchors.rightMargin: {return qm_MarginRight  + qm_BorderWidth}
        anchors.leftMargin: {return qm_MarginLeft + qm_BorderWidth}
        anchors.bottomMargin: {return qm_MarginBottom + qm_BorderWidth}

        horizontalAlignment:{return qm_ValueVarTextAlignmentHorizontal}
        verticalAlignment:{return qm_ValueVarTextAlignmentVertical}        
    }

    MouseArea
    {
        id:mouseArea
        anchors.fill: parent
        onPressed: {
            proxy.lButtonDown(objId, mouse.x, mouse.y);
        }
        onReleased: {
            if(containsMouse)
            {
                proxy.lButtonUp(objId, mouse.x, mouse.y);
            }
        }
    }
}


