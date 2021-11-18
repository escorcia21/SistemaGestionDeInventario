import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4
import "../pages"


PopupBase {
    id: popup
    width: 300
    height: 320

    contentItem: Rectangle {
        id:bg
        anchors.fill: parent


        Column {
            id: column
            anchors.top: parent.top
            anchors.topMargin: 20
            spacing: 40
            anchors.horizontalCenter: parent.horizontalCenter
            Text {
                id: name
                text: qsTr("ADD TYPE")
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 12
                font.bold: true
            }

            Column {
                id: column1
                spacing: 10
                Text {
                    id: name1
                    text: qsTr("Name")
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pointSize: 12
                    font.bold: true
                }


                FormField {
                    id:tipo
                }

                Column {
                    id: column2
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 10
                    Text {
                        id: name2
                        text: qsTr("Unit")
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pointSize: 12
                        font.bold: true
                    }


                    ComboBox {
                        id:tipo2
                        font.pointSize: 10
                        font.bold: true
                        model: ["Mts","Unidad"]

                    }
                }
            }
         }
            Row {
                id: row
                anchors.bottom: parent.bottom
                spacing: 20
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottomMargin: 20

                CardBtns {
                    id: cardBtns
                    width: 100
                    height: 37
                    text: "Close"
                    btnColorClicked: "#cd3737"
                    btnColorMouseOver: "#ec3c3c"
                    btnColorDefault: "#f05454"
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
                    font.pointSize: 10
                    font.bold: true
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (tipo.value != "" && (tipo2.currentText == "Mts" || tipo2.currentText == "Unidad")){
                                //console.log(tipo2.currentText);
                                backend.addType(tipo.value,tipo2.value);
                                backend.setAddPopUPTypes()
                                popup.close();
                            }
                        }
                    }
                }
            }
    }
}
