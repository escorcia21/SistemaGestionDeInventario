import QtQuick 2.15
import "../controls"
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4

Item {
    property string title: "CREAR FACTURA"


    property var fproductoPrecio: fproducto.listm.get(fproducto.indice).Precio
    property var fproductoId: fproducto.listm.get(fproducto.indice).ID
    property var fproductoNombre: fproducto.listm.get(fproducto.indice).Nombre
    property int indice: fproducto.indice
    property string fcantidad: cantidad.value

    property string fnumeroFact: numeroFact.value
    property var fclienteID: fcliente.listm.get(fcliente.indice).ID
    property var fvendedorID: fvendedor.listm.get(fvendedor.indice).ID
    property string ffecha: fecha.value

    property alias tablaFactures: homeTab.add
    property bool disableForms:false

    property alias fsubto: subto.text
    property alias ftotal: total.text
    property alias fiva: iva.text

    height: 720
    width: 1300
    Rectangle {
        height: 720
        width: 1000
        id: rectangle
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: text1
            x: 0
            width: parent.width
            height: 29
            text: "CREAR FACTURA"
            anchors.top: parent.top
            font.pixelSize: 24
            horizontalAlignment: Text.AlignHCenter
            font.bold: true
            anchors.topMargin: 20
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
                id: column1
                height: 129
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.verticalCenterOffset: 211
                anchors.horizontalCenterOffset: 0

                Row {
                    id: row
                    width: children.width*4
                    height: children.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    layoutDirection: Qt.LeftToRight
                    spacing: 15

                    Column {
                        id: rectangle10
                        spacing: 20
                        Text {
                            id: text5
                            width: 117
                            text: qsTr("N° de facturas")
                            font.pixelSize: 16
                            font.bold: true
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        FormField {
                            id:numeroFact
                            placeholderText: "..."
                            horizontalAlignment: Text.AlignLeft
                            width: 150
                            enabled: false

                        }
                    }

                    Column {
                        id: rectangle11
                        Text {
                            id: text6
                            text: qsTr("Clientes")
                            font.pixelSize: 16
                            font.bold: true
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        FungusComboBox {
                            id:fcliente
                            width: 275

                        }
                        spacing: 20
                    }

                    Column {
                        id: rectangle12
                        Text {
                            id: text7
                            text: qsTr("Vendedor")
                            font.pixelSize: 16
                            font.bold: true
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        FungusComboBox {
                            id:fvendedor
                            width: 275
                        }
                        spacing: 20
                    }

                    Column {
                        id: rectangle13
                        Text {
                            id: text8
                            text: qsTr("Fecha")
                            font.pixelSize: 16
                            font.bold: true
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        FormField {
                            id: fecha
                            horizontalAlignment: Text.AlignHCenter
                            placeholderText: "..."
                            width: 150
                            validator: RegExpValidator {regExp: /^(((([0\s][1-9\s]|[1\s][0-9\s]|[2\s][0-8\s])[\/]([0\s][1-9\s]|[1\s][012\s]))|((29|30|31)[\/]([0\s][13578\s]|[1\s][02\s]))|((29|30)[\/]([0\s][4,6,9]|11)))[\/]([19\s[2-9\s][0-9\s])\d\d|(^29[\/]02[\/]([19\s]|[2-9\s][0-9\s])(00|04|08|12|16|20|24|28|32|36|40|44|48|52|56|60|64|68|72|76|80|84|88|92|96)))$/}
                            inputMask: "99/99/9999"
                        }
                        spacing: 20
                    }

                }
            }

            Row {
                id: row1
                y: 114
                width: 1150
                height: 75


                Column {
                    id: column2
                    width: 100
                    height: 75

                    Text {
                        id: text9
                        text: qsTr("Producto:")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 16
                        font.bold: true
                    }
                }

                Column {
                    id: rectangle14
                    x: 100
                    width: 275
                    height: 75
                    spacing: 20

                    FungusComboBox {
                        id: fproducto
                        width: 275
                        height: 75
                    }
                }
                Column {
                    id: column3
                    width: 100
                    height: 75
                    anchors.left: parent.left
                    anchors.leftMargin: 396
                    layer.enabled: false
                    spacing: 1


                    Text {
                        id: text10
                        text: qsTr("Cantidad:")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignRight
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter

                    }
                }

                Column {
                    id: column4
                    width: 100
                    height: 75
                    spacing: 1
                    layer.enabled: false
                    x: column3.x + 100
                    FormField {
                        id: cantidad
                        width: 100
                        height: 30
                        anchors.verticalCenter: parent.verticalCenter
                        validator: RegExpValidator {regExp: /^\d{1,5}$/}

                    }
                }

                Column {
                    id: column5
                    width: 100
                    height: 75
                    anchors.left: parent.left
                    anchors.leftMargin: 616
                    spacing: 1
                    layer.enabled: false

                    Text {
                        id: text12
                        text: qsTr("Precio ($):")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignRight
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Column {
                    id: column6
                    width: 200
                    height: 75
                    spacing: 1
                    x: column5.x + 100
                    layer.enabled: false
                    Text {
                        text: fproducto.listm.get(fproducto.indice).Precio == -1 ? "-":fproducto.listm.get(fproducto.indice).Precio
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignRight
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }

            Row {
                id: row2
                x: 75
                y: 537
                width: 1150
                height: 30
                anchors.horizontalCenterOffset: 7
                smooth: true
                enabled: true
                layoutDirection: Qt.LeftToRight
                spacing: 0
                layer.enabled: true



                Column {
                    id: column10
                    width: 107
                    height: 30
                    anchors.left: parent.left
                    spacing: 1
                    x: column8.x + 100
                    layer.enabled: false
                    Text {
                        id: text17
                        text: qsTr("SubTotal ($):")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignRight
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Column {
                    id: column11
                    x: column10.x + 107
                    width: 150
                    height: 30
                    spacing: 1
                    layer.enabled: false
                    Text {
                        id: subto
                        text: qsTr("0")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignRight
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Column {
                    id: column8
                    width: 100
                    height: 30
                    anchors.left: parent.left
                    anchors.leftMargin: 396
                    spacing: 1
                    layer.enabled: false
                    Text {
                        id: text15
                        text: qsTr("IVA ($):")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignRight
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                anchors.horizontalCenter: parent.horizontalCenter
                Column {
                    id: column9
                    x: column8.x + 100
                    width: 150
                    height: 30
                    spacing: 1
                    layer.enabled: false
                    Text {
                        id: iva
                        text: qsTr("0")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignRight
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Column {
                    id: column12
                    width: 100
                    height: 30
                    spacing: 1
                    layer.enabled: false
                    x: column9.x + 396
                    Text {
                        id: text19
                        text: qsTr("Total$:")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignRight
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }

                Column {
                    id: colum69
                    x: column12.x + 100
                    width: 150
                    height: 30
                    spacing: 1
                    layer.enabled: false
                    Text {
                        id: total
                        text: qsTr("0")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignRight
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }

            StackLayout {
                x: 0
                y: 233
                width: 1300
                height: 396
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: tab.bottom
                anchors.bottom: parent.bottom
                anchors.horizontalCenterOffset: 0
                anchors.leftMargin: 0
                anchors.bottomMargin: 32
                anchors.topMargin: 0
                currentIndex: tab.currentIndex


                anchors{
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: top
                }
                TableSupp {
                    id: homeTab
                    headers: ["ID","Producto","Cantidad","Precio","Total"]
                    tablevisible: false

                }
            }


        }


    }
    Connections {
        target: backend
        function onSetClienteCombo(object){
            var txt = JSON.parse(object);
            for (var index = 0; index < Object.keys(txt).length; index++) {
                var a = txt[`Client${index}`];
                fcliente.listm.append({'ID': a.ID, 'Nombre': a.Nombre + " - " + a.ID });
            }
        }
        function onSetEmpleadoCombo(object){
            var txt = JSON.parse(object);
            for (var index = 0; index < Object.keys(txt).length; index++) {
                var a = txt[`Emple${index}`];
                fvendedor.listm.append({'ID': a.Cedula, 'Nombre': a.Nombre + " - " + a.Cedula });
            }
        }
        function onSetProdCombo(object){
            var txt = JSON.parse(object);
            for (var index = 0; index < Object.keys(txt).length; index++) {
                var a = txt[`Product${index}`];
                fproducto.listm.append({'ID': a.idd, 'Nombre': a.article,'Precio': a.price });
            }
        }
        function onSetfacturaID(object){
            console.log("asfad")
            var txt = JSON.parse(object);
            for (var index = 0; index < Object.keys(txt).length; index++) {
                var a = txt[`IDFac${index}`];
                var b = 1
                b += a.ID
                numeroFact.value = b
                //fproducto.listm.append({'ID': a.idd, 'Nombre': a.article + " - " + a.idd,'Precio': a.price });
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}D{i:2}D{i:7}D{i:8}D{i:6}D{i:10}D{i:11}D{i:9}D{i:13}D{i:14}
D{i:12}D{i:16}D{i:17}D{i:15}D{i:5}D{i:4}D{i:21}D{i:20}D{i:23}D{i:22}D{i:25}D{i:24}
D{i:27}D{i:26}D{i:30}D{i:29}D{i:32}D{i:31}D{i:19}D{i:35}D{i:34}D{i:37}D{i:36}D{i:39}
D{i:38}D{i:41}D{i:40}D{i:43}D{i:42}D{i:45}D{i:44}D{i:33}D{i:47}D{i:46}D{i:3}D{i:1}
D{i:48}
}
##^##*/
