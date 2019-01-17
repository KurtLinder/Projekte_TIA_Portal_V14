// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0

IGuiViewBitmap
{
    id: qButtonview   

    /// @brief data for stretched image
    property bool  qm_Streached: false
    
    function setZOrder(value)
    {
        z= value
    }
    
    Image
    { 
        id : image

        anchors.fill: parent
        anchors.bottomMargin: {return qm_MarginBottom + qm_BorderWidth}
        anchors.leftMargin: {return qm_MarginLeft + qm_BorderWidth}
        anchors.rightMargin: {return qm_MarginRight + qm_BorderWidth}
        anchors.topMargin: {return qm_MarginTop + qm_BorderWidth}

        fillMode: qm_Streached ? Image.Stretch: Image.Pad

        visible: qm_ContentVisibility
        source : "image://QSmartImageProvider/" + 
                  qm_GraphicImageID + "#" +            // image id
                                        (qm_Streached ? 1 : 0)      + "#" +     // streaching info
                                        image.horizontalAlignment   + "#" +     // horizontal alignment info
                                        image.verticalAlignment     + "#" +     // vertical alignment info
                                        qm_LanguageIndex            + "#" +     // language index
                                        0                                       // cache info

        horizontalAlignment: {return qm_ValueVarTextAlignmentHorizontal}
        verticalAlignment: {return qm_ValueVarTextAlignmentVertical}
        
        sourceSize.width: {return qButtonview.width - (2*qm_BorderWidth + qm_MarginLeft + qm_MarginRight)}
        sourceSize.height: {return qButtonview.height - (2*qm_BorderWidth + qm_MarginBottom + qm_MarginTop)}
    }
}
