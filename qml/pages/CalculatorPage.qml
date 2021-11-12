import QtQuick 2.15

import "../controls"

Item {
    id:root
    Rectangle {
        id: container
        anchors.fill: parent
        color: "#00000000"

        Row {
            id: row
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 10
            spacing: parent.width / parent.width + 20

            InformationHomePage {
                id: clients
                width: 189
                height: 84
                title: "hola"
                quantity: 4
            }

            InformationHomePage {
                id: sellers
                width: 189
                height: 84
                title: "hola"
                quantity: 4
            }

            InformationHomePage {
                id:products
                width: 189
                height: 84
                quantity: 4
                title: "hola"

            }


        }


    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
