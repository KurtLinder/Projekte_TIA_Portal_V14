import QtQuick 2.0
import SmartItemComponent 1.0

IGuiSmartItem{

    id:qSmartWidget
    onFocusChanged:
    {
        if(focus)
            handleFocus()
        else
            handleFocusLoss()
    }
}

