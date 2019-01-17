import QtQuick 2.0

Item{
    id:qGraphicIOEditList
    objectName: "qGraphicIOEditList"

    property int objId: 0

    property int qm_ImageVAlign:0
    property int qm_ImageHAlign:0
    property int qm_ImageMarginLeft:0
    property int qm_ImageMarginRight:0
    property int qm_ImageMarginTop:0
    property int qm_ImageMarginBottom:0

    property bool qm_Streached : fasle
    property int qm_NoOfVisibleColumns:1


        IGuiListCtrl
        {
        id: qListControl
            objectName: "qu100"
            x: 0
            y: 0
            width: parent.width
            height:parent.height

            qm_tableMarginLeft: qm_ImageMarginLeft
            qm_tableMarginRight: qm_ImageMarginRight
            qm_tableMarginBottom: qm_ImageMarginBottom
            qm_tableMarginTop: qm_ImageMarginTop


            qm_tableBackColor : "transparent"
            qm_tableAlternateBackColor : "transparent"
            qm_tableSelectBackColor : "transparent"
            qm_tableTextColor:"transparent"

            qm_ContentStreached: qm_Streached
            qm_RowHeight: qGraphicIOEditList.height
            enabled: true

            qm_noOfColumns: qm_NoOfVisibleColumns
            qm_linesPerRow: 1
            qm_hasGridLines: false
            qm_FocusLineWidth: 0
            qm_BorderLineWidth: 0

            qm_hasVerticalScrollBar : true
            qm_hasVerticalScrolling : true

            IGuiListColumnView {
               width: parent.width
               height: parent.height
               columnType: 1
               qm_columnValueVarTextAlignmentHorizontal:qm_ImageHAlign
               qm_columnValueVarTextAlignmentVertical:qm_ImageVAlign
           }

            Component.onCompleted:
            {
                /// @brief Needed to set the focus to the list control once it has been loaded
                handleFocus()
            }
        }


    function changeObjNameListCtl()
    {
        if(qListControl !== undefined)
        qListControl.objectName = ""
    }    
}
