import QtQuick 2.0
import SmartWebView 1.0
import SmartItemComponent 1.0

IGuiView {
    id: qWebViewRect
    property var comboBoxObj : undefined
    function selectIndex(index)
    {
        if (comboBoxObj !== undefined)
        {
            qSmartWebView.m_comboBoxElementObj = null;
            comboBoxObj.destroy();
            comboBoxObj = undefined
        }
        qSmartWebView.selectedComboIndex = index;
    }
    onFocusChanged: {
        if (true == qm_SmartFocus) {
            qSmartWebView.focus = true
            qm_SmartFocus = false
        }
    }

    IGuiSmartWebView
    {
        id: qSmartWebView
        hostObjId: {return qWebViewRect.objId}
        anchors.fill: {return parent}
        objectName: "webView"
        function loadComboBox()
        {
            var component = Qt.createComponent("IGuiWebComboBox.qml");
            comboBoxObj = component.createObject(qWebViewRect.parent, {"width": qWebViewRect.parent.width, "height": qWebViewRect.parent.height});
            comboBoxObj.setModelItems(comboBoxList, selectedComboIndex);
            comboBoxObj.selectedItem.connect(selectIndex)
            qSmartWebView.m_comboBoxElementObj = comboBoxObj
        }

        function triggerSmartKeyBoard(qStrVal, maxLength, isPassword) {
            utilProxy.triggerSmartKeyBoard(qWebViewRect.objId, qStrVal, maxLength, isPassword);
        }
        onComboBoxListChanged: {
            if(comboBoxList.length !== 0)
                qSmartWebView.loadComboBox();
            else
            {
                if (comboBoxObj !== undefined)
                {
                    comboBoxObj.destroy()
                    comboBoxObj = undefined
                }
            }
        }
        onWebProgessPercentChanged:
        {
            if(qSmartWebView.webProgessPercent == 100)
            {
                qProgressBarBackground.visible = false
            }
            else
            {
                qProgressBarBackground.visible = true
            }
        }
        Rectangle
        {
            id: qProgressBarBackground

            height: 3
            width: {return parent.width}
            color: "black"
            anchors.left: {return parent.left}
            anchors.bottom: {return parent.bottom}

            Rectangle
            {
                id: qprogressBar
                height: {return qProgressBarBackground.height}
                color: "#00DCFF"
                anchors.left: {return parent.left}
                anchors.bottom: {return parent.bottom}
                width: ((parent.width * (qSmartWebView.webProgessPercent)) / (100))
            }
        }

        Component.onCompleted: {
            qSmartWebView.triggerKeyBoard.connect(qSmartWebView.triggerSmartKeyBoard);
	    qSmartWebView.setWebFont(qm_FontFamilyName,  qm_FontSize, qm_FontBold, qm_FontItalic, qm_FontUnderline, qm_FontStrikeout);
        }
    }
}
