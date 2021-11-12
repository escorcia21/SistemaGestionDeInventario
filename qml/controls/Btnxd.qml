import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0

Button {
    id:calbtn
    text: qsTr("Label")
    //CUSTOM PROPERTIES

    property color btnColorDefault: "#30475e"
    property color btnColorMouseOver: "#223344"
    property color btnColorClicked: "#222831"
    property color textcolor: "#e8e8e8"

    QtObject {
        id: internal
        //MOUSE HOVER AND CLICKED

    property var dynamicColor: if(calbtn.down){
                                  calbtn.down ? btnColorClicked: btnColorDefault
                               }else{
                                  calbtn.hovered ? btnColorMouseOver: btnColorDefault
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


        Text {
            id: textbtn
            color: calbtn.textcolor
            text: calbtn.text
            font: calbtn.font
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter


        }
    }

}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:3;height:40;width:250}
}
##^##*/

