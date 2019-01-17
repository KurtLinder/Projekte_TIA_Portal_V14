
import QtQuick 2.0
import SmartBarScaleComponent 2.0
import SmartLineComponent 1.0
import SmartRectangleComponent 1.0

IGuiViewBitmap {
    id: qSmartBar

    property int objId: 0

    // Scale font properties
    property int    qm_BarFontSize: 7
    property string qm_BarFontFamilyName: "Tahoma"
    property bool   qm_BarFontNormal: true
    property bool   qm_BarFontBold: false
    property bool   qm_BarFontItalic: false
    property bool   qm_BarFontUnderline: false
    property bool   qm_BarFontStrikeout: false

    // Flow bar properties
    property int flowbarorientation: 0

    // Scale and label properties
    property color scalelabelcolor: "#000000"
    property int barscaleplacement: -1

    // Scale details
    property point scaleposition: Qt.point(0, 0)
    property int scalewidth: 0
    property int scaleheight: 0
    property int scalerectwidth: 0
    property int scalerectheight: 0
    property int scaleorientation: 0
    property int scalepinwidth: 0
    property int scalepinheight: 0
    property int scalelabelwidth: 0
    property int scalelabelheight: 0
    property int scalemunitwidth: 0
    property real scaleinterval: 0.0
    property real scalelowvalue: 0
    property real scalehighvalue: 0
    property int scalelabellength: 0
    property int scaledecimalplaceno: 0
    property int scaleincrementlabelmark: 0
    property int scalesubdivisioncount: 0
    property int scaledetails: 0
    property int scalemeasurementunitid: 0
    property int scaleenlarge: 0

    property int  bararrowtailwidth: 0

    property int qm_segmentBar: 0

    function setStatusValue (dValue)
    {
        flowBarRect.qm_nFlowbarDValue = dValue
    }

    IGuiSmartFlowBar
    {
        id: flowBarRect
		objectName : "flowBarRect"
        anchors.margins: {return qm_BorderWidth}
        qm_qParent: qSmartBar
        qm_pViewID: {return objId}
        qm_nFlowbarTextWidth: scaleenlarge ? 0 : qSmartBar.scalelabelwidth
        qm_nFlowbarTextHeight: qSmartBar.scalelabelheight
        qm_qFlowBarColor: qSmartBar.qm_TextColor
        qm_bIsSegmented: { return qm_segmentBar}
        qm_nFlowbOrientation: {return qSmartBar.flowbarorientation}

    }
    onQm_TextColorChanged: {
        qm_flowBarColor: qSmartBar.qm_TextColor
        flowBarRect.update();
    }

    IGuiSmartBarScale {
        id: barScale
		objectName : "barscale"
        qm_qParent: qSmartBar
        x: scaleposition.x
        y: scaleposition.y
        width: scalerectwidth
        height: scalerectheight
        visible: (qSmartBar.barscaleplacement >= 0)
        pViewID: objId

    }
}
