import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4
import "../controls"

Item {
    id:suppItem
    property alias currentIndexSupp: homeTab.selectedRow
    TabBar {
        id:tab
        width: parent.width
        height: 40

        TabButton {
            id: control
            text: qsTr("PROVEEDORES")
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
        TabButton {
            id:control1
            text: qsTr("MOVIMIENTOS")
            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 10
            height: 40
            background: Rectangle {
                height: 40
                color: tab.currentIndex == 1 ? "#e8e8e8" : "#353637"
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
                            var popup = Qt.createComponent("../controls/EditSupplierPopup.qml");
                            var Temp = homeTab.add.get(currentIndexSupp).NIT.split("-")
                            let idNitVar = Temp[0]
                            let idNitNumeroVar = Temp[1]
                            var popup2 = popup.createObject(suppItem,{name: homeTab.add.get(currentIndexSupp).Nombre,
                                                                address: homeTab.add.get(currentIndexSupp).Direccion,
                                                                phone: homeTab.add.get(currentIndexSupp).Telefono,
                                                                nit: idNitVar,
                                                                nitNumero: idNitNumeroVar,
                                                                email: homeTab.add.get(currentIndexSupp).Correo,
                                                                identification:homeTab.add.get(currentIndexSupp).ID});
                            popup2.open();
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
                    id:m2
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        var popup = Qt.createComponent("../controls/AddSupplierPopup.qml");
                        var popup2 = popup.createObject(suppItem);
                        popup2.open();
                    }
                }
            }
        }
        TableSupp {
            id: secondTab
            headers: ["ID","Producto","Proveedor","Cantidad","Precio","Fecha"]
            criterio: "Producto"
            RoundBtn {
                id:secondTabRound1
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                anchors.rightMargin: 20
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        var popup = Qt.createComponent("../controls/AddSupplierProductPopup.qml");
                        var popup2 = popup.createObject(suppItem);
                        backend.setSuppCombo();
                        backend.setProdComboBox();
                        popup2.open();
                    }
                }
            }
        }
    }




    Connections {
        target: backend

        function onPageSupplier(object){
            //add.clear()
            homeTab.add.clear();
            var txt = JSON.parse(object);
            //console.log(JSON.stringify(txt,null,2))
             for (var index = 0; index < Object.keys(txt).length; index++) {
                //txt[`'Product{index}`]
                 var a = txt[`Supp${index}`];
                 homeTab.add.append({"ID":a.ID,"Nombre":a.Nombre,"NIT":a.NIT,"Correo":a.Correo,"Direccion":a.Direccion,"Telefono":a.Telefono});
             }
        }

        function onPageSupplierProd(object,headers){
            secondTab.add.clear();
            var txt = JSON.parse(object);
            secondTab.headers = headers;
            for (var index = 0; index < Object.keys(txt).length; index++) {
                var a = txt[`Supp_Prod${index}`];
                secondTab.add.append({'ID':a.ID, 'Producto':a.Producto, 'Proveedor':a.Proveedor,'Cantidad':a.Cantidad, 'Precio':a.Precio, 'Fecha':a.Fecha});
            }
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:1.1;height:480;width:640}
}
##^##*/
