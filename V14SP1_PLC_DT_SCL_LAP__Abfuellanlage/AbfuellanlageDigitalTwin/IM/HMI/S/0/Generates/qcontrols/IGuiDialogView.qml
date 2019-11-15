import QtQuick 2.0
IGuiViewBitmap{

    id:dialogwidget

    /// @brief - CSR Object id
    property int objId : 0

    property int  captionrectX: 0
    property int  captionrectY: 0
    property int  captionrectWidth: 0
    property int  captionrectHeight :0
    property color captionrectBackgroundColor : "#1267EB"
    property color captionrectForegroundColor : "#1267EB"
    property int  captionTextX: 0
    property int  captionTextY: 0
    property int  captionTextWidth:0
    property int  captionTextHeight : 0
    property int  captionTextSize :12
    property int modalityWidth : 0
    property int modalityHeight : 0

    property int focusedElement: 0

    Rectangle{
        id:captionRect
        x: captionrectX
        y: captionrectY
        width: captionrectWidth
        height: captionrectHeight
        color: captionrectBackgroundColor
        Text{
            id:captionText
            x: captionTextX
            y: captionTextY
            width: captionTextWidth
            height: captionTextHeight
            color:captionrectForegroundColor
            text:qm_DisplayText
            font.family: qm_FontFamilyName
            font.pixelSize: qm_FontSize;
            font.bold: qm_FontBold
            font.italic: qm_FontItalic
            font.underline: qm_FontUnderline
            font.strikeout: qm_FontStrikeout
            elide: Text.ElideRight
            }
        }

    // --------------- This is for drag feature --------------
    MouseArea {
        id:mouseareaID
        anchors.fill: dialogwidget
                drag.target: dialogwidget
                drag.axis: Drag.XandYAxis
                drag.minimumX: 0
                drag.minimumY: 0
                drag.maximumX: modalityWidth
                drag.maximumY: modalityHeight
    }
}


