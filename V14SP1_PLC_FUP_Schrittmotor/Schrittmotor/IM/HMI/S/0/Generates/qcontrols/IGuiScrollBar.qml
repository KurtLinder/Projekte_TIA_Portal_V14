import QtQuick 2.0

// scroll bar
Item {
    id: scrollBar

    property color scrollBarColor: Qt.rgba((211/255),(211/255),(211/255),(255/255))
    property color scrollSliderColor: Qt.rgba((129/255),(129/255),(135/255),(255/255))
    property int scrollBarOrientation    
    property variant parentObj: scrollBar.parent

    property real totalContentHeight: 0
    property real totalContentWidth: 0

    // TODO: Hot zone area size changes from device to device
    property int scrollHotZoneArea: 32
    property int scrollSliderBackAreaSize: 2
    property int scrollSliderSize: 4
    property int scrollHotZone: 10
    property int scrollLimitAreaSize: 6
    property int excludeOffset: 0

    width: (scrollBarOrientation == Qt.Vertical) ? scrollHotZoneArea : (scrollBar.parent.width - scrollLimitAreaSize)
    height: (scrollBarOrientation == Qt.Vertical) ? (scrollBar.parent.height - scrollLimitAreaSize) : scrollHotZoneArea

    Rectangle {
        id: scrollLimitArea

        width: (scrollBarOrientation === Qt.Vertical) ? scrollLimitAreaSize : scrollBar.width
        height: (scrollBarOrientation === Qt.Vertical) ? scrollBar.height : scrollLimitAreaSize
        color: Qt.rgba((255/255),(255/255),(255/255),(255/255))

        Rectangle {
            id: scrollSliderArea

            width: (scrollBarOrientation === Qt.Vertical) ? scrollSliderBackAreaSize : scrollBar.width
            height: (scrollBarOrientation === Qt.Vertical) ? scrollBar.height : scrollSliderBackAreaSize
            color: scrollBarColor
        }
    }

    function setScrollBarSliderPositions () {
        if (scrollBarOrientation == Qt.Vertical) {
            scrollBar.x = (scrollBar.parent.width - scrollHotZoneArea)
            scrollLimitArea.x = scrollHotZoneArea - (scrollBarSlider.width / 2) - scrollSliderSize
            scrollSliderArea.x = (scrollLimitArea.width / 2) - 1
            scrollBarSlider.x = (scrollHotZoneArea - scrollBarSlider.width - 1)
        }
        else {
            scrollBar.y = (scrollBar.parent.height - scrollHotZoneArea)
            scrollLimitArea.y = scrollHotZoneArea  - (scrollBarSlider.height / 2) - scrollSliderSize
            scrollSliderArea.y = (scrollLimitArea.height / 2) - 1
            scrollBarSlider.y = (scrollHotZoneArea - scrollBarSlider.height - 1)
        }
    }

    function positionSlider (scrollPosition, barOrientation) {
        if (barOrientation === Qt.Vertical) {            
            var newSliderPosition = (scrollPosition) / (/*parentObj.contentHeight*/totalContentHeight - scrollBar.height)
            scrollSliderContainer.y = newSliderPosition * (scrollBar.height - scrollBarSlider.height);
        } else {
            var newSliderPosition = (scrollPosition) / (/*parentObj.contentHeight*/totalContentWidth - scrollBar.width)
            scrollSliderContainer.x = newSliderPosition * (scrollBar.width - scrollBarSlider.width);
        }
    }

    function scrollContent () {
        var newContentPos = 0.0
        if (scrollBar.scrollBarOrientation == Qt.Vertical) {

            newContentPos = scrollSliderContainer.y

            // If slider height is limited to 20 px and if slider reaches bottom of scroll bar, use preserved slider height to scroll to end of list,
            if (scrollSliderContainer.y + 20.0 === scrollBar.height) {
                newContentPos = scrollBar.height - scrollBarSlider.sliderActualHeight
            }

            // If slider height is limited to 20 px, recalculate scroll position to unlimited slider's y
            else if (scrollBarSlider.sliderActualHeight <= 20) {

                // Max limited slider y range = 0 to (scrollBar.height - 20px)
                // Calculate % displacement of limited slider in its range
                var sliderDisplacement = (scrollSliderContainer.y /(scrollBar.height - 20.0))

                // Max unlimited slider y range w.r.t limited slider top = 0 to (20 px - preserved height)
                // Relative % displacement of actual height slider in its range is same as that of umlimited slider
                var relativeActualSliderDisplacement = (20.0 - scrollBarSlider.sliderActualHeight) * sliderDisplacement

                // Scroll position = limited slider's y + relative displacement of actual height slider w.r.t limited slider
                newContentPos = scrollSliderContainer.y + relativeActualSliderDisplacement
            }
        }
        else {
            newContentPos = (scrollSliderContainer.x) * (/*scrollBar.parent.contentWidth*/totalContentWidth - scrollBar.parent.width)/(scrollBar.width - scrollSliderContainer.width);
        }

        scrollBar.parent.scrollListView(newContentPos, scrollBar.scrollBarOrientation, parent.currentIndex);
    }

    function resizeScrollBarWidth(nOffSet) {
        if (scrollBar.scrollBarOrientation === Qt.Horizontal) {
            scrollBar.width = scrollBar.width - nOffSet
        }
    }

    //scroll slider
    Item {
        id: scrollSliderContainer

        width: (scrollBarOrientation === Qt.Vertical) ? scrollHotZoneArea : scrollBarSlider.width
        height: (scrollBarOrientation === Qt.Vertical) ? scrollBarSlider.height : scrollHotZoneArea

        Rectangle {
            id: scrollBarSlider

            property int parentContentHeight: totalContentHeight

            // Minimum slider height limited to 20 px.
            // If number of list rows increase such that the slider height decreases below 20, the original height is preserved.
            property real sliderActualHeight: (scrollBarOrientation === Qt.Vertical) ? ((scrollBar.height / (parentContentHeight / scrollBar.height))) : scrollSliderSize

            width: (scrollBarOrientation === Qt.Vertical) ? scrollSliderSize : (scrollBar.width / (totalContentWidth / scrollBar.width))
            height: (scrollBarOrientation === Qt.Vertical) ? ((sliderActualHeight > 20 ) ? (scrollBar.height / (parentContentHeight / (scrollBar.height))) : 20 ) : scrollSliderSize

            color: scrollSliderColor
            radius: 2

            onParentContentHeightChanged: {
                var newSliderHeight = (scrollBar.height / (parentContentHeight / scrollBar.height))
                height = (scrollBarOrientation === Qt.Vertical) ? ((newSliderHeight > 20) ? (scrollBar.height / (parentContentHeight / scrollBar.height)): 20) : parent.height
                scrollBarSlider.sliderActualHeight = newSliderHeight
            }
        }

        MouseArea {
            id: scrollBarSliderArea

            width: (scrollBarOrientation === Qt.Vertical) ? scrollHotZoneArea : parent.width
            height: (scrollBarOrientation === Qt.Vertical) ? parent.height : scrollHotZoneArea

            preventStealing: true

            drag.target: scrollSliderContainer
            drag.axis: (scrollBarOrientation === Qt.Vertical) ? Drag.YAxis : Drag.XAxis
            drag.maximumX: (scrollBarOrientation === Qt.Vertical) ? 0 : (scrollBar.width - scrollBarSlider.width)
            drag.maximumY: (scrollBarOrientation === Qt.Vertical) ? (scrollBar.height - scrollBarSlider.height) :0
            drag.minimumY: 0
            drag.minimumX: 0

            onReleased: {
                if (scrollBarOrientation === Qt.Vertical) {
                    scrollContent ()
                }
                scrollBar.parent.stopEditMode()
            }

            onMouseXChanged: {
                if (scrollBarOrientation !== Qt.Vertical) {
                    scrollContent ()
                }
            }
        }
    }

    // To handle click event above the scrollBarSlider, in the Hot zone
    Item {
        id: scrollBarAbove

        height: (scrollBarOrientation === Qt.Vertical) ? scrollSliderContainer.y : scrollBar.height
        width: (scrollBarOrientation === Qt.Vertical) ? scrollBar.width : scrollSliderContainer.x

        MouseArea {
            height: parent.height
            width: parent.width

            onClicked: {
                if (scrollBarOrientation === Qt.Vertical) {
                    scrollSliderContainer.y = mouse.y
                }
                else {
                    scrollSliderContainer.x = mouse.x
                }
                scrollContent()
            }
        }
    }

    // To handle click event below the scrollBarSlider, in the Hot zone
    Item {
        id: scrollBarBelow

        height: (scrollBarOrientation === Qt.Vertical) ? (scrollBar.height - (scrollSliderContainer.y + scrollBarSlider.height)) : scrollBar.height
        width: (scrollBarOrientation === Qt.Vertical) ? scrollBar.width : (scrollBar.width - (scrollSliderContainer.x + scrollBarSlider.width))

        y: (scrollBarOrientation === Qt.Vertical) ? (scrollSliderContainer.y + scrollBarSlider.height) : 0
        x: (scrollBarOrientation === Qt.Vertical) ? 0 : (scrollSliderContainer.x + scrollBarSlider.width)

        MouseArea {
            height: parent.height
            width: parent.width

            onClicked: {
                // Recalculate scrollSliderContainer.y relative to current vertical slider y position
                if (scrollBarOrientation === Qt.Vertical) {

                    var newY = scrollSliderContainer.y + scrollBarSlider.height + mouse.y
                    var maxY = scrollBar.height - scrollBarSlider.height

                    // Ensure new slider Y position does not exceed total scrollBar height
                    if (newY > maxY)
                        scrollSliderContainer.y = maxY
                    else
                        scrollSliderContainer.y = newY
                }
                // Recalculate scrollSliderContainer.x relative to curent horizontal slider x position
                else {
                    var newX = scrollSliderContainer.x + scrollBarSlider.width + mouse.x
                    var maxX = scrollBar.width - scrollBarSlider.width

                    // Ensure new slider X position does not exceed total scrollBar height
                    if (newX > maxX)
                        scrollSliderContainer.x = maxX
                    else
                        scrollSliderContainer.x = newX
                }
                scrollContent()
            }
        }
    }

    Rectangle {
        id: scrollBarTrailer
        color: "#ffffff"
        x: (scrollBarOrientation === Qt.Vertical) ? scrollBar.width - scrollLimitAreaSize : scrollBar.width
        y: (scrollBarOrientation === Qt.Vertical) ? scrollBar.height : scrollBar.height - scrollLimitAreaSize
        height: scrollLimitAreaSize
        width: scrollLimitAreaSize
    }
    Component.onCompleted: {
        setScrollBarSliderPositions();
    }
}


