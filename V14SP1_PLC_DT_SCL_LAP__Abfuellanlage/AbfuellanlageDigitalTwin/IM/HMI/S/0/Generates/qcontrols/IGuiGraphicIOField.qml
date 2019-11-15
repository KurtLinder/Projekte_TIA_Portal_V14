// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0

IGuiViewBitmap
{
    id: qGraphiciofieldview

    /// @brief data for stretched image
    property bool  qm_Streached: false


    ///@brief data for  touchpad component and object
    property variant staticTouchComponent: undefined
    property variant staticTouchComponentObj: undefined

    property variant staticComponentEditmode: undefined
    property variant staticComponentObjEditmode: undefined

    property bool qm_InEditMode:false

   /// load list control QML
   function startEditMode(editFieldRef,editFieldValue, editFieldType, passwordMode, highlightText)
   {
       staticTouchComponent = Qt.createComponent("IGuiTouchpad.qml")
       staticTouchComponentObj = staticTouchComponent.createObject(qGraphiciofieldview,
                                                                   {
                                                                       "qm_TouchpadInputQml":"IGuiGraphicioListEdit.qml",
                                                                       "qm_TouchPadYposition":qm_BorderWidth,
                                                                       "qm_TouchPadXposition":qm_BorderWidth,
                                                                       "qm_TouchPadType":editFieldType,
                                                                       "qm_TouchPadWidth": qGraphiciofieldview.width - (2*qm_BorderWidth),
                                                                       "qm_TouchPadHeight":qGraphiciofieldview.height - (2*qm_BorderWidth),
                                                                       "qm_TextVAlign":qGraphiciofieldview.qm_ValueVarTextAlignmentVertical,
                                                                       "qm_TextHAlign":qGraphiciofieldview.qm_ValueVarTextAlignmentHorizontal,
                                                                       "qm_TextMarginLeft":qGraphiciofieldview.qm_MarginLeft,
                                                                       "qm_TextMarginRight":qGraphiciofieldview.qm_MarginRight,
                                                                       "qm_TextMarginTop":qGraphiciofieldview.qm_MarginTop,
                                                                       "qm_TextMarginBottom":qGraphiciofieldview.qm_MarginBottom,
                                                                       "qm_Streached":qm_Streached,
                                                                       "qm_HostComponentObj": qGraphiciofieldview
                                                                   })
       setEditmodeState(true);
       qm_InEditMode = true;
   }

   function doStopEditMode()
   {
       if(staticTouchComponentObj !== undefined)
       {
           staticTouchComponentObj.objectName = ""
           staticTouchComponentObj.destroy ()
           staticTouchComponentObj = undefined
           staticTouchComponent.destroy()
           staticTouchComponent = undefined
       }
       setEditmodeState(false);
       qm_InEditMode = false;
   }

   Image
   {
       id: image

        anchors.fill: parent
        anchors.bottomMargin: {return qm_MarginBottom + qm_BorderWidth}
        anchors.leftMargin: {return qm_MarginLeft + qm_BorderWidth}
        anchors.rightMargin: {return qm_MarginRight + qm_BorderWidth}
        anchors.topMargin: {return qm_MarginTop + qm_BorderWidth}

       fillMode: qm_Streached ? Image.Stretch: Image.Pad

       // Do not show this image when the graphic iofield is in edit mode
       visible: qm_InEditMode ? false : qm_ContentVisibility
       source : "image://QSmartImageProvider/" + 
                 qm_GraphicImageID + "#" +            // image id
                                        (qm_Streached ? 1 : 0)    + "#" +    // streaching info
                                        image.horizontalAlignment + "#" +    // horizontal alignment info
                                        image.verticalAlignment   + "#" +    // vertical alignment info
                                        qm_LanguageIndex          + "#" +    // language index
                                        0                                    // cache info
              
       horizontalAlignment: {return qm_ValueVarTextAlignmentHorizontal}
       verticalAlignment: {return qm_ValueVarTextAlignmentVertical}
       sourceSize.width: {return qGraphiciofieldview.width - (2*qm_BorderWidth + qm_MarginLeft + qm_MarginRight)}
       sourceSize.height: {return qGraphiciofieldview.height - (2*qm_BorderWidth + qm_MarginBottom + qm_MarginTop)}
   }

   /// @brief function for set editmode state
   function setEditmodeState(bEdit)
   {
       if(bEdit)
       {
           staticComponentEditmode = Qt.createComponent("IGuiUtilEditmodeRect.qml")
           staticComponentObjEditmode = staticComponentEditmode.createObject(qGraphiciofieldview,
                                                             {
                                                                 "border.color":  qm_BorderColor,
                                                                 "border.width": qm_BorderWidth + 2
                                                             })
       }
       else
       {
           if (staticComponentObjEditmode !== undefined)
           {
               staticComponentObjEditmode.destroy()
               staticComponentEditmode.destroy()
               staticComponentEditmode = undefined
               staticComponentObjEditmode = undefined
           }            
       }
   }
}
