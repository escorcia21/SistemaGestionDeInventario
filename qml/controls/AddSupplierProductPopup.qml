import QtQuick 2.15
import "../pages"


PopupBase {
    id:popup

    contentItem: Rectangle {
        id: rectangle
        anchors.fill: parent

        SupplierProductForm {
            id: edit
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: buttons.top
            anchors.bottomMargin: 0
            anchors.topMargin: 0
            anchors.leftMargin: 0
            anchors.rightMargin: 0
        }

        Rectangle {
            id: buttons
            height: 60
            color: "#00000000"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.bottomMargin: 0

            CardBtns {
                width: 100
                height: 37
                text: "Close"
                btnColorClicked: "#cd3737"
                btnColorMouseOver: "#ec3c3c"
                btnColorDefault: "#f05454"
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenterOffset: -66
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: 1
                font.pointSize: 10
                font.bold: true
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        popup.close()
                    }
                }
            }

            CardBtns {
                width: 100
                height: 37
                text: "Save"
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 1
                anchors.horizontalCenterOffset: 64
                font.pointSize: 10
                anchors.horizontalCenter: parent.horizontalCenter
                font.bold: true
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        if(edit.producID > -1 && edit.supplierID > -1 && edit.amounnt != "" && edit.price != "" && edit.fdate != ""){
                            //console.log("ok",edit.producID, edit.supplierID , edit.amounnt , edit.price , edit.fdate);
                            backend.addSupplierProduct(edit.producID, edit.supplierID , edit.amounnt , edit.price , edit.fdate);
                            popup.close()
                        }
                    }
                }
            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:0.9;height:480;width:640}
}
##^##*/
