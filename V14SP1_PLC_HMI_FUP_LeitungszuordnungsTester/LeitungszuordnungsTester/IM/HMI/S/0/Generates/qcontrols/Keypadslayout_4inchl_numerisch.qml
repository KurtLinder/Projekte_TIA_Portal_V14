import QtQuick 2.0
import "KeypadsLayout_4inch_Landscape.js" as Keyboard

Rectangle
{
	id: qVirtualKeyboard

    property Style style : Style { }

	//properties being used outside this file
	property bool qm_VirtualKeyboardPasswordMode: false
    property bool qm_HelpConfigured: true
	property string qm_VirtualKeyboardEditText: ""
	property int qm_VirtualKeyboardTextInputmaximumLength :0
	property int qm_IOFieldType:0
	property string qm_MaxValue:""
	property string qm_MinValue:""
    property int qm_buttonLayoutTopMargin:0
    property int qm_marginBetweenTextInputAndMaxValue:0
    property int qm_marginBetweenRactangles:0
    property bool qm_KeyPadInlandscapeMode:false
    property string qm_ScreenSize:""
    property string qm_seperatorString:""
    property int qm_screenWidth:0
    property int qm_screenHeight:0

	//properties being used locally
	property bool capsOn: false
	property bool shiftOn: false
	property bool shiftwithcaps: false
    property bool minValuevisibility:false
    property bool maxValuevisibility:false
    property bool decimalPointAllowed: false
	property int qVirtualKeyboardWidth:480
	property int qVirtualKeyboardHeight:282
    property color qVirtualKeyboardBorderColor:style.qVirtualKeyboardBorderColor
    property int qTitlebarHeight:style.qTitlebarHeight
    property int qTitlebarWidth: style.qTitlebarWidth
    property color qTitlebarcolor:style.qTitlebarcolor
    property real buttonWidth_N: (qVirtualKeyboard.width-40)/10
    property real buttonHeight_N:(qVirtualKeyboard.height+78)/10
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
    property int leftMargin:15
    property int counterforToggleButton: 0;

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

    //properties for disabling and enabling the buttons based on the type of IOField
    property bool binaryIOField:false
    property bool decimalIOField:false
    property bool hexadecimalIOField:false
    property bool signedValuePresent: false
    property bool macIoField:false
    //colors
    property color textInputSelectedTextColor:style.textInputSelectedTextColor
    property color textInputSelectionColor:style.textInputSelectionColor
    property color textInputTextColor:style.textInputTextColor
    property color textInputBorderColor:style.textInputBorderColor

	signal enterClicked(string inputText);
	signal escapeClicked();
	signal helpClicked();
	signal keyPressed();

	function keyboardButtonClicked(character)
	{

        keyPressed();
        counterforToggleButton =0;
        if(character !=="")
        {
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

	}
	//backspace button click function
	function backspaceButtonClicked()
	{
		//when input fiels is empty
		if(qVirtualKeyboardTextInput.text==="")
			return
        if(qVirtualKeyboardTextInput.text.charAt(0)==="-" &&qVirtualKeyboardTextInput.cursorPosition ==1 && !macIoField)
        {
            toggleButtonClicked()
            qVirtualKeyboardTextInput.cursorPosition=0
            return
        }

		//when input field value is selected
		if(qVirtualKeyboardTextInput.selectedText)
		{
			selectedTextHandling()
		}
		else
		{
            var preCursorSubstring = qVirtualKeyboardTextInput.text.substring(0,qVirtualKeyboardTextInput.cursorPosition-1)
            qVirtualKeyboardTextInput.text = preCursorSubstring+qVirtualKeyboardTextInput.text.substring(qVirtualKeyboardTextInput.cursorPosition,qVirtualKeyboardTextInput.text.length)
            if(counterforToggleButton)
            {
                qm_VirtualKeyboardTextInputmaximumLength-=1
                signedValuePresent = false
                counterforToggleButton--
            }
              if(preCursorSubstring === "-" && !macIoField)
            {
                counterforToggleButton++
            }
            qVirtualKeyboardTextInput.cursorPosition=preCursorSubstring.length
		}
	}

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
            if(qVirtualKeyboardTextInput.text.charAt(preCursorSubstring.length) ==="-" && !macIoField)
            {
                qm_VirtualKeyboardTextInputmaximumLength-=1
                signedValuePresent = false
            }
			qVirtualKeyboardTextInput.text = preCursorSubstring+postCursorSubstring
			qVirtualKeyboardTextInput.cursorPosition=preCursorSubstring.length
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
	function homeClicked()
	{
        keyPressed();
		qVirtualKeyboardTextInput.cursorPosition = 0
	}
	function endClicked()
	{
        keyPressed();
		qVirtualKeyboardTextInput.cursorPosition = qVirtualKeyboardTextInput.text.length
	}
	function selectedTextHandling()
	{
        var texthasnegativeSign = false
        if(qVirtualKeyboardTextInput.text.charAt(0) === "-" && !macIoField)
        {
            texthasnegativeSign = true
        }
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
        signedValuePresent = texthasnegativeSign
	}
    function toggleButtonClicked()
    {
        if(macIoField)
        {
            keyboardButtonClicked("-")
        }
        else
        {
			if(qVirtualKeyboardTextInput.text.charAt(0) === "-")
			{
				qVirtualKeyboardTextInput.remove(0,1)
				//qVirtualKeyboardTextInput.insert(0,"+")
				qVirtualKeyboardTextInput.cursorPosition=qVirtualKeyboardTextInput.text.length
				qm_VirtualKeyboardTextInputmaximumLength-=1
			}
			else
			{
				qm_VirtualKeyboardTextInputmaximumLength+=1
				qVirtualKeyboardTextInput.insert(0,"-")
				qVirtualKeyboardTextInput.cursorPosition=qVirtualKeyboardTextInput.text.length
			}
		}

    }

    function checkKeyValidation(keycode)
    {
        var allowedkeys = [];
        if(binaryIOField )
        {
            allowedkeys = [Qt.Key_0, Qt.Key_1]
        }
        else if(hexadecimalIOField)
        {
            allowedkeys = [Qt.Key_0, Qt.Key_1, Qt.Key_2, Qt.Key_3, Qt.Key_4, Qt.Key_5, Qt.Key_6, Qt.Key_7, Qt.Key_8, Qt.Key_9,
                           Qt.Key_A, Qt.Key_B, Qt.Key_C, Qt.Key_D, Qt.Key_E, Qt.Key_F]
        }
        else if(decimalIOField)
        {
            allowedkeys = [Qt.Key_0, Qt.Key_1, Qt.Key_2, Qt.Key_3, Qt.Key_4, Qt.Key_5, Qt.Key_6,Qt.Key_7 ,Qt.Key_8,Qt.Key_9 ]
        }

        if(allowedkeys.indexOf(keycode)>0)
        {
            return true
        }
        else
        {
            return false
        }

    }
        function dumpHashes(flag)
    {
        if(flag ===0)
        {
            if(minText.paintedWidth > textInputRectangleWidth)
            {
                qm_MinValue = ""
                while(qm_MinValue.length != Math.round(textInputRectangleWidth/minText.font.pixelSize))
                {
                    qm_MinValue+="#"
                }
                minText.text = qm_MinValue
            }
        }
        else
        {
            if(maxText.paintedWidth > textInputRectangleWidth)
            {
                qm_MaxValue = ""
                while(qm_MaxValue.length != Math.round(textInputRectangleWidth/maxText.font.pixelSize))
                {
                    qm_MaxValue+="#"
                }
                maxText.text = qm_MaxValue
            }
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
                  width:closeButtonWidth
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
                  topMargin: buttonSpacing*qm_marginBetweenTextInputAndMaxValue;
                  bottomMargin: buttonSpacing;
                  leftMargin: buttonSpacing;
                  rightMargin: buttonSpacing
			  }
			  Column
			  {
				  anchors.fill: parent
				  spacing: 2
                  Item
				  {
					  id:maxvalue
					  height:20
					  width: parent.width
					  Text
					  {
                          id:maxText
						  text:"Max: "+qm_MaxValue
                          font.pixelSize: 15
                          color:"#1c1f90"
                          visible: maxValuevisibility
                          clip: true
                          anchors
                          {
                              left: parent.left;
                              right: parent.right;
                              verticalCenter: parent.verticalCenter;
                              verticalCenterOffset: -1
                              leftMargin: buttonSpacing*4;
                              rightMargin: buttonSpacing*4;
                          }
					  }

				  }
				  Rectangle
				  {
                      id:textInput
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
                           passwordCharacter: "*"
						   echoMode: qm_VirtualKeyboardPasswordMode?TextInput.Password:TextInput.Normal
                           maximumLength: signedValuePresent?qm_VirtualKeyboardTextInputmaximumLength-1:qm_VirtualKeyboardTextInputmaximumLength
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
							   keyPressed();
							   if(event.key === Qt.Key_Escape)
							   {
								   escapeClicked()
                                   event.accepted = true
							   }
                               else if(event.key === Qt.Key_Return)
							   {
								   enterClicked(qVirtualKeyboardTextInput.text)
                                   event.accepted = true
							   }
                              else if(event.key === Qt.Key_Enter)
							   {
                                enterClicked(qVirtualKeyboardTextInput.text)
                                event.accepted = true
							   }
                               else if(event.key === Qt.Key_Minus)
                               {
                                   toggleButtonClicked()
                                   event.accepted = true
                               }
                               else if(event.key === Qt.Key_Backspace)
                               {
                                    backspaceButtonClicked()
                                    event.accepted = true
                               }
                               else if(event.key === Qt.Key_Delete)
                               {
                                    deleteButtonClicked()
                                    event.accepted = true
                               }
                               else if(qVirtualKeyboardTextInput.selectedText && checkKeyValidation(event.key) && !event.modifiers)
                               {
                                  selectedTextHandling()
                               }
                               else if((event.key >= Qt.Key_F1) && (event.key <= Qt.Key_F35))
                               {
                                    var isCtrlPressed = (event.modifiers & Qt.ControlModifier)
                                    var isAltPressed = (event.modifiers & Qt.AltModifier)
                                    if(NULL != proxy)
				    	proxy.keyHandler(0,event.key, true, event.text, event.isAutoRepeat, isAltPressed, isCtrlPressed);
                                    event.accepted = true
                               }
                               else
                                   counterforToggleButton=0;
						   }
                           Keys.onReleased:
                           {
                               if((event.key >= Qt.Key_F1) && (event.key <= Qt.Key_F35))
                               {
				 if(NULL != proxy)	
                                   	proxy.keyHandler(0, event.key, false, event.text, event.isAutoRepeat);
                                   event.accepted = true;
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
                               onClicked:
                               {
                                   if(qVirtualKeyboardTextInput.text.charAt(0) === "-")
                                   {
                                        qm_VirtualKeyboardTextInputmaximumLength-=1
                                   }
                                   qVirtualKeyboardTextInput.text = ""
                                   signedValuePresent = false
                               }

						   }
					  }
					  RegExpValidator
					  {
						  id:decimalValidator
                          regExp: /[0-9-]+/
					  }
                      RegExpValidator
                      {
                          id:decimalPointAllowedValidator
                          regExp: qm_seperatorString === "."?/[0-9.-]+/:/[0-9,-]+/
                      }
					  RegExpValidator{
						  id:binaryValidator
						  regExp: /[0-1]+/
					  }
					  RegExpValidator
					  {
						  id:hexadecimalValidator
                          regExp: macIoField?/[0-9A-Fa-f-]+/:/[0-9A-Fa-f]+/
					  }

					  states:[
						  State
						  {
							   when: binaryIOField ==true && decimalIOField=== false
							   PropertyChanges  {
								   target: qVirtualKeyboardTextInput;
								   validator: binaryValidator
							   }

						  },
						  State
						  {
							   when: binaryIOField ==true && decimalIOField === true && hexadecimalIOField === false
							   PropertyChanges {
								   target: qVirtualKeyboardTextInput;
                                   validator: decimalPointAllowed?decimalPointAllowedValidator:decimalValidator

							   }

						  },
						  State
						  {
							  when: hexadecimalIOField === true && binaryIOField ==true && decimalIOField === true
							   PropertyChanges {
								   target: qVirtualKeyboardTextInput;
								   validator: hexadecimalValidator

							   }
						  }
						  ]
				  }
                  Item
				  {
					  id:minvalue
					  height:20
					  width: parent.width
					  Text
					  {
                          id:minText
						  text:"Min: "+qm_MinValue
                          font.pixelSize: 15
                          color:"#1c1f90"
                          visible: minValuevisibility
                          clip: true
                          anchors
                          {
                              left: parent.left;
                              right: parent.right;
                              verticalCenter: parent.verticalCenter;
                              verticalCenterOffset: -1
                              leftMargin: buttonSpacing*4;
                              rightMargin: buttonSpacing*4;
                          }
					  }
				  }
			  }
			  Item
			  {
				  anchors
				  {
					  fill:parent
                      leftMargin: leftMargin
                      topMargin :buttonSpacing*qm_buttonLayoutTopMargin
				  }
                  Item
				  {
					  id: rect1
                      width: col1.width - 320
					  height: col1.height -70
					   Column
					   {
                          spacing: buttonSpacing
						  anchors
						  {
							  fill: parent
							  leftMargin: 10
							  topMargin: 5
							  bottomMargin: 10
						  }
						  Row
						  {
							  id:row11
                              spacing:buttonSpacing

                              Button{objectName:"ButtonNL_"+Keyboard.numbers[6];width:buttonWidth_N; height:buttonHeight_N; text:value; value:Keyboard.numbers[6]; onClicked:keyboardButtonClicked(text);enabled:decimalIOField; disabled:!decimalIOField }
                              Button{objectName:"ButtonNL_"+Keyboard.numbers[7];width:buttonWidth_N; height:buttonHeight_N; text:value; value:Keyboard.numbers[7]; onClicked:keyboardButtonClicked(text);enabled:decimalIOField; disabled:!decimalIOField }
                              Button{objectName:"ButtonNL_"+Keyboard.numbers[8];width:buttonWidth_N; height:buttonHeight_N; text:value; value:Keyboard.numbers[8]; onClicked:keyboardButtonClicked(text);enabled:decimalIOField; disabled:!decimalIOField }
						  }
						  Row
						  {
							  id:row12
                              spacing:buttonSpacing
                              Button{objectName:"ButtonNL_"+Keyboard.numbers[3];width:buttonWidth_N; height:buttonHeight_N; text:value; value:Keyboard.numbers[3]; onClicked:keyboardButtonClicked(text) ;enabled:decimalIOField; disabled:!decimalIOField }
                              Button{objectName:"ButtonNL_"+Keyboard.numbers[4];width:buttonWidth_N; height:buttonHeight_N; text:value; value:Keyboard.numbers[4]; onClicked:keyboardButtonClicked(text);enabled:decimalIOField; disabled:!decimalIOField }
                              Button{objectName:"ButtonNL_"+Keyboard.numbers[5];width:buttonWidth_N; height:buttonHeight_N; text:value; value:Keyboard.numbers[5]; onClicked:keyboardButtonClicked(text);enabled:decimalIOField; disabled:!decimalIOField }
						  }
						  Row
						  {
							  id:row13
                              spacing:buttonSpacing
                              Button{objectName:"ButtonNL_"+Keyboard.numbers[0];width:buttonWidth_N; height:buttonHeight_N; text:value; value:Keyboard.numbers[0]; onClicked:keyboardButtonClicked(text) ; enabled:binaryIOField; disabled:!binaryIOField}
                              Button{objectName:"ButtonNL_"+Keyboard.numbers[1];width:buttonWidth_N; height:buttonHeight_N; text:value; value:Keyboard.numbers[1]; onClicked:keyboardButtonClicked(text);enabled:decimalIOField; disabled:!decimalIOField }
                              Button{objectName:"ButtonNL_"+Keyboard.numbers[2];width:buttonWidth_N; height:buttonHeight_N; text:value; value:Keyboard.numbers[2]; onClicked:keyboardButtonClicked(text);enabled:decimalIOField; disabled:!decimalIOField }
						  }
						  Row
						  {
							  id:row14
                              spacing:buttonSpacing
                              Button{objectName:"ButtonNL_"+Keyboard.numbers[9];width:buttonWidth_N; height:buttonHeight_N; text:value; value:Keyboard.numbers[9]; onClicked:keyboardButtonClicked(text) ; enabled:binaryIOField; disabled:!binaryIOField}
                              Button{objectName:"ButtonNL_"+Keyboard.numbers[32];width:buttonWidth_N; height:buttonHeight_N; text:value; value:Keyboard.numbers[32]; onClicked:{keyPressed();toggleButtonClicked();}enabled:macIoField ||(decimalIOField && !hexadecimalIOField)?decimalIOField:macIoField; disabled:hexadecimalIOField && !macIoField?hexadecimalIOField:!decimalIOField}
                              Button{objectName:"ButtonNL_"+qm_seperatorString;width:buttonWidth_N; height:buttonHeight_N; text:value; value:qm_seperatorString; onClicked:decimalPointAllowed?keyboardButtonClicked(text):keyboardButtonClicked("");enabled:!hexadecimalIOField?decimalIOField:!hexadecimalIOField; disabled:hexadecimalIOField?hexadecimalIOField:!decimalIOField }
						  }
					   }
				  }
                  Item
				  {
					  id:rect2
					  anchors.left: rect1.right
                      anchors.leftMargin: qm_marginBetweenRactangles
					  width: col1.width -rect1.width-70
					  height: col1.height -70
					  Column
					  {
                          spacing: buttonSpacing
						  anchors
						  {
							  fill:parent
							  leftMargin: 10
							  topMargin: 5
						  }
						  Row
						  {
								  id:row21
                                  spacing:buttonSpacing
                                  Button{objectName:"ButtonNL_"+Keyboard.alphabet[10];width:buttonWidth_N; height:buttonHeight_N; text:value; value:Keyboard.alphabet[10]; onClicked:keyboardButtonClicked(text); enabled:hexadecimalIOField; disabled:!hexadecimalIOField }
                                  Button{objectName:"ButtonNL_"+Keyboard.alphabet[23];width:buttonWidth_N; height:buttonHeight_N; text:value; value:Keyboard.alphabet[23]; onClicked:keyboardButtonClicked(text); enabled:hexadecimalIOField; disabled:!hexadecimalIOField}
                                  Button{objectName:"ButtonNL_"+Keyboard.alphabet[21];width:buttonWidth_N; height:buttonHeight_N; text:value; value:Keyboard.alphabet[21]; onClicked:keyboardButtonClicked(text); enabled:hexadecimalIOField; disabled:!hexadecimalIOField}
                                  Button{objectName:"ButtonNL_Backspace";width:buttonWidth_N; height:buttonHeight_N; icon:backspaceButtonSource; onClicked: {keyPressed();backspaceButtonClicked();}}

						   }
						  Row
						  {
                              spacing: buttonSpacing
							  Column
							  {
                                     spacing: buttonSpacing
									 Row
									 {
										  id:row22
                                          spacing:buttonSpacing
                                          Button{objectName:"ButtonNL_"+Keyboard.alphabet[12];width:buttonWidth_N; height:buttonHeight_N; text:value; value:Keyboard.alphabet[12]; onClicked:keyboardButtonClicked(text); enabled:hexadecimalIOField; disabled:!hexadecimalIOField }
                                          Button{objectName:"ButtonNL_"+Keyboard.alphabet[2];width:buttonWidth_N; height:buttonHeight_N; text:value; value:Keyboard.alphabet[2]; onClicked:keyboardButtonClicked(text); enabled:hexadecimalIOField; disabled:!hexadecimalIOField}
                                          Button{objectName:"ButtonNL_"+Keyboard.alphabet[13];width:buttonWidth_N; height:buttonHeight_N; text:value; value:Keyboard.alphabet[13]; onClicked:keyboardButtonClicked(text); enabled:hexadecimalIOField; disabled:!hexadecimalIOField}

									 }
									 Row
									 {
										  id:row23
                                          spacing:buttonSpacing
                                          Button{objectName:"ButtonNL_Del";width:buttonWidth_N; height:buttonHeight_N; text:"Del"; onClicked:{keyPressed();deleteButtonClicked() }}
                                          Button{objectName:"ButtonNL_Home";width:buttonWidth_N; height:buttonHeight_N; text:"Home"; onClicked:homeClicked()}
                                          Button{objectName:"ButtonNL_End";width:buttonWidth_N; height:buttonHeight_N; text:"End";  onClicked:endClicked()}
									 }
								 }
								 Column
								 {
                                      spacing:buttonSpacing
                                      Button{objectName:"ButtonNL_Enter";width:buttonWidth_N; height:buttonHeight_N*2+7; backgroundImagePath:enterButtonBackgroundImage;icon:eneterButtonSource;onClicked: enterClicked(qVirtualKeyboardTextInput.text)}
								  }
							 }
							 Row
							 {
								  id:row24
                                  spacing:buttonSpacing
                                  Button{objectName:"ButtonNL_Esc";width:buttonWidth_N; height:buttonHeight_N; text:"Esc"; onClicked:escapeClicked()}
                                  Button{objectName:"ButtonNL_Help";width:buttonWidth_N; height:buttonHeight_N; text:"Help"; enabled: qm_HelpConfigured; disabled: !qm_HelpConfigured; onClicked:helpClicked()}
                                  Button{objectName:"ButtonNL_LeftArrow";width:buttonWidth_N; height:buttonHeight_N; icon:leftarrowButtonSource; onClicked:leftarrowButtonclicked()}
                                  Button{objectName:"ButtonNL_RightArrow";width:buttonWidth_N; height:buttonHeight_N; icon:rightarrowButtonSource; onClicked:rightarrowButtonclicked()}
							  }
					  }
				  }
			  }
		 }
	}
	Component.onCompleted:
	{
		qVirtualKeyboardTextInput.forceActiveFocus()
		qVirtualKeyboardTextInput.selectAll()
		if(qm_IOFieldType === 2)
		{
			binaryIOField = true
		}
        if(qm_IOFieldType === 10 || qm_IOFieldType ===11)
        {
            decimalIOField = true
            binaryIOField = true
            if(qm_IOFieldType ===11)
            {
              decimalPointAllowed = true
            }
        }
		if(qm_IOFieldType === 6)
		{
			hexadecimalIOField = true
			decimalIOField = true
			binaryIOField = true
		}

        //added one more type for MAC ID
        if(qm_IOFieldType === 7)
        {
            hexadecimalIOField = true
            decimalIOField = true
            binaryIOField = true
            macIoField = true
        }
        if(qm_MinValue !="")
        {
            dumpHashes(0)
            minValuevisibility = true
        }
        if(qm_MaxValue !="")
        {
            dumpHashes(1)
            maxValuevisibility = true
        }
	}
}

