import QtQuick 2.15

Rectangle {

    // ----- Public Properties ----- //

    property alias placeholder: lbPlaceholder.text
    property alias text: tiBox.text

    // ----- Signals ----- //

    id: root
    color: "#00000000"
    MouseArea{
        anchors.fill: parent
        cursorShape: Qt.IBeamCursor
    }

    Text {
        id: lbPlaceholder
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        horizontalAlignment: TextInput.AlignLeft
        verticalAlignment: TextInput.AlignVCenter
        opacity: tiBox.text.length === 0 ? 0.5 : 0
        font.pixelSize: tiBox.font.pixelSize
        Behavior on opacity { NumberAnimation { duration: 100 } }
    }

    TextInput {
        id: tiBox
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        horizontalAlignment: TextInput.AlignLeft
        verticalAlignment: TextInput.AlignVCenter
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.topMargin: 0
        anchors.leftMargin: 3
        font.pixelSize: parent.height * 0.5
        clip: true
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
