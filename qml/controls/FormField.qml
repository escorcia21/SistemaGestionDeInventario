import QtQuick 2.0
import QtQuick.Controls 2.15

TextField {
    property string placehold: "Hola"
    property color borderColor: "#30475e"
    property alias value: textField.text

    id: textField
    width: 200
    height: 30
    clip: true
    placeholderText: qsTr(textField.value)

    font.pixelSize: 14
    leftPadding: 1
    background: Rectangle {
        anchors.fill: parent
        anchors.rightMargin: -3
        anchors.leftMargin: -2
        anchors.topMargin: -2
        color: "#fff"
           border.width: 2
           border.color: borderColor
    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:3}
}
##^##*/
