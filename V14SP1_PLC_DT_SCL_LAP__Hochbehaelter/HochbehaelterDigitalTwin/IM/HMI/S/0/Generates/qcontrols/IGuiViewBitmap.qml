import QtQuick 2.0

IGuiView{

    id: qSmartBitmapWidget

    property Item fillRect : qFillcolorRect

    Rectangle{

        id : qFillcolorRect
        height: { return qm_FillRectHeight}
        width: { return qm_FillRectWidth}
        anchors.centerIn: parent
        z : -1

        /// @brief Assign radius of the view
        radius: { return qm_BorderCornerRadius}

        /// @brief Background color of the view
        color: qm_FillColor
   }

    /// @brief Loading tiled bitmap image
    BorderImage {
        id: bimage
        source: { return "image://QSmartImageProvider/" +
                                       qm_ImageID       + "#" +   // image id
                                       2                + "#" +   // tiled image
                                       4                + "#" +   // horizontal alignment info
                                       128              + "#" +   // vertical alignment info
                                       0                + "#" +   // language index
                                       0 }                          // cache info
        anchors.fill: parent

        border.left: {return qm_TileLeft}
        border.top: {return qm_TileTop}
        border.right: {return qm_TileRight}
        border.bottom: {return qm_TileBottom}

        horizontalTileMode: BorderImage.Repeat
        verticalTileMode: BorderImage.Repeat
    }
}
