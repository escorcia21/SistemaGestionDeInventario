import QtQuick 2.15
import "../controls"
import QtQuick.Controls 2.15
Item {
    id: root
    clip: true
    property string teamporal: ""
    property string fano: teamporal
    property string fmes: mes.listm.get(mes.indice).Nombre


    Rectangle {
        id: topbar
        width: parent.width
        height: parent.height - rectangle.height
        color: "#e8e8e8"

        Row {
            id: row
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 40


            Text {
                id: text3
                text: qsTr("Mes:")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 18
                font.bold: true
            }

            FungusComboBox {
                id: mes
                width: 200
                height: 75
                anchors.verticalCenter: parent.verticalCenter

            }

            Text {
                id: text1
                text: qsTr("Año:")
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 18
                font.bold: true
            }

            FungusComboBox {
                id: ano
                width: 200
                height: 75
                anchors.verticalCenter: parent.verticalCenter
                onIndiceChanged: {
                    if (ano.indice > -1){
                        teamporal = ano.listm.get(ano.indice).Nombre;
                        console.log(fano);
                        backend.setMesCombobox(fano);
                    }
                }
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


            Btnxd {
                id: purchase
                y: 30
                width: 170
                height: 45
                text: "Generar reporte"
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 12
                anchors.leftMargin: 20
                font.bold: true
                onClicked: {
                    if (ano.comboValue > 0 && mes.indice > -1){
                        backend.setGenerarInforme(fmes,fano)
                    }
                }
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
        function onSetAnoCombo(object){
            var txt = JSON.parse(object);
             for (var index = 0; index < Object.keys(txt).length; index++) {
                 var a = txt[`AnoList${index}`];
                 var palabra = (a.ano).toString();
                 ano.listm.append({'ID': a.ID, 'Nombre': palabra});
             }
        }

        function onSetMesCombo(object){
            var txt = JSON.parse(object);
             for (var index = 0; index < Object.keys(txt).length; index++) {
                 var a = txt[`MesList${index}`];
                 var palabra = (a.Mes).toString();
                 mes.listm.clear()
                 mes.listm.append({'ID': a.ID, 'Nombre': palabra});
             }
        }

    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
