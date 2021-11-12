import QtQuick 2.15
import "../controls"

Item {
    id: root
    clip: true
    property int totaltopay: checklist.totalPrice

    Rectangle {
        id: topbar
        width: parent.width
        height: 40
        color: "#e8e8e8"

        Text {
            id: text2
            text: qsTr("PRODUCTS")
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            font.pixelSize: 18
            font.bold: true
            anchors.leftMargin: 30
        }

        Row {
            id: row
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 40
            spacing: 40

            Text {
                id: text4
                text: qsTr("PRICE")
                font.pixelSize: 18
                font.bold: true
            }

            Text {
                id: text3
                text: qsTr("QUANTITY")
                font.pixelSize: 18
                font.bold: true
            }

            Text {
                id: text1
                text: qsTr("TOTAL")
                font.pixelSize: 18
                font.bold: true
            }


        }

    }

    CartList {
        id:checklist
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: topbar.bottom
        anchors.bottom: bottombar.top
        anchors.bottomMargin: 0
        anchors.topMargin: 0

    }

    Rectangle {
        id: bottombar
        height: 100
        color: "#00000000"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.bottomMargin: 0

        Rectangle {
            id: rectangle
            x: 0
            y: 380
            height: 100
            color: "#e8e8e8"
            anchors.fill: parent
            anchors.topMargin: 2


            Text {
                id: text6
                x: 375
                y: 39
                width: 67
                height: 22
                text: qsTr("TOTAL:")
                anchors.right: text7.left
                font.pixelSize: 18
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: 11
                font.bold: true
            }
            Text {
                id: text5
                x: 47
                y: 39
                text: totaltopay
                anchors.right: parent.right
                font.pixelSize: 18
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.rightMargin: 47
                font.bold: true
            }

            Text {
                id: text7
                x: 424
                y: 42
                text: qsTr("$")
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: text5.left
                font.pixelSize: 18
                horizontalAlignment: Text.AlignHCenter
                anchors.rightMargin: 8
                font.bold: true
            }

            Btnxd {
                id: delOrder
                y: 30
                width: 120
                height: 45
                text: "Delete order"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                font.pointSize: 12
                btnColorClicked: "#cd3737"
                btnColorMouseOver: "#ec3c3c"
                btnColorDefault: "#f05454"
                anchors.leftMargin: 30
                font.bold: true
                onClicked: {backend.deleteOrder()}
            }

            Btnxd {
                id: purchase
                y: 30
                width: 120
                height: 45
                text: "Purchase"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: delOrder.right
                font.pointSize: 12
                anchors.leftMargin: 20
                font.bold: true
            }
        }

        Rectangle {
            id: sep
            height: 2
            color: "#999999"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: rectangle.top
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            anchors.leftMargin: 0
            anchors.rightMargin: 0
        }
    }

    Connections{
        target: backend
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:13}D{i:14}
}
##^##*/
