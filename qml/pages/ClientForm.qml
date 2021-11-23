import QtQuick 2.15
import "../controls"
import QtQuick.Controls 2.15

Item {
    property string title: "AÑADIR CLIENTE"
    property alias ftipo: tipo.currentIndex
    property alias fname: name.value
    property alias fdireccion: direccion.value
    property alias fphone: phone.value
    property alias fcedula: idCedula.value
    property alias fnit: idNit.value
    property alias fnitnumero: idNitNumero.value
    property bool disableForms: false




    Rectangle {
        id: rectangle
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0


        Text {
            id: text1
            text: "AÑADIR CLIENTE"
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
                    text: qsTr("Tipo de cliente")
                    font.pixelSize: 16
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                ComboBox {
                    id:tipo
                    width: 200
                    currentIndex: -1
                    enabled: !disableForms
                    displayText: currentIndex === -1 ? "Porfavor escoja..." : currentText
                    model: [
                        "EMPRESA",
                        "PERSONA"
                    ]
                }

            }

            Column {
                id: rectangle2
                spacing: 20
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    id: text3
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
                id: rectangle3
                spacing: 20
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    id: text4
                    text: qsTr("Dirección")
                    font.pixelSize: 16
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                FormField {
                    id:direccion
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
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    id: text5
                    text: qsTr("ID")
                    font.pixelSize: 16
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }


                FormField {
                    id:idCedula
                    visible: ftipo == 1 ? true:false
                    enabled: !disableForms
                    placeholderText: "Cedula"
                    text: ftipo == 1 ? "":""
                    horizontalAlignment: Text.AlignLeft
                    validator: RegExpValidator {regExp: /^\d{1,10}$/}
                }
                FormField {
                    id:idNada
                    visible: ftipo == -1 ? true:false
                    color: "#737373"
                    enabled: ftipo == 0 ? true:false
                    text: "Escoja un tipo de cliente..."
                    placeholderText: qsTr("Nada")
                }

                Row {
                    id: row
                    width: 200
                    height: 30
                    visible: ftipo == 0 ? true:false


                    FormField {
                        id:idNit
                        width: 140
                        visible: ftipo == 0 ? true:false
                        placeholderText: "Nit"
                        enabled: !disableForms
                        text: ftipo == 0 ? "":""
                        horizontalAlignment: Text.AlignLeft
                        validator: RegExpValidator {regExp: /^\d{1,9}$/}
                    }

                    Text {
                        id: text7
                        width: 30
                        height: 30
                        text: qsTr("-")
                        font.pixelSize: 20
                        visible: ftipo == 0 ? true:false
                        horizontalAlignment: Text.AlignHCenter
                    }

                    FormField {
                        id:idNitNumero
                        x: 0
                        width: 30
                        enabled: !disableForms
                        visible: ftipo == 0 ? true:false
                        placeholderText: "0-9"
                        text: ftipo == 0 ? "":""
                        horizontalAlignment: Text.AlignHCenter
                        validator: RegExpValidator {regExp: /^\d{1,1}$/}
                    }

                }
            }

            Column {
                id: rectangle5
                spacing: 20
                Text {
                    id: text6
                    text: qsTr("Teléfono")
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
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
