import QtQuick 2.15
import QtQuick.Controls 2.15

SpinBox {
    id: control

    property color upColor: "#f05454"
    property color downColor: "#537aa2"
    property color bgColor: "#e8e8e8"


    from: 1
    implicitWidth: 80
    implicitHeight: 29

    background: Rectangle {
        color: bgColor
        border.color: "#a8a8a8"
    }
    up.indicator: Rectangle {
       x: control.mirrored ? 0 : parent.width - width
       height: parent.height
       border.color: upColor
       width: 29

       Text {
           text: "+"
           font.pixelSize: control.font.pixelSize * 2
           color: upColor
           anchors.fill: parent
           fontSizeMode: Text.Fit
           horizontalAlignment: Text.AlignHCenter
           verticalAlignment: Text.AlignTop
       }
    }
    down.indicator: Rectangle {
        x: control.mirrored ? parent.width - width : 0
        height: parent.height
        width: 29
        color: control.down.pressed ? "#e4e4e4" : "#f6f6f6"
        border.color: enabled ? downColor : "#bdbebf"
        Text {
            text: "-"
            font.pixelSize: control.font.pixelSize * 2
            color: downColor
            anchors.fill: parent
            fontSizeMode: Text.Fit
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignTop
        }
    }
}
