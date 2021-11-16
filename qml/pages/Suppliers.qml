import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4


import "../controls"

Item {
    id:suppItem

    TabBar {
        id:tab
        width: parent.width
        TabButton {
            text: qsTr("SUPPLIERS")
            font.bold: true
            font.pointSize: 10
        }
        TabButton {
            text: qsTr("MOVEMENTS")
            font.bold: true
            font.pointSize: 10

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
        }
        TableSupp {
            id: secondTab
            headers: ["ID","Producto","Proveedor","Cantidad","Precio","Fecha"]
            RoundBtn {
                id:secondTabRound
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                anchors.rightMargin: 20
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }




    Connections {
        target: backend

        function onPageSupplier(object){
            //add.clear()
            var txt = JSON.parse(object);
            //console.log(JSON.stringify(txt,null,2))
             for (var index = 0; index < Object.keys(txt).length; index++) {
                //txt[`'Product{index}`]
                 var a = txt[`Supp${index}`];
                 homeTab.add.append({"ID":a.ID,"Nombre":a.Nombre,"NIT":a.NIT,"Correo":a.Correo,"Direccion":a.Direccion,"Telefono":a.Telefono});
             }
        }

        function onPageSupplierProd(object,headers){
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
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
