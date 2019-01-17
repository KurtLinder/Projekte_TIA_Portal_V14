import QtQuick 2.0

Item
{
SystemPalette {id: palette}
//image and icon sources
property string closeButtonSource: "pics/Kb_ButtonClose_normal.png"
property string clearButtonSource:"pics/Kb_Icon_Clear.png"
property string capsLockButtonSource:"pics/Kb_Icon_CapsLock.png"
property string shiftButtonSource:"pics/Kb_Icon_Shift.png"
property string backspaceButtonSource:"pics/Kb_Icon_Delete.png"
property string eneterButtonSource:"pics/Kb_Icon_Enter.png"
property string leftarrowButtonSource:"pics/Kb_Icon_Left.png"
property string rightarrowButtonSource:"pics/Kb_Icon_Right.png"
property string enterButtonBackgroundImage:"pics/Kb_Enter_normal.png"
property string spaceButtonBackgroundImage:"pics/Kb_Space_normal.png"

//colors
property color textInputSelectedTextColor:"#ffffff"
property color textInputSelectionColor:"#1c1f30"
property color textInputTextColor:"#1c1f30"
property color textInputBorderColor:"#525d62"
property color virtualKeyboardBackground:"#d1d1d1"
property color qVirtualKeyboardBorderColor:"#000000"
property color qTitlebarcolor:"#3e414f"
//  general dimensions
property int qTitlebarHeight:30
property int qTitlebarWidth:30
property int closeButtonHeight:30
property int  closeButtonWidth:30
property int clearButtonHeight:20
property int clearButtonWidth:20
property int textInputFontSize:16
property string textInputFontFamily: "Siemens Sans"
property real textInputRoundness:3
property int textInputRectangleHeight:30
property int qVirtualKeyboardWidth:0
property int qVirtualKeyboardHeight:0
property real qbuttonWidth: 40
property real qbuttonHeight:35
property int qMarginBetweenTitleAndTextInput:38
property int qMarginBetweenTextInputAndButtonLayout:40

// dimensions specific to 4" display

property int fourInch_SoftKeypadHeight:276
property int fourInch_SoftKeypadWidth:480
property int fourInch_buttonWidth: 40
property int fourInch_buttonHeight:43
property int fourInch_PortraitMode_buttonWidth: 39
property int fourInch_PortraitMode_buttonHeight:40
property int fourInch_PortraitMode_buttonWidthForNumericKeypad: 50
property int fourInch_PortraitMode_buttonHeightForNumericKeypad: 40
property int fourInch_buttonWidthForNumericKeypad: 46
property int fourInch_buttonHeightForNumericKeypad:38
property int fourInch_buttonLayoutLeftMargin:70
property int fourInch_buttonLayoutTopMargin:11
property int fourInch_MarginBetweenTextInputAndMaxValue:5

// dimensions specific to 7" & 9" display

property int sevenToNineInch_SoftKeypadHeight:310
property int sevenToNineInch_SoftKeypadWidth:530
property int sevenToNineInch_buttonWidth: 45
property int sevenToNineInch_buttonHeight:45
property int sevenToNineInch_buttonWidthForNumericKeypad: 50
property int sevenToNineInch_buttonHeightForNumericKeypad:40
property int sevenToNineInch_PortraitMode_buttonWidthForNumericKeypad: 57
property int sevenToNineInch_PortraitMode_buttonHeightForNumericKeypad:45
property int sevenToNineInch_titleBarHeight:40
property int sevenToNineInch_textInputRectangleHeight:35
property int sevenToNineInch_closeButtonHeight:40
property int sevenToNineInch_closeButtonWidth:40
property int sevenToNineInch_marginBetweenTitleAndTextInput: 50
property int sevenToNineInch_marginBetweenTextInputAndButtonLayout: 50
property int sevenToNineInch_buttonLayoutLeftMargin:50
property int sevenToNineInch_buttonLayoutTopMargin:12
property int sevenToNineInch_MarginBetweenTextInputAndMaxValue:7

// dimensions specific to 12" display

property int twelveInch_SoftKeypadHeight:368
property int twelveInch_SoftKeypadWidth:588
property int twelveInch_buttonWidth: 50
property int twelveInch_buttonHeight:55
property int twelveInch_PortraitModebuttonWidth: 57
property int twelveInch_PortraitModebuttonHeight:52
property int twelveInch_buttonWidthForNumericKeypad: 61
property int twelveInch_buttonHeightForNumericKeypad:47
property int twelveInch_PortraitMode_buttonWidthForNumericKeypad: 72
property int twelveInch_PortraitMode_buttonHeightForNumericKeypad:54
property int twelveInch_textInputRectangleHeight:44
property int twelveInch_TitlebarHeight: 48
property int twelveInch_closeButtonHeight:48
property int twelveInch_closeButtonWidth:49
property int twelveInch_marginBetweenTitleAndTextInput: 60
property int twelveInch_marginBetweenTextInputAndButtonLayout: 60
property int twelveInch_buttonLayoutLeftMargin:5
property int twelveInch_buttonLayoutTopMargin:15
property int twelveInch_MarginBetweenTextInputAndMaxValue:9
}
