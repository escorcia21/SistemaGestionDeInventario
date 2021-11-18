import QtQuick 2.15
import "../controls"

Item {
    property string title: "ADD SUPPLIER"
    property alias fname: name.value
    property alias fnit: nit.value
    property alias femail: email.value
    property alias faddress: address.value
    property alias fphone: phone.value

    Rectangle {
        id: rectangle
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0


        Text {
            id: text1
            text: title
            anchors.top: parent.top
            font.pixelSize: 24
            font.bold: true
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Column {
            id: column
            y: 57
            width: parent.width/2
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            spacing: 40
            anchors.leftMargin: 0

            Column {
                id: rectangle1
                spacing: 20
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: text2
                    text: qsTr("Name")
                    font.pixelSize: 16
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                FormField {
                    id:name
                }
            }

            Column {
                id: rectangle2
                spacing: 20
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    id: text3
                    text: qsTr("NIT")
                    font.pixelSize: 16
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                FormField {
                    id:nit
                }
            }

            Column {
                id: rectangle3
                spacing: 20
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    id: text4
                    text: qsTr("E-Mail")
                    font.pixelSize: 16
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                FormField {
                    id:email
                }
            }

        }

        Column {
            id: column1
            height: column.height
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: column.right
            anchors.right: parent.right
            spacing: 40
            anchors.leftMargin: 0
            anchors.rightMargin: 0

            Column {
                id: rectangle4
                spacing: 20
                Text {
                    id: text5
                    text: qsTr("Address")
                    font.pixelSize: 16
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                FormField {
                    id:address
                }
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Column {
                id: rectangle5
                spacing: 20
                Text {
                    id: text6
                    text: qsTr("Phone")
                    font.pixelSize: 16
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                FormField {
                    id:phone
                    validator: IntValidator {bottom: 1; top: 100000000}
                }
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }

    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.66;height:480;width:640}
}
##^##*/
