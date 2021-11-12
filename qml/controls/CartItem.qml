import QtQuick 2.15
import "../controls"

Item {
    id: root
    property string title: "acetaminofen"
    property int oprice: 12
    property int cspinValue: 0
    property int total: 0
    property int pk: 34345
    property int fromvalue: 0
    property string sourceimg: "../../img/images/NoImage.png"


    //implicitHeight: 100
    anchors.fill: parent
    Rectangle {

        id: rectangle
        color: "#e8e8e8"
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: sep.bottom
        anchors.bottom: parent.bottom
        //border.color: "#a8a8a8"
        //border.width: 2
        anchors.topMargin: 0

        Image {
            id: sourceImg
            width: 120
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            source: sourceimg
            anchors.bottomMargin: 10
            anchors.topMargin: 10
            anchors.leftMargin: 20
            fillMode: Image.PreserveAspectFit
        }


        Row {
            id: contentPrice
            x: 444
            y: 225
            height: 30
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 20
            spacing: 5


            Text {
                id: originalPrice
                width: 100
                text: price
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                font.bold: true
                font.pointSize: 12
            }

            CSpinBox {
                id: cSpinBox
                value: cspinValue
                width: 100
                height: 30
                from:fromvalue
                anchors.verticalCenter: parent.verticalCenter
                onValueChanged: {

                    if (cSpinBox.value > 0){
                        backend.changeTotal(cSpinBox.value * oprice,pk)
                    }else{
                        backend.deleteFrom(pk)
                    }
                }
            }

            Text {
                id: totalPrice
                width: 100
                text: total
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                font.bold: true
                font.pointSize: 12
            }
        }

        Column {
            id: contentInfo
            y: 108
            width: 28
            height: 29
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: sourceImg.right
            anchors.leftMargin: 10
            visible: rectangle.width < 640 ? false: true
            Text {
                id: name
                text: title
                font.bold: true
                font.pointSize: 12
            }

            Text {
                id: identificator
                text: idd
                font.pixelSize: 12
            }

        }

        Text {
            id: coin
            text: qsTr("$")
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: contentPrice.left
            font.pointSize: 12
            anchors.rightMargin: 0
            font.bold: true
        }

        Text {
            id: del
            x: 453
            width: 47
            height: 17
            color: "#000000"
            text: qsTr("Delete")
            anchors.right: parent.right
            anchors.top: contentPrice.bottom
            font.pixelSize: 14
            font.bold: true
            anchors.topMargin: 4
            anchors.rightMargin: 150
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered:{cursorShape = Qt.PointingHandCursor}
                onPressed:{
                    backend.deleteFrom(pk)
                }
            }
        }

    }

    Rectangle {
        id: sep
        height: 1
        color: "#999999"
        anchors.top: parent.top
        anchors.topMargin: 0
    }

    Connections {
        target: backend
    }
}






/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
