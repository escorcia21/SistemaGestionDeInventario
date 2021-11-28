import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4


import "../controls"

Item {
    id:facturaItem
    property alias currentIndexSupp: homeTab.selectedRow


    TabBar {
        id:tab
        width: parent.width
        height: 40

        TabButton {
            id: control
            text: qsTr("FACTURAS")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 10
            height: 40
            background: Rectangle {
                color: tab.currentIndex == 0 ? "#e8e8e8" : "#353637"
                anchors.fill: parent
                height: 40
            }
        }
    }

    StackLayout {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: tab.bottom
        anchors.bottom: parent.bottom
        anchors.topMargin: 0
        currentIndex: tab.currentIndex
        TableSupp {
            id: homeTab
            headers: ["ID","Fecha","Cliente","Vendedor","Total","Estado"]

            RoundBtnEdit {
                id:roundBtnEdit
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                btnIconSource: "../../img/svg_img/edit.svg"
                anchors.bottomMargin: 20
                anchors.leftMargin: 20
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        if (currentIndexSupp > -1){
                            backend.anularFactura(homeTab.add.get(currentIndexSupp).ID);
                        }
                    }
                }
            }

            RoundBtn {
                id:secondTabRound
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                anchors.rightMargin: 20
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                            var popup = Qt.createComponent("../controls/AddFacturaPopup.qml");
                            var popup2 = popup.createObject(facturaItem);
                            backend.setClienteCombox();
                            backend.setEmpleadoCombox();
                            backend.setProdComboBox();
                            backend.setFactura_ID();
                            popup2.open();

                    }
                }
            }
            RoundBtnEdit {
                id:thirdTabRound
                x: 580
                y: 380
                width: 40
                height: 40
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 70
                anchors.rightMargin: 20
                btnIconSource: "../../img/svg_img/iconmonstr-eye-6.svg"

                MouseArea {
                    y: 0
                    width: 40
                    height: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        if (currentIndexSupp > -1){
                            var popup = Qt.createComponent("../controls/EditFacturaPopup.qml");
                            //console.log(homeTab.add.get(currentIndexSupp).ID)
                            var popup2 = popup.createObject(facturaItem,{
                                                                numeroFactura: homeTab.add.get(currentIndexSupp).ID
                                                                ,total: homeTab.add.get(currentIndexSupp).Total});
                            backend.setPageFacturaLista(homeTab.add.get(currentIndexSupp).ID)
                            backend.setPageFacturaTotal(homeTab.add.get(currentIndexSupp).ID)
                            popup2.open();
                        }
                    }
                }
            }
        }
    }




    Connections {
        target: backend

        function onPageFactura(object){
            homeTab.add.clear()
            var txt = JSON.parse(object);
             for (var index = 0; index < Object.keys(txt).length; index++) {
                 var a = txt[`Factura${index}`];
                 homeTab.add.append({"ID":a.ID,"Vendedor":a.Vendedor,"Cliente":a.Cliente,"Fecha":a.Fecha,"Total":a.Total,"Estado":a.Estado});
             }
        }
    }
}




/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
