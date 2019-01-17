import QtQuick 2.0

IGuiViewBitmap {
    id: qmDiagnosticView

    property string listObjName: {return "qu" + objId}

    //TODO: Check with es2rt as header for diagnostic view will be removed
    property color qm_headerTextColor: "#ff000000"
    property color qm_headerBackColor: "#ababab"
    property int qm_headerValueVarTextAlignmentHorizontal: Text.AlignLeft
    property int qm_headerValueVarTextAlignmentVertical: Text.AlignVCenter
    property int qm_headerValueVarTextOrientation: 0
    property int qm_headerMarginLeft: 0
    property int qm_headerMarginRight: 0
    property int qm_headerMarginBottom: 0
    property int qm_headerMarginTop: 0
    property int qm_headerFontSize: 7
    property string qm_headerFontFamilyName: "Tahoma"
    property bool qm_headerFontBold: false
    property bool qm_headerFontItalic: false
    property bool qm_headerFontUnderline:false
    property bool qm_headerFontStrikeout:false
    property int qm_headerTextPosX: 0
    property int qm_headerTextPosY: 0
    property int qm_headerTextWidth: 0
    property int qm_headerTextHeight: 0

    property int qm_diagViewToolbarPosX: 0
    property int qm_diagViewToolbarPosY: 0
    property int qm_diagViewToolbarWidth: 576
    property int qm_diagViewToolbarHeight: 30
    property color qm_toolBarBackColor: "transparent"    
    property real qm_diagViewCornerRadius: 0

    property variant pageObj: undefined

    property list<Component> qm_DiagnosticListComponent
    /// @brief function to set font data
    function setHeaderFontData(fontSize,fontName,bFontBold,bFontItalic,bFontUnderlined,bFontStrikeout)
    {
        qm_headerFontSize = fontSize;
        qm_headerFontFamilyName  = fontName;
        qm_headerFontBold  = bFontBold;
        qm_headerFontItalic = bFontItalic;
        qm_headerFontUnderline = bFontUnderlined;
        qm_headerFontStrikeout = bFontStrikeout;
    }

    clip: true

    Rectangle {
        x: {return qm_diagViewToolbarPosX}
        y: {return qm_diagViewToolbarPosY}
        width: {return qm_diagViewToolbarWidth}
        height: {return qm_diagViewToolbarHeight}
        color: {return qm_toolBarBackColor}
    }

    Rectangle {
        id: headerRect

        x: {return qm_headerTextPosX}
        y: {return qm_headerTextPosY}
        width: {return qm_headerTextWidth}
        height: {return qm_headerTextHeight}
        color: {return qm_headerBackColor}
        radius: {return qm_diagViewCornerRadius}

        Text {
            id: headerText

            anchors.fill: parent
            text:qm_DisplayText
            color: {return qm_headerTextColor}
            horizontalAlignment: {return qm_headerValueVarTextAlignmentHorizontal}
            verticalAlignment: {return qm_headerValueVarTextAlignmentVertical}
            anchors.leftMargin: {return qm_headerMarginLeft}
            anchors.topMargin: {return qm_headerMarginTop}
            anchors.rightMargin: {return qm_headerMarginRight}
            anchors.bottomMargin: {return qm_headerMarginBottom}
            elide: Text.ElideRight
            wrapMode: Text.WordWrap
            font.pixelSize: qm_headerFontSize
            font.family: qm_headerFontFamilyName
            font.bold: qm_headerFontBold
            font.italic: qm_headerFontItalic
            font.underline: qm_headerFontUnderline
            font.strikeout: qm_headerFontStrikeout
        }
    }

    function loadConfigurationPage (pageType) {
        pageObj = qm_DiagnosticListComponent[pageType].createObject(qmDiagnosticView,
                                                                    {
                                                                        "objectName": listObjName
                                                                    }
                                                                   )
    }

    function unloadConfigurationPage () {     
        if ((pageObj !== undefined) && (pageObj !== null)) {
            if (pageObj.objectName !== undefined) {
                pageObj.objectName = ""
            }
            pageObj.visible = false
            pageObj.enabled = false
            pageObj.destroy()
        }
    }
}
