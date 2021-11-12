import QtQuick 2.15
import QtQuick.Controls 2.15
import "../controls"

Item {
    id: item1

    Text {
        id: name
        text: qsTr("settings")
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: 24
        font.bold: true
        anchors.horizontalCenter: parent.horizontalCenter
    }

}



/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
