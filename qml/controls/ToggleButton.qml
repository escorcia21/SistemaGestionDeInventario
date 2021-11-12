import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0

Button {
    id:btnToggle
    //CUSTOM PROPERTIES

    property url btnIconSource: "../../img/svg_img/menu_icon.svg"
    property color btnColorDefault: "#30475e"
    property color btnColorMouseOver: "#223344"
    property color btnColorClicked: "#222831"
    QtObject {
        id: internal
        //MOUSE HOVER AND CLICKED

    property var dynamicColor: if(btnToggle.down){
                                  btnToggle.down ? btnColorClicked: btnColorDefault
                               }else{
                                  btnToggle.hovered ? btnColorMouseOver: btnColorDefault
                               }

    }

    implicitWidth: 100
    implicitHeight: 60
    background: Rectangle {
        id:bgBtn
        color: internal.dynamicColor

        Image {
            id: iconBtn
            source: btnIconSource
            mirror: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: 28
            width: 28
            visible: false
            fillMode: Image.PreserveAspectFit
        }

        ColorOverlay {
            anchors.fill: iconBtn
            source: iconBtn
            color: "#fff5ee"
            antialiasing: false
        }
    }
}




/*##^##
Designer {
    D{i:0;formeditorZoom:0.8999999761581421}
}
##^##*/
