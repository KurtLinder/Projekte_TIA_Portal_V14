import QtQuick 2.0
import SmartSymIOComponent 1.0

IGuiViewBitmap
{
    id:qComboBoxView

    property int  qm_GraphicImageId: 0

    /// @brief data is Down Button Visible or not
    property bool qm_IsDownButtonVisible:true
    /// @brief data for no of visible rows
    property int qm_NoOfVisibleRows:4
    /// @brief data for Hot Area Width
    property int qm_HotAreaWidth:0
    ///@brief data for  touchpad component and object
    property variant staticTouchComponent: undefined
    property variant staticTouchComponentObj: undefined
    ///@brief data for Symbolic IO field type
    property int qm_SymIOType :0
    ///@brief data for Cursur property visible
    property bool qm_ShowCursor:false
    ///@brief data for symio editmode
    property bool qm_InEditMode:false
    ///@brief List Control properties
    property color qm_SymIOSelBackFillColor:"transparent"
    property color qm_SymIOSelForeColor:"transparent"
    property color qm_SymIOAltBackFillColor:"transparent"
    property int qm_listHeight:0
    property int qm_tableRowHeight: qDisplayText.font.pixelSize
    property int qm_NoOfSymIoTextListItems:0
    property int qm_touchpadY: 0
    property int currentCursorPosition: 0
    ///@brief type of COMBO
    property int qm_ComboType : 0 //Default SymIO type

    property int qm_touchpadX: 0
    property var qm_TouchpadParent

    property int qm_EditType :0

    ///Function to set Edit mode and set the text and Cursor
    function setEditMode(bMode)
    {
        qm_InEditMode = bMode
        if(bMode)
        {
            showCursor(true)
            selectText(false)
        }
        else
        {
            selectText(true)
            showCursor(false)
        }
    }

    ///Function to set Cursor from backEnd
    function setCursorValue(value)
    {
        currentCursorPosition = value
        qm_ShowCursor = true
        qDisplayText.cursorPosition = currentCursorPosition
    }

    ///Function to Show the Cursor
    function showCursor(bCursorStatus)
    {
        qm_ShowCursor = bCursorStatus
    }
    ///Function to Show the Select text or deselect text
    function selectText(bSelectStatus)
    {
        if(bSelectStatus && qm_SmartFocus)
        {
            if(!qm_InEditMode)
            {
                qDisplayText.selectAll()

                if(qm_ComboType === 1)
                {
                    //For COMBO type set foreground and background color
                   qDisplayText.selectedTextColor = qm_SymIOSelForeColor
                    qDisplayText.selectionColor = qm_SymIOSelBackFillColor
                    if(qDisplayText.text.length === 0)
                    {
                        //if no element are there then show the cursor
                        qDisplayText.autoScroll = true;
                        qm_ShowCursor = true
                        qDisplayText.cursorPosition = 0
                    }
                }
            }
            else if ((qDisplayText.selectedTextColor == qm_SymIOSelForeColor) && (qm_SymIOType === 2))
            {
                qDisplayText.selectAll()
            }
        }
        else
        {
            qDisplayText.deselect()
        }
    }

    /// load edit field QML
    function startEditMode(editFieldRef,editFieldValue, editFieldType, passwordMode, highlightText)
    {
        qComboBoxView.z = 255
        if(editFieldType === 1)
        {
            fillRect.color = qComboBoxView.qm_FillColor
            qDisplayText.color = qComboBoxView.qm_TextColor
            qm_EditType = editFieldType
            qSmartSymio.calculateListControlheight();
            qSmartSymio.calculateAndSetTouchpadPositionY();
            staticTouchComponent = Qt.createComponent("IGuiTouchpad.qml")
            staticTouchComponentObj = staticTouchComponent.createObject(qSmartSymio.qm_TouchpadParent,
                                                                        {
                                                                            "qm_TouchpadInputQml":"IGuiSymioListEdit.qml",
                                                                            "qm_TouchPadXposition":qSmartSymio.qm_touchpadX,
                                                                            "qm_TouchPadYposition":qSmartSymio.qm_touchpadY,
                                                                            "qm_TouchPadType":editFieldType,
                                                                            "qm_TouchPadWidth": qComboBoxView.width,
                                                                            "qm_TouchPadHeight":qSmartSymio.qm_listHeight,
                                                                            "qm_TouchPadcolor": qComboBoxView.qm_FillColor,
                                                                            "qm_TouchPadBorderColor":qComboBoxView.qm_BorderColor,
                                                                            "qm_TextColor":qComboBoxView.qm_TextColor,
                                                                            "qm_TextVAlign":qComboBoxView.qm_ValueVarTextAlignmentVertical,
                                                                            "qm_TextHAlign":qComboBoxView.qm_ValueVarTextAlignmentHorizontal,
                                                                            "qm_TextMarginLeft":qComboBoxView.qm_MarginLeft,
                                                                            "qm_TextMarginRight":qComboBoxView.qm_MarginRight,
                                                                            "qm_TextMarginTop":qComboBoxView.qm_MarginTop,
                                                                            "qm_TextMarginBottom":qComboBoxView.qm_MarginBottom,
                                                                            "qm_TextRowHeight":qComboBoxView.qm_tableRowHeight,
                                                                            "qm_TextFontFamilyName":qComboBoxView.qm_FontFamilyName,
                                                                            "qm_TextFontSize":qComboBoxView.qm_FontSize,
                                                                            "qm_TextFontBold":qComboBoxView.qm_FontBold,
                                                                            "qm_TextFontItalic":qComboBoxView.qm_FontItalic,
                                                                            "qm_TextFontNormal":qComboBoxView.qm_FontNormal,
                                                                            "qm_TextFontUnderline":qComboBoxView.qm_FontUnderline,
                                                                            "qm_TextFontFontStrikeout":qComboBoxView.qm_FontStrikeout,
                                                                            "qm_NoOfVisibleRows":qSmartSymio.qm_NoOfVisibleEntries,
                                                                            "qm_ListCtrlSelBackColor":qComboBoxView.qm_SymIOSelBackFillColor,
                                                                            "qm_ListCtrlSelForeColor":qComboBoxView.qm_SymIOSelForeColor,
                                                                            "qm_ListCtrlAlternateRowColor":qComboBoxView.qm_SymIOAltBackFillColor,
                                                                            "qm_HostComponentObj":qComboBoxView
                                                                        })            
        }
        setEditMode(true)
        if(qm_SymIOType === 2)
        {
            qDisplayText.selectAll()
        }
    }

    /// unload edit field QML
    function doStopEditMode()
    {
        qComboBoxView.z = 0
        if(staticTouchComponentObj !== undefined)
        {
            staticTouchComponentObj.objectName = ""
            staticTouchComponentObj.destroy ()
            staticTouchComponentObj = undefined
            staticTouchComponent.destroy()
            staticTouchComponent = undefined
        }

        qComboBoxView.forceActiveFocus()
        setEditMode(false)
        qm_EditType = 0
    }

    ///Function to set the Value of the text
    onQmDisplayTextChanged:{
       qDisplayText.text = qm_DisplayText
        selectText(true)
    }

    /// @brief Helper-function for focus
    function handleFocus()
    {
        qm_SmartFocus = true;
        selectText(true)
    }

    /// @brief Function to hadle focus loss
    function handleFocusLoss()
    {
        selectText(false)
        if(staticTouchComponentObj === undefined)
        {
            if(qm_EditType === 1)
            {
                fillRect.color = qComboBoxView.qm_FillColor
                qDisplayText.color = qComboBoxView.qm_TextColor
            }
            //In focus loss make cursor invisible
            qDisplayText.autoScroll = false
            qm_ShowCursor = false
            qm_SmartFocus = false;
        }
    }

    TextInput
    {
        id:qDisplayText
        objectName: displayText
        anchors.fill: parent
        text:qm_DisplayText
        color: qComboBoxView.qm_TextColor
        anchors.bottomMargin: { return qComboBoxView.qm_MarginBottom + qComboBoxView.qm_BorderWidth}
        anchors.leftMargin: {return qComboBoxView.qm_MarginLeft + qComboBoxView.qm_BorderWidth}
        anchors.rightMargin:{return (qm_IsDownButtonVisible == false)? (qComboBoxView.qm_MarginRight + qComboBoxView.qm_BorderWidth)
                                      : (qComboBoxView.qm_MarginRight + qComboBoxView.qm_BorderWidth+qm_HotAreaWidth)}
        anchors.topMargin: {return qComboBoxView.qm_MarginTop + qComboBoxView.qm_BorderWidth}
        horizontalAlignment: {return qComboBoxView.qm_ValueVarTextAlignmentHorizontal}
        verticalAlignment: {return qComboBoxView.qm_ValueVarTextAlignmentVertical}
        font.bold: qm_FontBold
        font.italic: qm_FontItalic
        font.underline: qm_FontUnderline
        font.strikeout: qm_FontStrikeout
        font.family: qm_FontFamilyName
        font.pixelSize: qm_FontSize
        cursorVisible: qm_ShowCursor
        clip:true
        readOnly: qm_ShowCursor ? false : true
        autoScroll: false
   }

    IGuiSmartSymIO{
        id:qSmartSymio
        parent:qComboBoxView
        qm_NoOfVisibleRows:qComboBoxView.qm_NoOfVisibleRows
        qm_NoOfSymIoTextListItems:qComboBoxView.qm_NoOfSymIoTextListItems
        qm_tableRowHeight:qComboBoxView.qm_tableRowHeight
        qm_MarginTop:{ return qComboBoxView.qm_MarginTop}
        qm_MarginBottom: { return qComboBoxView.qm_MarginBottom}
        qm_SymioHeight:{return qComboBoxView.height}
        qm_ComboType:{ return qComboBoxView.qm_ComboType}
    }

    MouseArea
    {
        anchors.fill: parent
        onPressed: {
            if(!qm_SmartFocus)
            {
                //Set the Focus to Symbolic IO
                setItemFocus();
            }
            proxy.lButtonDown(objId, mouse.x, mouse.y);
            mouse.accepted = true;
        }
        onReleased: {
            if(containsMouse)
            {
                proxy.lButtonUp(objId, mouse.x, mouse.y);
                mouse.accepted = true;
            }
        }
    }

    Item
    {
        id:qDownButtonRect
        x: {return (qComboBoxView.width -(qm_HotAreaWidth +qm_BorderWidth))}
        height: {return qComboBoxView.height}
        width:{return qm_HotAreaWidth}
        visible: ((qm_IsDownButtonVisible == false))? false : true
        Image
        {
            id:qDownArrowImage
            source: { return "image://QSmartImageProvider/" +
                    qm_GraphicImageId  + "#" +       // image id
                    2       + "#" +                  // streaching info
                    4       + "#" +                  // horizontal alignment info
                    128     + "#" +                  // vertical alignment info
                    0       + "#" +                  // language index
                    0       }
            anchors.centerIn: qDownButtonRect
        }

        MouseArea{
            anchors.fill: qDownButtonRect
            onPressed: {
                if(!qm_SmartFocus)
                {
                    //Set the Focus to Symbolic IO
                    setItemFocus();
                }
                proxy.comboButtonDown(objId, mouse.x, mouse.y);
                mouse.accepted = true;
            }
            onReleased: {
                if(containsMouse)
                {
                    proxy.comboButtonUp(objId, mouse.x, mouse.y);
                    mouse.accepted = true;
                }
            }
        }
    }
}

