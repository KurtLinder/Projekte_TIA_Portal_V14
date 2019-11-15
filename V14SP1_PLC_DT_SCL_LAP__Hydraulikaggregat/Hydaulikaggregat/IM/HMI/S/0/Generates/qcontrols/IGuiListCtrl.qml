// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0
import QtDataModel 1.0
import QtGridline 1.0
import SmartListView 1.0

Rectangle {
    id : smartList

    property int objRef: 0

/*    //// BORDER STYLE ////
    0: No border should be displayed
    1: Border is solid
    2: Border is solid, 3D on
*/
    // Left Header
    property int qm_leftBorderCornerRadius
    property int qm_leftBorderWidth

    property int qm_leftImageID
    property int qm_leftTileTop
    property int qm_leftTileBottom
    property int qm_leftTileRight
    property int qm_leftTileLeft


    property int qm_middleImageID
    property int qm_middleTileTop
    property int qm_middleTileBottom
    property int qm_middleTileRight
    property int qm_middleTileLeft


    property int qm_rightImageID
    property int qm_rightTileTop
    property int qm_rightTileBottom
    property int qm_rightTileRight
    property int qm_rightTileLeft

    // Table Header text format
    property color qm_tableHeaderTextColor
    property int qm_tableHeaderValueVarTextAlignmentHorizontal
    property int qm_tableHeaderValueVarTextAlignmentVertical
    property int qm_tableHeaderValueVarTextOrientation    // specified in degrees

    property int qm_tableHeaderMarginLeft
    property int qm_tableHeaderMarginRight
    property int qm_tableHeaderMarginBottom
    property int qm_tableHeaderMarginTop

    // All Back Colors
    property color qm_tableBackColor
    property color qm_tableSelectBackColor
    property color qm_tableAlternateBackColor
    property color qm_tableHeaderBackColor

    // Table text format
    property color qm_tableTextColor
    // Selection text format
    property color qm_tableSelectTextColor

    // Alternate row text format
    property color qm_tableAlternateTextColor

    property int qm_tableMarginTop
    property int qm_tableMarginBottom
    property int qm_tableMarginLeft
    property int qm_tableMarginRight

    // Gridline properties
    property int qm_gridLineStyle
    property int qm_gridLineWidth
    property color qm_gridLineColor

    /* Table font information */
    property font qm_tableFont    
    property font qm_tableSelectFont

    //List Ctrl Row Height
    property int qm_tableRowHeight

    //List Ctrl Header Height
    property int qm_tableHeaderHeight

    // List control adjusting properties
    property bool qm_hasHeader
    property bool qm_hasGridLines
    property bool qm_hasBorder
    property bool qm_hasDisplayFocusLine
    property bool qm_hasVerticalScrolling
    property bool qm_hasVerticalScrollBar
    property bool qm_hasHorizontalScrollBar    
    property bool qm_hasColumnOrdering
    property bool qm_hasHighLightFullRow
    property bool qm_hasVerUpDownPresent
    property bool qm_hasVerPgUpDownPresent
    property bool qm_hasHighlight
    property bool qm_hasUpDownAsPageUpDown
    property bool qm_hasLongAlarmButton
    property bool qm_hasExtraPixelForLineHeight
    property bool qm_hasRowEditable
    property bool qm_hasRowJustification
    property bool qm_hasRowJustificationBottom

    // Number of lins per row
    property int qm_linesPerRow // noOfLines

    //================================
    // Properties used during run time
    //================================
    property int adjustChildModel: 2
    property int gridLineWidth: {return (qm_hasGridLines ? qm_gridLineWidth : 0)}

    // List control header properries
    property var headerObj: undefined
    property int headerHeight: {return (qm_hasHeader ? (qm_tableHeaderHeight + qm_tableHeaderMarginTop + qm_tableHeaderMarginBottom) : 0)}

    // List control model manager
    property alias modelManager: theDataModel

    // Scrol bar properties
    property int qm_scrollBarSize: smartlistview.scrollBarSize
    property var verticalScrollBarObj: undefined
    property var horizontalScrollBarObj: undefined
    property real totalContentHeight: 0
    property bool scrollWithScrollBar: false    
    property var verticalScrollBarComp: undefined

    // List control column operated properties
    property int qm_noOfColumns
    property int qm_FocusLineWidth: 1 /// @brief Default focus line iwdth for all controls
    property int qm_BorderLineWidth: 1 /// @brief Draw border for the list control
    property int totalColumnWidth: {return smartList.width}
    property int totalRowCount: smartlistview.totalRowCount
    property point qm_moveStartIndex: Qt.point(-1, -1)
    property point qm_moveEndIndex: Qt.point(-1, -1)
    property int qm_RowHeight: {return ((qm_tableRowHeight * qm_linesPerRow) + (qm_tableMarginTop + qm_tableMarginBottom + gridLineWidth))}
    property bool qm_ContentStreached: false    

    property variant staticComponent: undefined
    property variant staticComponentObj: undefined

    property variant scrollBarHeight: 0
    //support for row specific colors
    property bool qm_UseRowSpecificColor : false

    onStaticComponentObjChanged: {
        if (staticComponentObj !== undefined) {
            parent.setLoadedComponentObject(staticComponentObj)
        }
    }

    onFocusChanged: {
        if(focus)
            handleFocus()
    }

    // List control initialization from SMART-RT (invokeMethod)
    function init(refID) {
        var nRowsFit = 1;
        objRef = refID;        
        nRowsFit = (smartList.height - ((headerObj == undefined) ? headerHeight : 0)) / qm_RowHeight;
        smartlistview.rowsFit = nRowsFit;
        utilProxy.setPageRowsFit(objRef, Math.round(nRowsFit))
    }


    // Set / Reset the focus to list control from SMART-RT (invokeMethod)
    function setFocus() {
        if(false === smartlistview.focus)
        {
            utilProxy.handleFocusChange(parent.objId, objRef);
        }
    }

    function handleFocus()
    {        
        smartlistview.focus = true;
    }

    function handleFocusLoss()
    {        
        smartlistview.focus = false;
    }

    // Utility function required for internal list control operations
    function loadStaticComponent (componentName, rowNumber, columnNumber) {
        var cellPosition = smartlistview.getCellPosition(rowNumber, columnNumber)
        var cellSize = smartlistview.getCellSize(rowNumber, columnNumber)
        if((cellPosition.y + cellSize.height) > smartList.height)
        {
            smartlistview.snapListView(flickListView.contentY + qm_RowHeight)
            utilProxy.updateListData(smartList.objRef, 1)
            cellPosition = smartlistview.getCellPosition(rowNumber, columnNumber)
            cellSize = smartlistview.getCellSize(rowNumber, columnNumber)
        }
        staticComponent = Qt.createComponent(componentName)
        staticComponentObj = staticComponent.createObject(smartList,
                                                          {
                                                              "x": (cellPosition.x - flickListView.contentX),
                                                              "y": cellPosition.y,
                                                              "width": cellSize.width,
                                                              "height": cellSize.height
                                                          }
                                                         )
        staticComponentObj.handleParentData(theDataModel.getCellData(rowNumber, columnNumber))
    }

    function unloadStaticComponent () {
        if(staticComponentObj !== undefined)
        {
            staticComponentObj.objectName = ""
            staticComponentObj.destroy ()
            staticComponentObj = undefined
            staticComponent.destroy()
            staticComponent = undefined
        }
    }

    // TODO: replace this method in future
    function stopEditMode () {
        // unload QML static component
        if(staticComponentObj !== undefined)
        {
            utilProxy.stopListCtrlEditMode()
        }
    }

    // Update header data in model manager from SMART-RT (invokeMethod)
    function updateHeaderData(headerData) {
        if (qm_hasHeader && (headerObj == undefined)) {
            smartList.y = smartList.y + headerHeight
            smartList.height = smartList.height - headerHeight
            headerObj = headerComp.createObject(smartList.parent,
                                        {
                                            "x": smartList.x,
                                            "y": smartList.y - headerHeight
                                        }
                                       )
        }
        else if (headerObj !== undefined)
        {
            headerObj.updateHeader();
        }
    }

    function setVisibleRows(visibleRowCount) {
        //var listHeight = qm_RowHeight * visibleRowCount
        //smartList.height = listHeight + headerHeight
        totalColumnWidth = smartList.width
        smartlistview.height = smartList.height = (qm_RowHeight * visibleRowCount)
        smartlistview.update()
    }

    function handleScrollBar() {        
        if (horizontalScrollBarObj !== undefined) {
            horizontalScrollBarObj.opacity = horizontalScrollBarObj.enabled = (smartlistview.focus === true)
        }
        else {
            /// @brief create horizontal scroll bar only if required
            createHorizontalScrollbar()
        }

        if (verticalScrollBarObj !== undefined) {
            verticalScrollBarObj.opacity = verticalScrollBarObj.enabled = (smartlistview.focus === true)
        }
        else {
            /// @brief create vertical scroll bar only if required
            createVerticalScrollbar()
        }
    }

    function resizeVerticalScrollBar () {
        if ((totalContentHeight <= smartList.height) && (verticalScrollBarObj != undefined)) {
            verticalScrollBarObj.destroy()
            verticalScrollBarComp.destroy()
            verticalScrollBarObj = undefined
            // if vertical scroll bar is destroyed, increase horizontal scroll bar , if exists
            if (horizontalScrollBarObj !== undefined && scrollBarHeight !== smartList.height) {
                horizontalScrollBarObj.width += 6.0
            }
        } else if (verticalScrollBarObj != undefined) {
            verticalScrollBarObj.opacity = verticalScrollBarObj.enabled = (smartlistview.focus === true)
            verticalScrollBarObj.totalContentHeight = totalContentHeight
        } else {            
            createVerticalScrollbar()
        }
    }

    function createVerticalScrollbar() {
        if (qm_hasVerticalScrollBar) {                        
            if ((totalContentHeight > smartList.height) && (verticalScrollBarComp == undefined)) {                
                verticalScrollBarComp = Qt.createComponent("IGuiScrollBar.qml");
                if (verticalScrollBarComp.status === Component.Ready) {
                    scrollBarHeight = (horizontalScrollBarObj !== undefined ) ? (smartList.height - 6) : smartList.height
                    var verticalScrollBarHeight = smartList.height
                    if (horizontalScrollBarObj !== undefined) {
                        verticalScrollBarHeight -= 6.0
                        horizontalScrollBarObj.width -= 6.0  // Resize Vertical Scroll Bar by 6 px
                    }
                    verticalScrollBarObj = verticalScrollBarComp.createObject(smartList,
                                                                          {
                                                                              "x": smartList.width - qm_scrollBarSize,
                                                                              "width": qm_scrollBarSize,
                                                                              "height": verticalScrollBarHeight,
                                                                              "opacity": (smartlistview.focus === true),
                                                                              "enabled": (smartlistview.focus === true),
                                                                              "scrollBarOrientation": Qt.Vertical,
                                                                              "totalContentHeight": totalContentHeight,
                                                                              "scrollHotZoneArea": qm_scrollBarSize
                                                                          }
                                                                         )
                }
            }            
        }
    }

    function createHorizontalScrollbar () {
        if (qm_hasHorizontalScrollBar) {
            var horizontalScrollBarComp = undefined
            if ((smartList.totalColumnWidth > smartList.width) && (horizontalScrollBarObj == undefined)) {
                horizontalScrollBarComp = Qt.createComponent("IGuiScrollBar.qml");
                if (horizontalScrollBarComp.status === Component.Ready) {                    
                    var horizontalScrollBarWidth = smartList.width
                    if (verticalScrollBarObj !== undefined) {
                        horizontalScrollBarWidth -= 6.0
                        verticalScrollBarObj.height -= 6.0  // Resize Vertical Scroll Bar by 6 px
                    }
                    horizontalScrollBarObj = horizontalScrollBarComp.createObject(smartList,
                                                                                  {
                                                                                      "width": horizontalScrollBarWidth,
                                                                                      "excludeOffset": headerHeight,
                                                                                      "opacity": (smartlistview.focus === true),
                                                                                      "enabled": (smartlistview.focus === true),                                                                                      
                                                                                      "scrollBarOrientation": Qt.Horizontal,
                                                                                      "scrollHotZoneArea": qm_scrollBarSize,
                                                                                      "totalContentWidth": smartList.totalColumnWidth
                                                                                  }
                                                                                 )
                }
            }
            else if ((smartList.totalColumnWidth <= smartList.width) && (horizontalScrollBarObj != undefined)) {
                horizontalScrollBarObj.destroy()
                horizontalScrollBarObj = undefined
                if (verticalScrollBarObj !== undefined && verticalScrollBarObj.height !== smartList.height)
                    verticalScrollBarObj.height += 6.0   // if horizontal scroll bar is destroyed, increase vertical scroll bar, if it exists and was resized earlier
            }
        }
    }

    function scrollListView (newContentPos, scrollBarOrientation, columnIndex) {
        if ((scrollBarOrientation == Qt.Vertical) && (verticalScrollBarObj !== undefined)) {
            // Disable repositioning of scroll slider
            smartList.scrollWithScrollBar = true
            // scroll bar height = list Rectangle height - 6; only if horizontalScrollBarObj is not NULL
            var denomimator = (horizontalScrollBarObj !== undefined) ? smartList.height - 6.0 : smartList.height
            var nScrollRowIndex = Math.round((newContentPos / denomimator) * totalRowCount)
            utilProxy.scrollListData(objRef, nScrollRowIndex);
            smartList.scrollWithScrollBar = false
        } else if ((scrollBarOrientation == Qt.Horizontal) && (horizontalScrollBarObj !== undefined)) {            
            smartlistview.snapListViewColumn(Math.round(newContentPos));
        }
    }

    function getSelectedIndex(mousePosX, mousePosY) {
        var selectedIndex = Qt.point(-1, -1)
        selectedIndex = smartlistview.getIndexAt(mousePosX, mousePosY)
        return selectedIndex;
    }

    clip: true
    color: smartlistview.rowBackColor    

    // Data model initialization for list view
    QtDataModel {
        id: theDataModel
        objectName: "mquDataModel"

        Component.onCompleted: {
            // TODO: pass the appropriate col count
            theDataModel.InitializeSourceModel(qm_noOfColumns)
            theDataModel.HeaderDataChanged.connect(smartList.updateHeaderData)
        }
    }

    // Header component
    Component {
        id: headerComp

        Rectangle {
            id: headerItem

            width: {return (smartList.width < smartList.totalColumnWidth) ? smartList.width : smartList.totalColumnWidth}
            height: {return headerHeight}
            color: {return qm_tableHeaderBackColor}
            radius: {return qm_leftBorderCornerRadius}
            clip: true

            signal updateHeader

            Row {
                id: header

                property int newContentX: flickListView.contentX

                onNewContentXChanged: {
                    header.x = -flickListView.contentX;
                }

                Repeater {
                    model: {return qm_noOfColumns}
                    delegate:
                        Item {
                            id: headerDelegate

                            /// @breif Header Image ID
                            property int headerimageId: {return (index == 0) ? qm_leftImageID : ((index + 1 == qm_noOfColumns) ? qm_rightImageID : qm_middleImageID)}
                            /// @brief Image source
                            property string qm_headerimageSrc: {return (headerimageId > 0) ? ("image://QSmartImageProvider/" +
                                                                                                headerimageId     + "#" +       // image id
                                                                                                2                 + "#" +       // tiled image
                                                                                                4                 + "#" +       // horizontal alignment info
                                                                                                128               + "#" +       // vertical alignment info
                                                                                                0                 + "#" +       // language index
                                                                                                0                               // cache info
                                                                                      )
                                                                                   : ""}

                            width: smartList.children[index + adjustChildModel].width
                            height: {return headerHeight}
                            rotation: {return qm_tableHeaderValueVarTextOrientation}

                            /// @brief Loading tiled bitmap image
                            BorderImage {
                                id: headerimage

                                anchors.fill: parent
                                source: {return qm_headerimageSrc}
                                border.left: {return (index == 0) ? qm_leftTileLeft : ((index + 1 == qm_noOfColumns) ? qm_rightTileLeft : qm_middleTileLeft)}
                                border.top: {return (index == 0) ? qm_leftTileTop : ((index + 1 == qm_noOfColumns) ? qm_rightTileTop : qm_middleTileTop)}
                                border.right: {return (index == 0) ? qm_leftTileRight : ((index + 1 == qm_noOfColumns) ? qm_rightTileRight : qm_middleTileRight)}
                                border.bottom: {return (index == 0) ? qm_leftTileBottom : ((index + 1 == qm_noOfColumns) ? qm_rightTileBottom : qm_middleTileBottom)}
                                horizontalTileMode: BorderImage.Repeat
                                verticalTileMode: BorderImage.Repeat
                            }

                            function redrawHeaderData()
                            {
                                headerData.text = theDataModel.getHeaderData(index);
                            }

                            Text {
                                id: headerData

                                //Header font properties
                                font: smartlistview.headerFont

                                anchors.fill: parent
                                anchors.leftMargin: {return qm_tableHeaderMarginLeft}
                                anchors.topMargin: {return qm_tableHeaderMarginTop}
                                anchors.rightMargin: {return qm_tableHeaderMarginRight}
                                anchors.bottomMargin: {return qm_tableHeaderMarginBottom}
                                horizontalAlignment: {return qm_tableHeaderValueVarTextAlignmentHorizontal}
                                verticalAlignment: {return qm_tableHeaderValueVarTextAlignmentVertical}

                                text: theDataModel.getHeaderData(index)
                                color: {return qm_tableHeaderTextColor}

                                wrapMode: Text.WordWrap
                                elide: Text.ElideRight
                            }

                            Component.onCompleted: {
                                headerItem.updateHeader.connect(redrawHeaderData)
                            }
                        }
                }
            }
        }
    }

    Rectangle {
        width: {return smartList.width}
        height: {return smartList.height}
        color: "transparent"
        border.width: {return( (qm_hasBorder) ?  qm_BorderLineWidth : 0)}
        border.color: Qt.rgba((156/255), (157/255), (164/255), (255/255))
        enabled: false
        z: flickListView.z + 1
    }

    Flickable {
        id: flickListView

        x: {return qm_BorderLineWidth}
        y: {return qm_BorderLineWidth}
        width: {return smartList.width - (2 * qm_BorderLineWidth)}
        height: {return smartList.height - (2 * qm_BorderLineWidth)}

        boundsBehavior: Flickable.StopAtBounds
        flickableDirection:  qm_hasVerticalScrollBar ? Flickable.HorizontalAndVerticalFlick : Flickable.HorizontalFlick
        maximumFlickVelocity: 0.1
        //pressDelay: 500 // Should work for press delay to smart list view

        contentY: smartlistview.flickContentY
        contentX: smartlistview.contentX
        contentHeight: {smartlistview.flickContentHeight- (2 * qm_BorderLineWidth)}
        contentWidth: {return totalColumnWidth - (2 * qm_BorderLineWidth)}

        onContentXChanged: {
            if (horizontalScrollBarObj !== undefined) {
                horizontalScrollBarObj.positionSlider(contentX, Qt.Horizontal)
            }
        }

        onContentYChanged: {
            if ((verticalScrollBarObj !== undefined) && ((smartList.scrollWithScrollBar !== true) || (contentY == originY))) {
                verticalScrollBarObj.positionSlider((contentY + (smartlistview.bufferStartOffset * qm_RowHeight)), Qt.Vertical)
            }
        }        

        IGuiSmartListView {
            id: smartlistview
            objectName: "mquListView"

            width: {return totalColumnWidth}
            height: {return smartList.height}

            onFocusChanged: {
                if(false === smartlistview.focus)
                    handleFocusLoss()
                handleScrollBar()
            }

            onBufferStartOffsetChanged: {
                if ((verticalScrollBarObj !== undefined) && ((smartList.scrollWithScrollBar !== true) /*|| (flickListView.contentY === flickListView.originY)*/)) {
                    verticalScrollBarObj.positionSlider((flickListView.contentY + (smartlistview.bufferStartOffset * qm_RowHeight)), Qt.Vertical)
                }
            }

            onTotalListContentHeightChanged: {
                totalContentHeight = smartlistview.totalListContentHeight
                resizeVerticalScrollBar()
            }

            rowHeight: {return qm_RowHeight}
            linesPerRow: {return qm_linesPerRow}
            rowBackColor: qm_tableBackColor
            altRowBackColor: {return qm_tableAlternateBackColor}
            selectBackColor: {return qm_tableSelectBackColor}
            rowTextColor: {return qm_tableTextColor}
            altRowTextColor: {return qm_tableAlternateTextColor}
            selectTextColor: {return qm_tableSelectTextColor}
            useRowSpecificColor : qm_UseRowSpecificColor
            tableFont: qm_tableFont
            selectFont: qm_tableSelectFont
            dataModel: theDataModel
            listControlObj: {return smartList}
            flickControlObj: {return flickListView}
            gridLineStyle: {return qm_gridLineStyle + 1}
            gridLineColor: {return qm_gridLineColor}
            gridLineWidth: {return smartList.gridLineWidth}
            focusLineWidth: {return qm_FocusLineWidth}
            borderLineWidth: {return qm_BorderLineWidth}
            contentStretched: {return qm_ContentStreached}            
            contentTableMargin: {return [qm_tableMarginLeft, qm_tableMarginRight, qm_tableMarginTop, qm_tableMarginBottom]}            
            columnOffset: {return adjustChildModel}
            contentY: flickListView.contentY
            visibleAreaWidth : flickListView.width

            MouseArea {
                width:  (flickListView.contentWidth > smartList.width) ? flickListView.contentWidth : smartList.width
                height: (flickListView.contentHeight > smartList.height) ? flickListView.contentHeight : smartList.height

                onClicked: {                                        
                    var selectedIndex = getSelectedIndex(mouseX, mouseY)
                    utilProxy.lButtonClick(objRef, selectedIndex.x, selectedIndex.y)                    
                }

                onPressed: {                    
                    var selectedIndex = getSelectedIndex(mouseX, mouseY)
                    utilProxy.lButtonDown(objRef, selectedIndex.x, selectedIndex.y)
                    setFocus ()
                }

                onReleased: {                    
                    var selectedIndex = getSelectedIndex(mouseX, mouseY)
                    utilProxy.lButtonUp(objRef, selectedIndex.x, selectedIndex.y)
                }

                onDoubleClicked: {
                    var selectedIndex = getSelectedIndex(mouseX, mouseY)
                    utilProxy.lButtonDblClick(objRef, selectedIndex.x, selectedIndex.y)
                }
            }

            Keys.onPressed: {                                
                utilProxy.keyHandler(objRef, event.key, true, event.text, event.isAutoRepeat)
                event.accepted = true
            }

            Keys.onReleased: {
                utilProxy.keyHandler(objRef, event.key, false, event.text, event.isAutoRepeat)
                event.accepted = true
            }

            Component.onDestruction: {
                if (headerObj != undefined)
                {
                    headerObj.destroy()
                }
            }
        }

        onMovementStarted: {
            smartlistview.flickEvent = true

            // Enable repositioning of scroll slider on smooth scrolling
            smartList.scrollWithScrollBar = false

            // Unload the loaded component, if scrolling has been started
            stopEditMode()

            qm_moveStartIndex = smartlistview.getIndexAt(flickListView.contentX, flickListView.contentY)
        }

        onMovementEnded: {
            smartlistview.flickEvent = false

            if(flickableDirection === Flickable.VerticalFlick)
            {
                // Before getting the displacement row count snap row
                smartlistview.snapListView(flickListView.contentY);

                // Get the proper index value after snapping the list view
                qm_moveEndIndex = smartlistview.getIndexAt(flickListView.contentX, flickListView.contentY)

                var nDisplacedRowCount = (qm_moveEndIndex.x - qm_moveStartIndex.x)

                if (0 !== nDisplacedRowCount) {
                    utilProxy.updateListData(smartList.objRef, nDisplacedRowCount)
                }
            }
            else
            {
                smartlistview.snapListViewColumn(flickListView.contentX);
            }

            flickableDirection = qm_hasVerticalScrollBar ? Flickable.HorizontalAndVerticalFlick : Flickable.HorizontalFlick
        }

        onMovingHorizontallyChanged: {
            flickableDirection = Flickable.HorizontalFlick
        }

        onMovingVerticallyChanged: {
            flickableDirection = Flickable.VerticalFlick
        }
    }
}
