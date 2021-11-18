import QtQuick 2.0
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0


RoundButton {
    property color btnColorDefault: "#30475e"
    property color btnColorMouseOver: "#223344"
    property color btnColorClicked: "#222831"
    property color textcolor: "#e8e8e8"
    property int iconHeight: 28
    property int iconWidth: 28
    property url btnIconSource: ""

    QtObject {
        id: internal
        //MOUSE HOVER AND CLICKED
        property var dynamicColor: if(roundButton.down){
          roundButton.down ? btnColorClicked: btnColorDefault
        } else{
          roundButton.hovered ? btnColorMouseOver: btnColorDefault
        }

    }

    id: roundButton
    width: 40
    height: 40
    text: qsTr("+")
    rightPadding: 6
    leftPadding: 6
    bottomPadding: 6
    font.pointSize: 25
    topPadding: 1

    background: Rectangle {
        id:bgBtn
        color: internal.dynamicColor
        border.color: "#00000000"
        border.width: 0
        anchors.fill: parent
        radius: 40

    }
    contentItem: Item {
        id: content
        anchors.fill: parent
        Image {

            id: iconBtn
            width: iconWidth
            source: btnIconSource
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            sourceSize.height: iconHeight
            sourceSize.width: iconWidth
            height: iconHeight
            fillMode: Image.PreserveAspectFit
            visible: false
            antialiasing: true
        }

        ColorOverlay {
            width: 22
            height: 22
            source: iconBtn
            anchors.horizontalCenter: parent.horizontalCenter
            color: "#fff5ee"
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true
        }
    }
}


/*##^##
Designer {
    D{i:0;formeditorZoom:10}D{i:4}D{i:5}
}
##^##*/
