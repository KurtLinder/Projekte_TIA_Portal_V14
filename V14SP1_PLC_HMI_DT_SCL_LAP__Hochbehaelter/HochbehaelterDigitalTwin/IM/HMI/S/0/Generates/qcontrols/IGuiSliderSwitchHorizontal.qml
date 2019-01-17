import QtQuick 2.0

IGuiSwitchBitMap{

    id: qSliderSwitchView

    property int halfWidth: {return qSliderSwitchView.width/2}

    // Function to set the Switch value
    function setStatusValue(value )
    {
        slidertimer.stop();
        // If new value is Switch ON value
        if(value === qm_SwitchOnValue)
        {
            if(qm_SwichOnSide === true)
            {
                sliderRect.x = 0
                qm_SwitchStatus = false;
            }
            else
            {
                sliderRect.x = halfWidth;
                qm_SwitchStatus = true;
            }
            fillRect.color = qm_SliderRectOnFillColor;
        }
        else// If new value is Switch OFF value
        {
            if(qm_SwichOnSide === true)
            {
                sliderRect.x = halfWidth;
                qm_SwitchStatus = true
            }
            else
            {
                sliderRect.x = 0
                qm_SwitchStatus = false;
            }
            fillRect.color = qm_SliderRectOffFillColor;
        }
    }


    //Function to reset the Slider position in Drag area.
    function setSliderPosition(newx,newy)
    {
        var sliderCurrentState = false;
        //If Slider in right area of Drag area
        if(sliderRect.x >=(qSliderSwitchView.width - 4)/3 )
        {
            sliderRect.x = halfWidth;
            sliderCurrentState = true;
        }
        else //Slider in Left area of Drag area
        {
            sliderRect.x = 0
            sliderCurrentState = false;
        }

        if(sliderCurrentState != qm_SwitchStatus)
        {
            //Slider postion is changed so send the Event as Button pressed
            proxy.lButtonDown(objId, newx, newy);
            slidertimer.running = true;
        }
        if(!qm_SmartFocus)
            setItemFocus();
    }

    //Function to check and reset the slider position after timer expires
    function checkAndResetSlider()
    {
        //IF slider in left side then move it to right
        if(qm_SwitchStatus)
        {
            sliderRect.x = halfWidth;

        }
        else    //Slider is in right side so move it to left
        {
            sliderRect.x = 0
        }
    }

    //timer to check for Slider position to reset or not
    Timer {
        id: slidertimer
        interval: 500
        triggeredOnStart: false
        onTriggered: {
            checkAndResetSlider();
        }
    }

    //Text element  Rectangle for Switch ON
    Item{
        id:textLeftRect
        height:{return qSliderSwitchView.height}
        width:{ return halfWidth + qSliderSwitchView.qm_BorderWidth}
        property Item staticComponentObjRotationRect: {return textLeftRect}
        clip:true
        //Text element  for Switch ON
        Text {
            id:textElementLeft
            anchors.fill: parent
            parent : textLeftRect.staticComponentObjRotationRect
            text: (qm_SwichOnSide === true)? qm_SwitchOffText:qm_SwitchOnText
            color: qSliderSwitchView.qm_TextColor
            anchors.bottomMargin: {return qSliderSwitchView.qm_MarginBottom + qSliderSwitchView.qm_BorderWidth}
            anchors.leftMargin: {return qSliderSwitchView.qm_MarginLeft + qSliderSwitchView.qm_BorderWidth}
            anchors.rightMargin: {return qSliderSwitchView.qm_MarginRight + qSliderSwitchView.qm_BorderWidth}
            anchors.topMargin: {return qSliderSwitchView.qm_MarginTop + qSliderSwitchView.qm_BorderWidth}
            horizontalAlignment: {return qSliderSwitchView.qm_ValueVarTextAlignmentHorizontal}
            verticalAlignment: {return qSliderSwitchView.qm_ValueVarTextAlignmentVertical}
            font.bold: qm_FontBold
            font.italic: qm_FontItalic
            font.underline: qm_FontUnderline
            font.strikeout: qm_FontStrikeout
            font.family: qm_FontFamilyName
            font.pixelSize: qm_FontSize
            clip:true
        }
    }
    //Text element  Rectangle for Switch OFF
    Item{
        id:textRightRect
        x: {return halfWidth - qSliderSwitchView.qm_BorderWidth}
        height: {return qSliderSwitchView.height}
        width:{return halfWidth + qSliderSwitchView.qm_BorderWidth}
        property Item staticComponentObjRotationRect: {return textRightRect}
        clip:true
        //Text element  for Switch OFF
        Text {
            id:textElementRight
            anchors.fill: parent
            parent : textRightRect.staticComponentObjRotationRect
            text: (qm_SwichOnSide === true)? qm_SwitchOnText:qm_SwitchOffText
            color: qSliderSwitchView.qm_TextColor
            anchors.bottomMargin: {return qSliderSwitchView.qm_MarginBottom + qSliderSwitchView.qm_BorderWidth}
            anchors.leftMargin: {return qSliderSwitchView.qm_MarginLeft + qSliderSwitchView.qm_BorderWidth}
            anchors.rightMargin: {return qSliderSwitchView.qm_MarginRight + qSliderSwitchView.qm_BorderWidth}
            anchors.topMargin: {return qSliderSwitchView.qm_MarginTop + qSliderSwitchView.qm_BorderWidth}
            horizontalAlignment: {return qSliderSwitchView.qm_ValueVarTextAlignmentHorizontal}
            verticalAlignment: {return qSliderSwitchView.qm_ValueVarTextAlignmentVertical}
            font.bold: qm_FontBold
            font.italic: qm_FontItalic
            font.underline: qm_FontUnderline
            font.strikeout: qm_FontStrikeout
            font.family: qm_FontFamilyName
            font.pixelSize: qm_FontSize
            clip:true

        }
    }

    //Slider Item element sliderRect for Switch
    Item
    {
        id: sliderRect
        width:{return halfWidth}
        height: {return qSliderSwitchView.height}
        Rectangle{
            id: sliderRectbeckground
            anchors.centerIn: parent
            color:qm_FillColor
            radius: {return qm_BorderCornerRadius}
            height: {return qm_SliderRectHeight}
            width: {return qm_SliderRectWidth}
        }
        /// @brief Loading tiled bitmap image
        BorderImage {
            id: bimage
            source: {return qm_SliderRectimageSrc}
            anchors.fill: parent

            border.left: {return qm_SliderRectTileLeft}
            border.top: {return qm_SliderRectTileTop}
            border.right: {return qm_SliderRectTileRight}
            border.bottom: {return qm_SliderRectTileBottom}

            horizontalTileMode: BorderImage.Repeat
            verticalTileMode: BorderImage.Repeat

        }

        /// @brief BorderImage shows the Grip Lines
        BorderImage{
            id:sliderImage
            height: parent.height
            property int leftrightwidth: {return qm_SliderGripTileLeft + qm_SliderGripTileRight}
            property int tileWidth: {return leftrightwidth + ((qm_SliderGripTileWidth - leftrightwidth)* 3)}
            width :{ return (tileWidth > (parent.width/2 - qm_BorderWidth))? (parent.width/2 - qm_BorderWidth):tileWidth}
            anchors.centerIn: parent
            source: {return qm_SliderGripimageSrc}

            border.left: {return qm_SliderGripTileLeft}
            border.top: {return qm_SliderGripTileTop}
            border.right: {return qm_SliderGripTileRight}
            border.bottom: {return qm_SliderGripTileBottom}

            horizontalTileMode: BorderImage.Repeat
            verticalTileMode: BorderImage.Repeat
        }

        Drag.active: sliderDragArea.drag.active

        //Drop area for Slider Item sliderRect
        DropArea {
            id:sliderDropArea
            width: {return halfWidth}
            height: {return qSliderSwitchView.height}

        }

        //Mouse area for Slider Item sliderRect
        MouseArea {
            id:sliderDragArea
            anchors.fill: parent
            drag.target: sliderRect
            drag.axis: Drag.XAxis
            drag.minimumX: 0
            drag.maximumX: {return halfWidth}
            onReleased:{setSliderPosition(mouse.x,mouse.y);}
            onPressed:
            {
                if(!qm_SmartFocus)
                    setItemFocus();
            }
            onClicked: {
                //clicked Slider so send the Event as Button pressed
                proxy.lButtonDown(objId, mouse.x, mouse.y);
            }
        }
    }
}





