import QtQuick 2.15
import QtGraphicalEffects 1.15
import QtQuick.Controls 2.15
import "../controls"
import Qt.labs.platform 1.1

Item {
    id: cart
    implicitWidth: 250
    implicitHeight: 225


    //PROPERTIES
    property url productImg: "../../img/images/NoImage.png"
    property string cost: "34000"
    property int stock: 32
    property string seller: "Products S.A.S"
    property string name: "Acetaminofen"
    property string type: "Antibioticos"
    property int identification: 1
    property int maximumValue: 99
    Rectangle {
        id: container
        color: "#00000000"
        border.color: "#00000000"
        border.width: 1
        anchors.fill: parent
        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0


        Rectangle {
            id: bg
            color: "#ffffff"
            anchors.fill: parent


            Rectangle {
                id: topi
                color: "#f05454"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: mid.top
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0
                anchors.bottomMargin: 0

                Image {
                    id: image
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    source: productImg
                    anchors.topMargin: 15
                    anchors.leftMargin: 30
                    anchors.rightMargin: 30
                    anchors.bottomMargin: 0
                    fillMode: Image.PreserveAspectFit

                    MouseArea {
                        id: mouse
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: folderDialog.open()
                        hoverEnabled: true
                        onEntered: {
                            fade.visible = true
                        }
                        onExited:{
                            fade.visible = false
                        }
                    }

                    Rectangle {
                        id: fade
                        opacity: 0.8
                        visible: false
                        color: "#f05454"
                        anchors.fill: parent
                    }
                }
            }

            Rectangle {
                id: mid
                x: -1
                y: 192
                height: 13
                color: "#d2d2d2"
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 0
                anchors.rightMargin: 0
            }

            Rectangle {
                id: boti
                x: -1
                y: 205
                color: "#ffffff"
                radius: 0
                border.width: 0
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: mid.bottom
                anchors.bottom: parent.bottom
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.bottomMargin: 0
                anchors.topMargin: 0

                Text {
                    id: namep
                    text: name
                    anchors.left: parent.left
                    anchors.top: parent.top
                    font.pixelSize: 12
                    anchors.topMargin: 8
                    anchors.leftMargin: 10
                    width: 100
                    elide: Text.ElideRight
                }

                Text {
                    id: sellerp
                    text: identification
                    anchors.left: parent.left
                    anchors.top: namep.bottom
                    font.pixelSize: 12
                    anchors.topMargin: 3
                    anchors.leftMargin: 10
                    width: 100
                    elide: Text.ElideRight
                }

                Text {
                    id: typep
                    y: 42
                    text: type
                    anchors.left: parent.left
                    anchors.top: sellerp.bottom
                    font.pixelSize: 12
                    anchors.leftMargin: 10
                    anchors.topMargin: 3
                    width: 100
                    elide: Text.ElideRight
                }

                Text {
                    id: price
                    x: 142
                    text: cost
                    anchors.right: parent.right
                    anchors.top: parent.top
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignRight
                    font.hintingPreference: Font.PreferDefaultHinting
                    anchors.topMargin: 8
                    anchors.rightMargin: 8
                    width: 100
                    elide: Text.ElideRight
                }

                Text {
                    id: stockp
                    x: 206
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignRight
                    font.bold: true
                    anchors.topMargin: -37
                    anchors.rightMargin: 8
                    width: 44
                    color: "#ffffff"
                    text: stock
                    anchors.right: parent.right
                    anchors.top: parent.top
                    elide: Text.ElideRight
                }

                CardBtns {
                    id: add
                    y: 62
                    width: 80
                    height: 29
                    text: "Editar"
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10
                    anchors.horizontalCenter: parent.horizontalCenter
                    btnColorClicked: "#cd3737"
                    btnColorMouseOver: "#ec3c3c"
                    btnColorDefault: "#f05454"
                    font.pointSize: 9
                    font.bold: true
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                           var popup = Qt.createComponent("EditPopup.qml")
                           var popup2 = popup.createObject(rectangleProducts,{ename:name,eprice:cost,idd:identification});
                           popup2.open()

                           backend.setListTypes();
                       }
                    }
                }
                Text{
                    id: stockp1
                    width: 42
                    visible: true
                    color: "#ffffff"
                    text: "STOCK"
                    anchors.top: parent.top
                    font.pixelSize: 12
                    horizontalAlignment: Text.AlignLeft
                    font.bold: true
                    anchors.leftMargin: 10
                    anchors.topMargin: -36
                    elide: Text.ElideRight
                    anchors.left: parent.left
                }
            }
        }

        Rectangle {
            id: stockFade
            visible: stock == 0 ? true :false
            anchors.fill: parent
            opacity: 0.80
            color: "#30475e"
            z:2

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                onClicked: mouse.accepted = false
                hoverEnabled: true

                Text {
                    id: text1
                    x: 24
                    y: 93
                    color: "#ffffff"
                    text: qsTr("Sin Stock")
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 28
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }

    FileDialog {
        id: folderDialog
        folder: StandardPaths.writableLocation(StandardPaths.PicturesLocation)
        nameFilters: ["Img files (*.jpeg *.jpg *.png)"]
        onFileChanged: {
            backend.onChangeImage(currentFile,cart.identification)
        }
    }

    Connections{
        target: backend
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:1.75}
}
##^##*/
