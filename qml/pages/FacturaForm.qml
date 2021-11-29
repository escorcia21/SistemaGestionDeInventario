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

    property string pprice: fproducto.listm.get(fproducto.indice).Precio == -1 ? "-":fproducto.listm.get(fproducto.indice).Precio

    height: 1300
    width: 1300
    Rectangle {
        id: rectangle
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Text {
            id: text1
            height: 29
            text: "CREAR FACTURA"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            font.pixelSize: 24
            horizontalAlignment: Text.AlignHCenter
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            font.bold: true
            anchors.topMargin: 10
        }

        Rectangle {
            id: rectangle1
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: text1.bottom
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.topMargin: 10


            Row {
                id: row
                x: 0
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 20

                Column {
                    spacing: 20
                    Text {
                        id: text5
                        text: qsTr("N° de facturas")
                        font.pixelSize: 16
                        font.bold: true
                    }

                    FormField {
                        id:numeroFact
                        placeholderText: "..."
                        horizontalAlignment: Text.AlignLeft
                        enabled: false

                    }
                }

                Column {
                    spacing: 20
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
                }

                Column {
                    spacing: 20
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
                }

                Column {
                    spacing: 20
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
                }

            }

            Row {
                id:row1
                height: 99
                anchors.left: parent.left
                anchors.top: row.bottom
                anchors.leftMargin: 80
                spacing: 80
                anchors.topMargin: 5
                Row {
                    id: column
                    width: 290
                    height: 75
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 5

                    Text {
                        id: text9
                        text: qsTr("Producto:")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 16
                        font.bold: true
                    }

                    FungusComboBox {
                        id: fproducto
                        width: 275
                        height: 75
                        anchors.verticalCenter: parent.verticalCenter

                    }
                }

                Row {
                    id: row3
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 5
                    Text {
                        id: text10
                        text: qsTr("Cantidad:")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignRight
                        font.bold: true

                    }


                    FormField {
                        id: cantidad
                        width: 100
                        validator: RegExpValidator {regExp: /^\d{1,5}$/}

                    }
                }

                Row {
                    id: row4
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: 5
                    Text {
                        id: text12
                        text: qsTr("Precio ($):")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignRight
                        font.bold: true
                    }



                    Text {
                        text: pprice
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignRight
                        font.bold: true
                    }
                }
            }



            TableSupp {
                id: homeTab
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: row1.bottom
                anchors.bottom: row2.top
                anchors.bottomMargin: 0
                anchors.topMargin: 0
                headers: ["ID","Producto","Cantidad","Precio","Total"]
                tablevisible: false

            }

            Row {
                id: row2
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottomMargin: 10
                spacing: 90

                Row {
                    spacing: 5
                    Text {
                        id: text17
                        text: qsTr("SubTotal ($):")
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignRight
                        font.bold: true
                    }
                    Text {
                        id: subto
                        width: 200
                        text: qsTr("0")
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignLeft
                        font.bold: true
                    }
                }

                Row {
                    spacing: 5
                    Text {
                        id: text15
                        text: qsTr("IVA ($):")
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignRight
                        font.bold: true
                    }

                    Text {
                        id: iva
                        width: 200
                        text: qsTr("0")
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignLeft
                        font.bold: true
                    }
                }

                Row {
                    spacing: 5
                    Text {
                        id: text19
                        text: qsTr("Total$:")
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignRight
                        font.bold: true

                    }
                    Text {
                        id: total
                        width: 200
                        text: qsTr("0")
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignLeft
                        font.bold: true

                    }
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
            var txt = JSON.parse(object);
            for (var index = 0; index < Object.keys(txt).length; index++) {
                var a = txt[`IDFac${index}`];
                var b = 1;
                b += a.ID;
                numeroFact.value = b;
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}
}
##^##*/
