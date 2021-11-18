import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Layouts 1.15
import "../pages"


Popup {
    id: popup
    anchors.centerIn: Overlay.overlay
    width: 640
    height: 480
    modal: true
    focus: true
    closePolicy: Popup.NoAutoClose

    background: Rectangle{
        layer.enabled: enabled
        layer.effect: DropShadow {
            color: "#5c242826"
            horizontalOffset: 1
            verticalOffset: 1
            radius: 4
            samples: 9
        }
    }


    Overlay.modal: Rectangle {
        color: "#80000000"
        anchors.fill: parent
        anchors.margins: 10
    }
}
