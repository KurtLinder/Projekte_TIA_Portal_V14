import QtQuick 2.0
Rectangle
{
    id: qEditField

    property int qm_EditFieldObjid: 0
    property int qm_EditFieldBorderWidth: 1
    property int qm_EditFieldMarginLeft: 1
    property int qm_EditFieldMarginTop: 1
    property bool qm_EditFieldPasswordMode: false
    property color qm_EditFieldTextColor: "#000000"
    property bool qm_EditFieldFontBold: false
    property bool qm_EditFieldFontItalic: false
    property bool qm_EditFieldFontUnderLine: false
    property bool qm_EditFieldFontStrikeOut: false
    property string qm_EditFieldFontFamilyName: "Tohoma"
    property int qm_EditFieldFontSize: 8
    property int qm_EditFieldTextAlignmentHorizontal : Text.AlignLeft
    property int qm_EditFieldTextAlignmentVertical : Text.AlignTop
    property string qm_EditFieldText : ""

    signal editModeOff();

    function handleParentData (parentData)
    {
         qm_EditFieldText = parentData
    }

    TextInput
    {
        id: qEditFieldTextInput
        objectName: "qEditFieldTextInput"

        property int currentCursorPosition: qEditFieldTextInput.text.length

        x: qm_EditFieldMarginLeft + qm_EditFieldBorderWidth
        y: qm_EditFieldMarginTop + qm_EditFieldBorderWidth
        height: parent.height - (qm_EditFieldMarginTop + qm_EditFieldBorderWidth)
        width: parent.width - (qm_EditFieldMarginTop + qm_EditFieldBorderWidth)
        color: qm_EditFieldTextColor
        clip: true

        text: qm_EditFieldText
        font.bold: qm_EditFieldFontBold
        font.italic: qm_EditFieldFontItalic
        font.underline: qm_EditFieldFontUnderLine
        font.strikeout: qm_EditFieldFontStrikeOut
        font.family: qm_EditFieldFontFamilyName
        font.pixelSize: qm_EditFieldFontSize
        passwordCharacter: "*"
        echoMode: (qm_EditFieldPasswordMode) ? TextInput.Password : TextInput.Normal
        cursorVisible: false
        horizontalAlignment: qm_EditFieldTextAlignmentHorizontal
        verticalAlignment: qm_EditFieldTextAlignmentVertical

        function init(objectIdentifier)
        {
           qm_EditFieldObjid = objectIdentifier
           qEditFieldTextInput.select(currentCursorPosition-1,currentCursorPosition)
        }

        function setValue(value)
        {
           qm_EditFieldText = value
           qEditFieldTextInput.select(currentCursorPosition-1,currentCursorPosition)
        }

        function setFocus()
        {
            qEditFieldTextInput.forceActiveFocus()
            qEditFieldTextInput.focus = true
        }

        function doStopEditMode()
        {
            qEditField.editModeOff();
        }

        function setCursorValue(value)
        {
            currentCursorPosition = value
            if(currentCursorPosition === 1)
                qEditFieldTextInput.cursorPosition = 0
            qEditFieldTextInput.select(currentCursorPosition-1,currentCursorPosition)
        }


        MouseArea
        {
            id: mouseArea
            anchors.fill: parent
            onPressed: {
                utilProxy.lButtonDown(qm_EditFieldObjid, mouse.x, mouse.y)
                mouse.accepted = true
            }
            onReleased: {
                if(containsMouse)
                {
                   utilProxy.lButtonUp(qm_EditFieldObjid, mouse.x, mouse.y)
                    mouse.accepted = true
                }
            }
            onPositionChanged: {
                 utilProxy.handleMouseMove(qm_EditFieldObjid, mouse.x, mouse.y)
                mouse.accepted = true
            }
        }

        Keys.onPressed:
        {
            var isCtrlPressed = (event.modifiers & Qt.ControlModifier)
            var isAltPressed = (event.modifiers & Qt.AltModifier)
            utilProxy.keyHandler(qm_EditFieldObjid, event.key, true, event.text,event.isAutoRepeat, isCtrlPressed, isAltPressed);
            event.accepted = true;
        }

        Keys.onReleased:
        {
            utilProxy.keyHandler(qm_EditFieldObjid, event.key, false, event.text, event.isAutoRepeat);
            event.accepted = true;
        }
    }

    Component.onCompleted:
    {
        qEditFieldTextInput.setFocus()
    }
}
