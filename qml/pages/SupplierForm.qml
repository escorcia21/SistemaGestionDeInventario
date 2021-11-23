import QtQuick 2.15
import "../controls"

Item {
    property string title: "AÑADIR PROVEEDOR"
    property alias fname: name.value
    property alias fnit: idNit.value
    property alias fnitnumero: idNitNumero.value
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
                    text: qsTr("Nombre")
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

                Row {
                    FormField {
                        id:idNit
                        width: 140
                        placeholderText: "Nit"
                        horizontalAlignment: Text.AlignLeft
                        validator: RegExpValidator {regExp: /^\d{1,9}$/}
                    }

                    Text {
                        id: text7
                        width: 30
                        height: 30
                        text: qsTr("-")
                        font.pixelSize: 20
                        horizontalAlignment: Text.AlignHCenter
                    }

                    FormField {
                        id:idNitNumero
                        x: 0
                        width: 30
                        placeholderText: "0-9"
                        horizontalAlignment: Text.AlignHCenter
                        validator: RegExpValidator {regExp: /^\d{1,1}$/}
                    }
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
                    text: qsTr("Dirección")
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
                    text: qsTr("Telefono")
                    font.pixelSize: 16
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                FormField {
                    id:phone
                    validator: RegExpValidator {regExp: /^\d{1,10}$/}
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
