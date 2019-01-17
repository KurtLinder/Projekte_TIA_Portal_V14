import QtQuick 2.0

IGuiViewBitmap
{
    id:qSymIOEditView
    ///@brief data for Cursur property visible
    property bool qm_ShowCursor:false
    ///@brief data for symio editmode
    property bool qm_InEditMode:false

    //For Dynamic loading of components
    property Item staticComponentObjRotationRect: qSymIOEditView

    ///Function to set Edit mode and set the text and Cursor
    function setEditMode(bMode)
    {
        qm_InEditMode = bMode
        if(bMode)
        {
            qm_ShowCursor = true
            qDisplayText.deselect()
        }
        else
        {
           qm_ShowCursor = false
           qDisplayText.selectAll()
        }
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
               if(qDisplayText.text.length !== 0)
               {
                    qDisplayText.selectAll()
               }
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
       setEditMode(true)
    }

    /// unload edit field QML
    function doStopEditMode()
    {

        qSymIOEditView.forceActiveFocus()
        setEditMode(false)
    }

    ///Function to set the Value of the text
    onQmDisplayTextChanged:{
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
        //In focus loss make cursor invisible
        qDisplayText.autoScroll = false
        qm_ShowCursor = false
        qm_SmartFocus = false;
    }

    TextInput
    {
        id:qDisplayText
        objectName: displayText
        parent : staticComponentObjRotationRect
        anchors.fill: parent
        text:qm_DisplayText
        color: qSymIOEditView.qm_TextColor
        anchors.bottomMargin: {return qSymIOEditView.qm_MarginBottom + qSymIOEditView.qm_BorderWidth}
        anchors.leftMargin: {return qSymIOEditView.qm_MarginLeft + qSymIOEditView.qm_BorderWidth}
        anchors.rightMargin: {return qSymIOEditView.qm_MarginRight + qSymIOEditView.qm_BorderWidth}
        anchors.topMargin: {return qSymIOEditView.qm_MarginTop + qSymIOEditView.qm_BorderWidth}
        horizontalAlignment: {return qSymIOEditView.qm_ValueVarTextAlignmentHorizontal}
        verticalAlignment: {return qSymIOEditView.qm_ValueVarTextAlignmentVertical}
        font.bold: qm_FontBold
        font.italic: qm_FontItalic
        font.underline: qm_FontUnderline
        font.strikeout: qm_FontStrikeout
        font.family: qm_FontFamilyName
        font.pixelSize: qm_FontSize
        cursorVisible: qm_ShowCursor
        clip:true
        readOnly: qm_ShowCursor ? false : true
        smooth:true
        autoScroll: false
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
}

