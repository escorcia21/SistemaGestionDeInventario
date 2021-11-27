import QtQuick 2.15
import "../controls"
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4

Item {
    property string title: "CREAR FACTURA"

    property alias ftotal: total.text
    property alias fnumeroFact: numeroFact.value



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
            text: "FACTURA"
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
                y: 120
                width: 1300
                height: 509
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
        function onPageFacturaLista(object){
            console.log("LLego")
            var txt = JSON.parse(object);
            for (var index = 0; index < Object.keys(txt).length; index++) {
                var a = txt[`FacturaLista${index}`];
                console.log(a)
                homeTab.add.append({"ID":a.ID,"Producto":a.Producto,"Cantidad":a.Cantidad,"Precio":a.Precio,"Total":a.Total});
            }
        }
        function onPageFacturaTotal(object){
            console.log("LLego2")
            var txt = JSON.parse(object);
            for (var index = 0; index < Object.keys(txt).length; index++) {
                var a = txt[`FacturaTotal${index}`];
                subto.text = (a.Total);
                var b = a.Total
                iva.text = (b*0.19)
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.75}D{i:2}D{i:7}D{i:8}D{i:6}D{i:5}D{i:4}D{i:11}D{i:10}D{i:13}
D{i:12}D{i:15}D{i:14}D{i:17}D{i:16}D{i:19}D{i:18}D{i:21}D{i:20}D{i:9}D{i:23}D{i:22}
D{i:3}D{i:1}D{i:24}
}
##^##*/
