import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0

Button {
    id:btnLeft
    //CUSTOM PROPERTIES
    text: qsTr("Cart")
    property url btnIconSource: "../../img/svg_img/shopping_cart.svg"
    property color btnColorDefault: "#30475e"
    property color btnColorMouseOver: "#223344"
    property color btnColorClicked: "#222831"
    property int iconHeight: 28
    property int iconWidth: 28
    property color activeMenuColor: "#f05454"
    property color activeMenuColorRight: "#e8e8e8"
    property bool isActive: false
    property bool displayStock: false

    QtObject {
        id: internal
        //MOUSE HOVER AND CLICKED

    property var dynamicColor: if(btnLeft.down){
                                  btnLeft.down ? btnColorClicked: btnColorDefault
                               }else{
                                  btnLeft.hovered ? btnColorMouseOver: btnColorDefault
                               }

    }

    implicitWidth: 250
    implicitHeight: 60
    background: Rectangle {
        id:bgBtn
        color: internal.dynamicColor
        Rectangle {
            anchors {
                top: parent.top
                left: parent.left
                bottom: parent.bottom
            }
            color: activeMenuColor
            width: 3
            visible: isActive
        }

        Rectangle {
            anchors {
                top: parent.top
                right: parent.right
                bottom: parent.bottom
            }
            color: activeMenuColorRight
            width: 5
            visible: isActive
        }
    }

    contentItem: Item {
        id: content
        anchors.fill: parent
        Rectangle {
            id: rectangle
            height: 35
            width: 35
            color: "#00000000"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20

            Image {

                id: iconBtn
                source: btnIconSource
                anchors.bottomMargin: 0
                anchors.leftMargin: 0
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                sourceSize.height: iconHeight
                sourceSize.width: iconWidth
                height: iconHeight
                width: iconWidth
                fillMode: Image.PreserveAspectFit
                visible: false
                antialiasing: true
            }

            ColorOverlay {
                anchors.fill: iconBtn
                source: iconBtn
                color: "#fff5ee"
                height: iconHeight
                width: iconWidth
                antialiasing: true
            }
            Rectangle {
                id: stock
                x: 141
                width: 16
                height: 16
                color: "#9c0e0e"
                border.color: "#00000000"
                border.width: 0
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 0
                anchors.topMargin: 0
                radius: 50
                visible: displayStock
                Text {
                    width: 18
                    height: 21
                    color: "#fff5ee"
                    text: "1"
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    lineHeightMode: Text.ProportionalHeight
                    font.bold: true
                    font.pointSize: 8
                    anchors.horizontalCenter: parent.horizontalCenter

                }

            }



        }
        Text {
            color: "#fff5ee"
            text: btnLeft.text
            font: btnLeft.font
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 72


        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:60;width:250}
}
##^##*/
