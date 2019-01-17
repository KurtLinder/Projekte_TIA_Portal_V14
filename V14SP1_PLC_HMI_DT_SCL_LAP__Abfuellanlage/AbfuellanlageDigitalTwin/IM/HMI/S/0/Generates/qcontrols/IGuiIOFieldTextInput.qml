
import QtQuick 2.0

TextInput
{
    id:qTextInput
    height: {return qText.height}
    width : {return qText.width}
    x: {return qText.x}
    y : {return qText.y}
    font.bold:  {return qText.font.bold}
    font.italic: {return qText. font.italic}
    font.pixelSize: {return qText.font.pixelSize}
    font.strikeout: {return qText.font.strikeout}
    font.underline: {return qText.font.underline}
    horizontalAlignment: {return qText.horizontalAlignment}
    verticalAlignment: {return qText.verticalAlignment}
    antialiasing : true

    /// when font family changed in runtime, it will load dynamically
    font.family: qm_FontFamilyName

    cursorVisible:  false
    clip:true
    readOnly: true
    autoScroll: false

    MouseArea
    {
        id: mouseArea
        anchors.fill: parent

        onPressed: {
            proxy.lButtonDown(qIOFieldView.objId, mouse.x, mouse.y)
            mouse.accepted = true
        }

        onReleased: {
            if(containsMouse)
            {
                proxy.lButtonUp(qIOFieldView.objId, mouse.x, mouse.y)
                mouse.accepted = true
            }
        }
    }

    Component.onCompleted:
    {
        qTextInput.selectAll();
    }

    onDisplayTextChanged:
    {
        qTextInput.selectAll();
    }
}
