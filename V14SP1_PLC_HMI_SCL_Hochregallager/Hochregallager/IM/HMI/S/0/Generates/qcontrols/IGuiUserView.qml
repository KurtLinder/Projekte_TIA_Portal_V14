import QtQuick 2.0

IGuiViewBitmap{

    /***************************************************************************************/
    /* Loaded component Properties - Mainly required for list control */
    /***************************************************************************************/

    property variant qm_StaticComponentObj: undefined

    /// @brief set loaded component object
    function setLoadedComponentObject (loadedComponentObj) {
        qm_StaticComponentObj = loadedComponentObj
    }

    /// @breif unload static compoent object
    function unloadStaticComponentObject () {
        if (qm_StaticComponentObj !== undefined) {
            qm_StaticComponentObj.parent.unloadStaticComponent()
            qm_StaticComponentObj = undefined
        }
    }

   onQm_StaticComponentObjChanged: {
            if (qm_StaticComponentObj !== undefined) {
                qm_StaticComponentObj.editModeOff.connect(unloadStaticComponentObject)

            }
        }
}
