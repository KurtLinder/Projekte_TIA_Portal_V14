import QtQuick 2.0
Item{
    id:qSoftKeypad
    objectName: "qSoftKeypad"

    property Style style : Style { }

    //Initializer Properties
    property string qm_SoftKeypadInputQml:""
    property string qm_SoftKeypadEditString:virtualkeyboard.getIOFieldvalue()
    property bool   qm_SoftKeypadpasswordMode:virtualkeyboard.getPasswordMode()
    property int qm_SoftKeypadMaximumLength:virtualkeyboard.getMaximumLength()
    property int qm_SoftKeypadType: virtualkeyboard.getKeyboardType()
	property int qm_IOFieldType:virtualkeyboard.getIOFieldType()
	property string qm_MaxValue:virtualkeyboard.getMaxValue()
	property string qm_MinValue:virtualkeyboard.getMinValue()
    property string screenSize:virtualkeyboard.getScreenSize()
    property string screenHeight:virtualkeyboard.getScreenHeight()
    property string screenWidth: virtualkeyboard.getScreenWidth()
    property  int qm_SoftKeypadHeight:style.qVirtualKeyboardHeight
    property int qm_SoftKeypadWidth:style.qVirtualKeyboardWidth
    property string layout_mode:virtualkeyboard.getLayoutMode()
    property bool helpConfigured: virtualkeyboard.isHelpConfigured()
    property bool onSimulation: virtualkeyboard.getRotation()
	property string seperatorString: virtualkeyboard.getSeperatorString()
    property bool noRotationRequired: true
    property int qm_textInputRectangleHeight:style.textInputRectangleHeight
    property int qm_marginBetweenTitleAndTextInput:style.qMarginBetweenTitleAndTextInput
    property int qm_marginBetweenTextInputAndButtonLayout:style.qMarginBetweenTextInputAndButtonLayout
    property int qm_closeButtonHeight:style.closeButtonHeight
    property int qm_closeButtonWidth:style.closeButtonWidth
    property int qm_TitlebarHeight:style.qTitlebarHeight
    property real qm_buttonWidth: style.qbuttonWidth
    property real qm_buttonHeight:style.qbuttonHeight
    property real qm_buttonWidthForNumericKeypad: style.qbuttonWidth
    property real qm_buttonHeightForNumericKeypad:style.qbuttonHeight
    property int qm_buttonLayoutTopMargin:0
    property int qm_marginBetweenTextInputAndMaxValue:0
    property int qm_marginBetweenRactangles:0
    //Internal properties
    property variant dynamicComponent: undefined
    property variant dynamicComponentObj: undefined

    property bool landscapeMode: true
    //signal vkenterClicked(string inputText)
   // signal vkescapeClicked()
    height: screenHeight
    width:  screenWidth

    MouseArea
    {
        id:modal
        anchors.fill:parent
	    acceptedButtons: Qt.LeftButton | Qt.RightButton
    }

    function start()
    {
        if(layout_mode === "portrait")
        {
            landscapeMode = false
            if(!onSimulation)
                noRotationRequired = false
        }
        if(qm_SoftKeypadEditString.charAt(0)==="-")
            qm_SoftKeypadMaximumLength+=1

        if(screenSize ==="4")
        {
            qm_SoftKeypadHeight= landscapeMode?style.fourInch_SoftKeypadHeight:style.fourInch_SoftKeypadWidth
            qm_SoftKeypadWidth=landscapeMode?style.fourInch_SoftKeypadWidth:style.fourInch_SoftKeypadHeight
            qm_buttonWidth = landscapeMode?style.fourInch_buttonWidth:style.fourInch_PortraitMode_buttonWidth
            qm_buttonHeight = landscapeMode?style.fourInch_buttonHeight:style.fourInch_PortraitMode_buttonHeight
            qm_buttonWidthForNumericKeypad = landscapeMode?style.fourInch_buttonWidthForNumericKeypad:style.fourInch_PortraitMode_buttonWidthForNumericKeypad
            qm_buttonHeightForNumericKeypad = landscapeMode?style.fourInch_buttonHeightForNumericKeypad:style.fourInch_PortraitMode_buttonHeightForNumericKeypad
            qm_buttonLayoutTopMargin=style.fourInch_buttonLayoutTopMargin
            qm_marginBetweenTextInputAndMaxValue=style.fourInch_MarginBetweenTextInputAndMaxValue
            qm_marginBetweenRactangles=style.fourInch_buttonLayoutLeftMargin
        }
        if(screenSize ==="7" || screenSize ==="9" )
        {
            qm_SoftKeypadHeight=landscapeMode?style.sevenToNineInch_SoftKeypadHeight:style.sevenToNineInch_SoftKeypadWidth
            qm_SoftKeypadWidth=landscapeMode?style.sevenToNineInch_SoftKeypadWidth:style.sevenToNineInch_SoftKeypadHeight
            qm_buttonWidth = style.sevenToNineInch_buttonWidth
            qm_buttonHeight = style.sevenToNineInch_buttonHeight
            qm_TitlebarHeight = style.sevenToNineInch_titleBarHeight
            qm_textInputRectangleHeight =style.sevenToNineInch_textInputRectangleHeight
            qm_closeButtonHeight=style.sevenToNineInch_closeButtonHeight
            qm_closeButtonWidth=style.sevenToNineInch_closeButtonWidth
            qm_marginBetweenTitleAndTextInput = style.sevenToNineInch_marginBetweenTitleAndTextInput
            qm_marginBetweenTextInputAndButtonLayout = style.sevenToNineInch_marginBetweenTextInputAndButtonLayout
            qm_buttonWidthForNumericKeypad = landscapeMode?style.sevenToNineInch_buttonWidthForNumericKeypad:style.sevenToNineInch_PortraitMode_buttonWidthForNumericKeypad
            qm_buttonHeightForNumericKeypad = landscapeMode?style.sevenToNineInch_buttonHeightForNumericKeypad:style.sevenToNineInch_PortraitMode_buttonHeightForNumericKeypad
            qm_buttonLayoutTopMargin=style.sevenToNineInch_buttonLayoutTopMargin
            qm_marginBetweenTextInputAndMaxValue=style.sevenToNineInch_MarginBetweenTextInputAndMaxValue
            qm_marginBetweenRactangles=style.sevenToNineInch_buttonLayoutLeftMargin

        }
        if(screenSize ==="12")
        {
            qm_SoftKeypadHeight=style.twelveInch_SoftKeypadHeight
            qm_SoftKeypadWidth=style.twelveInch_SoftKeypadWidth
            qm_buttonWidth = style.twelveInch_buttonWidth
            qm_buttonHeight =style.twelveInch_buttonHeight
            qm_textInputRectangleHeight =style.twelveInch_textInputRectangleHeight
            qm_TitlebarHeight = style.twelveInch_TitlebarHeight
            qm_closeButtonHeight=style.twelveInch_closeButtonHeight
            qm_closeButtonWidth=style.twelveInch_closeButtonWidth
            qm_marginBetweenTitleAndTextInput = style.twelveInch_marginBetweenTitleAndTextInput
            qm_marginBetweenTextInputAndButtonLayout = style.twelveInch_marginBetweenTextInputAndButtonLayout
            qm_buttonWidthForNumericKeypad = style.twelveInch_buttonWidthForNumericKeypad
            qm_buttonHeightForNumericKeypad = style.twelveInch_buttonHeightForNumericKeypad
            qm_buttonLayoutTopMargin=style.twelveInch_buttonLayoutTopMargin
            qm_marginBetweenTextInputAndMaxValue=style.twelveInch_MarginBetweenTextInputAndMaxValue
            qm_marginBetweenRactangles=style.twelveInch_buttonLayoutLeftMargin
        }
        if(qm_SoftKeypadType === 1 && layout_mode ==="landscape")
        {
            dynamicComponent = Qt.createComponent("KeypadsLayout_4inch_Landscape.qml")
        }
        else if(qm_SoftKeypadType === 2 && layout_mode ==="landscape")
        {
            dynamicComponent = Qt.createComponent("Keypadslayout_4inchl_numerisch.qml")
        }
        else if(qm_SoftKeypadType === 1 && layout_mode ==="portrait")
        {
            if(screenSize ==="12")
                dynamicComponent = Qt.createComponent("KeypadsLayout_4inch_Landscape.qml")
            else
                dynamicComponent = Qt.createComponent("KeypadsLayout_4inch_portrait.qml")
        }
        else if(qm_SoftKeypadType === 2 && layout_mode ==="portrait")
        {
            if(screenSize ==="12")
               dynamicComponent = Qt.createComponent("Keypadslayout_4inchl_numerisch.qml")
            else
                dynamicComponent = Qt.createComponent("Keypadslayout_4inchl_Portrait_numerisch.qml")
        }

        qSoftKeypad.z = 1
        dynamicComponentObj = dynamicComponent.createObject(qSoftKeypad,
                                                          {
                                                              "qm_VirtualKeyboardEditText":qm_SoftKeypadEditString,
                                                              "qm_VirtualKeyboardPasswordMode":qm_SoftKeypadpasswordMode,
                                                              "qm_VirtualKeyboardTextInputmaximumLength":qm_SoftKeypadMaximumLength,
															  "qm_IOFieldType":qm_IOFieldType,
															  "qm_MaxValue":qm_MaxValue,
                                                              "qm_MinValue":qm_MinValue,
                                                              "qVirtualKeyboardWidth":qm_SoftKeypadWidth,
                                                              "qVirtualKeyboardHeight":qm_SoftKeypadHeight,
                                                              "textInputRectangleHeight":qm_textInputRectangleHeight,
                                                              "buttonWidth":qm_buttonWidth,
                                                              "buttonHeight":qm_buttonHeight,
                                                              "qTitlebarHeight":qm_TitlebarHeight,
                                                              "closeButtonHeight":qm_closeButtonHeight,
                                                              "closeButtonWidth":qm_closeButtonWidth,
                                                              "qm_marginBetweenTextInputAndButtonLayout":qm_marginBetweenTextInputAndButtonLayout,
                                                              "qm_marginBetweenTitleAndTextInput":qm_marginBetweenTitleAndTextInput,
                                                              "x":(screenWidth-qm_SoftKeypadWidth)/2,
                                                              "y":(screenHeight- qm_SoftKeypadHeight)/2,
                                                              "buttonHeight_N":qm_buttonHeightForNumericKeypad,
                                                              "buttonWidth_N":qm_buttonWidthForNumericKeypad,
                                                              "qm_buttonLayoutTopMargin":qm_buttonLayoutTopMargin,
                                                              "qm_marginBetweenTextInputAndMaxValue":qm_marginBetweenTextInputAndMaxValue,
                                                              "qm_marginBetweenRactangles":qm_marginBetweenRactangles,
                                                              "qm_KeyPadInlandscapeMode":noRotationRequired,
                                                              "qm_ScreenSize":screenSize,
                                                              "qm_HelpConfigured": helpConfigured,
                                                              "qm_screenWidth":screenWidth,
                                                              "qm_screenHeight":screenHeight,
															  "qm_seperatorString":seperatorString
                                                          })
        dynamicComponentObj.enterClicked.connect(onenterClicked)
        dynamicComponentObj.escapeClicked.connect(onescapeClicked)
		dynamicComponentObj.helpClicked.connect(onhelpClicked)
        dynamicComponentObj.keyPressed.connect(onkeyPressed)
        }

    function onenterClicked(inputText)
    {
        virtualkeyboard.slot_enterClicked(inputText)
        dynamicComponentObj.destroy()
        dynamicComponentObj = undefined
        dynamicComponent.destroy()
        dynamicComponent = undefined
    }

    function onescapeClicked()
    {
        virtualkeyboard.slot_escapeClicked()
        dynamicComponentObj.destroy()
        dynamicComponentObj = undefined
        dynamicComponent.destroy()
        dynamicComponent = undefined
    }
	
	function onhelpClicked()
    {
       virtualkeyboard.slot_helpClicked()
       dynamicComponentObj.destroy()
       dynamicComponentObj = undefined
       dynamicComponent.destroy()
       dynamicComponent = undefined
    }
    function onkeyPressed()
    {
        virtualkeyboard.slot_keyPressed()
    }
    Component.onCompleted: {start()}
}
