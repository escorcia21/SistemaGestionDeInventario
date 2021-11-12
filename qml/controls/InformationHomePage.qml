import QtQuick 2.15
import QtGraphicalEffects 1.15

Item {
    id:root

    property color imgBG: "#000000"
    property string title: "Products"
    property int quantity: 0
    property url iconSource: "../../img/images/NoImage.png"

    implicitHeight: 100
    implicitWidth: 300

    Rectangle {
        id: container
        radius: 8
        border.width: 0
        anchors.fill: parent
        Rectangle{
            id:imgContainer
            width: 80
            color: imgBG
            radius: 10
            border.width: 0
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.topMargin: 10
            anchors.leftMargin: 10

            Image {
                id: iconBtn
                source: iconSource
                anchors.rightMargin: 10
                anchors.leftMargin: 10
                anchors.bottomMargin: 10
                anchors.topMargin: 10
                mirror: false

                visible: false
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
            }

            ColorOverlay {
                anchors.fill: iconBtn
                source: iconBtn
                color: "#fff5ee"
                antialiasing: false
            }
        }

        Column {
            id: column
            anchors.left: imgContainer.right
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 14
            anchors.bottomMargin: 14
            anchors.rightMargin: 125
            spacing: parent.height/5
            anchors.leftMargin: 10

            Text {
                id: text1
                text: title
                font.pixelSize: 16
                font.bold: false
            }

            Text {
                id: text2
                text: quantity
                font.pixelSize: 16
                font.bold: true
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true}D{i:2}D{i:5}
}
##^##*/
