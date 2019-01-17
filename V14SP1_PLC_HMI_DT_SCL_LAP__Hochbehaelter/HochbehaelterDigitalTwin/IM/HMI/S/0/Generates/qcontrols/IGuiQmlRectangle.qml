// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 2.0

IGuiView
{
        id: rectanglcomp

        /// @brief Rectangle Component implemented in C++
        Rectangle{
            id: smartrectangle
            anchors.fill: parent
            color: qm_FillColor
            border.color: qm_TextColor
            border.width: {return qm_BorderWidth}
       }
}

