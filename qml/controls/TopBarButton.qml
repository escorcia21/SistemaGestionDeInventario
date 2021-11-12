import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0

Button {
    id:btnTopBar
    //CUSTOM PROPERTIES

    property url btnIconSource: "../../img/svg_img/minimize_icon.svg"
    property color btnColorDefault: "#30475e"
    property color btnColorMouseOver: "#223344"
    property color btnColorClicked: "#222831"
    QtObject {
        id: internal
        //MOUSE HOVER AND CLICKED

    property var dynamicColor: if(btnTopBar.down){
                                  btnTopBar.down ? btnColorClicked: btnColorDefault
                               }else{
                                  btnTopBar.hovered ? btnColorMouseOver: btnColorDefault
                               }

    }

    implicitWidth: 35
    implicitHeight: 35
    background: Rectangle {
        id:bgBtn
        color: internal.dynamicColor

        Image {
            id: iconBtn
            source: btnIconSource
            mirror: false
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: 16
            width: 16
            visible: false
            antialiasing: false
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
    D{i:0;autoSize:true;height:35;width:35}
}
##^##*/
