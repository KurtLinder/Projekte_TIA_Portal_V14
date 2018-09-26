import QtQuick 2.0

Rectangle{
    id:qSymIOEditList
    objectName: "qSymIOEditList"

    property int objId: 0
    property variant listCtrlObj
    property int qm_listCtrlHeight

    property color qm_TextColor:"black"
    property int  qm_TextVAlign:0
    property int  qm_TextHAlign:0
    property int qm_TextMarginLeft:0
    property int qm_TextMarginRight:0
    property int qm_TextMarginTop:0
    property int qm_TextMarginBottom:0
    property int qm_NoOfVisibleRows:0
    property string qm_TextFontFamilyName:""
    property int qm_TextFontSize:0
    property bool qm_TextFontBold:false
    property bool qm_TextFontItalic:false
    property bool qm_TextFontNormal:false
    property bool qm_TextFontUnderline:false
    property bool qm_TextFontFontStrikeout:false
    property int  qm_TextRowHeight: 0
    property color qm_ListCtrlSelBackColor:"transparent"
    property color qm_ListCtrlSelForeColor:"transparent"
    property color qm_ListCtrlAlternateRowColor:"transparent"
    property font qm_listControlFont

    height: (qm_listCtrlHeight === 0 ) ? 30 : qm_listCtrlHeight +2
    border.width: 1
    clip:true
    Component
    {
        id: listCtrlComp

        IGuiListCtrl
        {
            id: qu100
            objectName: "qu100"
            x:1
            y:1
            width: {return parent.width -2}
            height:qm_listCtrlHeight
            qm_tableTextColor: parent.qm_TextColor
            qm_tableAlternateTextColor:parent.qm_TextColor
            qm_tableBackColor: parent.color
            qm_tableMarginLeft: {return parent.qm_TextMarginLeft}
            //@brief 6 pixel for right alignment of text as not to overlap with scroll bar
            qm_tableMarginRight: {return parent.qm_TextMarginRight + 6}
            qm_tableMarginBottom: {return parent.qm_TextMarginBottom}
            qm_tableMarginTop: {return parent.qm_TextMarginTop}
            qm_tableRowHeight: parent.qm_TextRowHeight
            qm_tableFont: qm_listControlFont
            qm_tableSelectFont: qm_listControlFont
            qm_tableSelectTextColor: parent.qm_ListCtrlSelForeColor
            qm_tableSelectBackColor: parent.qm_ListCtrlSelBackColor
            qm_tableAlternateBackColor:parent.qm_ListCtrlAlternateRowColor
            qm_hasVerticalScrollBar:true
            qm_hasGridLines: true
            qm_hasHeader: false
            qm_gridLineWidth: 1            
            qm_linesPerRow: 1
            qm_noOfColumns: 1
            qm_BorderLineWidth: 0
            qm_FocusLineWidth: 1
            qm_hasHighlight:true

            onTotalRowCountChanged: {
                //This is Incase of recipe view Entries are added dynamically
                //If rows displayed is less than visible entries set then
                  if(qu100.totalRowCount <qm_NoOfVisibleRows)
                {
                    //Set the visible rows
                    setVisibleRows(qu100.totalRowCount)
                    //recalculate the List Control height
                    reCalculateListControlheight(qu100.totalRowCount)
                    //Change the touchpad size as well
                    qSymIOEditList.height = qm_listCtrlHeight +2

                }

            }

            IGuiListColumnView
            {
                width: parent.width
                height: parent.height
                columnType: 0
                qm_columnValueVarTextAlignmentHorizontal: qu100.parent.qm_TextHAlign
                qm_columnValueVarTextAlignmentVertical: qu100.parent.qm_TextVAlign
            }

            Component.onCompleted:
            {
                /// @brief Needed to set the focus to the list control once it has been loaded
                handleFocus()
                setVisibleRows(qm_NoOfVisibleRows)                
            }
        }
    }

    function setListControlFont() {
        qm_listControlFont.family = qm_TextFontFamilyName
        qm_listControlFont.pixelSize = qm_TextFontSize
        qm_listControlFont.bold = qm_TextFontBold
        qm_listControlFont.italic = qm_TextFontItalic
        qm_listControlFont.underline = qm_TextFontUnderline
        qm_listControlFont.strikeout = qm_TextFontFontStrikeout
    }

    function changeObjNameListCtl()
    {
		if(listCtrlObj !== undefined)
        listCtrlObj.objectName = ""
    }

    /// Calculates the list Control height
    function reCalculateListControlheight(qm_NoOfRows)
    {
        var qm_linesPerRow = 1
        var qm_gridLineWidth = 1
        // height calculation of list control
        qm_listCtrlHeight = ((listCtrlObj.qm_tableRowHeight * qm_linesPerRow)
                    + qm_TextMarginTop +qm_TextMarginBottom + qm_gridLineWidth) * qm_NoOfRows

    }

    Component.onDestruction: {
        listCtrlObj.destroy()
		listCtrlObj = undefined
    }

    Component.onCompleted:
    {
        setListControlFont()
        listCtrlObj = listCtrlComp.createObject(qSymIOEditList)
    }
}
