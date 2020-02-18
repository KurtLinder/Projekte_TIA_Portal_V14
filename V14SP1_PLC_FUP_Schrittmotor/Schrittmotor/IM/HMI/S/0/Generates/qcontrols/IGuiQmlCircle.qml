/** Template file for Ellipse/Circle */
import QtQuick 2.0

IGuiView
{
        id: qmlCircleComponent

        property int qm_Radius: 0

        /// @brief Circle/Ellipse Component implemented in C++
        Rectangle{

            id: smartcircle
            anchors.fill: parent
            radius : {return qm_Radius}
            color: qm_FillColor
            border.color: qm_TextColor
            border.width: {return qm_BorderWidth}
        }
}

