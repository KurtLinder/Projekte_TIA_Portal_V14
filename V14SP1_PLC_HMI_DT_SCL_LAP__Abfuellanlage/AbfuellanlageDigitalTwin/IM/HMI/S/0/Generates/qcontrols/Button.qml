import QtQuick 2.0

 Rectangle
 {
     id:button;

     property alias text: textItem.text
     property bool disabled:false
     property string value:""
     property string backgroundImagePath: "pics/Kb_Button_normal.png"
     property string icon:""
     property int fontsize:12
     property int buttonBorder:1
     property int buttonRadius:1
     property color buttonBordercolor: "#110101"
     property color buttonTextcolor: "#1c1f30"
     signal clicked()

     border.width: buttonBorder;
     radius: buttonRadius;
     border.color: buttonBordercolor
     clip: true;     
     Image
     {
         id: backgroundImage
         anchors.centerIn: parent
         source:backgroundImagePath
         height:parent.height
         width:parent.width
     }
     Image
     {
         id: buttonIcon
         anchors.centerIn: parent
         source:icon
     }
	 Text
     {
         id: textItem
         anchors.centerIn: parent
         font.pointSize: fontsize
         color: buttonTextcolor
         font.bold: false         
         font.family: "Siemens Sans"
     }
     MouseArea
     {
         id: mouseArea
         anchors.fill: parent
         onClicked: button.clicked()
     }
     states: [
         State {
         name: "pressed"; when: mouseArea.pressed === true && backgroundImagePath === "pics/Kb_Button_normal.png"
         PropertyChanges { target: backgroundImage; source:"pics/Kb_Button_pressed.png" }
     },
         State {
         name: "spaceButtonpressed"; when: mouseArea.pressed === true && backgroundImagePath === "pics/Kb_Space_normal.png"
         PropertyChanges { target: backgroundImage; source:"pics/Kb_Space_pressed.png" }
     },
         State {
         name: "enetrButtonpressed"; when: mouseArea.pressed === true && backgroundImagePath === "pics/Kb_Enter_normal.png"
         PropertyChanges { target: backgroundImage; source:"pics/Kb_Enter_pressed.png" }
     },
      State {
          name: "disabled";
          when: button.disabled === true
          PropertyChanges { target: button; opacity: .5 }
 }
     ]

 }
