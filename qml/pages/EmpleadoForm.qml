import QtQuick 2.15
import "../controls"
import QtQuick.Controls 2.15

Item {
    property string title: "AÑADIR EMPLEADO"

    property alias fcedula: cedula.value
    property alias ftelefono: telefono.value
    property alias fcargo: cargo.value
    property alias factivo: activo.currentIndex

    property alias fnombre: nombre.value
    property alias fdireccion: direccion.value
    property alias fsueldo: sueldo.value
    property alias fingreso: ingreso.value

    property alias fcorreo: correo.value
    property alias fpassword: password.value
    property alias fedad: edad.value
    property alias fsalida: salida.value



    Rectangle {
        id: rectangle
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0


        Text {
            id: text1
            text: "AÑADIR EMPLEADO"
            anchors.top: parent.top
            font.pixelSize: 24
            font.bold: true
            anchors.topMargin: 20
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            id: column
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: text1.bottom
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 10

            Column {
                id: col0
                width: parent.width/3
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 0
                anchors.topMargin: 0
                spacing: 40

                Column {
                    id: rectangle00
                    spacing: 20
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        id: text2
                        text: qsTr("Cedula")
                        font.pixelSize: 16
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    FormField {
                        id:cedula
                        horizontalAlignment: Text.AlignLeft
                        placeholderText: "Cedula"
                        validator: RegExpValidator {regExp: /^\d{1,10}$/}
                    }

                }

                Column {
                    id: rectangle01
                    spacing: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        id: text3
                        text: qsTr("Celular")
                        font.pixelSize: 16
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    FormField {
                        id:telefono
                        horizontalAlignment: Text.AlignLeft
                        placeholderText: "3000000000"
                        validator: RegExpValidator {regExp: /^\d{1,10}$/}
                    }
                }

                Column {
                    id: rectangle02
                    spacing: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        id: text4
                        text: qsTr("Cargo")
                        font.pixelSize: 16
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    FormField {
                        id:cargo
                        horizontalAlignment: Text.AlignLeft
                        placeholderText: "Bodeguero"
                    }
                }

                Column {
                    id: rectangle03
                    spacing: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        id: text12
                        text: qsTr("Activo")
                        font.pixelSize: 16
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    ComboBox {
                        id:activo
                        width: 200
                        currentIndex: -1
                        displayText: currentIndex === -1 ? "Porfavor escoja..." : currentText
                        model: [
                            "Activo",
                            "Retirado"
                        ]
                    }
                }
            }

            Column {
                id: col1
                width: parent.width/3
                anchors.left: col0.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 0
                anchors.topMargin: 0
                anchors.bottomMargin: 0
                spacing: 40

                Column {
                    id: rectangle10
                    spacing: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        id: text5
                        text: qsTr("Nombre")
                        font.pixelSize: 16
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    FormField {
                        id:nombre
                        placeholderText: "..."
                        horizontalAlignment: Text.AlignLeft
                    }
                }

                Column {
                    id: rectangle11
                    spacing: 20
                    Text {
                        id: text6
                        text: qsTr("Direccion")
                        font.pixelSize: 16
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    FormField {
                        id:direccion
                        horizontalAlignment: Text.AlignLeft
                        placeholderText: "Cr 0 #0-0"
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Column {
                    id: rectangle12
                    spacing: 20
                    Text {
                        id: text7
                        text: qsTr("Sueldo")
                        font.pixelSize: 16
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    FormField {
                        id:sueldo
                        placeholderText: "$"
                        horizontalAlignment: Text.AlignLeft
                        validator: RegExpValidator {regExp: /^\d{1,15}$/}
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Column {
                    id: rectangle13
                    spacing: 20
                    Text {
                        id: text8
                        text: qsTr("Fecha de ingreso")
                        font.pixelSize: 16
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    FormField {
                        id: ingreso
                        //placeholder: "01/01/2021"
                        validator: RegExpValidator {regExp: /^(((([0\s][1-9\s]|[1\s][0-9\s]|[2\s][0-8\s])[\/]([0\s][1-9\s]|[1\s][012\s]))|((29|30|31)[\/]([0\s][13578\s]|[1\s][02\s]))|((29|30)[\/]([0\s][4,6,9]|11)))[\/]([19\s[2-9\s][0-9\s])\d\d|(^29[\/]02[\/]([19\s]|[2-9\s][0-9\s])(00|04|08|12|16|20|24|28|32|36|40|44|48|52|56|60|64|68|72|76|80|84|88|92|96)))$/}
                        inputMask: "99/99/9999"
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            Column {
                id: col2
                anchors.left: col1.right
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 0
                anchors.rightMargin: 0
                anchors.topMargin: 0
                anchors.bottomMargin: 0
                spacing: 40

                Column {
                    id: rectangle15
                    spacing: 20
                    Text {
                        id: text18
                        text: qsTr("Email")
                        font.pixelSize: 16
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    FormField {
                        id:correo
                        horizontalAlignment: Text.AlignLeft
                        placeholderText: "Especialidad@outllok.com"

                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Column {
                    id: rectangle14
                    spacing: 20
                    Text {
                        id: text9
                        text: qsTr("Contraseña")
                        font.pixelSize: 16
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    FormField {
                        id:password
                        horizontalAlignment: Text.AlignLeft
                        placeholderText: "*************"
                        echoMode: TextInput.Password
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Column {
                    id: rectangle04
                    spacing: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        id: text10
                        text: qsTr("Edad")
                        font.pixelSize: 16
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    FormField {
                        id:edad
                        validator: RegExpValidator {regExp: /^\d{1,2}$/}
                    }
                }

                Column {
                    id: rectangle05
                    spacing: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    Text {
                        id: text11
                        text: qsTr("Fecha de ingreso")
                        font.pixelSize: 16
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    FormField {
                        id: salida
                        //placeholder: "01/01/2021"
                        validator: RegExpValidator {regExp: /^(((([0\s][1-9\s]|[1\s][0-9\s]|[2\s][0-8\s])[\/]([0\s][1-9\s]|[1\s][012\s]))|((29|30|31)[\/]([0\s][13578\s]|[1\s][02\s]))|((29|30)[\/]([0\s][4,6,9]|11)))[\/]([19\s[2-9\s][0-9\s])\d\d|(^29[\/]02[\/]([19\s]|[2-9\s][0-9\s])(00|04|08|12|16|20|24|28|32|36|40|44|48|52|56|60|64|68|72|76|80|84|88|92|96)))$/}
                        inputMask: "99/99/9999"
                        text: factivo == 1 ? "":""
                        enabled: factivo == 1 ? true:false
                    }
                }
            }
        }

    }
}



/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
