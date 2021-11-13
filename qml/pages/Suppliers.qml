import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls 1.4 as C1

Item {
    id:suppItem
    property alias listaSupp: suppliers.model
    Rectangle {
        id:suppBack
        color: "#00000000"
        anchors.fill: parent
        Rectangle {
            id:navBar
            height: 70
            color: "#00000000"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.topMargin: 0
        }

        C1.TableView {
            id: suppliers
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: navBar.bottom
            anchors.bottom: parent.bottom
            anchors.topMargin: 0
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 0


            model: ListModel {
                id: suppList
                ListElement {idd:1234;name:"Tubos S.A.S"}
            }

            C1.TableViewColumn {
                role: "idd"
                title: "ID"
                width: 100
            }
            C1.TableViewColumn {
                role: "name"
                title: "NAME"
                width: 200
            }

        }
    }
}


/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
