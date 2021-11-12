import QtQuick 2.0
import QtQuick.Controls 2.15


RoundButton {
    property color btnColorDefault: "#30475e"
    property color btnColorMouseOver: "#223344"
    property color btnColorClicked: "#222831"
    property color textcolor: "#e8e8e8"

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
    contentItem: Text {
           text: roundButton.text
           font: roundButton.font
           opacity: enabled ? 1.0 : 0.3
           color: "#fff"
           horizontalAlignment: Text.AlignHCenter
           verticalAlignment: Text.AlignVCenter
           elide: Text.ElideRight
       }
}


