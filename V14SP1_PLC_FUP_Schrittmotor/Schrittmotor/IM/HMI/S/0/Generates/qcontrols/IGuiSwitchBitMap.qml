import QtQuick 2.0

IGuiViewBitmap{

    id: qSwitchviewBitMap

    //Text for SwitchON
    property string qm_SwitchOnText:"ON"
    //Text for SwitchOFF
    property string qm_SwitchOffText:"OFF"
    //Switch Value ON
    property int qm_SwitchOnValue:0

    //Switch Value
    property int qm_SwitchCounter:0

    property bool qm_SwichOnSide:true /// false if it right oriented else left oriented
    property bool qm_SwitchStatus: (qm_SwichOnSide === true)? true:false ///true means Switch ON false means Switch OFF

    /***************************************************************************************/
    /* SliderRect Properties */
    /***************************************************************************************/
    property int qm_SliderRectHeight: 0
    property int qm_SliderRectWidth: 0

    /***************************************************************************************/
    /* SliderRect Data View Border Properties */
    /***************************************************************************************/

    /// @brief corner radius of the border
    property int qm_SliderRectBorderCornerRadius: 0

    /// @brief thickness of border
    property int qm_SliderRectBorderWidth: 0

    /***************************************************************************************/
    /*SliderRect  Tiled Bitmap Properties */
    /***************************************************************************************/

    /// @brief image id
    property int qm_SliderRectImageID: 0

    /// @brief left border line
    property int qm_SliderRectTileLeft: 0

    /// @brief top border line
    property int qm_SliderRectTileTop: 0

    /// @brief right border line
    property int qm_SliderRectTileRight: 0

    /// @brief bottom border line
    property int qm_SliderRectTileBottom: 0

    /// @brief image source
    property string qm_SliderRectimageSrc:  { return "image://QSmartImageProvider/" +
                                       qm_SliderRectImageID     + "#" +       // image id
                                       2                        + "#" +       // tiled image
                                       4                        + "#" +       // horizontal alignment info
                                       128                      + "#" +       // vertical alignment info
                                       0                        + "#" +       // language index
                                       0             }                         // cache info

    /***************************************************************************************/
    /* SliderGrip Data View Border Properties */
    /***************************************************************************************/

    /// @brief corner radius of the border
    property int qm_SliderGripBorderCornerRadius: 0

    /// @brief thickness of border
    property int qm_SliderGripBorderWidth: 0

    /***************************************************************************************/
    /* SliderGrip Tiled Bitmap Properties */
    /***************************************************************************************/

    /// @brief image id
    property int qm_SliderGripImageID: 0

    /// @brief tiled image width
    property int qm_SliderGripTileWidth: 0

    /// @brief tiled image height
    property int qm_SliderGripTileHeight: 0

    /// @brief left border line
    property int qm_SliderGripTileLeft: 0

    /// @brief top border line
    property int qm_SliderGripTileTop: 0

    /// @brief right border line
    property int qm_SliderGripTileRight: 0

    /// @brief bottom border line
    property int qm_SliderGripTileBottom: 0

    /// @brief image source
    property string qm_SliderGripimageSrc:  {return "image://QSmartImageProvider/" +
                                       qm_SliderGripImageID     + "#" +       // image id
                                       2                        + "#" +       // tiled image
                                       4                        + "#" +       // horizontal alignment info
                                       128                      + "#" +       // vertical alignment info
                                       0                        + "#" +       // language index
                                       0            }                          // cache info


    /***************************************************************************************/
    /* SliderRectOff Fill Color Properties */
    /***************************************************************************************/

    /// @brief data for background color
    property color qm_SliderRectOffFillColor : "#00000000"


    /***************************************************************************************/
    /* SliderRectOn Fill Color Properties */
    /***************************************************************************************/

    /// @brief data for background color
    property color qm_SliderRectOnFillColor : "#00000000"

    /// @brief For focus : to set parent to focus Rectangle
    qm_FocusRectParent : {return sliderRect}

    /// @brief property is set true if qml rotation functon should be called
    property bool qm_SliderSwitch: true

    //Function to set rotations
    function setTextRotation()
    {
        SetRotation(textLeftRect);
        SetRotation(textRightRect);
    }

    /// @brief function for set text
    onQmDisplayTextChanged:{

        if(qm_SwitchCounter == 0)
        {
            qm_SwitchOnText = qm_DisplayText
            qm_SwitchCounter = 1
        }
        else
        {
            qm_SwitchOffText = qm_DisplayText
            qm_SwitchCounter = 0
        }
    }
}





