import QtQuick 2.0
import QtQuick.Controls 2.15

TextField {
    property string placehold: "Hola"
    property color borderColor: "#30475e"
    property alias value: textField.text
    property color placeholdColor:  textField.enabled ?  "#2a2a2a" : "#7f353637"

    id: textField
    width: 200
    height: 30
    clip: true
    placeholderText: qsTr(textField.value)
    color: placeholdColor
    font.pixelSize: 14
    horizontalAlignment: Text.AlignHCenter
    placeholderTextColor: placeholdColor
    leftPadding: 1
    background: Rectangle {
        color: "#00000000"
        anchors.fill: parent
        anchors.rightMargin: -3
        anchors.leftMargin: -2
        anchors.topMargin: -2
        border.width: 2
        border.color: borderColor
    }
}



/*##^##
Designer {
    D{i:0;formeditorZoom:4}
}
##^##*/
