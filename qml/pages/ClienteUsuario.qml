import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4


import "../controls"

Item {
    id:clienteItem
    property alias currentIndexSupp: homeTab.selectedRow
    property alias currentIndexSupp2: secondTab.selectedRow


    TabBar {
        id:tab
        width: parent.width
        height: 40

        TabButton {
            id: control
            text: qsTr("CLIENTES")
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
            text: qsTr("EMPLEADOS")
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
            headers: ["ID","Nombre","Tipo","Direccion","Telefono"]

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
                            var tipoVar = homeTab.add.get(currentIndexSupp).Tipo == "EMPRESA" ? 0:1
                            var CedulaVar = ""
                            var idNitVar = ""
                            var idNitNumeroVar = ""
                            if (tipoVar == 0){
                                var Temp = homeTab.add.get(currentIndexSupp).ID.split("-")
                                idNitVar = Temp[0]
                                idNitNumeroVar = Temp[1]
                            }
                            else if(tipoVar == 1){
                                CedulaVar = homeTab.add.get(currentIndexSupp).ID
                            }

                            var popup = Qt.createComponent("../controls/EditClientePopup.qml");
                            var popup2 = popup.createObject(clienteItem,{
                                                                name: homeTab.add.get(currentIndexSupp).Nombre
                                                                ,direccion: homeTab.add.get(currentIndexSupp).Direccion
                                                                ,phone: homeTab.add.get(currentIndexSupp).Telefono
                                                                ,tipo: tipoVar
                                                                ,idCedula: CedulaVar
                                                                ,idNit: idNitVar
                                                                ,idNitNumero: idNitNumeroVar});
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
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                            var popup = Qt.createComponent("../controls/AddClientePopup.qml");
                            var popup2 = popup.createObject(clienteItem);
                            popup2.open();
                    }
                }
            }
        }
        TableSupp {
            id: secondTab
            headers: ["Cedula","Nombre","Edad","Celular","Direccion","Email","Ingreso","Termino","Salario","Rol","Contrasena","Activo"]

            RoundBtn {
                id:secondTabRound2
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                anchors.rightMargin: 20
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                            var popup = Qt.createComponent("../controls/AddEmpleadoPopup.qml");
                            var popup2 = popup.createObject(clienteItem);
                            popup2.open();
                    }
                }
            }

            RoundBtnEdit {
                id:roundBtnEdit2
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                btnIconSource: "../../img/svg_img/edit.svg"
                anchors.bottomMargin: 20
                anchors.leftMargin: 20
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    //fcedula: cedula
                    //ftelefono: telefono
                    //fcargo: cargo
                    //factivo: activo

                    //fnombre: nombre
                    //fdireccion: direccion
                    //fsueldo: sueldo
                    //fingreso: ingreso

                    //fcorreo: correo
                    //fpassword: password
                    //fedad: edad
                    //fsalida: salida

                    onClicked: {
                        if (currentIndexSupp2 > -1){
                            var tipoVar = secondTab.add.get(currentIndexSupp2).Activo == "Activo" ? 0:1

                            var popup = Qt.createComponent("../controls/EditEmpleadoPopup.qml");
                            var popup2 = popup.createObject(clienteItem,{
                                                                cedula: secondTab.add.get(currentIndexSupp2).Cedula
                                                                ,telefono: secondTab.add.get(currentIndexSupp2).Celular
                                                                ,cargo: secondTab.add.get(currentIndexSupp2).Rol
                                                                ,activo: tipoVar

                                                                ,nombre: secondTab.add.get(currentIndexSupp2).Nombre
                                                                ,direccion: secondTab.add.get(currentIndexSupp2).Direccion
                                                                ,sueldo: secondTab.add.get(currentIndexSupp2).Salario
                                                                ,ingreso: secondTab.add.get(currentIndexSupp2).Ingreso

                                                                ,correo: secondTab.add.get(currentIndexSupp2).Email
                                                                ,password: secondTab.add.get(currentIndexSupp2).Contrasena
                                                                ,edad: secondTab.add.get(currentIndexSupp2).Edad
                                                                ,salida: secondTab.add.get(currentIndexSupp2).Termino
                                                            });
                            popup2.open();
                        }
                    }
                }
            }
        }
    }




    Connections {
        target: backend

        function onPageClient(object){
            homeTab.add.clear()
            var txt = JSON.parse(object);
            //console.log(JSON.stringify(txt,null,2))
             for (var index = 0; index < Object.keys(txt).length; index++) {
                //txt[`'Product{index}`]
                 var a = txt[`Client${index}`];
                 homeTab.add.append({"ID":a.ID,"Tipo":a.Tipo,"Nombre":a.Nombre,"Direccion":a.Direccion,"Telefono":a.Telefono});
             }
        }

        function onPageEmpleado(object){
            secondTab.add.clear()
            var txt = JSON.parse(object);
            //console.log(JSON.stringify(txt,null,2))
             for (var index = 0; index < Object.keys(txt).length; index++) {
                //txt[`'Product{index}`]
                 var a = txt[`Emple${index}`];

                 var fecha = a.Termino
                 //console.log(fecha)
                 if(fecha == "01/Jan/1999"){
                     a.Termino = "-"
                     //console.log("lohizo")
                 }
                 secondTab.add.append({"Cedula":a.Cedula,"Nombre":a.Nombre,"Edad":a.Edad,"Celular":a.Celular,"Direccion":a.Direccion,"Email":a.Email,"Ingreso":a.Ingreso,"Termino":a.Termino,"Salario":a.Salario,"Rol":a.Rol,"Contrasena":a.Contrasena,"Activo":a.Activo});
             }
        }
    }

}




/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
