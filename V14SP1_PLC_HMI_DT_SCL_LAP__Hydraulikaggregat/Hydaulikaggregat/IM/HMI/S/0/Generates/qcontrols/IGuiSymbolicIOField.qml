import QtQuick 2.0
import SmartSymIOComponent 1.0

IGuiViewBitmap
{
    id:qSymIOFieldView
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
    ///@brief type of COMBO
    property int qm_ComboType : 0 //Default SymIO type
    ///@brief List Control properties
    property color qm_SymIOSelBackFillColor:"transparent"
    property color qm_SymIOSelForeColor:"transparent"
    property color qm_SymIOAltBackFillColor:"transparent"
    property int qm_listHeight:0
    property int qm_tableRowHeight: qDisplayText.font.pixelSize
    property int qm_NoOfSymIoTextListItems:0
    property int qm_touchpadY: 0
    property int qm_touchpadX: 0
    property var qm_TouchpadParent


     //For Dynamic loading of components
    property Item staticComponentObjRotationRect: qSymIOFieldView

    /// load edit field QML
    function startEditMode(editFieldRef,editFieldValue, editFieldType, passwordMode, highlightText)
    {
        qSymIOFieldView.z = 255
        if((staticTouchComponentObj === undefined) && (editFieldType === 1))
        {
            fillRect.color = qSymIOFieldView.qm_FillColor
            qDisplayText.color = qSymIOFieldView.qm_TextColor
            qSmartSymio.calculateListControlheight();
            qSmartSymio.calculateAndSetTouchpadPositionY();
            staticTouchComponent = Qt.createComponent("IGuiTouchpad.qml")
            staticTouchComponentObj = staticTouchComponent.createObject(qSmartSymio.qm_TouchpadParent,
                                                                        {
                                                                            "qm_TouchpadInputQml":"IGuiSymioListEdit.qml",
                                                                            "qm_TouchPadXposition":qSmartSymio.qm_touchpadX,
                                                                            "qm_TouchPadYposition":qSmartSymio.qm_touchpadY,
                                                                            "qm_TouchPadType":editFieldType,
                                                                            "qm_TouchPadWidth": qSymIOFieldView.width,
                                                                            "qm_TouchPadHeight":qSmartSymio.qm_listHeight,
                                                                            "qm_TouchPadcolor": qSymIOFieldView.qm_FillColor,
                                                                            "qm_TouchPadBorderColor":qSymIOFieldView.qm_BorderColor,
                                                                            "qm_TextColor":qSymIOFieldView.qm_TextColor,
                                                                            "qm_TextVAlign":qSymIOFieldView.qm_ValueVarTextAlignmentVertical,
                                                                            "qm_TextHAlign":qSymIOFieldView.qm_ValueVarTextAlignmentHorizontal,
                                                                            "qm_TextMarginLeft":qSymIOFieldView.qm_MarginLeft,
                                                                            "qm_TextMarginRight":qSymIOFieldView.qm_MarginRight,
                                                                            "qm_TextMarginTop":qSymIOFieldView.qm_MarginTop,
                                                                            "qm_TextMarginBottom":qSymIOFieldView.qm_MarginBottom,
                                                                            "qm_TextRowHeight":qSymIOFieldView.qm_tableRowHeight,
                                                                            "qm_TextFontFamilyName":qSymIOFieldView.qm_FontFamilyName,
                                                                            "qm_TextFontSize":qSymIOFieldView.qm_FontSize,
                                                                            "qm_TextFontBold":qSymIOFieldView.qm_FontBold,
                                                                            "qm_TextFontItalic":qSymIOFieldView.qm_FontItalic,
                                                                            "qm_TextFontNormal":qSymIOFieldView.qm_FontNormal,
                                                                            "qm_TextFontUnderline":qSymIOFieldView.qm_FontUnderline,
                                                                            "qm_TextFontFontStrikeout":qSymIOFieldView.qm_FontStrikeout,
                                                                            "qm_NoOfVisibleRows":qSmartSymio.qm_NoOfVisibleEntries,
                                                                            "qm_ListCtrlSelBackColor":qSymIOFieldView.qm_SymIOSelBackFillColor,
                                                                            "qm_ListCtrlSelForeColor":qSymIOFieldView.qm_SymIOSelForeColor,
                                                                            "qm_ListCtrlAlternateRowColor":qSymIOFieldView.qm_SymIOAltBackFillColor,
                                                                            "qm_HostComponentObj":qSymIOFieldView
                                                                        })
            staticTouchComponent.destroy()
        }
    }

    /// unload edit field QML
    function doStopEditMode()
    {
        qSymIOFieldView.z = 0
        if(staticTouchComponentObj !== undefined)
        {
            staticTouchComponentObj.objectName = ""
            staticTouchComponentObj.destroy ()
            staticTouchComponentObj = undefined
        }

        qSymIOFieldView.forceActiveFocus()
    }

    /// @brief Helper-function for focus
    function handleFocus()
    {
        //Inform backend to handle focus change
        qm_SmartFocus = true;
        if(qm_SymIOType === 1)
        {
            if(staticTouchComponentObj === undefined)
            {
                fillRect.color = qSymIOFieldView.qm_SymIOSelBackFillColor
                qDisplayText.color = qSymIOFieldView.qm_SymIOSelForeColor
            }

        }
    }

    /// @brief Function to hadle focus loss
    function handleFocusLoss()
    {
        if(qm_SymIOType === 1)
        {
            fillRect.color = Qt.binding(function(){return qSymIOFieldView.qm_FillColor})
            qDisplayText.color = Qt.binding(function(){return qSymIOFieldView.qm_TextColor})
        }
        qm_SmartFocus = false;
    }
    clip:true

    Text
    {
        id:qDisplayText
        parent:staticComponentObjRotationRect
        anchors.fill: parent
        text:qm_DisplayText
        color: qSymIOFieldView.qm_TextColor
        anchors.bottomMargin: {return qSymIOFieldView.qm_MarginBottom + qSymIOFieldView.qm_BorderWidth}
        anchors.leftMargin: {return qSymIOFieldView.qm_MarginLeft + qSymIOFieldView.qm_BorderWidth}
        anchors.rightMargin:{return (qm_IsDownButtonVisible == false)? (qSymIOFieldView.qm_MarginRight + qSymIOFieldView.qm_BorderWidth)
                                      : (qSymIOFieldView.qm_MarginRight + qSymIOFieldView.qm_BorderWidth+qm_HotAreaWidth)}
        anchors.topMargin: {return qSymIOFieldView.qm_MarginTop + qSymIOFieldView.qm_BorderWidth}
        horizontalAlignment: {return qSymIOFieldView.qm_ValueVarTextAlignmentHorizontal}
        verticalAlignment: {return qSymIOFieldView.qm_ValueVarTextAlignmentVertical}
        font.bold: qm_FontBold
        font.italic: qm_FontItalic
        font.underline: qm_FontUnderline
        font.strikeout: qm_FontStrikeout
        font.family: qm_FontFamilyName
        font.pixelSize: qm_FontSize
        clip:true
       
    }
    IGuiSmartSymIO{
        id:qSmartSymio
        parent:qSymIOFieldView
        qm_NoOfVisibleRows:qSymIOFieldView.qm_NoOfVisibleRows
        qm_NoOfSymIoTextListItems:qSymIOFieldView.qm_NoOfSymIoTextListItems
        qm_tableRowHeight: {return qSymIOFieldView.qm_tableRowHeight}
        qm_MarginTop: {return qSymIOFieldView.qm_MarginTop}
        qm_MarginBottom:{return qSymIOFieldView.qm_MarginBottom}
        qm_SymioHeight: {return qSymIOFieldView.height}
        qm_ComboType:{return qSymIOFieldView.qm_ComboType}
    }

    Image
    {
        id:qDownButtonRect
        x: {return (qSymIOFieldView.width -(qm_HotAreaWidth +qm_BorderWidth))}
        height:{return qSymIOFieldView.height}
        width:{return qm_HotAreaWidth}
        visible: ((qm_IsDownButtonVisible == false))? false : true
        fillMode: Image.Pad
        source:{ return "image://QSmartImageProvider/" +
                      qm_GraphicImageId  + "#" +       // image id
                      2       + "#" +                  // streaching info
                      4       + "#" +                  // horizontal alignment info
                      128     + "#" +                  // vertical alignment info
                      0       + "#" +                  // language index
                      1      }
    }
}



