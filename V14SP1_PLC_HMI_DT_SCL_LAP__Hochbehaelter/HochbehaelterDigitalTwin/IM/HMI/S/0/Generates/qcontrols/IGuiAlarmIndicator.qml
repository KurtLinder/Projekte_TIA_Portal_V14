import QtQuick 2.0

IGuiViewBitmap{
    id: qAlarmIndDialogID

    focus: false
    visible: visibility
    property int qm_NoOfAlarms:0
	// --------------- This is for drag feature --------------
	//    property int maxdragx: 40  this is for drag feature
	//    property int maxdragy: 40
	// -------------------------------------------------------
   
    property int qm_AlarmImagewidth :31
    property int qm_AlarmImageheight :31
    property int qm_AlarmTextWidth : 0
    property int qm_AlarmTextHeight : 0
    property int qm_AlarmTextPosX : 0
    property int qm_AlarmTextPosY : 0


    /// @brief the no.of alarms have to be set when there is change in no of alarms
    function setNoOfAlarms(NoOfAlarms)
    { 
       qm_NoOfAlarms = NoOfAlarms;
    }

   // This is the outermost rectangle
    Rectangle {
        id:alarmIndicatorRectID
        height: parent.height - qm_BorderWidth - 1
        width: parent.width - qm_BorderWidth -1
        anchors.centerIn: parent
        color: "transparent"

	    // inner rectangle contains image
        Rectangle{
			id:alarmImageRectID
			x:alarmIndicatorRectID.x+qAlarmIndDialogID.anchors.leftMargin*1
			y:alarmIndicatorRectID.y+qAlarmIndDialogID.anchors.topMargin*1
			width: qm_AlarmImagewidth
			height: qm_AlarmImageheight
			color : "transparent"
			Image{
                id: imageID
                source: "image://QSmartImageProvider/" + 
                                       qm_GraphicImageID    + "#" +         // image id
                                       1                    + "#" +         // streaching info
                                       4                    + "#" +         // horizontal alignment info
                                       128                  + "#" +         // vertical alignment info
                                       0                    + "#" +         // language index
                                       0                                    // cache info
                sourceSize.width: alarmImageRectID.width
                sourceSize.height: alarmImageRectID.height
            }
        }

		// inner rectangle contains alarm number
		Rectangle{
			id:alarmNumberRectID
			x:qm_AlarmTextPosX
			y:qm_AlarmTextPosY-qAlarmIndDialogID.anchors.topMargin-1
			width:qm_AlarmTextWidth
			height:qm_AlarmTextHeight
			anchors.horizontalCenter :alarmIndicatorRectID.horizontalCenter

			color:qm_FillColor

            Text{
                id:textAlarmRect
                text:qm_NoOfAlarms
                anchors.fill: parent
                color:qm_TextColor
                horizontalAlignment:Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Tahoma"
            }

        }
        MouseArea {
            id:mouseareaID
            anchors.fill: alarmIndicatorRectID
			// --------------- This is for drag feature --------------
			//            drag.target: qAlarmIndDialogID
			//            drag.axis: Drag.XandYAxis
			//            drag.minimumX: 0
			//            drag.minimumY: 0
			//            drag.maximumX: qAlarmIndDialogID.maxdragx
			//            drag.maximumY: qAlarmIndDialogID.maxdragy
			// --------------------------------------------------------
            onPressed: {
                     proxy.lButtonDown(objId, mouse.x, mouse.y);

            }

        }
    }
}

