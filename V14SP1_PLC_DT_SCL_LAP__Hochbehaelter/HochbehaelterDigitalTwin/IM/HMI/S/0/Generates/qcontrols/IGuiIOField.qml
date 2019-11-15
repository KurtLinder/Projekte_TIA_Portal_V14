import QtQuick 2.0

IGuiViewBitmap{
    id:qIOFieldView

    property bool qm_passwordMode: false
    property variant staticComponent: undefined
    property variant staticComponentObj: undefined

    property int qm_FontRendringTpe: Text.QtRendering

    //For Dynamic loading of components
    property Item staticComponentObjRotationRect: {return qIOFieldView}

    //For Dynamic loading of TextInput component
    property variant staticComponentTextInput: undefined
    property variant staticComponentObjTextInput: undefined

    // load edit field QML
    function startEditMode(editFieldRef, editFieldValue, editFieldType, passwordMode, highlightText)
    {
        unloadIOFieldTextInput();
        qIOFieldView.z = 1
        staticComponent = Qt.createComponent("IGuiEditfield.qml")
        staticComponentObj = staticComponent.createObject(qIOFieldView,
                                                          {
                                                                 "x": qText.x,
                                                                 "y": qText.y,
                                                                 "width": qText.width,
                                                                 "height": qText.height,
                                                                 "color" : qm_FillColor,
                                                                 "radius": qm_BorderCornerRadius,
                                                                 "qm_EditFieldText":editFieldValue,
                                                                 "qm_EditFieldFontBold": qm_FontBold,
                                                                 "qm_EditFieldFontItalic": qm_FontItalic,
                                                                 "qm_EditFieldFontUnderLine": qm_FontUnderline,
                                                                 "qm_EditFieldFontStrikeOut": qm_FontStrikeout,
                                                                 "qm_EditFieldFontFamilyName": qm_FontFamilyName,
                                                                 "qm_EditFieldFontSize": qm_FontSize,
                                                                 "qm_EditFieldTextColor":qm_TextColor,
                                                                 "qm_EditFieldPasswordMode":qm_passwordMode,
                                                                 "qm_EditFieldTextAlignmentHorizontal": qm_ValueVarTextAlignmentHorizontal,
                                                                 "qm_EditFieldTextAlignmentVertical": qm_ValueVarTextAlignmentVertical,
                                                                 "qm_EditFieldObjid":editFieldRef
                                                           }
                                                          )

        if (staticComponentObj !== undefined)
        {
            staticComponentObj.editModeOff.connect(stopEditMode)
        }
    }

    // unload edit field QML
    function stopEditMode()
    {
        if(qm_SmartFocus)
            loadIOFieldTextInput();
        qIOFieldView.z = 0
        if(staticComponentObj !== undefined)
        {
            staticComponentObj.destroy()
            staticComponent.destroy()
            staticComponent = undefined
            staticComponentObj = undefined
        }
        qIOFieldView.forceActiveFocus()
    }

    /// @brief Helper-function for focus
    function handleFocus()
    {
       if(false === qm_SmartFocus) // ?? what is the relevance of this, should loadIOFieldTextInput() be called before
       {
           qm_SmartFocus = true;
       }
       qText.visible = false;
       loadIOFieldTextInput();
    }

    /// @brief Function to hadle focus loss
    function handleFocusLoss()
    {
        unloadIOFieldTextInput();
        qText.visible = true;
        qm_SmartFocus = false;
    }

       /// @brief Function to set the transparency
    function setTransparent(value)
    {
        if(value)
        {
            enableObject(false);           
            fillRect.color = qm_FillColor;
        }
        else
        {
            enableObject(true);
            fillRect.color = "#FFFFFF";
        }
    }
  clip:true

    Text{
        id:qText
        color: qIOFieldView.qm_TextColor
        text :qm_DisplayText
        antialiasing : true
        parent : staticComponentObjRotationRect
        anchors.fill: parent
        anchors.bottomMargin: {return qIOFieldView.qm_MarginBottom + qIOFieldView.qm_BorderWidth}
        anchors.leftMargin: {return qIOFieldView.qm_MarginLeft + qIOFieldView.qm_BorderWidth}
        anchors.rightMargin: {return qIOFieldView.qm_MarginRight + qIOFieldView.qm_BorderWidth}
        anchors.topMargin: {return qIOFieldView.qm_MarginTop + qIOFieldView.qm_BorderWidth}
        horizontalAlignment: {return qIOFieldView.qm_ValueVarTextAlignmentHorizontal}
        verticalAlignment: {return qIOFieldView.qm_ValueVarTextAlignmentVertical}
        font.bold: qm_FontBold
        font.italic: qm_FontItalic
        font.underline: qm_FontUnderline
        font.strikeout: qm_FontStrikeout
        font.family: qm_FontFamilyName
        font.pixelSize: qm_FontSize
        elide : Text.ElideRight        
        renderType: qm_FontRendringTpe

        MouseArea
        {
            id: mouseArea
            anchors.fill: parent

            onPressed: {

                if(qm_Selectable)
                {
                    if(!qm_SmartFocus)
                    {
                        qIOFieldView.setItemFocus();
                    }

                 proxy.lButtonDown(objId, mouse.x, mouse.y)

                mouse.accepted = true
                }
            }
            onReleased: {

                    if(qm_Selectable)
                    {
                        if(containsMouse)
                        {
                            proxy.lButtonUp(objId, mouse.x, mouse.y)
                            mouse.accepted = true
                        }
                    }
            }
        }
    }

   function loadIOFieldTextInput()
   {
       if(staticComponentObjTextInput === undefined)
       {
           staticComponentTextInput = Qt.createComponent("IGuiIOFieldTextInput.qml")
            staticComponentObjTextInput = staticComponentTextInput.createObject(qIOFieldView,
                                                                                {
                                                                                    "text": Qt.binding(function() {return qm_DisplayText}),
                                                                                })
       }
   }

   function unloadIOFieldTextInput()
   {
       if(staticComponentObjTextInput !== undefined)
       {
           staticComponentObjTextInput.destroy()
           staticComponentTextInput.destroy()
           staticComponentObjTextInput = undefined
           staticComponentTextInput = undefined
       }
   }
}
