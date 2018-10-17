
import QtQuick 2.0

IGuiViewBitmap{

    id: qGraphicsview

    property bool imageStreched: imageStreched

    // For loading image
    Image
    {
        id: image
        source :  "image://QSmartImageProvider/"+
                  qm_GraphicImageID            + "#" +   // image id
                  (imageStreched ? 1 : 0)      + "#" +   // streaching info
                  image.horizontalAlignment    + "#" +   // horizontal alignment info
                  image.verticalAlignment      + "#" +   // vertical alignment info
                  qm_LanguageIndex             + "#" +   // language index
                   0                                    // cache info

        visible: qm_ContentVisibility
        cache: false
        fillMode: imageStreched ? Image.Stretch: Image.Pad
        
        anchors.fill: parent
        anchors.bottomMargin: {return qm_MarginBottom + qm_BorderWidth}        
        anchors.leftMargin: {return qm_MarginLeft + qm_BorderWidth}
        anchors.rightMargin: {return qm_MarginRight + qm_BorderWidth}
        anchors.topMargin: {return qm_MarginTop + qm_BorderWidth}

        horizontalAlignment: {return qm_ValueVarTextAlignmentHorizontal}
        verticalAlignment: {return qm_ValueVarTextAlignmentVertical}

        sourceSize.width: {return qGraphicsview.width - (2*qm_BorderWidth + qm_MarginLeft + qm_MarginRight)}
        sourceSize.height: {return qGraphicsview.height - (2*qm_BorderWidth + qm_MarginBottom + qm_MarginTop)}

    }

}


