import QtQuick 2.4
import QtQuick.Controls 2.15
import "../controls"

Item {
    id: formProduct
    //anchors.fill: parent
    property alias formTitle: title.text
    property alias name: ff1.value
    property alias type: fungus1.comboValue
    property alias price: ff2.value
    //property var list1: ListModel {id:list}

    Rectangle {
        id: container
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0

        Rectangle {
            id: fieldName
            y: 79
            width: 210
            height: 58
            anchors.left: parent.left
            anchors.leftMargin: 60
            Text {
                id: text1
                text: qsTr("Nombre")
                anchors.left: parent.left
                anchors.top: parent.top
                font.pixelSize: 16
                anchors.topMargin: 3
                anchors.leftMargin: 0
                font.bold: true
            }

            FormField {
                id:ff1
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: text1.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: 9
                anchors.leftMargin: 0
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
            }

        }

        Rectangle {
            id: fieldSupp
            x: 357
            y: 55
            width: 240
            height: 123
            anchors.right: parent.right
            anchors.rightMargin: 60
            FungusComboBox {
                id:fungus1
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: text3.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: 4
            }

            Text {
                id: text3
                x: 0
                y: 24
                text: qsTr("Tipo")
                font.pixelSize: 16
                font.bold: true
            }
        }

        Rectangle {
            id: fieldPrice
            y: 232
            width: 210
            height: 58
            anchors.left: parent.left
            anchors.leftMargin: 60
            Text {
                id: text2
                x: 0
                y: 0
                text: qsTr("Precio")
                font.pixelSize: 16
                font.bold: true
            }

            FormField {
                id: ff2
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: text2.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: 9
                anchors.rightMargin: 0
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                validator: RegExpValidator {regExp: /^\d{1,15}$/}
            }

        }

        Text {
            id: title
            x: 227
            text: qsTr("EDITAR PRODUCTO")
            anchors.top: parent.top
            font.pixelSize: 24
            anchors.topMargin: 20
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
        }

    }

    Connections {
        target: backend
        function onListTypes(object){
            fungus1.listm.clear();
            fungus1.listm.append({"ID":0,'Nombre': ""});
            var txt = JSON.parse(object);
            //console.log(JSON.stringify(txt,null,2))
             for (var index = 0; index < Object.keys(txt).length; index++) {
                //txt[`'Product{index}`]
                 var a = txt[`Type${index}`];
                 fungus1.listm.append({'ID': a.ID, 'Nombre': a.Nombre});
             }
             //fungus1.listm = list1;
        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}
}
##^##*/
