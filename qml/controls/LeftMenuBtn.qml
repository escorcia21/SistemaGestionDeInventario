import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0

Button {
    id:btnLeft
    //CUSTOM PROPERTIES
    text: qsTr("Home")
    property url btnIconSource: "../../img/svg_img/home_icon.svg"
    property color btnColorDefault: "#30475e"
    property color btnColorMouseOver: "#223344"
    property color btnColorClicked: "#222831"
    property int iconHeight: 28
    property int iconWidth: 28
    property color activeMenuColor: "#f05454"
    property color activeMenuColorRight: "#e8e8e8"
    property bool isActive: false

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
        Image {

            id: iconBtn
            source: btnIconSource
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
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
            anchors.verticalCenter: parent.verticalCenter
            height: iconHeight
            width: iconWidth
            antialiasing: true
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
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
