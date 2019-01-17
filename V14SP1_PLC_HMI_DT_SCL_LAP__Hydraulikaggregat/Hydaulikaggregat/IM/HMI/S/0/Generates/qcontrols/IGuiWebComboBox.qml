
import QtQuick 2.0

Rectangle {
    x:0
    y:0
    id: rect
    color:  "#80000000"
    property int listItemheight: 30
    property int listSetectedIndex: 0
    property int scrollBarwidth:6
    property var scrollBarObj: undefined
    property int startindex: 0
    property int listItemsPerPage : (listRect.height/rect.listItemheight)

    function setModelItems(comboBoxText, currentIndex)
    {
        for (var i=0; i < comboBoxText.length; i++)
        {
                     modelListData.append({"comboBoxListItem": comboBoxText[i]})
        }
        comboBoxList.currentIndex = currentIndex;
        listSetectedIndex = currentIndex;
        if(comboBoxList.currentIndex >= listItemsPerPage)
        {
            startindex = comboBoxList.currentIndex - (listItemsPerPage - 1);
        }

    }
    signal selectedItem(var ItemIndex);
    MouseArea
    {
        id: rectMouseArea;
        anchors.fill: {return parent}
        acceptedButtons:  Qt.LeftButton
        onClicked:
        {
            rect.selectedItem(-1)
        }
    }
    function comboBoxKeyEvents(keyCode)
    {

        if(keyCode === Qt.Key_PageDown)
        {
            if(comboBoxList.count < listItemsPerPage)
            {
                comboBoxList.currentIndex = comboBoxList.count - 1;
            }
            else if((comboBoxList.currentIndex - startindex) < (listItemsPerPage - 1))
            {
                comboBoxList.currentIndex = startindex + (listItemsPerPage - 1);
            }
            else
            {
                startindex = comboBoxList.currentIndex + 1;
                comboBoxList.currentIndex = startindex + (listItemsPerPage - 1);
                if(comboBoxList.currentIndex > (comboBoxList.count - 1))
                {
                    comboBoxList.currentIndex = (comboBoxList.count - 1);
                    startindex = comboBoxList.currentIndex - (listItemsPerPage - 1);
                }
            }
        }
        else if(keyCode === Qt.Key_PageUp)
        {
            if(comboBoxList.currentIndex == startindex)
            {
                comboBoxList.currentIndex = startindex - listItemsPerPage;
                startindex = comboBoxList.currentIndex;
            }
            else
            {
                comboBoxList.currentIndex = startindex;
            }

            if(comboBoxList.currentIndex < 0)
            {
                comboBoxList.currentIndex = startindex = 0;
            }
        }
        else if(keyCode === Qt.Key_Home)
        {
            startindex = 0;
            comboBoxList.currentIndex = 0;
        }
        else if(keyCode === Qt.Key_End)
        {
            comboBoxList.currentIndex = comboBoxList.count -1;
            if(comboBoxList.count < listItemsPerPage)
                startindex = 0;
            else
                startindex = comboBoxList.count -listItemsPerPage;
        }
        else if(keyCode === Qt.Key_Up)
        {
            if (comboBoxList.currentIndex > 0)
            {
                if(startindex == comboBoxList.currentIndex)
                    startindex--;
            }
        }
        else if(keyCode === Qt.Key_Down)
        {
            if (comboBoxList.currentIndex < (comboBoxList.count - 1))
            {
                if(comboBoxList.currentIndex == (startindex +(listItemsPerPage - 1)))
                    startindex++;
            }
        }
    }

    Rectangle
    {
        id:comboboxRect
        color: "white"
        width: 270
        height: 270
        anchors.centerIn: {return parent}

        function createScrollbar()
        {
            var scrollBarComp = Qt.createComponent("IGuiScrollBar.qml")

            if(scrollBarComp.status === Component.Ready) {
                scrollBarObj = scrollBarComp.createObject(comboboxRect,
                                                          {
                                                              "x": comboboxRect.width -scrollBarwidth,
                                                              "y": closeRect.height,
                                                              "width": scrollBarwidth,
                                                              "height": (comboboxRect.height - closeRect.height),
                                                              "opacity": 1,
                                                              "enabled": true,
                                                              "scrollBarOrientation": Qt.Vertical,
                                                              "totalContentHeight":comboBoxList.contentHeight,
                                                              "scrollLimitAreaSize":0
                                                          }
                                                          )
            }
        }

        function scrollListView (newContentPos, scrollBarOrientation, columnIndex)
        {
            comboBoxList.contentY =  newContentPos * (comboBoxList.contentHeight / (comboboxRect.height - closeRect.height));
        }

        function stopEditMode()
        {}

        Rectangle
        {
            id: closeRect
            width: {return listRect.width}
            height: 25
            color: "#ff3e414f"
            anchors.top: {return comboboxRect.top}
            anchors.right: {return comboboxRect.right}
            anchors.left: {return comboboxRect.left}
            MouseArea
            {
                x:0; y:0;
                width: closeRect.width - colseButtonImage.width
                height: closeRect.height
            }
            Image
            {
                id: colseButtonImage
                source: "./pics/Kb_ButtonClose_normal.png"
                height: 25
                width: 25
                anchors.right: {return closeRect.right}
            }
        }

        Rectangle
        {
            id: listRect
            color: "white"
            anchors.top: {return closeRect.bottom}
            anchors.right: {return comboboxRect.right}
            anchors.left: {return comboboxRect.left}
            anchors.bottom: {return comboboxRect.bottom}
            //opacity: 1.0


            ListView
            {
                id: comboBoxList;
                clip: true;
                currentIndex: -1;
                boundsBehavior: Flickable.StopAtBounds

                onContentHeightChanged:{
                    if ( (contentHeight > 0) && (contentHeight > (comboboxRect.height - closeRect.height)))
                    {
                        comboboxRect.createScrollbar();
                    }
                }

                onContentYChanged: {
                    scrollBarObj.positionSlider(comboBoxList.contentY,Qt.Vertical);
                }

                model: ListModel
                {
                id: modelListData;
                }

                delegate: Item
                {
                id: listItem;
                height: {return listItemheight}
                anchors {
                    left: {return parent.left;}
                    right: {return parent.right;}
                }

                property bool isCurrent : (model.index === comboBoxList.currentIndex);
                onIsCurrentChanged:
                {
                    if (isCurrent)
                    {
                        input.forceActiveFocus ();
                    }
                    else
                    {
                        input = false;
                    }
                }
                Text
                {
                    id: label;
                    text: model.comboBoxListItem;
                    font.pointSize: 12
                    visible: !listItem.isCurrent;

                    anchors
                    {
                        left: parent.left;
                        margins: 5;
                        verticalCenter: {return parent.verticalCenter;}
                    }
                }
                Text
                {
                    id: input;
                    text: {return model.comboBoxListItem;}
                    font.pointSize: 12
                    visible: listItem.isCurrent;
                    anchors
                    {
                        left: {return parent.left;}
                        margins: 5;
                        verticalCenter: {return parent.verticalCenter;}
                    }
                    Rectangle
                    {
                        z: {return parent.z -1;}
                        x: {return 2 - parent.x;}
                        y: {return 2 - parent.y;}
                        height: {return listItemheight - 4;}
                        width: {return listRect.width - 4;}
                        border.color: "#A0DCFF"
                        color: "#A5EFFF"
                        border.width: 3
                        radius: 3
                    }
                }
                MouseArea
                {
                    id: clicker;
                    anchors.fill: {return parent}
                    onClicked:
                    {
                        if(listSetectedIndex !== model.index)
                        {
                            comboBoxList.currentIndex = model.index;
                            rect.selectedItem(comboBoxList.currentIndex)
                        }
                        else
                        {
                            rect.selectedItem(-1)
                        }
                    }

                }

                Rectangle
                {
                    id: rowSplitter
                    height: 1;
                    color: "lightgray";
                    anchors
                    {
                        left: {return parent.left}
                        right: {return parent.right}
                        bottom: {return parent.bottom}
                    }
                }
            }
            anchors.fill: {return parent}
            Keys.onPressed:
            {
                comboBoxKeyEvents(event.key)
            }


            Keys.onEnterPressed:
            {
                if(listSetectedIndex !== comboBoxList.currentIndex)
                    rect.selectedItem(comboBoxList.currentIndex)
                else
                    rect.selectedItem(-1)

            }
            Keys.onReturnPressed:
            {
                if(listSetectedIndex !== comboBoxList.currentIndex)
                    rect.selectedItem(comboBoxList.currentIndex)
                else
                    rect.selectedItem(-1)
            }
            Keys.onEscapePressed:
            {
                rect.selectedItem(-1)
            }
            onFocusChanged:
            {
                if(focus == false)
                {
                    rect.selectedItem(-2)
                }
            }

        }
        }
        Item {
            id: scrollBar
             width: 6;
             height: {return listRect.height}
             anchors.right: {return listRect.right}
             anchors.top: {return listRect.top}
             opacity: 1
             Rectangle {
                id: scrollBackground
                anchors.fill: {return parent}
                color: Qt.rgba((211/255),(211/255),(211/255),(255/255))
             }

        }
    }
}
