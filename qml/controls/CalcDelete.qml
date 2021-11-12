import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0

Button {
    id:caldlt
    //CUSTOM PROPERTIES
    property url btnIconSource: "../../img/svg_img/delete.svg"
    property color btnColorDefault: "#30475e"
    property color btnColorMouseOver: "#223344"
    property color btnColorClicked: "#222831"
    property int iconHeight: 34
    property int iconWidth: 34

    QtObject {
        id: internal
        //MOUSE HOVER AND CLICKED

    property var dynamicColor: if(caldlt.down){
                                  caldlt.down ? btnColorClicked: btnColorDefault
                               }else{
                                  caldlt.hovered ? btnColorMouseOver: btnColorDefault
                               }

    }
    implicitWidth: 100
    implicitHeight: 80
    background: Rectangle {
        id:bgBtn
        color: internal.dynamicColor
        border.color: "#00000000"
        border.width: 0
        anchors.fill: parent
    }

    contentItem: Item {
        id: content
        anchors.fill: parent
        Image {

            id: iconBtn
            source: btnIconSource
            anchors.horizontalCenter: parent.horizontalCenter
            mirror: true
            anchors.verticalCenter: parent.verticalCenter
            sourceSize.height: iconHeight
            sourceSize.width: iconWidth
            height: iconHeight
            width: iconWidth
            fillMode: Image.PreserveAspectFit
            visible: false
        }

        ColorOverlay {
            anchors.fill: iconBtn
            source: iconBtn
            color: "#fff5ee"
            anchors.verticalCenter: parent.verticalCenter
            height: iconHeight
            width: iconWidth
        }
    }

}
/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
