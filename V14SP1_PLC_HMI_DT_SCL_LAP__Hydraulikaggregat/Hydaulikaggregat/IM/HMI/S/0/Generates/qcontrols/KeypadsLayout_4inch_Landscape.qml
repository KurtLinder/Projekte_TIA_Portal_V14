import QtQuick 2.0
import "KeypadsLayout_4inch_Landscape.js" as Keyboard

Rectangle
{
    id: qVirtualKeyboard

    property Style style : Style { }

    //properties being used outside this file
    property bool qm_VirtualKeyboardPasswordMode: false
    property bool qm_HelpConfigured: false
    property string qm_VirtualKeyboardEditText: ""
	property int qm_VirtualKeyboardTextInputmaximumLength :0
    property bool qm_KeyPadInlandscapeMode:false
    property string qm_ScreenSize:""
    property int qm_screenWidth:0
    property int qm_screenHeight:0

    //properties being used locally
	property bool capsOn: false
    property bool shiftOn: false
    property bool numberOn: false
    property int qVirtualKeyboardWidth:480
    property int qVirtualKeyboardHeight:282
    property color qVirtualKeyboardBorderColor:style.qVirtualKeyboardBorderColor
    property int qTitlebarHeight:style.qTitlebarHeight
    property int qTitlebarWidth: style.qTitlebarWidth
    property color qTitlebarcolor:style.qTitlebarcolor
    property real buttonWidth: (qVirtualKeyboard.width-80)/10
    property real buttonHeight:(qVirtualKeyboard.height+118)/10
    property int closeButtonHeight:style.closeButtonHeight
    property int  closeButtonWidth:style.closeButtonWidth
    property int clearButtonHeight:style.clearButtonHeight
    property int clearButtonWidth:style.clearButtonWidth
    property int textInputFontSize:style.textInputFontSize
    property string textInputFontFamily:style.textInputFontFamily
    property real textInputRoundness:style.textInputRoundness
    property int textInputRectangleHeight:style.textInputRectangleHeight
    property int textInputRectangleWidth:qVirtualKeyboard.width-60
    property int textInputWidth:textInputRectangleWidth-35
    property int buttonSpacing:6
    property int qm_marginBetweenTitleAndTextInput:42
    property int qm_marginBetweenTextInputAndButtonLayout:48
    property string specialkeysymbol1:"^"+"\\"+"\""
    property string specialkeysymbol2:"#+$"

    //image sources
    property string closeButtonSource: style.closeButtonSource
    property string clearButtonSource:style.clearButtonSource
    property string capsLockButtonSource:style.capsLockButtonSource
    property string shiftButtonSource:style.shiftButtonSource
    property string backspaceButtonSource:style.backspaceButtonSource
    property string eneterButtonSource:style.eneterButtonSource
    property string leftarrowButtonSource:style.leftarrowButtonSource
    property string rightarrowButtonSource:style.rightarrowButtonSource
    property string enterButtonBackgroundImage:style.enterButtonBackgroundImage
    property string spaceButtonBackgroundImage:style.spaceButtonBackgroundImage

    //colors
    property color textInputSelectedTextColor:style.textInputSelectedTextColor
    property color textInputSelectionColor:style.textInputSelectionColor
    property color textInputTextColor:style.textInputTextColor
    property color textInputBorderColor:style.textInputBorderColor
//    property Gradient gradientDefault: Gradient {
//                                                    GradientStop { position: 0; color: "#fafafa" }
//                                                    GradientStop { position: 1; color: "#d8d8d8" }
//                                                }

    signal enterClicked(string inputText);
    signal escapeClicked();
    signal helpClicked();
	signal keyPressed();

        //change the "123" button text as "ABC" when it's clicked and
        //numeric keypad is displayed and vice versa too
        function showNumbersOrCharacters(buttonText)
        {
            keyPressed();
            if(buttonText ==="123")
            {
                numberOn = true
                row4.children[2].text = "ABC"
                row3.children[0].text = specialkeysymbol1
                row3.children[0].icon = ""
                row3.children[8].icon = ""
                changeCharacters(Keyboard.numbers)
            }
            else if(buttonText ==="ABC")
            {
                numberOn = false
                row4.children[2].text = "123"
                row3.children[0].text = ""
                row3.children[8].text = ""
                row3.children[0].icon = capsLockButtonSource
                row3.children[8].icon = shiftButtonSource
                changeCharacters(Keyboard.alphabet)
            }
            else if(buttonText === specialkeysymbol1)
            {
                row3.children[0].text = specialkeysymbol2
                changeSpecialCharacters(27)
            }
            else if(buttonText === specialkeysymbol2)
            {
                row3.children[0].text = specialkeysymbol1
                changeSpecialCharacters(10)
            }

        }

		//change the text of the buttons to numbers or characters 
        function changeCharacters(characters)
        {
            for (var firstrowindex=0; firstrowindex<row1.children.length; firstrowindex++)
            {
                row1.children[firstrowindex].value = characters[firstrowindex];
			}

            //for setting the value for the 1st button in clo3 ex:- p or 9
			col3.children[0].value = characters[9]

            for(var secondrowindex=0; secondrowindex<row2.children.length; secondrowindex++)
            {
                row2.children[secondrowindex].value = characters[Keyboard.row1Length+secondrowindex];
			}

            //(row3.children.length-2):last child of row3 is a shift button which has image, so setting the value for that button is not needed
            //(row3.children[thirdrowindex+1]):first child of row3 is capslock button which also has its own image, skip that button
            for(var thirdrowindex=0; thirdrowindex<row3.children.length-2; thirdrowindex++)
            {
                row3.children[thirdrowindex+1].value = characters[Keyboard.row1Length+Keyboard.row2Length+thirdrowindex];
			}
            row3.children[8].text = numberOn?characters[26]:"";
		}
        //change the special characters after clicking on the specail character symbol key
        function changeSpecialCharacters(startindex)
        {
            for(var rowindex=0; rowindex<row2.children.length; rowindex++)
            {
                row2.children[rowindex].value = Keyboard.numbers[startindex+rowindex];
            }
			row3.children[1].value = Keyboard.numbers[startindex+9];
        }

		//set the text of the InputField after button click
        function keyboardButtonClicked(character)
        {
            keyPressed();
            if(shiftOn)
			{
                shiftOn = false
			}

            //when input field value is selected
            if(qVirtualKeyboardTextInput.selectedText)
            {
                selectedTextHandling()
            }
            var preCursorSubstring = qVirtualKeyboardTextInput.text.substring(0,qVirtualKeyboardTextInput.cursorPosition)
            var postCursorSubstring = qVirtualKeyboardTextInput.text.substring(qVirtualKeyboardTextInput.cursorPosition, qVirtualKeyboardTextInput.text.length)
            if((preCursorSubstring+postCursorSubstring).length< qm_VirtualKeyboardTextInputmaximumLength)
            {
                qVirtualKeyboardTextInput.insert(preCursorSubstring.length,character)
                qVirtualKeyboardTextInput.cursorPosition = preCursorSubstring.length+1
            }
		}

		//space button click function
        function spaceButtonClicked()
        {
            keyPressed();
             //when input field value is selected
            if(qVirtualKeyboardTextInput.selectedText)
            {
                selectedTextHandling()
            }
            var preCursorSubstring = qVirtualKeyboardTextInput.text.substring(0,qVirtualKeyboardTextInput.cursorPosition)
            var postCursorSubstring = qVirtualKeyboardTextInput.text.substring(qVirtualKeyboardTextInput.cursorPosition, qVirtualKeyboardTextInput.text.length)
            qVirtualKeyboardTextInput.text = preCursorSubstring.concat(" ").concat(postCursorSubstring)
            qVirtualKeyboardTextInput.cursorPosition = preCursorSubstring.length+1
		}

		//backspace button click function
        function backspaceButtonClicked()
        {
            //when input fiels is empty
            if(qVirtualKeyboardTextInput.text==="")
                return

            //when input field value is selected
            if(qVirtualKeyboardTextInput.selectedText)
            {
                selectedTextHandling()
            }
            else
            {
            var preCursorSubstring = qVirtualKeyboardTextInput.text.substring(0,qVirtualKeyboardTextInput.cursorPosition-1)
            qVirtualKeyboardTextInput.text = preCursorSubstring+qVirtualKeyboardTextInput.text.substring(qVirtualKeyboardTextInput.cursorPosition,qVirtualKeyboardTextInput.text.length)
            qVirtualKeyboardTextInput.cursorPosition=preCursorSubstring.length
            }
		}

        //delete button click function
        function deleteButtonClicked()
        {
            //when input fiels is empty
            if(qVirtualKeyboardTextInput.text==="")
                return

            //when input field value is selected
            if(qVirtualKeyboardTextInput.selectedText)
            {
                selectedTextHandling()
            }
            else
            {
                var preCursorSubstring = qVirtualKeyboardTextInput.text.substring(0,qVirtualKeyboardTextInput.cursorPosition)
                var postCursorSubstring = qVirtualKeyboardTextInput.text.substring(qVirtualKeyboardTextInput.cursorPosition+1, qVirtualKeyboardTextInput.text.length)
                qVirtualKeyboardTextInput.text = preCursorSubstring+postCursorSubstring
                qVirtualKeyboardTextInput.cursorPosition=preCursorSubstring.length
            }
		}

		//capsLock button click
        function capsLockButtonClicked()
        {
            keyPressed();
			if(shiftOn && !capsOn)
            {
                shiftOn = false
            }
            else if(capsOn)
			{
				capsOn = false
			}
			else
			{
				capsOn = true
			}
		}

		//shift button  click
        function shiftButtonClicked()
        {
            keyPressed();
            if(shiftOn)
			{
                shiftOn = false
			}
			else
			{
                shiftOn = true
			}

		}

		//left arrow click
        function leftarrowButtonclicked()
        {
            keyPressed();
              //when input fiels is empty
            if(qVirtualKeyboardTextInput.text==="")
                return

             //when input field value is selected
            if(qVirtualKeyboardTextInput.selectedText)
            {
                qVirtualKeyboardTextInput.cursorPosition = qVirtualKeyboardTextInput.selectionStart
            }
             else
                qVirtualKeyboardTextInput.cursorPosition=qVirtualKeyboardTextInput.cursorPosition-1
		}

		//right arrow click
        function rightarrowButtonclicked()
        {
            keyPressed();
              //when input fiels is empty
            if(qVirtualKeyboardTextInput.text==="")
                return

             //when input field value is selected
            if(qVirtualKeyboardTextInput.selectedText)
            {
                qVirtualKeyboardTextInput.cursorPosition = qVirtualKeyboardTextInput.selectionEnd
            }
            else
                qVirtualKeyboardTextInput.cursorPosition=qVirtualKeyboardTextInput.cursorPosition+1
		}

        function selectedTextHandling()
        {
                if(qVirtualKeyboardTextInput.cursorPosition === qVirtualKeyboardTextInput.text.length)
                    qVirtualKeyboardTextInput.text = qVirtualKeyboardTextInput.text.slice(0,qVirtualKeyboardTextInput.selectionStart)
                else if(qVirtualKeyboardTextInput.cursorPosition === 0)
                {
                    qVirtualKeyboardTextInput.text = qVirtualKeyboardTextInput.text.slice(qVirtualKeyboardTextInput.selectionEnd,qVirtualKeyboardTextInput.text.length)
                    qVirtualKeyboardTextInput.cursorPosition=0
                }
                else
                {
                    var preSelectedSubstring = qVirtualKeyboardTextInput.text.substring(0,qVirtualKeyboardTextInput.selectionStart)
                    var postSelectedSubstring = qVirtualKeyboardTextInput.text.substring(qVirtualKeyboardTextInput.selectionEnd, qVirtualKeyboardTextInput.text.length)
                    qVirtualKeyboardTextInput.text = preSelectedSubstring+postSelectedSubstring
                    qVirtualKeyboardTextInput.cursorPosition=preSelectedSubstring.length
                }
        }

        width: qVirtualKeyboardWidth ;
        height: qVirtualKeyboardHeight;
        border.color: qVirtualKeyboardBorderColor;
        color:style.virtualKeyboardBackground
        rotation:qm_KeyPadInlandscapeMode?0:90

        Item
        {
            id: qMainLayout
            anchors.fill: parent
            Rectangle
            {
                id:qTitlebar
                width:qVirtualKeyboard.width
                height:qTitlebarHeight
                color: qTitlebarcolor
                anchors.bottomMargin: qVirtualKeyboard.height-1
                //for moving the window by click and drag
                MouseArea
                {
                    id: movingRegion
					anchors.fill: parent
                    width: qm_KeyPadInlandscapeMode?qm_screenWidth:qm_screenHeight
                    height: qm_KeyPadInlandscapeMode?qm_screenHeight:qm_screenWidth
                    drag.target: qVirtualKeyboard
                    drag.axis: Drag.XandYAxis
                    drag.minimumX: qm_KeyPadInlandscapeMode?0:-110
                    drag.minimumY: qm_KeyPadInlandscapeMode?0:100
                    drag.maximumY: qm_KeyPadInlandscapeMode?qm_screenHeight-qVirtualKeyboardHeight:(qm_screenHeight-qVirtualKeyboardWidth)+110
                    drag.maximumX: qm_KeyPadInlandscapeMode?qm_screenWidth-qVirtualKeyboardWidth:(qm_screenWidth-qVirtualKeyboardHeight)-110
                }

                Image
                {
                    id: closeButton
                    source: closeButtonSource
                    height: closeButtonHeight
                    width: closeButtonWidth
                    anchors.right:parent.right
                    MouseArea
                    {
                        id: closemouseArea
                        anchors.fill: parent
                        onClicked:  escapeClicked();

                    }
                }
            }
            Item
            {
                id: col1;
                anchors
                {
                    fill: parent;
                    topMargin: qm_marginBetweenTitleAndTextInput;
                    bottomMargin: buttonSpacing;
                    leftMargin: buttonSpacing;
                    rightMargin: buttonSpacing
                }
                Rectangle
                {
                    border.color: textInputBorderColor
                    width: textInputRectangleWidth
                    height:textInputRectangleHeight
                    anchors.horizontalCenter: parent.horizontalCenter
                    radius: textInputRoundness
                    TextInput
                    {
                        id:qVirtualKeyboardTextInput
						objectName: "qVirtualKeyboardTextInput"
                        text:qm_VirtualKeyboardEditText
						validator: RegExpValidator { regExp: /[+0-9A-Za-z-@(),.*/\\;:"=_\s\[\]#$%^&!<>|\x20AC]+/ }
                        passwordCharacter: "*"
                        echoMode: qm_VirtualKeyboardPasswordMode?TextInput.Password:TextInput.Normal
						maximumLength: qm_VirtualKeyboardTextInputmaximumLength
                        font.pixelSize: textInputFontSize
                        font.family: textInputFontFamily
                        width:textInputWidth
                        focus:true
                        selectByMouse: true
                        selectedTextColor: textInputSelectedTextColor
                        selectionColor: textInputSelectionColor
                        color:textInputTextColor
                        font.bold: false
                        clip: true
                        onFocusChanged: forceActiveFocus()
                        anchors
                        {
                            fill:parent.Center
                            left: parent.left;
                            verticalCenter: parent.verticalCenter;
                            verticalCenterOffset: -1
                            leftMargin: buttonSpacing;
                        }
                        Keys.onPressed:
                        {
							keyPressed()
                            if (event.key === Qt.Key_CapsLock)
                            {
                                capsLockButtonClicked()
                                event.accepted = true
                            }
                            if(event.key === Qt.Key_Escape)
                            {
                                escapeClicked(false)
                                event.accepted = true
                            }
                            if(event.key === Qt.Key_Return)
                            {
                                enterClicked(qVirtualKeyboardTextInput.text)
                                event.accepted = true
                            }
							if(event.key === Qt.Key_Enter)
                            {
                                enterClicked(qVirtualKeyboardTextInput.text)
                                event.accepted = true
                            }
                            if(event.key === Qt.Key_Shift && event.modifiers)
                            {
                                shiftButtonClicked()
                                event.accepted = true
                            }
                            else if ((event.key >= Qt.Key_F1) && (event.key <= Qt.Key_F35))
                            {
                               var isCtrlPressed = (event.modifiers & Qt.ControlModifier)
                               var isAltPressed = (event.modifiers & Qt.AltModifier)
			       if(NULL != proxy)
                               	proxy.keyHandler(0,event.key, true, event.text, event.isAutoRepeat, isAltPressed, isCtrlPressed);
                               event.accepted = true
                            }
                        }
                        Keys.onReleased:
                        {
                            if(event.key === Qt.Key_Shift)
                            {
                                shiftButtonClicked()
                                event.accepted = true
                            }
                            else if((event.key >= Qt.Key_F1) && (event.key <= Qt.Key_F35))
                            {
				if(NULL != proxy)
                                	proxy.keyHandler(0,event.key, false, event.text, event.isAutoRepeat);
                                event.accepted = true
                            }
                        }
						// function for GoToHome and GoToEnd event
						function setCursorValue(value)
                        {
                            if(value > qVirtualKeyboardTextInput.text.length)
                                qVirtualKeyboardTextInput.cursorPosition = qVirtualKeyboardTextInput.text.length
                            else
                                qVirtualKeyboardTextInput.cursorPosition = value
                        }
                    }
                    Image
                    {
                        id: clear_img
                        source:clearButtonSource
                        anchors
                        {
                            right: parent.right
                            verticalCenter: parent.verticalCenter
                            rightMargin: buttonSpacing
                        }
                        height:clearButtonHeight
                        width:clearButtonWidth
                        MouseArea
                        {
                            id: clearmouseArea
                            anchors.fill: parent
                            onClicked:qVirtualKeyboardTextInput.text = ""

                        }
                    }
                }

                Row{
                        id:row
                        spacing:buttonSpacing
                        anchors
                        {
                            fill:parent;
                            topMargin: qm_marginBetweenTextInputAndButtonLayout;
                            leftMargin:buttonSpacing;
                            rightMargin:buttonSpacing
                        }
                        Column
                        {
                            id:col2
                            spacing:buttonSpacing
                            Row
                            {
                                id:row1
                                spacing:buttonSpacing
                                Button{objectName:"ButtonAL_"+Keyboard.alphabet[0];width:buttonWidth; height:buttonHeight; text:shiftOn ^ capsOn?value:value.toLowerCase(); value:Keyboard.alphabet[0]; onClicked:keyboardButtonClicked(text) }
                                Button{objectName:"ButtonAL_"+Keyboard.alphabet[1];width:buttonWidth; height:buttonHeight; text:shiftOn ^capsOn?value:value.toLowerCase(); value:Keyboard.alphabet[1]; onClicked:keyboardButtonClicked(text)}
                                Button{objectName:"ButtonAL_"+Keyboard.alphabet[2];width:buttonWidth; height:buttonHeight; text:shiftOn ^capsOn?value:value.toLowerCase(); value:Keyboard.alphabet[2]; onClicked:keyboardButtonClicked(text)}
                                Button{objectName:"ButtonAL_"+Keyboard.alphabet[3];width:buttonWidth; height:buttonHeight; text:shiftOn ^capsOn?value:value.toLowerCase(); value:Keyboard.alphabet[3]; onClicked:keyboardButtonClicked(text)}
                                Button{objectName:"ButtonAL_"+Keyboard.alphabet[4];width:buttonWidth; height:buttonHeight; text:shiftOn ^capsOn?value:value.toLowerCase(); value:Keyboard.alphabet[4]; onClicked:keyboardButtonClicked(text)}
                                Button{objectName:"ButtonAL_"+Keyboard.alphabet[5];width:buttonWidth; height:buttonHeight; text:shiftOn ^capsOn?value:value.toLowerCase(); value:Keyboard.alphabet[5]; onClicked:keyboardButtonClicked(text)}
                                Button{objectName:"ButtonAL_"+Keyboard.alphabet[6];width:buttonWidth; height:buttonHeight; text:shiftOn ^capsOn?value:value.toLowerCase(); value:Keyboard.alphabet[6]; onClicked:keyboardButtonClicked(text)}
                                Button{objectName:"ButtonAL_"+Keyboard.alphabet[7];width:buttonWidth; height:buttonHeight; text:shiftOn ^capsOn?value:value.toLowerCase(); value:Keyboard.alphabet[7]; onClicked:keyboardButtonClicked(text)}
                                Button{objectName:"ButtonAL_"+Keyboard.alphabet[8];width:buttonWidth; height:buttonHeight; text:shiftOn ^capsOn?value:value.toLowerCase(); value:Keyboard.alphabet[8]; onClicked:keyboardButtonClicked(text)}
                            }


                            Row
                            {
                                id:row2
                                spacing:buttonSpacing
                                Button{objectName:"ButtonAL_"+Keyboard.alphabet[10];width:buttonWidth; height:buttonHeight; text:shiftOn ^capsOn?value:value.toLowerCase(); value:Keyboard.alphabet[10]; onClicked:keyboardButtonClicked(text)}
                                Button{objectName:"ButtonAL_"+Keyboard.alphabet[11];width:buttonWidth; height:buttonHeight; text:shiftOn ^capsOn?value:value.toLowerCase(); value:Keyboard.alphabet[11]; onClicked:keyboardButtonClicked(text)}
                                Button{objectName:"ButtonAL_"+Keyboard.alphabet[12];width:buttonWidth; height:buttonHeight; text:shiftOn ^capsOn?value:value.toLowerCase(); value:Keyboard.alphabet[12]; onClicked:keyboardButtonClicked(text)}
                                Button{objectName:"ButtonAL_"+Keyboard.alphabet[13];width:buttonWidth; height:buttonHeight; text:shiftOn ^capsOn?value:value.toLowerCase(); value:Keyboard.alphabet[13]; onClicked:keyboardButtonClicked(text)}
                                Button{objectName:"ButtonAL_"+Keyboard.alphabet[14];width:buttonWidth; height:buttonHeight; text:shiftOn ^capsOn?value:value.toLowerCase(); value:Keyboard.alphabet[14]; onClicked:keyboardButtonClicked(text)}
                                Button{objectName:"ButtonAL_"+Keyboard.alphabet[15];width:buttonWidth; height:buttonHeight; text:shiftOn ^capsOn?value:value.toLowerCase(); value:Keyboard.alphabet[15]; onClicked:keyboardButtonClicked(text)}
                                Button{objectName:"ButtonAL_"+Keyboard.alphabet[16];width:buttonWidth; height:buttonHeight; text:shiftOn ^capsOn?value:value.toLowerCase(); value:Keyboard.alphabet[16]; onClicked:keyboardButtonClicked(text)}
                                Button{objectName:"ButtonAL_"+Keyboard.alphabet[17];width:buttonWidth; height:buttonHeight; text:shiftOn ^capsOn?value:value.toLowerCase(); value:Keyboard.alphabet[17]; onClicked:keyboardButtonClicked(text)}
                                Button{objectName:"ButtonAL_"+Keyboard.alphabet[18];width:buttonWidth; height:buttonHeight; text:shiftOn ^capsOn?value:value.toLowerCase(); value:Keyboard.alphabet[18]; onClicked:keyboardButtonClicked(text)}
                            }

                            Row
                            {
                                id:row3
                                spacing:buttonSpacing
                                Button{objectName:"ButtonAL_CapsLock";width:buttonWidth; height:buttonHeight;icon:capsLockButtonSource; onClicked:{numberOn? showNumbersOrCharacters(text):capsLockButtonClicked();}}
                                Button{objectName:"ButtonAL_"+Keyboard.alphabet[19];width:buttonWidth; height:buttonHeight; text:shiftOn ^capsOn?value:value.toLowerCase(); value:Keyboard.alphabet[19]; onClicked:keyboardButtonClicked(text)}
                                Button{objectName:"ButtonAL_"+Keyboard.alphabet[20];width:buttonWidth; height:buttonHeight; text:shiftOn ^capsOn?value:value.toLowerCase(); value:Keyboard.alphabet[20]; onClicked:keyboardButtonClicked(text)}
                                Button{objectName:"ButtonAL_"+Keyboard.alphabet[21];width:buttonWidth; height:buttonHeight; text:shiftOn ^capsOn?value:value.toLowerCase(); value:Keyboard.alphabet[21]; onClicked:keyboardButtonClicked(text)}
                                Button{objectName:"ButtonAL_"+Keyboard.alphabet[22];width:buttonWidth; height:buttonHeight; text:shiftOn ^capsOn?value:value.toLowerCase(); value:Keyboard.alphabet[22]; onClicked:keyboardButtonClicked(text)}
                                Button{objectName:"ButtonAL_"+Keyboard.alphabet[23];width:buttonWidth; height:buttonHeight; text:shiftOn ^capsOn?value:value.toLowerCase(); value:Keyboard.alphabet[23]; onClicked:keyboardButtonClicked(text)}
                                Button{objectName:"ButtonAL_"+Keyboard.alphabet[24];width:buttonWidth; height:buttonHeight; text:shiftOn ^capsOn?value:value.toLowerCase(); value:Keyboard.alphabet[24]; onClicked:keyboardButtonClicked(text)}
                                Button{objectName:"ButtonAL_"+Keyboard.alphabet[25];width:buttonWidth; height:buttonHeight; text:shiftOn ^capsOn?value:value.toLowerCase(); value:Keyboard.alphabet[25]; onClicked:keyboardButtonClicked(text)}
                                Button{objectName:"ButtonAL_Shift";width:buttonWidth; height:buttonHeight; icon: shiftButtonSource;onClicked: {numberOn?keyboardButtonClicked(text):shiftButtonClicked();}}

                            }
                            Row
                            {
                                id:row4
                                spacing:buttonSpacing
                                Button{objectName:"ButtonAL_Del";width:buttonWidth; height:buttonHeight; text:"Del"; onClicked: {keyPressed();deleteButtonClicked()}}
                                Button{objectName:"ButtonAL_Esc";width:buttonWidth; height:buttonHeight; text:"Esc"; onClicked: escapeClicked();}
                                Button{objectName:"ButtonAL_123";width:buttonWidth; height:buttonHeight; text:"123"; onClicked: showNumbersOrCharacters(text);}
                                Button{objectName:"ButtonAL_Space";width:buttonWidth*3+12; height:buttonHeight; text:""; backgroundImagePath: spaceButtonBackgroundImage;onClicked:spaceButtonClicked()}
                                Button{objectName:"ButtonAL_Help";width:buttonWidth; height:buttonHeight; text:"Help"; enabled: qm_HelpConfigured; disabled: !qm_HelpConfigured; onClicked: helpClicked()}
                                Button{objectName:"ButtonAL_LeftArrow";width:buttonWidth; height:buttonHeight; icon:leftarrowButtonSource;onClicked: leftarrowButtonclicked()}
                                Button{objectName:"ButtonAL_RightArrow";width:buttonWidth; height:buttonHeight;icon:rightarrowButtonSource;onClicked: rightarrowButtonclicked()}
                            }
                        }

                        Column
                        {
                            id:col3
                            spacing:buttonSpacing
                            Button{objectName:"ButtonAL_"+Keyboard.alphabet[9];width:buttonWidth; height:buttonHeight; text:shiftOn ^capsOn?value:value.toLowerCase(); value:Keyboard.alphabet[9]; onClicked:keyboardButtonClicked(text)}
                            Button{objectName:"ButtonAL_Backspace";width:buttonWidth; height:buttonHeight; icon:backspaceButtonSource;onClicked:{keyPressed(); backspaceButtonClicked();}}
                            Button{objectName:"ButtonAL_Enter";width:buttonWidth; height:buttonHeight*2+6; backgroundImagePath:enterButtonBackgroundImage;icon:eneterButtonSource;onClicked: enterClicked(qVirtualKeyboardTextInput.text)}
                        }

                    }
            }
        }

        Component.onCompleted:
        {
            qVirtualKeyboardTextInput.forceActiveFocus()
            qVirtualKeyboardTextInput.selectAll()
        }
}
